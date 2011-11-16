From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 16:35:15 +0000
Subject: [PATCH 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111116154402.GE2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-4-git-send-email-pawel.moll@arm.com>
 <20111116154402.GE2073@localhost.localdomain>
Message-ID: <1321461315.3137.371.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 15:44 +0000, Dave Martin wrote:
> > +  where <model> is the the model, eg:
> 
> Two "the"s.
> 
> What "model" means isn't obvious to the uninitiated -- how about
> something like "where <model> is the full platform model name" ?

Ok.

> > +  - for Coretile Express A5x2 (V2P-CA5s):
> > +	compatible = "arm,vexpress-v2p-ca5s", "arm-vexpress";
> > +  - Coretile Express A9x4 (V2P-CA9):
> > +	comaptible = "arm,vexpress-v2p-ca9", "arm,vexpress-legacy", "arm-vexpress";
> > +
> > +Current Linux implementation requires a "timer" alias pointing
> > +at a SP804 timer block to be used when tile is not using local
> > +timer source.
> 
> We should specify a list of all the "standard" aliases used by the
> generic motherboard code here, since these are part of the contract
> between each board-specific device tree and the motherboard code.
> 
> Is "timer" the only one, or are there others?

One and only. There were more, but I got rid of them.

> > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > index 9311484..4c11e90 100644
> > --- a/arch/arm/mach-vexpress/Kconfig
> > +++ b/arch/arm/mach-vexpress/Kconfig
> > @@ -9,4 +9,8 @@ config ARCH_VEXPRESS_CA9X4
> >  	select ARM_ERRATA_751472
> >  	select ARM_ERRATA_753970
> >  
> 
> For "non-interactive" config items, can we still please have comments
> indicating what the item means and how it should be used?
> 
> Such comments can be very brief, but having at least something makes the
> configs easier to understand and maintain, in my view.

Em, what bits do you refer to? The lines you quoted are not changed...

> > diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> 
> [...]
> 
> > +void __init v2m_dt_init_early(void)
> > +{
> > +	struct device_node *node;
> > +	const __be32 *reg;
> > +	u32 dt_hbi;
> > +
> > +	node = of_find_compatible_node(NULL, NULL, "arm,vexpress-sysreg");
> > +	BUG_ON(!node);
> > +	/* The following will become of_iomap() when possible */
> > +	reg = of_get_property(node, "reg", NULL);
> > +	BUG_ON(!reg);
> > +	v2m_sysreg_base = V2M_PERIPH_P2V(be32_to_cpup(reg));
> > +
> > +	/* Confirm board type against DT property, if available */
> > +	if (of_property_read_u32(allnodes, "arm,hbi", &dt_hbi) == 0) {
> > +		u32 misc = readl(v2m_sysreg_base + V2M_SYS_MISC);
> > +		u32 id = readl(v2m_sysreg_base + (misc & SYS_MISC_MASTERSITE ?
> > +				V2M_SYS_PROCID1 : V2M_SYS_PROCID0));
> > +		u32 hbi = id & SYS_PROCIDx_HBI_MASK;
> > +
> > +		if (WARN_ON(dt_hbi != hbi))
> > +			pr_warning("vexpress: DT HBI (%x) is not matching "
> > +					"hardware (%x)!\n", dt_hbi, hbi);
> 
> Once this code is mature enough, should we panic the kernel here
> instead?

I'm not convinced. Actually the first version I wrote was panicking. But
then I thought that if it works, it works - why should I prevent this?
The use case is simple - FPGA implementations, being
mostly-exact-equivalents of the core tiles, will have the logic tile HBI
here. And to use them you would have to modify the DTS if this code
panicked. With WARN_ON you'll see the message, but if you know what are
you doing, that's fine...

Don't know, really. Any strong feelings about it?

Cheers!

Pawe?
