From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue,  8 Jun 2010 22:01:10 +1200
Subject: [PATCH 1/3] EP93xx: Add i2s core support
In-Reply-To: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add core support for EP93xx i2s audio

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-ep93xx/clock.c                    |   67 ++++++++++++++++++++++-
 arch/arm/mach-ep93xx/core.c                     |   67 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   10 ++++
 arch/arm/mach-ep93xx/include/mach/platform.h    |    3 +
 4 files changed, 146 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 5f80092..e782af1 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -43,7 +43,8 @@ static unsigned long get_uart_rate(struct clk *clk);
 
 static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
 static int set_div_rate(struct clk *clk, unsigned long rate);
-
+static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
+static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);
 
 static struct clk clk_xtali = {
 	.rate		= EP93XX_EXT_CLK_RATE,
@@ -108,6 +109,29 @@ static struct clk clk_video = {
 	.set_rate	= set_div_rate,
 };
 
+static struct clk clk_i2s_mclk = {
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_CLKDIV_ENABLE,
+	.set_rate	= set_div_rate,
+};
+
+static struct clk clk_i2s_sclk = {
+	.sw_locked	= 1,
+	.parent		= &clk_i2s_mclk,
+	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
+	.set_rate	= set_i2s_sclk_rate,
+};
+
+static struct clk clk_i2s_lrclk = {
+	.sw_locked	= 1,
+	.parent		= &clk_i2s_sclk,
+	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
+	.set_rate	= set_i2s_lrclk_rate,
+};
+
 /* DMA Clocks */
 static struct clk clk_m2p0 = {
 	.parent		= &clk_h,
@@ -186,6 +210,9 @@ static struct clk_lookup clocks[] = {
 	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
+	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
+	INIT_CK("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
+	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
 	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
 	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
 	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
@@ -396,6 +423,44 @@ static int set_div_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned val = __raw_readl(clk->enable_reg);
+
+	if (rate == clk_i2s_mclk.rate / 2)
+		ep93xx_syscon_swlocked_write(val & ~EP93XX_I2SCLKDIV_SDIV, 
+					     clk->enable_reg);
+	else if (rate == clk_i2s_mclk.rate / 4)
+		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_SDIV, 
+					     clk->enable_reg);
+	else
+		return -EINVAL;
+
+	clk_i2s_sclk.rate = rate;
+	return 0;
+}
+
+static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned val = __raw_readl(clk->enable_reg) & 
+		~EP93XX_I2SCLKDIV_LRDIV_MASK;
+	
+	if (rate == clk_i2s_sclk.rate / 32)
+		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV32,
+					     clk->enable_reg);
+	else if (rate == clk_i2s_sclk.rate / 64)
+		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV64,
+					     clk->enable_reg);
+	else if (rate == clk_i2s_sclk.rate / 128)
+		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV128,
+					     clk->enable_reg);
+	else
+		return -EINVAL;
+
+	clk_i2s_lrclk.rate = rate;
+	return 0;
+}
+
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	if (clk->set_rate)
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..005af0f 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -617,6 +617,73 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
 
+/*************************************************************************
+ * EP93xx I2S audio peripheral handling
+ *************************************************************************/
+static struct resource ep93xx_i2s_resource[] = {
+	{
+		.start	= EP93XX_I2S_PHYS_BASE,
+		.end	= EP93XX_I2S_PHYS_BASE + 0x100 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ep93xx_i2s_device = {
+	.name		= "ep93xx-i2s",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_i2s_resource),
+	.resource	= ep93xx_i2s_resource,
+};
+
+void __init ep93xx_register_i2s(void)
+{
+	platform_device_register(&ep93xx_i2s_device);
+}
+
+#define EP93XX_SYSCON_DEVCFG_I2S_MASK	(EP93XX_SYSCON_DEVCFG_I2SONSSP | \
+					 EP93XX_SYSCON_DEVCFG_I2SONAC97)
+
+#define EP93XX_I2SCLKDIV_MASK		(EP93XX_SYSCON_I2SCLKDIV_ORIDE | \
+					 EP93XX_SYSCON_I2SCLKDIV_SPOL)
+
+int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config)
+{
+	unsigned val;
+
+	/* Sanity check */
+	if (i2s_pins & ~EP93XX_SYSCON_DEVCFG_I2S_MASK)
+		return -EINVAL;
+	if (i2s_config & ~EP93XX_I2SCLKDIV_MASK)
+		return -EINVAL;
+
+	/* Must have only one of I2SONSSP/I2SONAC97 set */
+	if ((i2s_pins & EP93XX_SYSCON_DEVCFG_I2SONSSP) ==
+	    (i2s_pins & EP93XX_SYSCON_DEVCFG_I2SONAC97))
+		return -EINVAL;
+
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2S_MASK);
+	ep93xx_devcfg_set_bits(i2s_pins);
+
+	/*
+	 * This is potentially racy with the clock api for i2s_mclk, sclk and 
+	 * lrclk. Since the i2s driver is the only user of those clocks we
+	 * rely on it to prevent parallel use of this function and the 
+	 * clock api for the i2s clocks.
+	 */
+	val = __raw_readl(EP93XX_SYSCON_I2SCLKDIV);
+	val &= ~EP93XX_I2SCLKDIV_MASK;
+	val |= i2s_config;
+	ep93xx_syscon_swlocked_write(val, EP93XX_SYSCON_I2SCLKDIV);
+
+	return 0;
+}
+EXPORT_SYMBOL(ep93xx_i2s_acquire);
+
+void ep93xx_i2s_release(void)
+{
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2S_MASK);
+}
+EXPORT_SYMBOL(ep93xx_i2s_release);
 
 extern void ep93xx_gpio_init(void);
 
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 93e2ecc..3fbb095 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -93,6 +93,7 @@
 /* APB peripherals */
 #define EP93XX_TIMER_BASE		EP93XX_APB_IOMEM(0x00010000)
 
+#define EP93XX_I2S_PHYS_BASE		EP93XX_APB_PHYS(0x00020000)
 #define EP93XX_I2S_BASE			EP93XX_APB_IOMEM(0x00020000)
 
 #define EP93XX_SECURITY_BASE		EP93XX_APB_IOMEM(0x00030000)
@@ -193,6 +194,15 @@
 #define EP93XX_SYSCON_CLKDIV_ESEL	(1<<14)
 #define EP93XX_SYSCON_CLKDIV_PSEL	(1<<13)
 #define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
+#define EP93XX_SYSCON_I2SCLKDIV		EP93XX_SYSCON_REG(0x8c)
+#define EP93XX_SYSCON_I2SCLKDIV_SENA	(1<<31)
+#define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1<<29)
+#define EP93XX_SYSCON_I2SCLKDIV_SPOL	(1<<19)
+#define EP93XX_I2SCLKDIV_SDIV		(1 << 16)
+#define EP93XX_I2SCLKDIV_LRDIV32	(0 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV64	(1 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV128 	(2 << 17)
+#define EP93XX_I2SCLKDIV_LRDIV_MASK 	(3 << 17)
 #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
 #define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index c6dc14d..0f2822d 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -43,6 +43,9 @@ void ep93xx_pwm_release_gpio(struct platform_device *pdev);
 void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
 int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
 void ep93xx_keypad_release_gpio(struct platform_device *pdev);
+void ep93xx_register_i2s(void);
+int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config);
+void ep93xx_i2s_release(void);
 
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
-- 
1.6.0.4
