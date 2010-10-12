From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Tue, 12 Oct 2010 15:41:12 +0300
Subject: [PATCH 1/2] [v2]ARM: S3C64XX: Fix USB and 48M clock enable procedure
In-Reply-To: <20101012123945.16469.2779.stgit@localhost.localdomain>
References: <20101012123945.16469.2779.stgit@localhost.localdomain>
Message-ID: <20101012124112.16469.40417.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

48M clock is output from USB PHY PLL. To enable 48M clock
we must initialize USB PHY.

changes since v1:
- renamed s3c64xx_clk_xusbxti_is_osc() to s3c64xx_clk_xusbxti_set_osc()

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 arch/arm/mach-s3c64xx/clock.c              |   67 +++++++++++++++++++++++++---
 arch/arm/plat-samsung/include/plat/clock.h |    2 +
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7e03f0a..71131f7 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/hardware.h>
 #include <mach/map.h>
@@ -32,6 +33,7 @@
 #include <plat/cpu-freq.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
+#include <plat/regs-usb-hsotg-phy.h>
 
 /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
  * ext_xtal_mux for want of an actual name from the manual.
@@ -61,7 +63,20 @@ struct clk clk_27m = {
 	.rate		= 27000000,
 };
 
-static int clk_48m_ctrl(struct clk *clk, int enable)
+void __init s3c64xx_clk_xusbxti_set_osc(int is_osc)
+{
+	u32 val;
+
+	/* no need to protect since it will be called from machine init */
+	val = __raw_readl(S3C_PHYCLK);
+	if (is_osc)
+		val |= S3C_PHYCLK_EXT_OSC;
+	else
+		val &= ~S3C_PHYCLK_EXT_OSC;
+	__raw_writel(val, S3C_PHYCLK);
+}
+
+static int clk_xusbxti_ctrl(struct clk *clk, int enable)
 {
 	unsigned long flags;
 	u32 val;
@@ -76,22 +91,62 @@ static int clk_48m_ctrl(struct clk *clk, int enable)
 		val &= ~S3C64XX_OTHERS_USBMASK;
 
 	__raw_writel(val, S3C64XX_OTHERS);
+
+	val = __raw_readl(S3C_PHYPWR);
+	if (enable)
+		val &= ~(SRC_PHYPWR_OTG_DISABLE | SRC_PHYPWR_ANALOG_POWERDOWN |
+			 SRC_PHYPWR_FORCE_SUSPEND);
+	else
+		val |= (SRC_PHYPWR_OTG_DISABLE | SRC_PHYPWR_ANALOG_POWERDOWN |
+			SRC_PHYPWR_FORCE_SUSPEND);
+	__raw_writel(val, S3C_PHYPWR);
+	mdelay(1);
+
+	if (enable) {
+		val = __raw_readl(S3C_PHYCLK);
+
+		val &= ~S3C_PHYCLK_CLKSEL_MASK;
+
+		switch (clk->rate) {
+		case 12*MHZ:
+			val |= S3C_PHYCLK_CLKSEL_12M;
+			break;
+		case 24*MHZ:
+			val |= S3C_PHYCLK_CLKSEL_24M;
+			break;
+		default:
+			pr_err("Invalid USB PHY external clock frequency: %lu\n",
+			       clk->rate);
+		case 48*MHZ:
+			/* default reference clock */
+			break;
+		}
+
+		__raw_writel(val | S3C_PHYCLK_CLK_FORCE, S3C_PHYCLK);
+
+		/* issue a full set of resets to the otg and core */
+		__raw_writel(S3C_RSTCON_PHY, S3C_RSTCON);
+		udelay(20);	/* at-least 10uS */
+		__raw_writel(0, S3C_RSTCON);
+	}
+
 	local_irq_restore(flags);
 
 	return 0;
 }
 
-struct clk clk_48m = {
-	.name		= "clk_48m",
+struct clk clk_xusbxti = {
+	.name		= "xusbxti",
 	.id		= -1,
 	.rate		= 48000000,
-	.enable		= clk_48m_ctrl,
+	.enable		= clk_xusbxti_ctrl,
 };
 
-struct clk clk_xusbxti = {
-	.name		= "xusbxti",
+struct clk clk_48m = {
+	.name		= "clk_48m",
 	.id		= -1,
 	.rate		= 48000000,
+	.parent		= &clk_xusbxti,
 };
 
 static int inline s3c64xx_gate(void __iomem *reg,
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 0fbcd0e..ed6f6fa 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -76,6 +76,8 @@ extern struct clk clk_27m;
 extern struct clk clk_48m;
 extern struct clk clk_xusbxti;
 
+extern void s3c64xx_clk_xusbxti_set_osc(int is_osc);
+
 extern int clk_default_setrate(struct clk *clk, unsigned long rate);
 extern struct clk_ops clk_ops_def_setrate;
 
