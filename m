From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 10 Oct 2010 13:54:11 +0300
Subject: [PATCH 3/4] ARM: ep93xx: add AC97 platform support
In-Reply-To: <cover.1286707213.git.mika.westerberg@iki.fi>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
Message-ID: <d63475d15634d7ffa4c4167cbead782a5aa1cfc9.1286707213.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform support for the EP93xx AC97 controller driver.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/core.c                     |   32 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    1 +
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 4cb55d3..6f514c4 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -826,6 +826,38 @@ void ep93xx_i2s_release(void)
 }
 EXPORT_SYMBOL(ep93xx_i2s_release);
 
+/*************************************************************************
+ * EP93xx AC97 audio peripheral handling
+ *************************************************************************/
+static struct resource ep93xx_ac97_resources[] = {
+	{
+		.start	= EP93XX_AAC_PHYS_BASE,
+		.end	= EP93XX_AAC_PHYS_BASE + 0xb0 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_EP93XX_AACINTR,
+		.end	= IRQ_EP93XX_AACINTR,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ep93xx_ac97_device = {
+	.name		= "ep93xx-ac97",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_ac97_resources),
+	.resource	= ep93xx_ac97_resources,
+};
+
+void __init ep93xx_register_ac97(void)
+{
+	/*
+	 * Make sure that the AC97 pins are not used by I2S.
+	 */
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97);
+	platform_device_register(&ep93xx_ac97_device);
+}
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index c54b3e5..9ac4d10 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -105,6 +105,7 @@
 #define EP93XX_GPIO_B_INT_STATUS	EP93XX_GPIO_REG(0xbc)
 #define EP93XX_GPIO_EEDRIVE		EP93XX_GPIO_REG(0xc8)
 
+#define EP93XX_AAC_PHYS_BASE		EP93XX_APB_PHYS(0x00080000)
 #define EP93XX_AAC_BASE			EP93XX_APB_IOMEM(0x00080000)
 
 #define EP93XX_SPI_PHYS_BASE		EP93XX_APB_PHYS(0x000a0000)
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 3330b36..5066045 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -61,6 +61,7 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev);
 void ep93xx_register_i2s(void);
 int ep93xx_i2s_acquire(unsigned i2s_pins, unsigned i2s_config);
 void ep93xx_i2s_release(void);
+void ep93xx_register_ac97(void);
 
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
-- 
1.5.6.5
