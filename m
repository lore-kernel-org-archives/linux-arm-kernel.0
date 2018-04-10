From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Apr 2018 16:28:27 +0100
Subject: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
References: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
 <20180410134149.GQ5700@atomide.com>
 <685f80e3-30b3-8806-b81c-8de456507001@ti.com>
Message-ID: <20180410152827.GE15514@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 05:12:37PM +0300, Tero Kristo wrote:
> On 10/04/18 16:41, Tony Lindgren wrote:
> >* Russell King <rmk+kernel@armlinux.org.uk> [180410 10:43]:
> >>diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> >>index 021b5a8b9c0a..d4ddc78b2a0b 100644
> >>--- a/arch/arm/mach-omap2/prm_common.c
> >>+++ b/arch/arm/mach-omap2/prm_common.c
> >>@@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
> >>  	prm_ll_data->reset_system();
> >>  	while (1)
> >>-		cpu_relax();
> >>+		cpu_do_idle();
> >>  }
> >
> >Hmm we need to check so the added WFI here does not cause an
> >undesired change to a low power state. Adding Tero to Cc also.
> 
> Generally it is a bad idea to call arbitrary WFI within OMAP architecture,
> as this triggers a PRCM power transition and will most likely cause a hang
> if not controlled properly.
> 
> Has this patch been tested on any platform that supports proper power
> management?

An alternative to WFI would be a DSB, which should avoid unexpected
interactions with power management.

Will
