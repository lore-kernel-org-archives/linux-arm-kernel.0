From: balbi@ti.com (Felipe Balbi)
Date: Wed, 9 Jul 2014 08:51:37 -0500
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
In-Reply-To: <20140709092531.GK28884@atomide.com>
References: <20140707104944.GS3705@n2100.arm.linux.org.uk>
 <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
 <20140707151024.GJ5582@saruman.home> <53BB7980.2060909@ti.com>
 <20140708082948.GE28884@atomide.com>
 <20140709092531.GK28884@atomide.com>
Message-ID: <20140709135137.GC973@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 02:25:31AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140708 01:32]:
> > * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
> > > On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
> > > > On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux wrote:
> > > >> --- a/arch/arm/mm/cache-l2x0.c
> > > >> +++ b/arch/arm/mm/cache-l2x0.c
> > > >> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
> > > >>  
> > > >>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
> > > >>  {
> > > >> -	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
> > > >> +	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RTL_MASK;
> > > >>  	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
> > > > 
> > > > even with this change, l2c still tries to write to power control
> > > > register, at least on AM437x. Looking a little deeper here, AM437x
> > > > identifies itself as l2c PL310 r3p3, which should have power control
> > > > register, but aparentely there's no way to write that register. I'll
> > > > file a bug to our ROM team, but we will certainly need a way to
> > > > workaround this inside omap4-common.c
> > > 
> > > Looks like we need both my patch as well as Russell's patch. I can
> > > respin my patch with the pr_info_once() dropped if it helps further
> > > reduce boot noise.
> > 
> > In that case I'm fine with the original patch in this series. Russell,
> > got any better ideas?
> 
> I guess no more comments. Took a look at the patch again, Sekhar, can
> you please update the description with what has been discovered in this
> thread and repost?

another thing to note is that as of today, there is no known way of
accessing power control register in *any* TI parts. That's quite
unfortunate :-(

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/06d18d0f/attachment.sig>
