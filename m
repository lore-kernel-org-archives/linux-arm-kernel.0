From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Jul 2010 14:18:47 +0900
Subject: [PATCH] ARM: S5P6442: Add Watchdog support for S5P6442
Message-ID: <1279516727-7609-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch adds support for Watchdog timer for Samsung S5P6442.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE:
Depends on 'ARM: S5P6442: Add Watchdog Timer map for S5P6442' which
has submitted for other part.

 arch/arm/mach-s5p6442/Kconfig         |    2 ++
 arch/arm/mach-s5p6442/clock.c         |    6 ++++++
 arch/arm/mach-s5p6442/mach-smdk6442.c |    1 +
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5p6442/Kconfig b/arch/arm/mach-s5p6442/Kconfig
index 0fd41b4..7cd2843 100644
--- a/arch/arm/mach-s5p6442/Kconfig
+++ b/arch/arm/mach-s5p6442/Kconfig
@@ -19,6 +19,8 @@ config CPU_S5P6442
 config MACH_SMDK6442
 	bool "SMDK6442"
 	select CPU_S5P6442
+	select S3C_DEV_WDT
+	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDK6442
 
diff --git a/arch/arm/mach-s5p6442/clock.c b/arch/arm/mach-s5p6442/clock.c
index 087e57f..dcd20f1 100644
--- a/arch/arm/mach-s5p6442/clock.c
+++ b/arch/arm/mach-s5p6442/clock.c
@@ -361,6 +361,12 @@ static struct clk init_clocks[] = {
 		.enable		= s5p6442_clk_ip3_ctrl,
 		.ctrlbit	= (1<<19),
 	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_pclkd1,
+		.enable		= s5p6442_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 22),
+	}, {
 		.name		= "timers",
 		.id		= -1,
 		.parent		= &clk_pclkd1,
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index ebcf997..6e061be 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -66,6 +66,7 @@ static struct s3c2410_uartcfg smdk6442_uartcfgs[] __initdata = {
 
 static struct platform_device *smdk6442_devices[] __initdata = {
 	&s5p6442_device_iis0,
+	&s3c_device_wdt,
 };
 
 static void __init smdk6442_map_io(void)
-- 
1.6.2.5
