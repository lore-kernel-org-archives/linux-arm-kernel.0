From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 16 May 2010 23:19:36 +0800
Subject: [PATCH] NUC900/audio: Add nuc900 audio support part to arch
Message-ID: <4BF00D08.1060508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

This patch is to add audio support part to Winbond/Nuvoton
arm platform.

Thanks a lot!


Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

---
 arch/arm/mach-w90x900/dev.c              |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-w90x900/include/mach/mfp.h |   24 ++++++++++++++++++++++++
 arch/arm/mach-w90x900/mfp.c              |    6 ++++++
 3 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/mfp.h

diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index e2958eb..b2eda4d 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -423,6 +423,33 @@ void  nuc900_fb_set_platdata(struct nuc900fb_mach_info *pd)
 }
 #endif

+/* AUDIO controller*/
+static u64 nuc900_device_audio_dmamask = -1;
+static struct resource nuc900_ac97_resource[] = {
+	[0] = {
+		.start = W90X900_PA_ACTL,
+		.end   = W90X900_PA_ACTL + W90X900_SZ_ACTL - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_ACTL,
+		.end   = IRQ_ACTL,
+		.flags = IORESOURCE_IRQ,
+	}
+
+};
+
+struct platform_device nuc900_device_audio = {
+	.name		= "nuc900-audio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(nuc900_ac97_resource),
+	.resource	= nuc900_ac97_resource,
+	.dev              = {
+		.dma_mask               = &nuc900_device_audio_dmamask,
+		.coherent_dma_mask      = -1,
+	}
+};
+
 /*Here should be your evb resourse,such as LCD*/

 static struct platform_device *nuc900_public_dev[] __initdata = {
@@ -434,6 +461,7 @@ static struct platform_device *nuc900_public_dev[]
__initdata = {
 	&nuc900_device_emc,
 	&nuc900_device_spi,
 	&nuc900_device_wdt,
+	&nuc900_device_audio,
 };

 /* Provide adding specific CPU platform devices API */
diff --git a/arch/arm/mach-w90x900/include/mach/mfp.h
b/arch/arm/mach-w90x900/include/mach/mfp.h
new file mode 100644
index 0000000..94c0e71
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/mfp.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/mach-w90x900/include/mach/mfp.h
+ *
+ * Copyright (c) 2010 Nuvoton technology corporation.
+ *
+ * Wan ZongShun <mcuos.com@gmail.com>
+ *
+ * Based on arch/arm/mach-s3c2410/include/mach/map.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation;version 2 of the License.
+ *
+ */
+
+#ifndef __ASM_ARCH_MFP_H
+#define __ASM_ARCH_MFP_H
+
+extern void mfp_set_groupf(struct device *dev);
+extern void mfp_set_groupc(struct device *dev);
+extern void mfp_set_groupi(struct device *dev);
+extern void mfp_set_groupg(struct device *dev);
+
+#endif /* __ASM_ARCH_MFP_H */
diff --git a/arch/arm/mach-w90x900/mfp.c b/arch/arm/mach-w90x900/mfp.c
index a47dc9a..fb7fb62 100644
--- a/arch/arm/mach-w90x900/mfp.c
+++ b/arch/arm/mach-w90x900/mfp.c
@@ -36,9 +36,12 @@

 #define GPIOG0TO1	(0x03 << 14)
 #define GPIOG2TO3	(0x03 << 16)
+#define GPIOG22TO23	(0x03 << 22)
+
 #define ENSPI		(0x0a << 14)
 #define ENI2C0		(0x01 << 14)
 #define ENI2C1		(0x01 << 16)
+#define ENAC97		(0x02 << 22)

 static DEFINE_MUTEX(mfp_mutex);

@@ -146,6 +149,9 @@ void mfp_set_groupg(struct device *dev)
 	} else if (strcmp(dev_id, "nuc900-i2c1") == 0) {
 		mfpen &= ~(GPIOG2TO3);
 		mfpen |= ENI2C1;/*enable i2c1*/
+	} else if (strcmp(dev_id, "nuc900-audio") == 0) {
+		mfpen &= ~(GPIOG22TO23);
+		mfpen |= ENAC97;/*enable AC97*/
 	} else {
 		mfpen &= ~(GPIOG0TO1 | GPIOG2TO3);/*GPIOG[3:0]*/
 	}
-- 
1.6.3.3
