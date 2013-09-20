From: matt.porter@linaro.org (Matt Porter)
Date: Fri, 20 Sep 2013 15:16:14 -0400
Subject: [PATCH 00/26] ARM: provide common arch init for DT clocks
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130920191613.GA25191@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 07:53:33PM +0200, Sebastian Hesselbarth wrote:
> This is a patch set based on an RFC [1][2] sent earlier to provide a common
> arch/arm init for DT clock providers. Currently, the call to of_clk_init(NULL)
> to initialize DT clock providers is spread among several mach-dirs. Since most
> machs require DT clocks initialized before timers, no initcall can be used.
> 
> By adding of_clk_init(NULL) to arch/arm time_init(), we can remove all
> mach-specific .init_time hooks that basically called of_clk_init and
> clocksource_of_init.
> 
> In contrast to the RFC version, of_clk_init(NULL) is now only called if no
> custom .init_time callback is set. This allows some machs to still call clock
> init themselves, as not all can be converted now. Therefore, this patch sets
> drops conversion of mach-mvebu and mach-zynq. New machs that were introduced
> with v3.12-rc1 are also converted, except mach-u300 that requires clocks
> before irqs.
> 
> The patch set is based on v3.12-rc1 and further depends on a topic branch
> created by Stephen Warren for mach-tegra [3]. It is now split into preparation
> and removal patches to not break bisectability. I added all Acked-by/Tested-by's
> where applicable or dropped them, if the patch was separated into two.
> It has been compile tested for all machs involved with the following defconfigs
> (multi_v7, bcm2835, dove, exynos, kirkwood, mxs, nhk8815) and nspire selected
> on multi_v4_v5.
> 
> Patches 1-8 comprise preparation patches that convert machs nomadik, prima2,
> socfpga, sunxi, tegra, and vt8500 to usual .init_time callbacks calling only
> of_clk_init and clocksource_of_init.
> 
> Patch 9 then introduces of_clk_init(NULL) to the arch-wide default .init_time
> callback.
> 
> Patches 10-26 finally remove custom .init_time callbacks from the machs involved.

Hi Sebastian,

Could you pick up the following patch for mach-bcm/ into this series?

Thanks,
Matt

>From f65d048b3453447bb3e693cb21701c4d0c6375ed Mon Sep 17 00:00:00 2001
From: Matt Porter <matt.porter@linaro.org>
Date: Fri, 20 Sep 2013 13:41:06 -0400
Subject: [PATCH] ARM: bcm: Remove custom .time_init hook

With arch/arm calling of_clk_init(NULL) and clocksource_of_init()
this is no longer needed. The former is useful because we can make
use of dummy fixed clocks for drivers until the bcm281xx common
clock driver is ready.

Signed-off-by: Matt Porter <matt.porter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Christian Daudt <csd@broadcom.com>
---
 arch/arm/mach-bcm/board_bcm281xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/mach-bcm/board_bcm281xx.c
index 8d9f931..26b2390 100644
--- a/arch/arm/mach-bcm/board_bcm281xx.c
+++ b/arch/arm/mach-bcm/board_bcm281xx.c
@@ -68,7 +68,6 @@ static void __init board_init(void)
 static const char * const bcm11351_dt_compat[] = { "brcm,bcm11351", NULL, };
 
 DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
-	.init_time = clocksource_of_init,
 	.init_machine = board_init,
 	.restart = bcm_kona_restart,
 	.dt_compat = bcm11351_dt_compat,
-- 
1.8.4
