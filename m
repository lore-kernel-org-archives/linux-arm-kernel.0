From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Apr 2018 07:11:39 -0700
Subject: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <20180411125210.GF10990@n2100.armlinux.org.uk>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
 <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
 <20180411125210.GF10990@n2100.armlinux.org.uk>
Message-ID: <20180411141139.GU5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180411 12:53]:
> On Tue, Apr 10, 2018 at 05:12:37PM +0300, Tero Kristo wrote:
> > On 10/04/18 16:41, Tony Lindgren wrote:
> > >* Russell King <rmk+kernel@armlinux.org.uk> [180410 10:43]:
> > >>diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> > >>index 021b5a8b9c0a..d4ddc78b2a0b 100644
> > >>--- a/arch/arm/mach-omap2/prm_common.c
> > >>+++ b/arch/arm/mach-omap2/prm_common.c
> > >>@@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
> > >>  	prm_ll_data->reset_system();
> > >>  	while (1)
> > >>-		cpu_relax();
> > >>+		cpu_do_idle();
> > >>  }
> > >
> > >Hmm we need to check so the added WFI here does not cause an
> > >undesired change to a low power state. Adding Tero to Cc also.
> > 
> > Generally it is a bad idea to call arbitrary WFI within OMAP architecture,
> > as this triggers a PRCM power transition and will most likely cause a hang
> > if not controlled properly.
> > 
> > Has this patch been tested on any platform that supports proper power
> > management?
> 
> That will also go for the other locations in this patch too, as they
> are all callable on _any_ platform.
> 
> It sounds like we need to abstract this so that platforms where "wfi"
> is complex can handle the "spin on this CPU forever" appropriately.
> 
> While we could use dsb, we're asking a CPU to indefinitely spin in a
> tight loop, which isn't going to be good for power consumption - what
> if we have three CPUs doing that, could it push a SoC over the thermal
> limits?  I don't think that's a question we can confidently answer
> except for specific SoCs.

We already have code in the kernel (and in the bootrom) to "park" a
cpu after starting. But using it without resetting the cpu would require
1-1 memory mapping or modifying the code. That is if we wanted to use
the same code also for parking the cpus for kexec without resetting
them.

Regards,

Tony
