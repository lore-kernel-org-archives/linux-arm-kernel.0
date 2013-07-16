From: dsd@laptop.org (Daniel Drake)
Date: Tue, 16 Jul 2013 14:10:29 -0400 (EDT)
Subject: [PATCH RESEND 1/2] clk: mmp: use global clock lock
Message-ID: <20130716181029.C08D8FAAF3@dev.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmp platform shares a lock between different clock types, and all
clocks are currently initialized by static bindings.

Move this static/private lock into global context so that it can
easily be shared by clocks that will be defined by the device tree in
followup patches.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/clk/mmp/Makefile   |   2 +-
 drivers/clk/mmp/clk-apbc.c |  38 +++++----------
 drivers/clk/mmp/clk-apmu.c |  20 ++------
 drivers/clk/mmp/clk-mmp2.c | 116 ++++++++++++++++++++++-----------------------
 drivers/clk/mmp/clk.h      |   8 ++--
 drivers/clk/mmp/common.c   |  13 +++++
 6 files changed, 92 insertions(+), 105 deletions(-)
 create mode 100644 drivers/clk/mmp/common.c

Resending after a month without review.

diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 392d780..31aacb5 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for mmp specific clk
 #
 
-obj-y += clk-apbc.o clk-apmu.o clk-frac.o
+obj-y += common.o clk-apbc.o clk-apmu.o clk-frac.o
 
 obj-$(CONFIG_CPU_PXA168) += clk-pxa168.o
 obj-$(CONFIG_CPU_PXA910) += clk-pxa910.o
diff --git a/drivers/clk/mmp/clk-apbc.c b/drivers/clk/mmp/clk-apbc.c
index d14120e..89a146a 100644
--- a/drivers/clk/mmp/clk-apbc.c
+++ b/drivers/clk/mmp/clk-apbc.c
@@ -30,7 +30,6 @@ struct clk_apbc {
 	void __iomem		*base;
 	unsigned int		delay;
 	unsigned int		flags;
-	spinlock_t		*lock;
 };
 
 static int clk_apbc_prepare(struct clk_hw *hw)
@@ -43,8 +42,7 @@ static int clk_apbc_prepare(struct clk_hw *hw)
 	 * It may share same register as MUX clock,
 	 * and it will impact FNCLK enable. Spinlock is needed
 	 */
-	if (apbc->lock)
-		spin_lock_irqsave(apbc->lock, flags);
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 
 	data = readl_relaxed(apbc->base);
 	if (apbc->flags & APBC_POWER_CTRL)
@@ -52,33 +50,26 @@ static int clk_apbc_prepare(struct clk_hw *hw)
 	data |= APBC_FNCLK;
 	writel_relaxed(data, apbc->base);
 
-	if (apbc->lock)
-		spin_unlock_irqrestore(apbc->lock, flags);
-
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 	udelay(apbc->delay);
-
-	if (apbc->lock)
-		spin_lock_irqsave(apbc->lock, flags);
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 
 	data = readl_relaxed(apbc->base);
 	data |= APBC_APBCLK;
 	writel_relaxed(data, apbc->base);
 
-	if (apbc->lock)
-		spin_unlock_irqrestore(apbc->lock, flags);
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 
 	udelay(apbc->delay);
 
 	if (!(apbc->flags & APBC_NO_BUS_CTRL)) {
-		if (apbc->lock)
-			spin_lock_irqsave(apbc->lock, flags);
+		spin_lock_irqsave(&mmp_clk_lock, flags);
 
 		data = readl_relaxed(apbc->base);
 		data &= ~APBC_RST;
 		writel_relaxed(data, apbc->base);
 
-		if (apbc->lock)
-			spin_unlock_irqrestore(apbc->lock, flags);
+		spin_unlock_irqrestore(&mmp_clk_lock, flags);
 	}
 
 	return 0;
@@ -90,8 +81,7 @@ static void clk_apbc_unprepare(struct clk_hw *hw)
 	unsigned long data;
 	unsigned long flags = 0;
 
-	if (apbc->lock)
-		spin_lock_irqsave(apbc->lock, flags);
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 
 	data = readl_relaxed(apbc->base);
 	if (apbc->flags & APBC_POWER_CTRL)
@@ -99,20 +89,15 @@ static void clk_apbc_unprepare(struct clk_hw *hw)
 	data &= ~APBC_FNCLK;
 	writel_relaxed(data, apbc->base);
 
-	if (apbc->lock)
-		spin_unlock_irqrestore(apbc->lock, flags);
-
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 	udelay(10);
-
-	if (apbc->lock)
-		spin_lock_irqsave(apbc->lock, flags);
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 
 	data = readl_relaxed(apbc->base);
 	data &= ~APBC_APBCLK;
 	writel_relaxed(data, apbc->base);
 
-	if (apbc->lock)
-		spin_unlock_irqrestore(apbc->lock, flags);
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 }
 
 struct clk_ops clk_apbc_ops = {
@@ -122,7 +107,7 @@ struct clk_ops clk_apbc_ops = {
 
 struct clk *mmp_clk_register_apbc(const char *name, const char *parent_name,
 		void __iomem *base, unsigned int delay,
-		unsigned int apbc_flags, spinlock_t *lock)
+		unsigned int apbc_flags)
 {
 	struct clk_apbc *apbc;
 	struct clk *clk;
@@ -141,7 +126,6 @@ struct clk *mmp_clk_register_apbc(const char *name, const char *parent_name,
 	apbc->base = base;
 	apbc->delay = delay;
 	apbc->flags = apbc_flags;
-	apbc->lock = lock;
 	apbc->hw.init = &init;
 
 	clk = clk_register(NULL, &apbc->hw);
diff --git a/drivers/clk/mmp/clk-apmu.c b/drivers/clk/mmp/clk-apmu.c
index abe182b..4f4d8c5 100644
--- a/drivers/clk/mmp/clk-apmu.c
+++ b/drivers/clk/mmp/clk-apmu.c
@@ -24,7 +24,6 @@ struct clk_apmu {
 	void __iomem    *base;
 	u32		rst_mask;
 	u32		enable_mask;
-	spinlock_t	*lock;
 };
 
 static int clk_apmu_enable(struct clk_hw *hw)
@@ -33,14 +32,10 @@ static int clk_apmu_enable(struct clk_hw *hw)
 	unsigned long data;
 	unsigned long flags = 0;
 
-	if (apmu->lock)
-		spin_lock_irqsave(apmu->lock, flags);
-
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 	data = readl_relaxed(apmu->base) | apmu->enable_mask;
 	writel_relaxed(data, apmu->base);
-
-	if (apmu->lock)
-		spin_unlock_irqrestore(apmu->lock, flags);
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 
 	return 0;
 }
@@ -51,14 +46,10 @@ static void clk_apmu_disable(struct clk_hw *hw)
 	unsigned long data;
 	unsigned long flags = 0;
 
-	if (apmu->lock)
-		spin_lock_irqsave(apmu->lock, flags);
-
+	spin_lock_irqsave(&mmp_clk_lock, flags);
 	data = readl_relaxed(apmu->base) & ~apmu->enable_mask;
 	writel_relaxed(data, apmu->base);
-
-	if (apmu->lock)
-		spin_unlock_irqrestore(apmu->lock, flags);
+	spin_unlock_irqrestore(&mmp_clk_lock, flags);
 }
 
 struct clk_ops clk_apmu_ops = {
@@ -67,7 +58,7 @@ struct clk_ops clk_apmu_ops = {
 };
 
 struct clk *mmp_clk_register_apmu(const char *name, const char *parent_name,
-		void __iomem *base, u32 enable_mask, spinlock_t *lock)
+		void __iomem *base, u32 enable_mask)
 {
 	struct clk_apmu *apmu;
 	struct clk *clk;
@@ -85,7 +76,6 @@ struct clk *mmp_clk_register_apmu(const char *name, const char *parent_name,
 
 	apmu->base = base;
 	apmu->enable_mask = enable_mask;
-	apmu->lock = lock;
 	apmu->hw.init = &init;
 
 	clk = clk_register(NULL, &apmu->hw);
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index d1f1a19..cb1b0b6 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -52,8 +52,6 @@
 #define APMU_CCIC1	0xf4
 #define MPMU_UART_PLL	0x14
 
-static DEFINE_SPINLOCK(clk_lock);
-
 static struct clk_factor_masks uart_factor_masks = {
 	.factor = 2,
 	.num_mask = 0x1fff,
@@ -196,254 +194,254 @@ void __init mmp2_clk_init(void)
 	clk_register_clkdev(clk, "uart_pll", NULL);
 
 	clk = mmp_clk_register_apbc("twsi0", "vctcxo",
-				apbc_base + APBC_TWSI0, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI0, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.0");
 
 	clk = mmp_clk_register_apbc("twsi1", "vctcxo",
-				apbc_base + APBC_TWSI1, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI1, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.1");
 
 	clk = mmp_clk_register_apbc("twsi2", "vctcxo",
-				apbc_base + APBC_TWSI2, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI2, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.2");
 
 	clk = mmp_clk_register_apbc("twsi3", "vctcxo",
-				apbc_base + APBC_TWSI3, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI3, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.3");
 
 	clk = mmp_clk_register_apbc("twsi4", "vctcxo",
-				apbc_base + APBC_TWSI4, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI4, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.4");
 
 	clk = mmp_clk_register_apbc("twsi5", "vctcxo",
-				apbc_base + APBC_TWSI5, 10, 0, &clk_lock);
+				apbc_base + APBC_TWSI5, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-i2c.5");
 
 	clk = mmp_clk_register_apbc("gpio", "vctcxo",
-				apbc_base + APBC_GPIO, 10, 0, &clk_lock);
+				apbc_base + APBC_GPIO, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp2-gpio");
 
 	clk = mmp_clk_register_apbc("kpc", "clk32",
-				apbc_base + APBC_KPC, 10, 0, &clk_lock);
+				apbc_base + APBC_KPC, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa27x-keypad");
 
 	clk = mmp_clk_register_apbc("rtc", "clk32",
-				apbc_base + APBC_RTC, 10, 0, &clk_lock);
+				apbc_base + APBC_RTC, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp-rtc");
 
 	clk = mmp_clk_register_apbc("pwm0", "vctcxo",
-				apbc_base + APBC_PWM0, 10, 0, &clk_lock);
+				apbc_base + APBC_PWM0, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp2-pwm.0");
 
 	clk = mmp_clk_register_apbc("pwm1", "vctcxo",
-				apbc_base + APBC_PWM1, 10, 0, &clk_lock);
+				apbc_base + APBC_PWM1, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp2-pwm.1");
 
 	clk = mmp_clk_register_apbc("pwm2", "vctcxo",
-				apbc_base + APBC_PWM2, 10, 0, &clk_lock);
+				apbc_base + APBC_PWM2, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp2-pwm.2");
 
 	clk = mmp_clk_register_apbc("pwm3", "vctcxo",
-				apbc_base + APBC_PWM3, 10, 0, &clk_lock);
+				apbc_base + APBC_PWM3, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp2-pwm.3");
 
 	clk = clk_register_mux(NULL, "uart0_mux", uart_parent,
 				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_UART0, 4, 3, 0, &mmp_clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("uart0", "uart0_mux",
-				apbc_base + APBC_UART0, 10, 0, &clk_lock);
+				apbc_base + APBC_UART0, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.0");
 
 	clk = clk_register_mux(NULL, "uart1_mux", uart_parent,
 				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_UART1, 4, 3, 0, &mmp_clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("uart1", "uart1_mux",
-				apbc_base + APBC_UART1, 10, 0, &clk_lock);
+				apbc_base + APBC_UART1, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.1");
 
 	clk = clk_register_mux(NULL, "uart2_mux", uart_parent,
 				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_UART2, 4, 3, 0, &mmp_clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("uart2", "uart2_mux",
-				apbc_base + APBC_UART2, 10, 0, &clk_lock);
+				apbc_base + APBC_UART2, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.2");
 
 	clk = clk_register_mux(NULL, "uart3_mux", uart_parent,
 				ARRAY_SIZE(uart_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_UART3, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_UART3, 4, 3, 0, &mmp_clk_lock);
 	clk_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.3", NULL);
 
 	clk = mmp_clk_register_apbc("uart3", "uart3_mux",
-				apbc_base + APBC_UART3, 10, 0, &clk_lock);
+				apbc_base + APBC_UART3, 10, 0);
 	clk_register_clkdev(clk, NULL, "pxa2xx-uart.3");
 
 	clk = clk_register_mux(NULL, "ssp0_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_SSP0, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_SSP0, 4, 3, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("ssp0", "ssp0_mux",
-				apbc_base + APBC_SSP0, 10, 0, &clk_lock);
+				apbc_base + APBC_SSP0, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp-ssp.0");
 
 	clk = clk_register_mux(NULL, "ssp1_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_SSP1, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_SSP1, 4, 3, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("ssp1", "ssp1_mux",
-				apbc_base + APBC_SSP1, 10, 0, &clk_lock);
+				apbc_base + APBC_SSP1, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp-ssp.1");
 
 	clk = clk_register_mux(NULL, "ssp2_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_SSP2, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_SSP2, 4, 3, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("ssp2", "ssp2_mux",
-				apbc_base + APBC_SSP2, 10, 0, &clk_lock);
+				apbc_base + APBC_SSP2, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp-ssp.2");
 
 	clk = clk_register_mux(NULL, "ssp3_mux", ssp_parent,
 				ARRAY_SIZE(ssp_parent), CLK_SET_RATE_PARENT,
-				apbc_base + APBC_SSP3, 4, 3, 0, &clk_lock);
+				apbc_base + APBC_SSP3, 4, 3, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ssp_mux.3", NULL);
 
 	clk = mmp_clk_register_apbc("ssp3", "ssp3_mux",
-				apbc_base + APBC_SSP3, 10, 0, &clk_lock);
+				apbc_base + APBC_SSP3, 10, 0);
 	clk_register_clkdev(clk, NULL, "mmp-ssp.3");
 
 	clk = clk_register_mux(NULL, "sdh_mux", sdh_parent,
 				ARRAY_SIZE(sdh_parent), CLK_SET_RATE_PARENT,
-				apmu_base + APMU_SDH0, 8, 2, 0, &clk_lock);
+				apmu_base + APMU_SDH0, 8, 2, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "sdh_mux", NULL);
 
 	clk = clk_register_divider(NULL, "sdh_div", "sdh_mux",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_SDH0,
-				10, 4, CLK_DIVIDER_ONE_BASED, &clk_lock);
+				10, 4, CLK_DIVIDER_ONE_BASED, &mmp_clk_lock);
 	clk_register_clkdev(clk, "sdh_div", NULL);
 
 	clk = mmp_clk_register_apmu("sdh0", "sdh_div", apmu_base + APMU_SDH0,
-				0x1b, &clk_lock);
+				0x1b);
 	clk_register_clkdev(clk, NULL, "sdhci-pxav3.0");
 
 	clk = mmp_clk_register_apmu("sdh1", "sdh_div", apmu_base + APMU_SDH1,
-				0x1b, &clk_lock);
+				0x1b);
 	clk_register_clkdev(clk, NULL, "sdhci-pxav3.1");
 
 	clk = mmp_clk_register_apmu("sdh2", "sdh_div", apmu_base + APMU_SDH2,
-				0x1b, &clk_lock);
+				0x1b);
 	clk_register_clkdev(clk, NULL, "sdhci-pxav3.2");
 
 	clk = mmp_clk_register_apmu("sdh3", "sdh_div", apmu_base + APMU_SDH3,
-				0x1b, &clk_lock);
+				0x1b);
 	clk_register_clkdev(clk, NULL, "sdhci-pxav3.3");
 
 	clk = mmp_clk_register_apmu("usb", "usb_pll", apmu_base + APMU_USB,
-				0x9, &clk_lock);
+				0x9);
 	clk_register_clkdev(clk, "usb_clk", NULL);
 
 	clk = clk_register_mux(NULL, "disp0_mux", disp_parent,
 				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
-				apmu_base + APMU_DISP0, 6, 2, 0, &clk_lock);
+				apmu_base + APMU_DISP0, 6, 2, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "disp_mux.0", NULL);
 
 	clk = clk_register_divider(NULL, "disp0_div", "disp0_mux",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_DISP0,
-				8, 4, CLK_DIVIDER_ONE_BASED, &clk_lock);
+				8, 4, CLK_DIVIDER_ONE_BASED, &mmp_clk_lock);
 	clk_register_clkdev(clk, "disp_div.0", NULL);
 
 	clk = mmp_clk_register_apmu("disp0", "disp0_div",
-				apmu_base + APMU_DISP0, 0x1b, &clk_lock);
+				apmu_base + APMU_DISP0, 0x1b);
 	clk_register_clkdev(clk, NULL, "mmp-disp.0");
 
 	clk = clk_register_divider(NULL, "disp0_sphy_div", "disp0_mux", 0,
-				apmu_base + APMU_DISP0, 15, 5, 0, &clk_lock);
+				apmu_base + APMU_DISP0, 15, 5, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "disp_sphy_div.0", NULL);
 
 	clk = mmp_clk_register_apmu("disp0_sphy", "disp0_sphy_div",
-				apmu_base + APMU_DISP0, 0x1024, &clk_lock);
+				apmu_base + APMU_DISP0, 0x1024);
 	clk_register_clkdev(clk, "disp_sphy.0", NULL);
 
 	clk = clk_register_mux(NULL, "disp1_mux", disp_parent,
 				ARRAY_SIZE(disp_parent), CLK_SET_RATE_PARENT,
-				apmu_base + APMU_DISP1, 6, 2, 0, &clk_lock);
+				apmu_base + APMU_DISP1, 6, 2, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "disp_mux.1", NULL);
 
 	clk = clk_register_divider(NULL, "disp1_div", "disp1_mux",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_DISP1,
-				8, 4, CLK_DIVIDER_ONE_BASED, &clk_lock);
+				8, 4, CLK_DIVIDER_ONE_BASED, &mmp_clk_lock);
 	clk_register_clkdev(clk, "disp_div.1", NULL);
 
 	clk = mmp_clk_register_apmu("disp1", "disp1_div",
-				apmu_base + APMU_DISP1, 0x1b, &clk_lock);
+				apmu_base + APMU_DISP1, 0x1b);
 	clk_register_clkdev(clk, NULL, "mmp-disp.1");
 
 	clk = mmp_clk_register_apmu("ccic_arbiter", "vctcxo",
-				apmu_base + APMU_CCIC0, 0x1800, &clk_lock);
+				apmu_base + APMU_CCIC0, 0x1800);
 	clk_register_clkdev(clk, "ccic_arbiter", NULL);
 
 	clk = clk_register_mux(NULL, "ccic0_mux", ccic_parent,
 				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
-				apmu_base + APMU_CCIC0, 6, 2, 0, &clk_lock);
+				apmu_base + APMU_CCIC0, 6, 2, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.0", NULL);
 
 	clk = clk_register_divider(NULL, "ccic0_div", "ccic0_mux",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC0,
-				17, 4, CLK_DIVIDER_ONE_BASED, &clk_lock);
+				17, 4, CLK_DIVIDER_ONE_BASED, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ccic_div.0", NULL);
 
 	clk = mmp_clk_register_apmu("ccic0", "ccic0_div",
-				apmu_base + APMU_CCIC0, 0x1b, &clk_lock);
+				apmu_base + APMU_CCIC0, 0x1b);
 	clk_register_clkdev(clk, "fnclk", "mmp-ccic.0");
 
 	clk = mmp_clk_register_apmu("ccic0_phy", "ccic0_div",
-				apmu_base + APMU_CCIC0, 0x24, &clk_lock);
+				apmu_base + APMU_CCIC0, 0x24);
 	clk_register_clkdev(clk, "phyclk", "mmp-ccic.0");
 
 	clk = clk_register_divider(NULL, "ccic0_sphy_div", "ccic0_div",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC0,
-				10, 5, 0, &clk_lock);
+				10, 5, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "sphyclk_div", "mmp-ccic.0");
 
 	clk = mmp_clk_register_apmu("ccic0_sphy", "ccic0_sphy_div",
-				apmu_base + APMU_CCIC0, 0x300, &clk_lock);
+				apmu_base + APMU_CCIC0, 0x300);
 	clk_register_clkdev(clk, "sphyclk", "mmp-ccic.0");
 
 	clk = clk_register_mux(NULL, "ccic1_mux", ccic_parent,
 				ARRAY_SIZE(ccic_parent), CLK_SET_RATE_PARENT,
-				apmu_base + APMU_CCIC1, 6, 2, 0, &clk_lock);
+				apmu_base + APMU_CCIC1, 6, 2, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ccic_mux.1", NULL);
 
 	clk = clk_register_divider(NULL, "ccic1_div", "ccic1_mux",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC1,
-				16, 4, CLK_DIVIDER_ONE_BASED, &clk_lock);
+				16, 4, CLK_DIVIDER_ONE_BASED, &mmp_clk_lock);
 	clk_register_clkdev(clk, "ccic_div.1", NULL);
 
 	clk = mmp_clk_register_apmu("ccic1", "ccic1_div",
-				apmu_base + APMU_CCIC1, 0x1b, &clk_lock);
+				apmu_base + APMU_CCIC1, 0x1b);
 	clk_register_clkdev(clk, "fnclk", "mmp-ccic.1");
 
 	clk = mmp_clk_register_apmu("ccic1_phy", "ccic1_div",
-				apmu_base + APMU_CCIC1, 0x24, &clk_lock);
+				apmu_base + APMU_CCIC1, 0x24);
 	clk_register_clkdev(clk, "phyclk", "mmp-ccic.1");
 
 	clk = clk_register_divider(NULL, "ccic1_sphy_div", "ccic1_div",
 				CLK_SET_RATE_PARENT, apmu_base + APMU_CCIC1,
-				10, 5, 0, &clk_lock);
+				10, 5, 0, &mmp_clk_lock);
 	clk_register_clkdev(clk, "sphyclk_div", "mmp-ccic.1");
 
 	clk = mmp_clk_register_apmu("ccic1_sphy", "ccic1_sphy_div",
-				apmu_base + APMU_CCIC1, 0x300, &clk_lock);
+				apmu_base + APMU_CCIC1, 0x300);
 	clk_register_clkdev(clk, "sphyclk", "mmp-ccic.1");
 }
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index ab86dd4..d697d9b 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -3,6 +3,9 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t mmp_clk_lock;
 
 #define APBC_NO_BUS_CTRL	BIT(0)
 #define APBC_POWER_CTRL		BIT(1)
@@ -24,10 +27,9 @@ extern struct clk *mmp_clk_register_pll2(const char *name,
 		const char *parent_name, unsigned long flags);
 extern struct clk *mmp_clk_register_apbc(const char *name,
 		const char *parent_name, void __iomem *base,
-		unsigned int delay, unsigned int apbc_flags, spinlock_t *lock);
+		unsigned int delay, unsigned int apbc_flags);
 extern struct clk *mmp_clk_register_apmu(const char *name,
-		const char *parent_name, void __iomem *base, u32 enable_mask,
-		spinlock_t *lock);
+		const char *parent_name, void __iomem *base, u32 enable_mask);
 extern struct clk *mmp_clk_register_factor(const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *base, struct clk_factor_masks *masks,
diff --git a/drivers/clk/mmp/common.c b/drivers/clk/mmp/common.c
new file mode 100644
index 0000000..dadce5f
--- /dev/null
+++ b/drivers/clk/mmp/common.c
@@ -0,0 +1,13 @@
+/*
+ * mmp clock common elements
+ *
+ * Copyright (C) 2013 One Laptop per Child
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/spinlock.h>
+
+DEFINE_SPINLOCK(mmp_clk_lock);
-- 
1.8.1.4
