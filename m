From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Sep 2011 16:40:54 +0900
Subject: [patch] ARM: smpboot: Enable interrupts after marking CPU
	online/active
In-Reply-To: <20110923084001.GP17169@n2100.arm.linux.org.uk>
References: <20110908215314.829452535@linutronix.de>
	<CADGdYn6V_eQJZ4=irMbSS7XJj4MJVeALxcrWdD7o2bGs1sEJZQ@mail.gmail.com>
	<20110913133258.GA6267@n2100.arm.linux.org.uk>
	<CAKfTPtCWuiOM5+sOwdh1FzXZb1EFT__tVEpRPY5suGOxpYTdQQ@mail.gmail.com>
	<20110913175312.GB6267@n2100.arm.linux.org.uk>
	<20110923084001.GP17169@n2100.arm.linux.org.uk>
Message-ID: <009101cc7e7b$1ebece00$5c3c6a00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Tue, Sep 13, 2011 at 06:53:12PM +0100, Russell King - ARM Linux wrote:
> > So, we must have the setting of CPU online _after_ we've setup the
> > scheduler domain information etc - so the following is a strict
> > ordering:
> >
> > 1. calibrate_delay()
> > 2. smp_store_cpu_info()
> > 3. set_cpu_online()
> >
> > Now, the question is do we need interrupts enabled to setup timers
> > via percpu_timer_setup() and calibrate delay.  Can we move enabling
> > interrupts after smp_store_cpu_info().  IOW, instead of moving the
> > setting of cpu online before all this, can we move notify_cpu_starting()
> > and the enabling of _both_ interrupts after smp_store_cpu_info()...
> > No idea at the moment.
> 
> And to make things worse... 4bd0fe1c78623062263cf5ae875fd484c5b8256d
> has appeared in mainline today.
> 
> diff --git a/arch/arm/mach-exynos4/platsmp.c
b/arch/arm/mach-exynos4/platsmp.c
> index 7c2282c..df6ef1b 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -106,6 +106,8 @@ void __cpuinit platform_secondary_init(unsigned int
cpu)
>          */
>         spin_lock(&boot_lock);
>         spin_unlock(&boot_lock);
> +
> +       set_cpu_online(cpu, true);
>  }
> 
>  int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> 
> I think some work needs to be done to eliminate some of the dependencies
> in this code so that we can have a *sane* order for bringup of secondary
> CPUs.
> 
Hi Russell,

Oops, as you said, it seems not proper place, platform_secondary_init() to
make secondary CPU online so I will submit its revert patch.

But as Amit said, current EXYNOS4 SoCs which are using SPI for local timers
has problem that the irq_set_affinity() method is called in
percpu_timer_setup() before CPU1 becomes online with the commit
5dfc54e087c15f823ee9b6541d2f0f314e69cbed ("ARM: GIC: avoid routing
interrupts to offline CPUs"). So I will check again.

If you have any ideas, please kindly let me know.

> I'm just going to sit on the fence and watch what platform people do
> during the next merge window when the support for the topological
> scheduler goes in.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
