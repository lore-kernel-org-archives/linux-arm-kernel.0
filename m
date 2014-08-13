From: zonque@gmail.com (Daniel Mack)
Date: Wed, 13 Aug 2014 21:59:19 +0200
Subject: [PATCH 2/2] ARM: pxa3xx: provide specific platform_devices for all
 ssp ports
In-Reply-To: <1407959959-4977-1-git-send-email-zonque@gmail.com>
References: <1407959959-4977-1-git-send-email-zonque@gmail.com>
Message-ID: <1407959959-4977-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, devices for SSP ports 1, 2 and 3 are registered as compatible
devices to pxa27x-ssp. While the actual IP core is comparable, there are
some subtle differences which users of the SSP ports address by looking at
the 'type' field.

By registering devices of type 'pxa27x-ssp', this 'type' field is
incorrectly set to PXA27x_SSP which confuses the users.

To fix this, provide specific ssp port plaform devices which use
'pxa3xx-ssp' as driver name, an instantiate them from pxa3xx.c.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/devices.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-pxa/devices.h |  3 +++
 arch/arm/mach-pxa/pxa3xx.c  | 14 +++++++-------
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 78b7181..d1d8ea0 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1099,9 +1099,47 @@ static struct resource pxa3xx_resource_ssp4[] = {
 	},
 };
 
+/*
+ * PXA3xx SSP is basically equivalent to PXA27x.
+ * However, we need to register the device by the correct name in order to
+ * make the driver set the correct internal type, hence we provide specific
+ * platform_devices for each of them.
+ */
+struct platform_device pxa3xx_device_ssp1 = {
+	.name		= "pxa3xx-ssp",
+	.id		= 0,
+	.dev		= {
+		.dma_mask = &pxa27x_ssp1_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.resource	= pxa27x_resource_ssp1,
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp1),
+};
+
+struct platform_device pxa3xx_device_ssp2 = {
+	.name		= "pxa3xx-ssp",
+	.id		= 1,
+	.dev		= {
+		.dma_mask = &pxa27x_ssp2_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.resource	= pxa27x_resource_ssp2,
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp2),
+};
+
+struct platform_device pxa3xx_device_ssp3 = {
+	.name		= "pxa3xx-ssp",
+	.id		= 2,
+	.dev		= {
+		.dma_mask = &pxa27x_ssp3_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.resource	= pxa27x_resource_ssp3,
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp3),
+};
+
 struct platform_device pxa3xx_device_ssp4 = {
-	/* PXA3xx SSP is basically equivalent to PXA27x */
-	.name		= "pxa27x-ssp",
+	.name		= "pxa3xx-ssp",
 	.id		= 3,
 	.dev		= {
 		.dma_mask = &pxa3xx_ssp4_dma_mask,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 19906c9..298caea 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -28,6 +28,9 @@ extern struct platform_device pxa25x_device_assp;
 extern struct platform_device pxa27x_device_ssp1;
 extern struct platform_device pxa27x_device_ssp2;
 extern struct platform_device pxa27x_device_ssp3;
+extern struct platform_device pxa3xx_device_ssp1;
+extern struct platform_device pxa3xx_device_ssp2;
+extern struct platform_device pxa3xx_device_ssp3;
 extern struct platform_device pxa3xx_device_ssp4;
 
 extern struct platform_device pxa25x_device_pwm0;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 7675a5d..0c20bcf 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -84,10 +84,10 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_usbh, "pxa27x-ohci", NULL),
 	INIT_CLKREG(&clk_pxa3xx_u2d, "pxa3xx-u2d", NULL),
 	INIT_CLKREG(&clk_pxa3xx_keypad, "pxa27x-keypad", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa27x-ssp.0", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa27x-ssp.1", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp3, "pxa27x-ssp.2", NULL),
-	INIT_CLKREG(&clk_pxa3xx_ssp4, "pxa27x-ssp.3", NULL),
+	INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa3xx-ssp.0", NULL),
+	INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa3xx-ssp.1", NULL),
+	INIT_CLKREG(&clk_pxa3xx_ssp3, "pxa3xx-ssp.2", NULL),
+	INIT_CLKREG(&clk_pxa3xx_ssp4, "pxa3xx-ssp.3", NULL),
 	INIT_CLKREG(&clk_pxa3xx_pwm0, "pxa27x-pwm.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_pwm1, "pxa27x-pwm.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
@@ -456,9 +456,9 @@ static struct platform_device *devices[] __initdata = {
 	&pxa_device_asoc_platform,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
-	&pxa27x_device_ssp1,
-	&pxa27x_device_ssp2,
-	&pxa27x_device_ssp3,
+	&pxa3xx_device_ssp1,
+	&pxa3xx_device_ssp2,
+	&pxa3xx_device_ssp3,
 	&pxa3xx_device_ssp4,
 	&pxa27x_device_pwm0,
 	&pxa27x_device_pwm1,
-- 
2.0.4
