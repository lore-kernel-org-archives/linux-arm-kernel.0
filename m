From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  8 Nov 2011 22:07:07 +0800
Subject: [PATCH] arm/mxs: fix mmc device adding for mach-mx28evk
Message-ID: <1320761227-24476-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merge commit "526b264 Merge branch 'imx/cleanup' into imx/devel"
left a duplicated mx28_add_mxs_mmc() call, which causes the problem
below during boot.

  kobject_add_internal failed for mxs-mmc.1 with -EEXIST, don't try
  to register things with the same name in the same directory.

The patch removes this leftover and also change mmc0 adding to align
with mmc1.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mx28evk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index ac2316d..064ec5a 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -471,7 +471,8 @@ static void __init mx28evk_init(void)
 			       "mmc0-slot-power");
 	if (ret)
 		pr_warn("failed to request gpio mmc0-slot-power: %d\n", ret);
-	mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
+	else
+		mx28_add_mxs_mmc(0, &mx28evk_mmc_pdata[0]);
 
 	ret = gpio_request_one(MX28EVK_MMC1_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc1-slot-power");
@@ -480,7 +481,6 @@ static void __init mx28evk_init(void)
 	else
 		mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
 
-	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
 	mx28_add_rtc_stmp3xxx();
 
 	gpio_led_register_device(0, &mx28evk_led_data);
-- 
1.7.4.1
