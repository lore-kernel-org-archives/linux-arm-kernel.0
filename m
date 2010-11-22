From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 22 Nov 2010 20:28:59 +0800
Subject: [PATCH] ARM: mmp: remove pxa_register_device
Message-ID: <1290428939-18863-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa_register_device() is used to register platform device by simple way.
But it's limited in one IRQ and one memory map in platform device. Since
we can't avoid to use platform_device_register(), pxa_register_device()
increase the complexity of registering platform device.

pxa_register_device() can't handle platform data structure also. So adding
PXAxxx_add_yyy() API is used to transmit platform data structure to device
driver. No we can use platform_device_add_data() instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/Makefile               |    2 +-
 arch/arm/mach-mmp/aspenite.c             |   34 ++++--
 arch/arm/mach-mmp/avengers_lite.c        |    8 +-
 arch/arm/mach-mmp/devices.c              |   69 ----------
 arch/arm/mach-mmp/flint.c                |   15 ++-
 arch/arm/mach-mmp/include/mach/devices.h |   53 --------
 arch/arm/mach-mmp/include/mach/mmp2.h    |   90 ++-----------
 arch/arm/mach-mmp/include/mach/pxa168.h  |  126 +++---------------
 arch/arm/mach-mmp/include/mach/pxa910.h  |   78 ++----------
 arch/arm/mach-mmp/jasper.c               |   22 +++-
 arch/arm/mach-mmp/mmp2.c                 |  201 ++++++++++++++++++++++++++---
 arch/arm/mach-mmp/pxa168.c               |  213 +++++++++++++++++++++++++++---
 arch/arm/mach-mmp/pxa910.c               |  117 +++++++++++++++--
 arch/arm/mach-mmp/tavorevb.c             |   13 +-
 arch/arm/mach-mmp/teton_bga.c            |   18 ++-
 arch/arm/mach-mmp/ttc_dkb.c              |    7 +-
 16 files changed, 607 insertions(+), 459 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/devices.c
 delete mode 100644 arch/arm/mach-mmp/include/mach/devices.h

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 751cdbf..1b0927f 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Marvell's PXA168 processors line
 #
 
-obj-y				+= common.o clock.o devices.o time.o
+obj-y				+= common.o clock.o time.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o irq-pxa168.o
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..185c905 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -25,8 +25,9 @@
 #include <mach/pxa168.h>
 #include <mach/gpio.h>
 #include <video/pxa168fb.h>
-#include <linux/input.h>
 #include <plat/pxa27x_keypad.h>
+#include <plat/i2c.h>
+#include <plat/pxa3xx_nand.h>
 
 #include "common.h"
 
@@ -218,22 +219,33 @@ static struct pxa27x_keypad_platform_data aspenite_keypad_info __initdata = {
 	.matrix_key_map		= aspenite_matrix_key_map,
 	.matrix_key_map_size	= ARRAY_SIZE(aspenite_matrix_key_map),
 	.debounce_interval	= 30,
+	.clear_wakeup_event	= pxa168_clear_keypad_wakeup,
+};
+
+static struct platform_device *aspenite_devices[] = {
+	/* on-chip devices */
+	&pxa168_device_uart1,
+	&pxa168_device_twsi1,
+	&pxa168_device_ssp1,
+	&pxa168_device_nand,
+	&pxa168_device_fb,
+	&pxa168_device_keypad,
+	/* off-chip devices */
+	&smc91x_device,
 };
 
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
 
-	/* on-chip devices */
-	pxa168_add_uart(1);
-	pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
-	pxa168_add_ssp(1);
-	pxa168_add_nand(&aspenite_nand_info);
-	pxa168_add_fb(&aspenite_lcd_info);
-	pxa168_add_keypad(&aspenite_keypad_info);
-
-	/* off-chip devices */
-	platform_device_register(&smc91x_device);
+	platform_device_add_data(&pxa168_device_nand, &aspenite_nand_info,
+				 sizeof(struct pxa3xx_nand_platform_data));
+	platform_device_add_data(&pxa168_device_fb, &aspenite_lcd_info,
+				 sizeof(struct pxa168fb_mach_info));
+	platform_device_add_data(&pxa168_device_keypad, &aspenite_keypad_info,
+				 sizeof(struct pxa27x_keypad_platform_data));
+	platform_add_devices(ARRAY_AND_SIZE(aspenite_devices));
+	i2c_register_board_info(1, ARRAY_AND_SIZE(aspenite_i2c_info));
 }
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 39f0878..098fecf 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -32,12 +32,16 @@ static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
 	GPIO89_UART2_RXD,
 };
 
+static struct platform_device *avengers_lite_devices[] = {
+	/* on-chip devices */
+	&pxa168_device_uart2,
+};
+
 static void __init avengers_lite_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(avengers_lite_pin_config_V16F));
 
-	/* on-chip devices */
-	pxa168_add_uart(2);
+	platform_add_devices(ARRAY_AND_SIZE(avengers_lite_devices));
 }
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
deleted file mode 100644
index 191d9de..0000000
--- a/arch/arm/mach-mmp/devices.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/devices.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/irq.h>
-#include <mach/devices.h>
-
-int __init pxa_register_device(struct pxa_device_desc *desc,
-				void *data, size_t size)
-{
-	struct platform_device *pdev;
-	struct resource res[2 + MAX_RESOURCE_DMA];
-	int i, ret = 0, nres = 0;
-
-	pdev = platform_device_alloc(desc->drv_name, desc->id);
-	if (pdev == NULL)
-		return -ENOMEM;
-
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-
-	memset(res, 0, sizeof(res));
-
-	if (desc->start != -1ul && desc->size > 0) {
-		res[nres].start	= desc->start;
-		res[nres].end	= desc->start + desc->size - 1;
-		res[nres].flags	= IORESOURCE_MEM;
-		nres++;
-	}
-
-	if (desc->irq != NO_IRQ) {
-		res[nres].start	= desc->irq;
-		res[nres].end	= desc->irq;
-		res[nres].flags	= IORESOURCE_IRQ;
-		nres++;
-	}
-
-	for (i = 0; i < MAX_RESOURCE_DMA; i++, nres++) {
-		if (desc->dma[i] == 0)
-			break;
-
-		res[nres].start	= desc->dma[i];
-		res[nres].end	= desc->dma[i];
-		res[nres].flags	= IORESOURCE_DMA;
-	}
-
-	ret = platform_device_add_resources(pdev, res, nres);
-	if (ret) {
-		platform_device_put(pdev);
-		return ret;
-	}
-
-	if (data && size) {
-		ret = platform_device_add_data(pdev, data, size);
-		if (ret) {
-			platform_device_put(pdev);
-			return ret;
-		}
-	}
-
-	return platform_device_add(pdev);
-}
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index bdeb6db..a741a89 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -103,16 +103,19 @@ static struct platform_device smc91x_device = {
 	.resource       = smc91x_resources,
 };
 
+static struct platform_device *flint_devices[] = {
+	/* on-chip devices */
+	&mmp2_device_uart1,
+	&mmp2_device_uart2,
+	/* off-chip devices */
+	&smc91x_device,
+};
+
 static void __init flint_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(flint_pin_config));
 
-	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(2);
-
-	/* off-chip devices */
-	platform_device_register(&smc91x_device);
+	platform_add_devices(ARRAY_AND_SIZE(flint_devices));
 }
 
 MACHINE_START(FLINT, "Flint Development Platform")
diff --git a/arch/arm/mach-mmp/include/mach/devices.h b/arch/arm/mach-mmp/include/mach/devices.h
deleted file mode 100644
index d0ec7da..0000000
--- a/arch/arm/mach-mmp/include/mach/devices.h
+++ /dev/null
@@ -1,53 +0,0 @@
-#ifndef __MACH_DEVICE_H
-#define __MACH_DEVICE_H
-
-#include <linux/types.h>
-
-#define MAX_RESOURCE_DMA	2
-
-/* structure for describing the on-chip devices */
-struct pxa_device_desc {
-	const char	*dev_name;
-	const char	*drv_name;
-	int		id;
-	int		irq;
-	unsigned long	start;
-	unsigned long	size;
-	int		dma[MAX_RESOURCE_DMA];
-};
-
-#define PXA168_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc pxa168_device_##_name __initdata = {		\
-	.dev_name	= "pxa168-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_PXA168_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-};
-
-#define PXA910_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc pxa910_device_##_name __initdata = {		\
-	.dev_name	= "pxa910-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_PXA910_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-};
-
-#define MMP2_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct pxa_device_desc mmp2_device_##_name __initdata = {		\
-	.dev_name	= "mmp2-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_MMP2_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-}
-
-extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
-#endif /* __MACH_DEVICE_H */
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 4aec493..74dfc63 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
 
-#include <plat/sdhci.h>
-
 struct sys_timer;
 
 extern struct sys_timer mmp2_timer;
@@ -10,80 +8,20 @@ extern void __init mmp2_init_icu(void);
 extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
 
-#include <linux/i2c.h>
-#include <mach/devices.h>
-#include <plat/i2c.h>
-
-extern struct pxa_device_desc mmp2_device_uart1;
-extern struct pxa_device_desc mmp2_device_uart2;
-extern struct pxa_device_desc mmp2_device_uart3;
-extern struct pxa_device_desc mmp2_device_uart4;
-extern struct pxa_device_desc mmp2_device_twsi1;
-extern struct pxa_device_desc mmp2_device_twsi2;
-extern struct pxa_device_desc mmp2_device_twsi3;
-extern struct pxa_device_desc mmp2_device_twsi4;
-extern struct pxa_device_desc mmp2_device_twsi5;
-extern struct pxa_device_desc mmp2_device_twsi6;
-extern struct pxa_device_desc mmp2_device_sdh0;
-extern struct pxa_device_desc mmp2_device_sdh1;
-extern struct pxa_device_desc mmp2_device_sdh2;
-extern struct pxa_device_desc mmp2_device_sdh3;
-
-static inline int mmp2_add_uart(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &mmp2_device_uart1; break;
-	case 2: d = &mmp2_device_uart2; break;
-	case 3: d = &mmp2_device_uart3; break;
-	case 4: d = &mmp2_device_uart4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int mmp2_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct pxa_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 1: d = &mmp2_device_twsi1; break;
-	case 2: d = &mmp2_device_twsi2; break;
-	case 3: d = &mmp2_device_twsi3; break;
-	case 4: d = &mmp2_device_twsi4; break;
-	case 5: d = &mmp2_device_twsi5; break;
-	case 6: d = &mmp2_device_twsi6; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id - 1, info, size);
-	if (ret)
-		return ret;
-
-	return pxa_register_device(d, data, sizeof(*data));
-}
-
-static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 0: d = &mmp2_device_sdh0; break;
-	case 1: d = &mmp2_device_sdh1; break;
-	case 2: d = &mmp2_device_sdh2; break;
-	case 3: d = &mmp2_device_sdh3; break;
-	default:
-		return -EINVAL;
-	}
-
-	return pxa_register_device(d, data, sizeof(*data));
-}
+extern struct platform_device mmp2_device_uart1;
+extern struct platform_device mmp2_device_uart2;
+extern struct platform_device mmp2_device_uart3;
+extern struct platform_device mmp2_device_uart4;
+extern struct platform_device mmp2_device_twsi1;
+extern struct platform_device mmp2_device_twsi2;
+extern struct platform_device mmp2_device_twsi3;
+extern struct platform_device mmp2_device_twsi4;
+extern struct platform_device mmp2_device_twsi5;
+extern struct platform_device mmp2_device_twsi6;
+extern struct platform_device mmp2_device_sdh1;
+extern struct platform_device mmp2_device_sdh2;
+extern struct platform_device mmp2_device_sdh3;
+extern struct platform_device mmp2_device_sdh4;
 
 #endif /* __ASM_MACH_MMP2_H */
 
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 1801e42..95b927e 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -7,114 +7,22 @@ extern struct sys_timer pxa168_timer;
 extern void __init pxa168_init_irq(void);
 extern void pxa168_clear_keypad_wakeup(void);
 
-#include <linux/i2c.h>
-#include <mach/devices.h>
-#include <plat/i2c.h>
-#include <plat/pxa3xx_nand.h>
-#include <video/pxa168fb.h>
-#include <plat/pxa27x_keypad.h>
-#include <mach/cputype.h>
-
-extern struct pxa_device_desc pxa168_device_uart1;
-extern struct pxa_device_desc pxa168_device_uart2;
-extern struct pxa_device_desc pxa168_device_twsi0;
-extern struct pxa_device_desc pxa168_device_twsi1;
-extern struct pxa_device_desc pxa168_device_pwm1;
-extern struct pxa_device_desc pxa168_device_pwm2;
-extern struct pxa_device_desc pxa168_device_pwm3;
-extern struct pxa_device_desc pxa168_device_pwm4;
-extern struct pxa_device_desc pxa168_device_ssp1;
-extern struct pxa_device_desc pxa168_device_ssp2;
-extern struct pxa_device_desc pxa168_device_ssp3;
-extern struct pxa_device_desc pxa168_device_ssp4;
-extern struct pxa_device_desc pxa168_device_ssp5;
-extern struct pxa_device_desc pxa168_device_nand;
-extern struct pxa_device_desc pxa168_device_fb;
-extern struct pxa_device_desc pxa168_device_keypad;
-
-static inline int pxa168_add_uart(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_uart1; break;
-	case 2: d = &pxa168_device_uart2; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct pxa_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 0: d = &pxa168_device_twsi0; break;
-	case 1: d = &pxa168_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id, info, size);
-	if (ret)
-		return ret;
-
-	return pxa_register_device(d, data, sizeof(*data));
-}
-
-static inline int pxa168_add_pwm(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_pwm1; break;
-	case 2: d = &pxa168_device_pwm2; break;
-	case 3: d = &pxa168_device_pwm3; break;
-	case 4: d = &pxa168_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_ssp(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_ssp1; break;
-	case 2: d = &pxa168_device_ssp2; break;
-	case 3: d = &pxa168_device_ssp3; break;
-	case 4: d = &pxa168_device_ssp4; break;
-	case 5: d = &pxa168_device_ssp5; break;
-	default:
-		return -EINVAL;
-	}
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
-{
-	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
-}
-
-static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
-{
-	return pxa_register_device(&pxa168_device_fb, mi, sizeof(*mi));
-}
-
-static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
-{
-	if (cpu_is_pxa168())
-		data->clear_wakeup_event = pxa168_clear_keypad_wakeup;
-
-	return pxa_register_device(&pxa168_device_keypad, data, sizeof(*data));
-}
+extern struct platform_device pxa168_device_uart1;
+extern struct platform_device pxa168_device_uart2;
+extern struct platform_device pxa168_device_twsi0;
+extern struct platform_device pxa168_device_twsi1;
+extern struct platform_device pxa168_device_pwm1;
+extern struct platform_device pxa168_device_pwm2;
+extern struct platform_device pxa168_device_pwm3;
+extern struct platform_device pxa168_device_pwm4;
+extern struct platform_device pxa168_device_nand;
+extern struct platform_device pxa168_device_ssp1;
+extern struct platform_device pxa168_device_ssp2;
+extern struct platform_device pxa168_device_ssp3;
+extern struct platform_device pxa168_device_ssp4;
+extern struct platform_device pxa168_device_ssp5;
+extern struct platform_device pxa168_device_nand;
+extern struct platform_device pxa168_device_fb;
+extern struct platform_device pxa168_device_keypad;
 
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index f13c49d..d52c4db 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -6,74 +6,14 @@ struct sys_timer;
 extern struct sys_timer pxa910_timer;
 extern void __init pxa910_init_irq(void);
 
-#include <linux/i2c.h>
-#include <mach/devices.h>
-#include <plat/i2c.h>
-#include <plat/pxa3xx_nand.h>
+extern struct platform_device pxa910_device_uart1;
+extern struct platform_device pxa910_device_uart2;
+extern struct platform_device pxa910_device_twsi0;
+extern struct platform_device pxa910_device_twsi1;
+extern struct platform_device pxa910_device_pwm1;
+extern struct platform_device pxa910_device_pwm2;
+extern struct platform_device pxa910_device_pwm3;
+extern struct platform_device pxa910_device_pwm4;
+extern struct platform_device pxa910_device_nand;
 
-extern struct pxa_device_desc pxa910_device_uart1;
-extern struct pxa_device_desc pxa910_device_uart2;
-extern struct pxa_device_desc pxa910_device_twsi0;
-extern struct pxa_device_desc pxa910_device_twsi1;
-extern struct pxa_device_desc pxa910_device_pwm1;
-extern struct pxa_device_desc pxa910_device_pwm2;
-extern struct pxa_device_desc pxa910_device_pwm3;
-extern struct pxa_device_desc pxa910_device_pwm4;
-extern struct pxa_device_desc pxa910_device_nand;
-
-static inline int pxa910_add_uart(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_uart1; break;
-	case 2: d = &pxa910_device_uart2; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct pxa_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 0: d = &pxa910_device_twsi0; break;
-	case 1: d = &pxa910_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id, info, size);
-	if (ret)
-		return ret;
-
-	return pxa_register_device(d, data, sizeof(*data));
-}
-
-static inline int pxa910_add_pwm(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_pwm1; break;
-	case 2: d = &pxa910_device_pwm2; break;
-	case 3: d = &pxa910_device_pwm3; break;
-	case 4: d = &pxa910_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return pxa_register_device(d, NULL, 0);
-}
-
-static inline int pxa910_add_nand(struct pxa3xx_nand_platform_data *info)
-{
-	return pxa_register_device(&pxa910_device_nand, info, sizeof(*info));
-}
 #endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 24172a0..6fc69cf 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -19,12 +19,15 @@
 #include <linux/regulator/max8649.h>
 #include <linux/mfd/max8925.h>
 #include <linux/interrupt.h>
+#include <linux/i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
+#include <plat/i2c.h>
+#include <plat/sdhci.h>
 
 #include "common.h"
 
@@ -153,19 +156,26 @@ static struct i2c_board_info jasper_twsi1_info[] = {
 	},
 };
 
-static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
+static struct sdhci_pxa_platdata jasper_sdh1_info = {
 	.max_speed	= 25000000,
 };
 
+static struct platform_device *jasper_devices[] = {
+	/* on-chip devices */
+	&mmp2_device_uart1,
+	&mmp2_device_uart3,
+	&mmp2_device_twsi1,
+	&mmp2_device_sdh1,
+};
+
 static void __init jasper_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
 
-	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(3);
-	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	platform_device_add_data(&mmp2_device_sdh1, &jasper_sdh1_info,
+				 sizeof(struct sdhci_pxa_platdata));
+	platform_add_devices(ARRAY_AND_SIZE(jasper_devices));
+	i2c_register_board_info(0, ARRAY_AND_SIZE(jasper_twsi1_info));
 
 	regulator_has_full_constraints();
 }
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..3c201ef 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
@@ -26,7 +27,6 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/gpio.h>
-#include <mach/devices.h>
 #include <mach/mmp2.h>
 
 #include "common.h"
@@ -211,19 +211,188 @@ struct sys_timer mmp2_timer = {
 };
 
 /* on-chip devices */
-MMP2_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4030000, 0x30, 4, 5);
-MMP2_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4017000, 0x30, 20, 21);
-MMP2_DEVICE(uart3, "pxa2xx-uart", 2, UART3, 0xd4018000, 0x30, 22, 23);
-MMP2_DEVICE(uart4, "pxa2xx-uart", 3, UART4, 0xd4016000, 0x30, 18, 19);
-MMP2_DEVICE(twsi1, "pxa2xx-i2c", 0, TWSI1, 0xd4011000, 0x70);
-MMP2_DEVICE(twsi2, "pxa2xx-i2c", 1, TWSI2, 0xd4031000, 0x70);
-MMP2_DEVICE(twsi3, "pxa2xx-i2c", 2, TWSI3, 0xd4032000, 0x70);
-MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4, 0xd4033000, 0x70);
-MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
-MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
-MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
-MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
-MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
-MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
-MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);
+static struct resource mmp2_resources_uart1[] = {
+	{ 0xd4030000, 0xd403002f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_UART1, IRQ_MMP2_UART1, NULL, IORESOURCE_IRQ, },
+	{ 4, 5, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device mmp2_device_uart1 = {
+	.name		= "pxa2xx-uart",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_uart1),
+	.resource	= &mmp2_resources_uart1[0],
+};
+
+static struct resource mmp2_resources_uart2[] = {
+	{ 0xd4018000, 0xd401802f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_UART2, IRQ_MMP2_UART2, NULL, IORESOURCE_IRQ, },
+	{ 20, 21, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device mmp2_device_uart2 = {
+	.name		= "pxa2xx-uart",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_uart2),
+	.resource	= &mmp2_resources_uart2[0],
+};
+
+static struct resource mmp2_resources_uart3[] = {
+	{ 0xd4018000, 0xd401802f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_UART3, IRQ_MMP2_UART3, NULL, IORESOURCE_IRQ, },
+	{ 22, 23, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device mmp2_device_uart3 = {
+	.name		= "pxa2xx-uart",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_uart3),
+	.resource	= &mmp2_resources_uart3[0],
+};
+
+static struct resource mmp2_resources_uart4[] = {
+	{ 0xd4016000, 0xd401602f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_UART4, IRQ_MMP2_UART4, NULL, IORESOURCE_IRQ, },
+	{ 18, 19, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device mmp2_device_uart4 = {
+	.name		= "pxa2xx-uart",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_uart4),
+	.resource	= &mmp2_resources_uart4[0],
+};
+
+static struct resource mmp2_resources_twsi1[] = {
+	{ 0xd4011000, 0xd401106f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI1, IRQ_MMP2_TWSI1, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi1 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi1),
+	.resource	= &mmp2_resources_twsi1[0],
+};
+
+static struct resource mmp2_resources_twsi2[] = {
+	{ 0xd4031000, 0xd403106f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI2, IRQ_MMP2_TWSI2, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi2 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi2),
+	.resource	= &mmp2_resources_twsi2[0],
+};
+
+static struct resource mmp2_resources_twsi3[] = {
+	{ 0xd4032000, 0xd403206f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI3, IRQ_MMP2_TWSI3, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi3 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi3),
+	.resource	= &mmp2_resources_twsi3[0],
+};
+
+static struct resource mmp2_resources_twsi4[] = {
+	{ 0xd4033000, 0xd403306f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI4, IRQ_MMP2_TWSI4, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi4 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi4),
+	.resource	= &mmp2_resources_twsi4[0],
+};
+
+static struct resource mmp2_resources_twsi5[] = {
+	{ 0xd4033800, 0xd403386f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI5, IRQ_MMP2_TWSI5, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi5 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi5),
+	.resource	= &mmp2_resources_twsi5[0],
+};
+
+static struct resource mmp2_resources_twsi6[] = {
+	{ 0xd4034000, 0xd403406f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_TWSI6, IRQ_MMP2_TWSI6, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_twsi6 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 5,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_twsi6),
+	.resource	= &mmp2_resources_twsi6[0],
+};
+
+static struct resource mmp2_resources_nand[] = {
+	{ 0xd4283000, 0xd42830ff, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_NAND, IRQ_MMP2_NAND, NULL, IORESOURCE_IRQ, },
+	{ 28, 29, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device mmp2_device_nand = {
+	.name		= "pxa3xx-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_nand),
+	.resource	= &mmp2_resources_nand[0],
+};
+
+static struct resource mmp2_resources_sdh1[] = {
+	{ 0xd4280000, 0xd428011f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_MMC, IRQ_MMP2_MMC, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_sdh1 = {
+	.name		= "sdhci-pxa",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_sdh1),
+	.resource	= &mmp2_resources_sdh1[0],
+};
+
+static struct resource mmp2_resources_sdh2[] = {
+	{ 0xd4280800, 0xd428091f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_MMC2, IRQ_MMP2_MMC2, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_sdh2 = {
+	.name		= "sdhci-pxa",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_sdh2),
+	.resource	= &mmp2_resources_sdh2[0],
+};
+
+static struct resource mmp2_resources_sdh3[] = {
+	{ 0xd4281000, 0xd428111f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_MMC3, IRQ_MMP2_MMC3, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_sdh3 = {
+	.name		= "sdhci-pxa",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_sdh3),
+	.resource	= &mmp2_resources_sdh3[0],
+};
+
+static struct resource mmp2_resources_sdh4[] = {
+	{ 0xd4281800, 0xd428191f, NULL, IORESOURCE_MEM, },
+	{ IRQ_MMP2_MMC4, IRQ_MMP2_MMC4, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device mmp2_device_sdh4 = {
+	.name		= "sdhci-pxa",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_sdh4),
+	.resource	= &mmp2_resources_sdh4[0],
+};
 
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..8092965 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -23,7 +24,6 @@
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <mach/dma.h>
-#include <mach/devices.h>
 #include <mach/mfp.h>
 
 #include "common.h"
@@ -147,19 +147,198 @@ void pxa168_clear_keypad_wakeup(void)
 }
 
 /* on-chip devices */
-PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
-PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
-PXA168_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
-PXA168_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
-PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
-PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE, 0xd401a400, 0x10);
-PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
-PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
-PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
-PXA168_DEVICE(ssp1, "pxa168-ssp", 0, SSP1, 0xd401b000, 0x40, 52, 53);
-PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
-PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
-PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
-PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
-PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
-PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
+static struct resource pxa168_resources_uart1[] = {
+	{ 0xd4017000, 0xd401702f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_UART1, IRQ_PXA168_UART1, NULL, IORESOURCE_IRQ, },
+	{ 21, 22, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_uart1 = {
+	.name		= "pxa2xx-uart",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_uart1),
+	.resource	= &pxa168_resources_uart1[0],
+};
+
+static struct resource pxa168_resources_uart2[] = {
+	{ 0xd4018000, 0xd401802f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_UART2, IRQ_PXA168_UART2, NULL, IORESOURCE_IRQ, },
+	{ 23, 24, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_uart2 = {
+	.name		= "pxa2xx-uart",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_uart2),
+	.resource	= &pxa168_resources_uart2[0],
+};
+
+static struct resource pxa168_resources_twsi0[] = {
+	{ 0xd4011000, 0xd401102f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_TWSI0, IRQ_PXA168_TWSI0, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa168_device_twsi0 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_twsi0),
+	.resource	= &pxa168_resources_twsi0[0],
+};
+
+static struct resource pxa168_resources_twsi1[] = {
+	{ 0xd4025000, 0xd402502f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_TWSI1, IRQ_PXA168_TWSI1, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa168_device_twsi1 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_twsi1),
+	.resource	= &pxa168_resources_twsi1[0],
+};
+
+static struct resource pxa168_resources_pwm1[] = {
+	{ 0xd401a000, 0xd401a00f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa168_device_pwm1 = {
+	.name		= "pxa168-pwm",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_pwm1),
+	.resource	= &pxa168_resources_pwm1[0],
+};
+
+static struct resource pxa168_resources_pwm2[] = {
+	{ 0xd401a400, 0xd401a40f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa168_device_pwm2 = {
+	.name		= "pxa168-pwm",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_pwm2),
+	.resource	= &pxa168_resources_pwm2[0],
+};
+
+static struct resource pxa168_resources_pwm3[] = {
+	{ 0xd401a800, 0xd401a80f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa168_device_pwm3 = {
+	.name		= "pxa168-pwm",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_pwm3),
+	.resource	= &pxa168_resources_pwm3[0],
+};
+
+static struct resource pxa168_resources_pwm4[] = {
+	{ 0xd401ac00, 0xd401ac0f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa168_device_pwm4 = {
+	.name		= "pxa168-pwm",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_pwm4),
+	.resource	= &pxa168_resources_pwm4[0],
+};
+
+static struct resource pxa168_resources_nand[] = {
+	{ 0xd4283000, 0xd428307f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_NAND, IRQ_PXA168_NAND, NULL, IORESOURCE_IRQ, },
+	{ 97, 99, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_nand = {
+	.name		= "pxa3xx-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_nand),
+	.resource	= &pxa168_resources_nand[0],
+};
+
+static struct resource pxa168_resources_ssp1[] = {
+	{ 0xd401b000, 0xd401b03f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_SSP1, IRQ_PXA168_SSP1, NULL, IORESOURCE_IRQ, },
+	{ 52, 53, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_ssp1 = {
+	.name		= "pxa168-ssp",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_ssp1),
+	.resource	= &pxa168_resources_ssp1[0],
+};
+
+static struct resource pxa168_resources_ssp2[] = {
+	{ 0xd401c000, 0xd401c03f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_SSP2, IRQ_PXA168_SSP2, NULL, IORESOURCE_IRQ, },
+	{ 54, 55, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_ssp2 = {
+	.name		= "pxa168-ssp",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_ssp2),
+	.resource	= &pxa168_resources_ssp2[0],
+};
+
+static struct resource pxa168_resources_ssp3[] = {
+	{ 0xd401f000, 0xd401f03f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_SSP3, IRQ_PXA168_SSP3, NULL, IORESOURCE_IRQ, },
+	{ 56, 57, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_ssp3 = {
+	.name		= "pxa168-ssp",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_ssp3),
+	.resource	= &pxa168_resources_ssp3[0],
+};
+
+static struct resource pxa168_resources_ssp4[] = {
+	{ 0xd4020000, 0xd402003f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_SSP4, IRQ_PXA168_SSP4, NULL, IORESOURCE_IRQ, },
+	{ 58, 59, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_ssp4 = {
+	.name		= "pxa168-ssp",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_ssp4),
+	.resource	= &pxa168_resources_ssp4[0],
+};
+
+static struct resource pxa168_resources_ssp5[] = {
+	{ 0xd4021000, 0xd402103f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_SSP5, IRQ_PXA168_SSP5, NULL, IORESOURCE_IRQ, },
+	{ 60, 61, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa168_device_ssp5 = {
+	.name		= "pxa168-ssp",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_ssp5),
+	.resource	= &pxa168_resources_ssp5[0],
+};
+
+static struct resource pxa168_resources_fb[] = {
+	{ 0xd420b000, 0xd420b1cf, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_LCD, IRQ_PXA168_LCD, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa168_device_fb = {
+	.name		= "pxa168-fb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_fb),
+	.resource	= &pxa168_resources_fb[0],
+};
+
+static struct resource pxa168_resources_keypad[] = {
+	{ 0xd4012000, 0xd401204f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA168_KEYPAD, IRQ_PXA168_KEYPAD, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa168_device_keypad = {
+	.name		= "pxa27x-keypad",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_keypad),
+	.resource	= &pxa168_resources_keypad[0],
+};
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 46f2d69..7c1875c 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -23,7 +24,6 @@
 #include <mach/gpio.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
-#include <mach/devices.h>
 
 #include "common.h"
 #include "clock.h"
@@ -169,12 +169,109 @@ struct sys_timer pxa910_timer = {
  *
  * UART1 is not used by AP for the moment.
  */
-PXA910_DEVICE(uart1, "pxa2xx-uart", 0, UART2, 0xd4017000, 0x30, 21, 22);
-PXA910_DEVICE(uart2, "pxa2xx-uart", 1, UART3, 0xd4018000, 0x30, 23, 24);
-PXA910_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
-PXA910_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
-PXA910_DEVICE(pwm1, "pxa910-pwm", 0, NONE, 0xd401a000, 0x10);
-PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
-PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
-PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
-PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+static struct resource pxa910_resources_uart1[] = {
+	{ 0xd4017000, 0xd401702f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA910_UART2, IRQ_PXA910_UART2, NULL, IORESOURCE_IRQ, },
+	{ 21, 22, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa910_device_uart1 = {
+	.name		= "pxa2xx-uart",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_uart1),
+	.resource	= &pxa910_resources_uart1[0],
+};
+
+static struct resource pxa910_resources_uart2[] = {
+	{ 0xd4018000, 0xd401802f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA910_UART3, IRQ_PXA910_UART3, NULL, IORESOURCE_IRQ, },
+	{ 23, 24, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa910_device_uart2 = {
+	.name		= "pxa2xx-uart",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_uart2),
+	.resource	= &pxa910_resources_uart2[0],
+};
+
+static struct resource pxa910_resources_twsi0[] = {
+	{ 0xd4011000, 0xd401102f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA910_TWSI0, IRQ_PXA910_TWSI0, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa910_device_twsi0 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_twsi0),
+	.resource	= &pxa910_resources_twsi0[0],
+};
+
+static struct resource pxa910_resources_twsi1[] = {
+	{ 0xd4037000, 0xd403702f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA910_TWSI1, IRQ_PXA910_TWSI1, NULL, IORESOURCE_IRQ, },
+};
+
+struct platform_device pxa910_device_twsi1 = {
+	.name		= "pxa2xx-i2c",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_twsi1),
+	.resource	= &pxa910_resources_twsi1[0],
+};
+
+static struct resource pxa910_resources_pwm1[] = {
+	{ 0xd401a000, 0xd401a00f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa910_device_pwm1 = {
+	.name		= "pxa910-pwm",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_pwm1),
+	.resource	= &pxa910_resources_pwm1[0],
+};
+
+static struct resource pxa910_resources_pwm2[] = {
+	{ 0xd401a400, 0xd401a40f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa910_device_pwm2 = {
+	.name		= "pxa910-pwm",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_pwm2),
+	.resource	= &pxa910_resources_pwm2[0],
+};
+
+static struct resource pxa910_resources_pwm3[] = {
+	{ 0xd401a800, 0xd401a80f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa910_device_pwm3 = {
+	.name		= "pxa910-pwm",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_pwm3),
+	.resource	= &pxa910_resources_pwm3[0],
+};
+
+static struct resource pxa910_resources_pwm4[] = {
+	{ 0xd401ac00, 0xd401ac0f, NULL, IORESOURCE_MEM, },
+};
+
+struct platform_device pxa910_device_pwm4 = {
+	.name		= "pxa910-pwm",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_pwm4),
+	.resource	= &pxa910_resources_pwm4[0],
+};
+
+static struct resource pxa910_resources_nand[] = {
+	{ 0xd4283000, 0xd428307f, NULL, IORESOURCE_MEM, },
+	{ IRQ_PXA910_NAND, IRQ_PXA910_NAND, NULL, IORESOURCE_IRQ, },
+	{ 97, 99, NULL, IORESOURCE_DMA, },
+};
+
+struct platform_device pxa910_device_nand = {
+	.name		= "pxa3xx-nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_nand),
+	.resource	= &pxa910_resources_nand[0],
+};
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index c296b75..e974d22 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -87,15 +87,18 @@ static struct platform_device smc91x_device = {
 	.resource	= smc91x_resources,
 };
 
+static struct platform_device *tavorevb_devices[] = {
+	/* on-chip devices */
+	&pxa910_device_uart1,
+	/* off-chip devices */
+	&smc91x_device,
+};
+
 static void __init tavorevb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(tavorevb_pin_config));
 
-	/* on-chip devices */
-	pxa910_add_uart(1);
-
-	/* off-chip devices */
-	platform_device_register(&smc91x_device);
+	platform_add_devices(ARRAY_AND_SIZE(tavorevb_devices));
 }
 
 MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbe4727..c31a98f 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -17,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
-#include <plat/pxa27x_keypad.h>
 #include <linux/i2c.h>
 
 #include <asm/mach-types.h>
@@ -26,6 +25,7 @@
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
 #include <mach/teton_bga.h>
+#include <plat/pxa27x_keypad.h>
 
 #include "common.h"
 
@@ -61,6 +61,7 @@ static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 	.matrix_key_map         = teton_bga_matrix_key_map,
 	.matrix_key_map_size    = ARRAY_SIZE(teton_bga_matrix_key_map),
 	.debounce_interval      = 30,
+	.clear_wakeup_event	= pxa168_clear_keypad_wakeup,
 };
 
 static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
@@ -70,14 +71,21 @@ static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
 	},
 };
 
+static struct platform_device *teton_bga_devices[] = {
+	/* on-chip devices */
+	&pxa168_device_uart1,
+	&pxa168_device_keypad,
+	&pxa168_device_twsi1,
+};
+
 static void __init teton_bga_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(teton_bga_pin_config));
 
-	/* on-chip devices */
-	pxa168_add_uart(1);
-	pxa168_add_keypad(&teton_bga_keypad_info);
-	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
+	platform_device_add_data(&pxa168_device_keypad, &teton_bga_keypad_info,
+				 sizeof(struct pxa27x_keypad_platform_data));
+	platform_add_devices(ARRAY_AND_SIZE(teton_bga_devices));
+	i2c_register_board_info(0, ARRAY_AND_SIZE(teton_bga_i2c_info));
 }
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index e411039..7780a7c 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -110,6 +110,9 @@ static struct platform_device ttc_dkb_device_onenand = {
 };
 
 static struct platform_device *ttc_dkb_devices[] = {
+	/* on-chip devices */
+	&pxa910_device_uart1,
+	/* off-chip devices */
 	&ttc_dkb_device_onenand,
 };
 
@@ -117,10 +120,6 @@ static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
 
-	/* on-chip devices */
-	pxa910_add_uart(1);
-
-	/* off-chip devices */
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 }
 
-- 
1.5.6.5
