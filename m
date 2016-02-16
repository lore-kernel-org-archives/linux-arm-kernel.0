From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 16 Feb 2016 16:31:51 +0100
Subject: [PATCH 3/4] drivers: sh: Stop using the legacy clock domain on ARM
In-Reply-To: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
References: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1455636712-3040-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS are enabled unconditionally
for Renesas ARM-based SoCs, the legacy clock domain is no longer used on
these SoCs.
Remove the related support code, and stop entering drivers/sh/ on ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Notes:
  - This does break booting R-Car Gen2 boards using pre-v4.3 DTSes that
    don't have power-domains properties,
  - This may unbreak SuperH-based ARCH_SHMOBILE platforms, which were
    probably broken since v4.4 by commit 0ba58de231066e47 ("drivers: sh:
    Get rid of CONFIG_ARCH_SHMOBILE_MULTI").
---
 drivers/Makefile        | 1 -
 drivers/sh/pm_runtime.c | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 8f5d076baeb0e832..6afdb78e21382538 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
-obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 91a003011acfacb2..c887ecdaf19b7c10 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -34,15 +34,6 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init sh_pm_runtime_init(void)
 {
-	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
-		if (!of_find_compatible_node(NULL, NULL,
-					     "renesas,cpg-mstp-clocks"))
-			return 0;
-		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
-		    of_find_node_with_property(NULL, "#power-domain-cells"))
-			return 0;
-	}
-
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-- 
1.9.1
