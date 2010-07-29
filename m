From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:12 -0700
Subject: [PATCH 5/7] ARM: LPC32xx: Add workaround the AMBA LCD clocking
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The AMBA LCD driver attempts to access peripheral registers prior to
enabling the clock for the peripheral. This workaround will get
around that issue by making sure the LCD clock is enabled for the
first peripheral register accesses.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/phy3250.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 50346c9..9283cab 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -350,6 +350,19 @@ static void __init phy3250_board_init(void)
 	}
 	lpc32xx_unclock_primecells();
 
+#ifdef CONFIG_FB_ARMCLCD
+	/*
+	 * The AMBA PL11x driver attempts to disable the LCD and then
+	 * access some peripheral registers while the clock is disabled.
+	 * This workaround won't fix the unbalanced clock enable and
+	 * disable, but will prevent the ARM core from throwing an
+	 * exception when that happens. 
+	 */
+	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL);
+	__raw_writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
+		LPC32XX_CLKPWR_LCDCLK_CTRL);
+#endif
+
 	/* Test clock needed for UDA1380 initial init */
 	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
 		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
-- 
1.7.1.1
