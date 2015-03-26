From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 26 Mar 2015 22:19:55 +0000
Subject: [PATCH 2/5] arm64: alternative: Allow immediate branch as
 alternative instruction
In-Reply-To: <20150326220323.GA23836@arm.com>
References: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
 <1426773576-14062-3-git-send-email-marc.zyngier@arm.com>
 <20150326220323.GA23836@arm.com>
Message-ID: <20150326221955.4b8fe6f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015 22:03:23 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Thu, Mar 19, 2015 at 01:59:33PM +0000, Marc Zyngier wrote:
> > Since all immediate branches are PC-relative on Aarch64, these
> > instructions cannot be used as an alternative with the simplistic
> > approach we currently have (the immediate has been computed from
> > the .altinstr_replacement section, and end-up being completely off
> > if we insert it directly).
> > 
> > This patch handles the b and bl instructions in a different way,
> > using the insn framework to recompute the immediate, and generate
> > the right displacement.
> > 
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm64/kernel/alternative.c | 55 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> [...]
> 
> >  static int __apply_alternatives(void *alt_region)
> >  {
> >  	struct alt_instr *alt;
> > @@ -40,16 +83,24 @@ static int __apply_alternatives(void *alt_region)
> >  	u8 *origptr, *replptr;
> >  
> >  	for (alt = region->begin; alt < region->end; alt++) {
> > +		u32 insn;
> > +		int i;
> > +
> >  		if (!cpus_have_cap(alt->cpufeature))
> >  			continue;
> >  
> > -		BUG_ON(alt->alt_len > alt->orig_len);
> > +		BUG_ON(alt->alt_len != alt->orig_len);
> >  
> >  		pr_info_once("patching kernel code\n");
> >  
> >  		origptr = (u8 *)&alt->orig_offset + alt->orig_offset;
> >  		replptr = (u8 *)&alt->alt_offset + alt->alt_offset;
> > -		memcpy(origptr, replptr, alt->alt_len);
> > +
> > +		for (i = 0; i < alt->alt_len; i += sizeof(insn)) {
> > +			insn = get_alt_insn(origptr + i, replptr + i);
> > +			*(u32 *)(origptr + i) = insn;
> 
> My brain's not firing on all cylinders right now, but do you need a
> cpu_to_le32 here?

I'm not 100% awake myself (probably some acute form of firmwaritis),
but I suspect you're quite right (get_alt_insn calls aarch64_insn_read,
which does a le32_to_cpu). Obviously, we need to revert the conversion
when writing the instruction back.

Do you want a fixup on top of this, or would you prefer me to respin
the series?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
