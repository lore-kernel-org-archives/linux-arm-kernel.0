From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 10 May 2012 15:14:44 +0200
Subject: [PATCH] ARM: ux500: Add audio-related platform-data
Message-ID: <1336655684-19682-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ola Lilja <ola.o.lilja@stericsson.com>

This patch adds audio-related platform-data like hardwired settings
for microphones and common-mode voltage for the earpiece.
There is also some refactoring of the msp/audio-files.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/Makefile                       |    3 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   58 ++++++++++++++++
 arch/arm/mach-ux500/board-mop500-msp.c             |   72 +++++++-------------
 arch/arm/mach-ux500/board-mop500.c                 |    5 +-
 arch/arm/mach-ux500/board-mop500.h                 |    2 +
 .../mach-ux500/include/mach/board-mop500-audio.h   |   52 ++++++++++++++
 .../arm/mach-ux500/include/mach/board-mop500-msp.h |   30 ++++++++
 7 files changed, 171 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-audio.h
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-msp.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 11729bc..f97cee8 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o \
-				board-mop500-msp.o
+				board-mop500-msp.o \
+				board-mop500-audio.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
new file mode 100644
index 0000000..e50b6a9
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+#include <mach/board-mop500-audio.h>
+
+static struct mop500_audio_platform_data mop500_audio_pdata = {
+	.amics =  {
+		.mic1_type = AMIC_TYPE_DIFFERENTIAL,
+		.mic2_type = AMIC_TYPE_DIFFERENTIAL,
+		.mic1a_micbias = AMIC_MICBIAS_VAMIC1,
+		.mic1b_micbias = AMIC_MICBIAS_VAMIC1,
+		.mic2_micbias = AMIC_MICBIAS_VAMIC2
+	},
+	.ear_cmv = EAR_CMV_0_95V
+};
+
+/* Platform device for MOP500 audio-parts */
+static struct platform_device mop500_audio = {
+	.name = "snd-soc-mop500",
+	.id = 0,
+	.dev = {
+		.platform_data = &mop500_audio_pdata,
+	},
+};
+
+/* Platform device for Ux500-PCM */
+static struct platform_device ux500_pcm = {
+	.name = "ux500-pcm",
+	.id = 0,
+	.dev = {
+		.platform_data = NULL,
+	},
+};
+
+int mop500_audio_init(struct device *parent)
+{
+	int ret;
+
+	pr_info("%s: Register platform-device 'snd-soc-mop500'.\n", __func__);
+	ret = platform_device_register(&mop500_audio);
+
+	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
+	ret |= platform_device_register(&ux500_pcm);
+
+	return ret;
+};
diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index 9960480..7b92eab 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -15,14 +14,13 @@
 
 #include <mach/devices.h>
 #include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/msp.h>
+#include <mach/board-mop500-msp.h>
 
 #include "ste-dma40-db8500.h"
-#include "board-mop500.h"
 #include "devices-db8500.h"
 #include "pins-db8500.h"
 
+
 /* MSP1/3 Tx/Rx usage protection */
 static DEFINE_SPINLOCK(msp_rxtx_lock);
 
@@ -96,7 +94,7 @@ static struct stedma40_chan_cfg msp0_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static struct msp_i2s_platform_data msp0_platform_data = {
+static struct msp_i2s_platform_data msp0_pdata = {
 	.id = MSP_I2S_0,
 	.msp_i2s_dma_rx = &msp0_dma_rx,
 	.msp_i2s_dma_tx = &msp0_dma_tx,
@@ -128,7 +126,7 @@ static struct stedma40_chan_cfg msp1_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static struct msp_i2s_platform_data msp1_platform_data = {
+static struct msp_i2s_platform_data msp1_pdata = {
 	.id = MSP_I2S_1,
 	.msp_i2s_dma_rx = NULL,
 	.msp_i2s_dma_tx = &msp1_dma_tx,
@@ -166,10 +164,10 @@ static struct stedma40_chan_cfg msp2_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static struct platform_device *db8500_add_msp_i2s(struct device *parent,
-			int id,
-			resource_size_t base, int irq,
-			struct msp_i2s_platform_data *pdata)
+static struct platform_device *mop500_msp_register_device(struct device *parent,
+						int id, resource_size_t base,
+						int irq,
+						struct msp_i2s_platform_data *pdata)
 {
 	struct platform_device *pdev;
 	struct resource res[] = {
@@ -177,45 +175,27 @@ static struct platform_device *db8500_add_msp_i2s(struct device *parent,
 		DEFINE_RES_IRQ(irq),
 	};
 
-	pr_info("Register platform-device 'ux500-msp-i2s', id %d, irq %d\n",
-		id, irq);
+	pr_info("%s: Register platform-device 'ux500-msp-i2s', id %d, irq %d\n",
+		__func__, id, irq);
 	pdev = platform_device_register_resndata(parent, "ux500-msp-i2s", id,
 						res, ARRAY_SIZE(res),
 						pdata, sizeof(*pdata));
 	if (!pdev) {
-		pr_err("Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
-			id);
+		pr_err("%s: Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
+			__func__, id);
 		return NULL;
 	}
 
 	return pdev;
 }
 
-/* Platform device for ASoC U8500 machine */
-static struct platform_device snd_soc_u8500 = {
-		.name = "snd-soc-u8500",
-		.id = 0,
-		.dev = {
-			.platform_data = NULL,
-		},
-};
-
-/* Platform device for Ux500-PCM */
-static struct platform_device ux500_pcm = {
-		.name = "ux500-pcm",
-		.id = 0,
-		.dev = {
-			.platform_data = NULL,
-		},
-};
-
-static struct msp_i2s_platform_data msp2_platform_data = {
+static struct msp_i2s_platform_data msp2_pdata = {
 	.id = MSP_I2S_2,
 	.msp_i2s_dma_rx = &msp2_dma_rx,
 	.msp_i2s_dma_tx = &msp2_dma_tx,
 };
 
-static struct msp_i2s_platform_data msp3_platform_data = {
+static struct msp_i2s_platform_data msp3_pdata = {
 	.id		= MSP_I2S_3,
 	.msp_i2s_dma_rx	= &msp1_dma_rx,
 	.msp_i2s_dma_tx	= NULL,
@@ -227,18 +207,15 @@ int mop500_msp_init(struct device *parent)
 {
 	struct platform_device *msp1;
 
-	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_u8500);
-
-	pr_info("Initialize MSP I2S-devices.\n");
-	db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-			   &msp0_platform_data);
-	msp1 = db8500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1,
-			   &msp1_platform_data);
-	db8500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2,
-			   &msp2_platform_data);
-	db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
-			   &msp3_platform_data);
+	pr_info("%s: Initialize MSP I2S-devices.\n", __func__);
+	mop500_msp_register_device(parent, 0, U8500_MSP0_BASE,
+				IRQ_DB8500_MSP0, &msp0_pdata);
+	msp1 = mop500_msp_register_device(parent, 1, U8500_MSP1_BASE,
+				IRQ_DB8500_MSP1, &msp1_pdata);
+	mop500_msp_register_device(parent, 2, U8500_MSP2_BASE,
+				IRQ_DB8500_MSP2, &msp2_pdata);
+	mop500_msp_register_device(parent, 3, U8500_MSP3_BASE,
+				IRQ_DB8500_MSP1, &msp3_pdata);
 
 	/* Get the pinctrl handle for MSP1 */
 	if (msp1) {
@@ -260,8 +237,5 @@ int mop500_msp_init(struct device *parent)
 		}
 	}
 
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
-
 	return 0;
 }
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 1dc3165..ee07269 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -52,7 +52,7 @@
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
-#include "board-mop500-msp.h"
+
 
 static struct gpio_led snowball_led_array[] = {
 	{
@@ -653,6 +653,7 @@ static void __init mop500_init_machine(void)
 	mop500_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -684,6 +685,7 @@ static void __init snowball_init_machine(void)
 	snowball_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -721,6 +723,7 @@ static void __init hrefv60_init_machine(void)
 	hrefv60_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index bc44c07..7fd4b57 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -88,6 +88,8 @@ void __init mop500_stuib_init(void);
 void __init mop500_pinmaps_init(void);
 void __init snowball_pinmaps_init(void);
 void __init hrefv60_pinmaps_init(void);
+void mop500_msp_init(struct device *parent);
+void mop500_audio_init(struct device *parent);
 
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
diff --git a/arch/arm/mach-ux500/include/mach/board-mop500-audio.h b/arch/arm/mach-ux500/include/mach/board-mop500-audio.h
new file mode 100644
index 0000000..15ffea6
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/board-mop500-audio.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef __BOARD_MOP500_AUDIO_H_
+#define __BOARD_MOP500_AUDIO_H_
+
+/* Mic-types */
+enum amic_type {
+	AMIC_TYPE_SINGLE_ENDED,
+	AMIC_TYPE_DIFFERENTIAL
+};
+
+/* Mic-biases */
+enum amic_micbias {
+	AMIC_MICBIAS_VAMIC1,
+	AMIC_MICBIAS_VAMIC2
+};
+
+/* Bias-voltage */
+enum ear_cm_voltage {
+	EAR_CMV_0_95V,
+	EAR_CMV_1_10V,
+	EAR_CMV_1_27V,
+	EAR_CMV_1_58V
+};
+
+/* Analog microphone settings */
+struct amic_settings {
+	enum amic_type mic1_type;
+	enum amic_type mic2_type;
+	enum amic_micbias mic1a_micbias;
+	enum amic_micbias mic1b_micbias;
+	enum amic_micbias mic2_micbias;
+};
+
+/* Platform data structure for the audio-parts of the MOP500 */
+struct mop500_audio_platform_data {
+	struct amic_settings amics;
+	enum ear_cm_voltage ear_cmv;
+};
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/board-mop500-msp.h b/arch/arm/mach-ux500/include/mach/board-mop500-msp.h
new file mode 100644
index 0000000..7f8a863
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/board-mop500-msp.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+
+#ifndef __BOARD_MOP500_MSP_H_
+#define __BOARD_MOP500_MSP_H_
+
+#include <plat/ste_dma40.h>
+
+enum msp_i2s_id {
+	MSP_I2S_0 = 0,
+	MSP_I2S_1,
+	MSP_I2S_2,
+	MSP_I2S_3,
+};
+
+/* Platform data structure for a MSP I2S-device */
+struct msp_i2s_platform_data {
+	enum msp_i2s_id id;
+	struct stedma40_chan_cfg *msp_i2s_dma_rx;
+	struct stedma40_chan_cfg *msp_i2s_dma_tx;
+	int (*msp_i2s_init) (void);
+	int (*msp_i2s_exit) (void);
+};
+
+#endif
-- 
1.7.9.2
