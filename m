From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 20:50:59 +0200
Subject: [PATCHv5 1/3] ARM: mm: add support for HW coherent systems in
 PL310 cache
In-Reply-To: <20140630173217.GT28951@arm.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1402585772-10405-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140630173217.GT28951@arm.com>
Message-ID: <20140630205059.2e7b2278@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Mon, 30 Jun 2014 18:32:17 +0100, Catalin Marinas wrote:

> > +/*
> >   * Note that the end addresses passed to Linux primitives are
> >   * noninclusive, while the hardware cache range operations use
> >   * inclusive start and end addresses.
> > @@ -1487,6 +1514,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
> >  
> >  	data = of_match_node(l2x0_ids, np)->data;
> >  
> > +	if (of_device_is_compatible(np, "arm,pl310-cache") &&
> > +	    of_property_read_bool(np, "arm,io-coherent"))
> > +		data = &of_l2c310_coherent_data;
> 
> I don't have a better way without duplicating the l2c_init_data
> structure since the fixup function does not take a device_node
> pointer. If it did, you could have added the check in l2c310_fixup and
> zeroed the sync pointer there.
> 
> Anyway, your approach works for me as well:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the confirmation. Note that it comes a bit too late though:
the patch is already in 3.16-rc3:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/mm/cache-l2x0.c?id=98ea2dba65932ffc456b6d7b11b8a0624e2f7b95.

However, I'm interested in hearing your opinion about the I/O coherency
discussion in !SMP, and especially whether the TTB flags need to be
consistent with the PMD flags in terms of cache policy and
shareability. See
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263524.html.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
