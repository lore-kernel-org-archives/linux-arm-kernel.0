From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 30 Jan 2013 16:56:28 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <51094D12.60304@arm.com>
References: <51093B0B.7010708@arm.com>
 <20130130160405.GC20593@e102568-lin.cambridge.arm.com>
 <51094D12.60304@arm.com>
Message-ID: <20130130165628.GA22535@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 04:40:50PM +0000, Punit Agrawal wrote:
> Hi Lorenzo,
> 
> 
> On 30/01/13 16:04, Lorenzo Pieralisi wrote:
> > On Wed, Jan 30, 2013 at 03:23:55PM +0000, Punit Agrawal wrote:
> >> Hi Nicolas,
> >>
> >> I was trying to boot 3.8-rc5 on Realview EB 11MPCore using realview-smp_defconfig as a starting point but the kernel failed to progress past the log below (config attached).
> >>
> >> Pawel suggested I try reverting 384a290283fde63ba8dc671fca5420111cdac19a - "ARM: gic: use a private mapping for CPU target interfaces" that you've authored. With this commit reverted the kernel boots.
> >>
> >> I am not quite sure why the commit breaks 11MPCore but Pawel (cc'd) might be able to shed light on that.
> >
> > I *think* it is because in the ARM11MPcore GIC
> >
> > dist_base + GIC_DIST_TARGET
> >
> > is RAZ for IT0-IT28. To give it a go you should change code in
> >
> > gic_cpu_init()
> >
> > and read (GIC_DIST_TARGET + 0x1c) (where IT29 starts)
> >
> > if I am not mistaken, since that will return the GIC CPU IF ID of the
> > reading CPU.
> 
> With the following changes the kernel boots up further -
> 
> $ git diff
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 36ae03a..68f6368 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -400,8 +400,11 @@ static void __cpuinit gic_cpu_init(struct 
> gic_chip_data *gic)
>           * Get what the GIC says our CPU mask is.
>           */
>          BUG_ON(cpu >= NR_GIC_CPU_IF);
> -   cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
> + cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0x1c);
> + cpu_mask = (cpu_mask & 0xff00) >> 8;
> +
>          gic_cpu_map[cpu] = cpu_mask;
> + printk(KERN_INFO "cpu: %d, cpu_mask: 0x%08x\n", cpu, cpu_mask);
> 
>          /*
>           * Clear our mask from the other map entries in case they're
> 
> But doesn't go all the way to init.

That's because IT28 read as zero as well, so using 0x1c does not work.

See Russell's reply, basically we need to scan first 32 IRQs and use
the first non-zero value to init the map.

Lorenzo
