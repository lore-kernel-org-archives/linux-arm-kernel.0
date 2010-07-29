From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:11 -0700
Subject: [PATCH 4/7] ARM: LPC32xx: Change clocking for AMBA device registration
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-5-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The LCP32xx will throw an exception if a peripheral block is accessed
when not being clocked. For AMBA registration where the AMBA
peripheral ID is read from the register block, temporarily enable the
clocks during registration and disable them once complete. The
original logic left the clocks on.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c   |   25 +++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/clock.h   |    3 +++
 arch/arm/mach-lpc32xx/phy3250.c |   21 ++++-----------------
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 32d6379..5c3ac73 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1042,6 +1042,31 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
+/*
+ * These are the clocks for cells registered as primecell drivers
+ * on the AMBA bus. These must be on during AMBA device registration
+ * since the bus probe will attempt to read magic configuration
+ * registers for these devices. If they are deactivated these probes
+ * will fail.
+ */
+void lpc32xx_clock_primecells(void)
+{
+	clk_enable(&clk_mmc);
+	clk_enable(&clk_lcd);
+	clk_enable(&clk_ssp0);
+	clk_enable(&clk_ssp1);
+}
+EXPORT_SYMBOL(lpc32xx_clock_primecells);
+
+void lpc32xx_unclock_primecells(void)
+{
+	clk_disable(&clk_mmc);
+	clk_disable(&clk_lcd);
+	clk_disable(&clk_ssp0);
+	clk_disable(&clk_ssp1);
+}
+EXPORT_SYMBOL(lpc32xx_unclock_primecells);
+
 #define _REGISTER_CLOCK(d, n, c) \
 	{ \
 		.dev_id = (d), \
diff --git a/arch/arm/mach-lpc32xx/clock.h b/arch/arm/mach-lpc32xx/clock.h
index c0a8434..f326752 100644
--- a/arch/arm/mach-lpc32xx/clock.h
+++ b/arch/arm/mach-lpc32xx/clock.h
@@ -35,4 +35,7 @@ struct clk {
 	u32 enable_mask;
 };
 
+void lpc32xx_clock_primecells(void);
+void lpc32xx_unclock_primecells(void);
+
 #endif
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bc9a42d..50346c9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -38,6 +38,7 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include "common.h"
+#include "clock.h"
 
 /*
  * Mapped GPIOLIB GPIOs
@@ -340,28 +341,14 @@ static void __init phy3250_board_init(void)
 
 	lpc32xx_serial_init();
 
-	/*
-	 * AMBA peripheral clocks need to be enabled prior to AMBA device
-	 * detection or a data fault will occur, so enable the clocks
-	 * here. However, we don't want to enable them if the peripheral
-	 * isn't included in the image
-	 */
-#ifdef CONFIG_FB_ARMCLCD
-	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
-		LPC32XX_CLKPWR_LCDCLK_CTRL);
-#endif
-#ifdef CONFIG_SPI_PL022
-	tmp = __raw_readl(LPC32XX_CLKPWR_SSP_CLK_CTRL);
-	__raw_writel((tmp | LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN),
-		LPC32XX_CLKPWR_SSP_CLK_CTRL);
-#endif
-
 	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
+
+	lpc32xx_clock_primecells();
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
 		amba_device_register(d, &iomem_resource);
 	}
+	lpc32xx_unclock_primecells();
 
 	/* Test clock needed for UDA1380 initial init */
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
-- 
1.7.1.1
