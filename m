From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 20 Sep 2011 10:57:43 +0200
Subject: [PATCH 1/1] mx31moboard: Add poweroff support
Message-ID: <1316509063-26787-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add poweroff support on mx31moboard platform.
A watchdog timeout is generated while enabling the watchdog
reset IO to trigger a PMIC poweroff.

Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c       |   17 +++++++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 2a43492..3d3d10f 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -29,6 +29,9 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/input.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
 
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -509,6 +512,18 @@ err:
 
 }
 
+static void mx31moboard_poweroff(void)
+{
+	struct clk *clk = clk_get_sys("imx2-wdt.0", NULL);
+
+	if (!IS_ERR(clk))
+		clk_enable(clk);
+
+	mxc_iomux_mode(MX31_PIN_WATCHDOG_RST__WATCHDOG_RST);
+
+	__raw_writew(1 << 6 | 1 << 2, MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
+}
+
 static int mx31moboard_baseboard;
 core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
 
@@ -544,6 +559,8 @@ static void __init mx31moboard_init(void)
 
 	moboard_usbh2_init();
 
+	pm_power_off = mx31moboard_poweroff;
+
 	switch (mx31moboard_baseboard) {
 	case MX31NOBOARD:
 		break;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx3.h b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
index c92f0b1..63f22a0 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx3.h
@@ -735,6 +735,7 @@ enum iomux_pins {
 #define MX31_PIN_KEY_COL5_KEY_COL5	IOMUX_MODE(MX31_PIN_KEY_COL5, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_KEY_COL6_KEY_COL6	IOMUX_MODE(MX31_PIN_KEY_COL6, IOMUX_CONFIG_FUNC)
 #define MX31_PIN_KEY_COL7_KEY_COL7	IOMUX_MODE(MX31_PIN_KEY_COL7, IOMUX_CONFIG_FUNC)
+#define MX31_PIN_WATCHDOG_RST__WATCHDOG_RST	IOMUX_MODE(MX31_PIN_WATCHDOG_RST, IOMUX_CONFIG_FUNC)
 
 
 /*
-- 
1.6.3.3
