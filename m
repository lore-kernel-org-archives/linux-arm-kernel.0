From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 10 Jul 2014 12:19:04 -0300
Subject: [PATCH v3 1/4] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <20140707221823.GC16677@electric-eye.fr.zoreil.com>
References: <1404758751-2346-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404758751-2346-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140707221823.GC16677@electric-eye.fr.zoreil.com>
Message-ID: <20140710151904.GA5283@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08 Jul 12:18 AM, Francois Romieu wrote:
> Ezequiel Garcia <ezequiel.garcia@free-electrons.com> :
> [...]
> > diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> > new file mode 100644
> > index 0000000..21931a1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/marvell/mvpp2.c
> [...]
> > +static inline void mvpp2_mib_counters_clear(struct mvpp2_port *pp)
> > +{
> > +	int i;
> > +	u32 dummy;
> > +
> > +	/* Perform dummy reads from MIB counters */
> > +	for (i = 0; i < MVPP2_MIB_LATE_COLLISION; i += 4)
> > +		dummy = readl(pp->pp2->lms_base +
> > +			      (MVPP2_MIB_COUNTERS_BASE(pp->id) + i));
>                               ^ excess parenthesis
> 
> Please reduce the scope of the dummy variable and add curly braces in the
> (multi-line) "for" block.
> 
> You may remove the "Perform dummy ..." comment. The code is literate enough.
> 

Actually, the dummy variable is not needed: a plain readl() is enough.

> [...]
> > +/* Update lookup field in tcam sw entry */
> > +static void mvpp2_prs_tcam_lu_set(struct mvpp2_prs_entry *pe, unsigned int lu)
> > +{
> > +	pe->tcam.byte[MVPP2_PRS_TCAM_LU_BYTE] = lu;
> > +	pe->tcam.byte[MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_LU_BYTE)] =
> > +							      MVPP2_PRS_LU_MASK;
> 
> Use a local u8 *b = pe->tcam.byte; ?
> 

I think keeping the pe->tcam.byte, but using a local for the
MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_LU_BYTE) should be more readable.
I've gone through similar patterns and fixed this.

> > +}
> > +
> > +/* Update mask for single port in tcam sw entry */
> > +static void mvpp2_prs_tcam_port_set(struct mvpp2_prs_entry *pe,
> > +				    unsigned int port, bool add)
> > +{
> > +	if (add)
> > +		pe->tcam.byte[MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE)]
> > +								&= ~(1 << port);
> > +	else
> > +		pe->tcam.byte[MVPP2_PRS_TCAM_EN_OFFS(MVPP2_PRS_TCAM_PORT_BYTE)]
> > +								 |= (1 << port);
> 
> Use a local u8 *b = pe->tcam.byte; ?
> 

Ditto, using a local for the array should be readable enough.

> [...]
> > +/* Compare tcam data bytes with a pattern */
> > +static bool mvpp2_prs_tcam_data_cmp(struct mvpp2_prs_entry *pe,
> > +				    unsigned int offs, unsigned int size,
> > +					   unsigned char *bytes)
> > +{
> > +	unsigned char byte, mask;
> > +	int i;
> > +
> > +	for (i = 0; i < size; i++) {
> > +		mvpp2_prs_tcam_data_byte_get(pe, offs + i, &byte, &mask);
> > +
> > +		if (byte != bytes[i])
> > +			return false;
> 
> Please reduce the scope of "byte" and "mask".
> 

Agreed. This applies on several other places, I'll fix them all.

> > +	}
> > +	return true;
> > +}
> > +
> > +/* Update ai bits in tcam sw entry */
> > +static void mvpp2_prs_tcam_ai_update(struct mvpp2_prs_entry *pe,
> > +				     unsigned int bits, unsigned int enable)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < MVPP2_PRS_AI_BITS; i++)
> > +		if (enable & BIT(i)) {
> > +			if (bits & BIT(i))
> > +				pe->tcam.byte[MVPP2_PRS_TCAM_AI_BYTE] |=
> > +								       (1 << i);
> > +			else
> > +				pe->tcam.byte[MVPP2_PRS_TCAM_AI_BYTE] &=
> > +								      ~(1 << i);
> > +		}
> 
> Curly braces for the "for" loop + local variable for &pe->tcam.byte[foo]
> 

As you suggest below: I'll fix the comparison to recover the indent, use a local
for the array index, and add curly braces.

> [...]
> > +/* Update ri bits in sram sw entry */
> > +static void mvpp2_prs_sram_ri_update(struct mvpp2_prs_entry *pe,
> > +				     unsigned int bits, unsigned int mask)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < MVPP2_PRS_SRAM_RI_CTRL_BITS; i++)
> 
> Please add curly braces.
> 

Sure.

> > +		if (mask & BIT(i)) {
> 
> Invert the test and add a "continue" statement to recover the missing indent
> level ?
> 

Agreed. The same applies on other places.

[..]
> > +/* Return first free tcam index, seeking from start to end */
> > +static int mvpp2_prs_tcam_first_free(struct mvpp2 *pp2, unsigned char start,
> > +				     unsigned char end)
> > +{
> > +	int tid;
> > +	bool found = false;
> > +
> > +	if (start > end)
> > +		swap(start, end);
> > +
> > +	for (tid = start; tid <= end; tid++) {
> > +		if (!pp2->prs_shadow[tid].valid) {
> > +			found = true;
> > +			break;
> 
> Don't break: test for tid < MVPP2_PRS_TCAM_SRAM_SIZE and return.
> 

Yes, this function can be reworked altogether to trim "end" to the size
and remove the "found" variable.

> > +		}
> > +	}
> > +
> > +	if (found && (tid < MVPP2_PRS_TCAM_SRAM_SIZE))
> > +		return tid;
> > +	return -EINVAL;
> [...]
> > +static void mvpp2_prs_mac_all_multi_set(struct mvpp2 *pp2, int port, bool add)
> > +{
> > +	struct mvpp2_prs_entry pe;
> > +	unsigned int index = 0;
> > +	unsigned int i;
> > +
> > +	/* Ethernet multicast address first byte is
> > +	 * 0x01 for IPv4 and 0x33 for IPv6
> > +	 */
> > +	unsigned char da_mc[MVPP2_PRS_MAX_MAC_MC] = { 0x01, 0x33 };
> > +
> > +	for (i = MVPP2_PRS_IP4_MAC_MC; i < MVPP2_PRS_MAX_MAC_MC; i++) {
> > +		if (i == MVPP2_PRS_IP4_MAC_MC)
> > +			index = MVPP2_PE_MAC_MC_ALL;
> > +		else
> > +			index = MVPP2_PE_MAC_MC_IP6;
> 
> Ternary ?
> 

Sure.

[..]
> > +static struct mvpp2_prs_entry *mvpp2_prs_vlan_find(struct mvpp2 *pp2,
> > +						   unsigned short tpid, int ai)
> > +{
> > +	struct mvpp2_prs_entry *pe;
> > +	unsigned int ri_bits, ai_bits;
> > +	unsigned int enable;
> > +	unsigned char tpid_arr[2];
> > +	int tid;
> 
> Nitnit: please xmas-treefy (wherever possible).
> 

OK.

> > +/* Search for existing double vlan entry */
> > +static struct mvpp2_prs_entry *mvpp2_prs_double_vlan_find(struct mvpp2 *pp2,
> > +							  unsigned short tpid1,
> > +							  unsigned short tpid2)
> > +{
> > +	struct mvpp2_prs_entry *pe;
> > +	unsigned int enable, bits;
> 
> Excess scope.
> 
> > +	unsigned char tpid_arr1[2];
> > +	unsigned char tpid_arr2[2];
> 
> unsigned char tpid[2][2] ?
> 

Yeah, this function needs some love.

So, I have fixed all the excess parenthesis, excess scope, missing curly braces,
added ternary uses and did many other style clean-ups, based on your feedback.

In addition, removed the Tx/Rx module parameters and instead using the default
values (which are fixed by the hardware).

Thanks for such detailed review. I'll submit v4 shortly.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
