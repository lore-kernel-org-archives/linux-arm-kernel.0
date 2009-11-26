From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2009 14:49:56 +0000
Subject: IXP425: help on HSS channelized service
In-Reply-To: <200911261543.08448.schindele@nentec.de>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<m3d437bi7i.fsf@intrepid.localdomain>
	<200911261543.08448.schindele@nentec.de>
Message-ID: <20091126144956.GA7150@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 04:43:07PM +0200, Juergen Schindele wrote:
> Am Mittwoch, 25. November 2009 schrieb Krzysztof Halasa:
> > The buffers have different structures for RX and TX.
> This was a very good hint :-). I discovered that the 
> "struct desc" used in the kernel mainline driver is quite 
> different from the one used in INTEL code !?????.
> When I replace the "struct desc" (see below) it works fine for me.
> Isn't there a general problem with this driver when it works only 
> for channelized mode (your case) ???
> Has sombody made it working in HDLC_PIPE mode ????
> 
> here my changes:
> I replaced 
> 
> struct desc {
>         u32 next;               /* pointer to next buffer, unused */
> 
> #ifdef __ARMEB__
>         u16 buf_len;            /* buffer length */
>         u16 pkt_len;            /* packet length */
>         u32 data;               /* pointer to data buffer in RAM */
>         u8 status;
>         u8 error_count;
>         u16 __reserved;
> #else
>         u16 pkt_len;            /* packet length */
>         u16 buf_len;            /* buffer length */
>         u32 data;               /* pointer to data buffer in RAM */
>         u16 __reserved;
>         u8 error_count;
>         u8 status;
> #endif
>         u32 __reserved1[4];

If these structures are sensitive to the byte-endian, they should be
defined using [bl]e(32|16|8) so that sparse can check that you're
using appropriate cpu_to_xxx() and xxx_to_cpu() endian conversions on
them.
