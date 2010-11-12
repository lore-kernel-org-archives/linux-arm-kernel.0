From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Nov 2010 15:17:34 +0800
Subject: [PATCH 05/11] ARM: pxa: support pxa95x
In-Reply-To: <1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core of PXA955 is PJ4. Add new PJ4 support. And add new macro
CONFIG_PXA95x.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/Kconfig                          |    4 +-
 arch/arm/mach-pxa/Kconfig                 |   12 +-
 arch/arm/mach-pxa/Makefile                |    1 +
 arch/arm/mach-pxa/clock.h                 |   20 ++
 arch/arm/mach-pxa/devices.c               |  292 ++++++++++---------
 arch/arm/mach-pxa/generic.h               |    7 +
 arch/arm/mach-pxa/include/mach/hardware.h |   29 ++-
 arch/arm/mach-pxa/include/mach/irqs.h     |    1 +
 arch/arm/mach-pxa/pxa95x.c                |  452 +++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                       |    8 +-
 arch/arm/plat-pxa/Makefile                |    1 +
 arch/arm/plat-pxa/include/plat/mfp.h      |    5 +-
 12 files changed, 670 insertions(+), 162 deletions(-)
 create mode 100644 arch/arm/mach-pxa/pxa95x.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..d78a03c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -999,8 +999,8 @@ source arch/arm/mm/Kconfig
 
 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK
-	default y if PXA27x || PXA3xx || ARCH_MMP
+	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
+	default y if PXA27x || PXA3xx || PXA93x || PXA95x || ARCH_MMP
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 84123d4..d9424ff 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -657,11 +657,17 @@ config CPU_PXA935
 	help
 	  PXA935 (codename Tavor-P65)
 
-config CPU_PXA950
+config PXA95x
 	bool
-	select CPU_PXA930
+	select CPU_PJ4
+	help
+	  Select code specific to PXA95x variants
+
+config CPU_PXA955
+	bool
+	select PXA95x
 	help
-	  PXA950 (codename Tavor-PV2)
+	  PXA955 (codename MG1)
 
 config PXA_SHARP_C7xx
 	bool
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index ebdb899..1642f6c 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
 obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_PXA93x)		+= mfp-pxa3xx.o pxa93x.o smemc.o
+obj-$(CONFIG_PXA95x)		+= mfp-pxa3xx.o pxa95x.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index 0d824eb..5018b2c 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -87,3 +87,23 @@ extern void clk_pxa93x_cken_enable(struct clk *);
 extern void clk_pxa93x_cken_disable(struct clk *);
 #endif
 
+#ifdef CONFIG_PXA95x
+#define DEFINE_PXA95_CKEN(_name, _cken, _rate, _delay)	\
+struct clk clk_##_name = {				\
+		.ops	= &clk_pxa95x_cken_ops,		\
+		.rate	= _rate,			\
+		.cken	= CKEN_##_cken,			\
+		.delay	= _delay,			\
+	}
+
+#define DEFINE_PXA95_CK(_name, _cken, _ops)		\
+struct clk clk_##_name = {				\
+		.ops	= _ops,				\
+		.cken	= CKEN_##_cken,			\
+	}
+
+extern const struct clkops clk_pxa95x_cken_ops;
+extern void clk_pxa95x_cken_enable(struct clk *);
+extern void clk_pxa95x_cken_disable(struct clk *);
+#endif
+
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 881ccc3..9c0aba3 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -342,27 +342,6 @@ struct platform_device pxa27x_device_i2c_power = {
 };
 #endif
 
-#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
-static struct resource pxa3xx_resources_i2c_power[] = {
-	{
-		.start  = 0x40f500c0,
-		.end    = 0x40f500d3,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_PWRI2C,
-		.end	= IRQ_PWRI2C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa3xx_device_i2c_power = {
-	.name		= "pxa3xx-pwri2c",
-	.id		= 1,
-	.resource	= pxa3xx_resources_i2c_power,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_i2c_power),
-};
-#endif
-
 static struct resource pxai2s_resources[] = {
 	{
 		.start	= 0x40400000,
@@ -633,32 +612,6 @@ struct platform_device pxa25x_device_assp = {
 #endif /* CONFIG_PXA25x */
 
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
-
-static struct resource pxa27x_resource_keypad[] = {
-	[0] = {
-		.start	= 0x41500000,
-		.end	= 0x4150004c,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_KEYPAD,
-		.end	= IRQ_KEYPAD,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa27x_device_keypad = {
-	.name		= "pxa27x-keypad",
-	.id		= -1,
-	.resource	= pxa27x_resource_keypad,
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_keypad),
-};
-
-void __init pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info)
-{
-	pxa_register_device(&pxa27x_device_keypad, info);
-}
-
 static u64 pxa27x_ohci_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource pxa27x_resource_ohci[] = {
@@ -690,6 +643,66 @@ void __init pxa_set_ohci_info(struct pxaohci_platform_data *info)
 	pxa_register_device(&pxa27x_device_ohci, info);
 }
 
+static u64 pxa27x_dma_mask_camera = DMA_BIT_MASK(32);
+
+static struct resource pxa27x_resource_camera[] = {
+	[0] = {
+		.start	= 0x50000000,
+		.end	= 0x50000fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CAMERA,
+		.end	= IRQ_CAMERA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pxa27x_device_camera = {
+	.name		= "pxa27x-camera",
+	.id		= 0, /* This is used to put cameras on this interface */
+	.dev		= {
+		.dma_mask      		= &pxa27x_dma_mask_camera,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_camera),
+	.resource	= pxa27x_resource_camera,
+};
+
+void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
+{
+	pxa_register_device(&pxa27x_device_camera, info);
+}
+#endif	/* CONFIG_PXA27x || CONFIG_PXA3xx || CONFIG_PXA93x */
+
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)		\
+	|| defined(CONFIG_PXA93x) || defined(CONFIG_PXA95x)
+
+static struct resource pxa27x_resource_keypad[] = {
+	[0] = {
+		.start	= 0x41500000,
+		.end	= 0x4150004c,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_KEYPAD,
+		.end	= IRQ_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa27x_device_keypad = {
+	.name		= "pxa27x-keypad",
+	.id		= -1,
+	.resource	= pxa27x_resource_keypad,
+	.num_resources	= ARRAY_SIZE(pxa27x_resource_keypad),
+};
+
+void __init pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info)
+{
+	pxa_register_device(&pxa27x_device_keypad, info);
+}
+
 static u64 pxa27x_ssp1_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource pxa27x_resource_ssp1[] = {
@@ -833,79 +846,9 @@ struct platform_device pxa27x_device_pwm1 = {
 	.resource	= pxa27x_resource_pwm1,
 	.num_resources	= ARRAY_SIZE(pxa27x_resource_pwm1),
 };
-
-static struct resource pxa27x_resource_camera[] = {
-	[0] = {
-		.start	= 0x50000000,
-		.end	= 0x50000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CAMERA,
-		.end	= IRQ_CAMERA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa27x_dma_mask_camera = DMA_BIT_MASK(32);
-
-static struct platform_device pxa27x_device_camera = {
-	.name		= "pxa27x-camera",
-	.id		= 0, /* This is used to put cameras on this interface */
-	.dev		= {
-		.dma_mask      		= &pxa27x_dma_mask_camera,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_camera),
-	.resource	= pxa27x_resource_camera,
-};
-
-void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
-{
-	pxa_register_device(&pxa27x_device_camera, info);
-}
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx || CONFIG_PXA93x */
 
 #if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)
-static u64 pxa3xx_ssp4_dma_mask = DMA_BIT_MASK(32);
-
-static struct resource pxa3xx_resource_ssp4[] = {
-	[0] = {
-		.start	= 0x41a00000,
-		.end	= 0x41a0003f,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SSP4,
-		.end	= IRQ_SSP4,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		/* DRCMR for RX */
-		.start	= 2,
-		.end	= 2,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		/* DRCMR for TX */
-		.start	= 3,
-		.end	= 3,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-struct platform_device pxa3xx_device_ssp4 = {
-	/* PXA3xx SSP is basically equivalent to PXA27x */
-	.name		= "pxa27x-ssp",
-	.id		= 3,
-	.dev		= {
-		.dma_mask = &pxa3xx_ssp4_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource	= pxa3xx_resource_ssp4,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resource_ssp4),
-};
-
 static struct resource pxa3xx_resources_mci2[] = {
 	[0] = {
 		.start	= 0x42000000,
@@ -984,6 +927,92 @@ void __init pxa3xx_set_mci3_info(struct pxamci_platform_data *info)
 	pxa_register_device(&pxa3xx_device_mci3, info);
 }
 
+static struct resource pxa3xx_resources_gcu[] = {
+	{
+		.start	= 0x54000000,
+		.end	= 0x54000fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_GCU,
+		.end	= IRQ_GCU,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 pxa3xx_gcu_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device pxa3xx_device_gcu = {
+	.name		= "pxa3xx-gcu",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa3xx_resources_gcu),
+	.resource	= pxa3xx_resources_gcu,
+	.dev		= {
+		.dma_mask = &pxa3xx_gcu_dmamask,
+		.coherent_dma_mask = 0xffffffff,
+	},
+};
+#endif /* CONFIG_PXA3xx || CONFIG_PXA93x */
+
+#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x) || defined(CONFIG_PXA95x)
+static struct resource pxa3xx_resources_i2c_power[] = {
+	{
+		.start  = 0x40f500c0,
+		.end    = 0x40f500d3,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PWRI2C,
+		.end	= IRQ_PWRI2C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa3xx_device_i2c_power = {
+	.name		= "pxa3xx-pwri2c",
+	.id		= 1,
+	.resource	= pxa3xx_resources_i2c_power,
+	.num_resources	= ARRAY_SIZE(pxa3xx_resources_i2c_power),
+};
+
+static u64 pxa3xx_ssp4_dma_mask = DMA_BIT_MASK(32);
+
+static struct resource pxa3xx_resource_ssp4[] = {
+	[0] = {
+		.start	= 0x41a00000,
+		.end	= 0x41a0003f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_SSP4,
+		.end	= IRQ_SSP4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* DRCMR for RX */
+		.start	= 2,
+		.end	= 2,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		/* DRCMR for TX */
+		.start	= 3,
+		.end	= 3,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device pxa3xx_device_ssp4 = {
+	/* PXA3xx SSP is basically equivalent to PXA27x */
+	.name		= "pxa27x-ssp",
+	.id		= 3,
+	.dev		= {
+		.dma_mask = &pxa3xx_ssp4_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.resource	= pxa3xx_resource_ssp4,
+	.num_resources	= ARRAY_SIZE(pxa3xx_resource_ssp4),
+};
+
 static struct resource pxa3xx_resources_nand[] = {
 	[0] = {
 		.start	= 0x43100000,
@@ -1026,34 +1055,7 @@ void __init pxa3xx_set_nand_info(struct pxa3xx_nand_platform_data *info)
 {
 	pxa_register_device(&pxa3xx_device_nand, info);
 }
-
-static struct resource pxa3xx_resources_gcu[] = {
-	{
-		.start	= 0x54000000,
-		.end	= 0x54000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= IRQ_GCU,
-		.end	= IRQ_GCU,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa3xx_gcu_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device pxa3xx_device_gcu = {
-	.name		= "pxa3xx-gcu",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_gcu),
-	.resource	= pxa3xx_resources_gcu,
-	.dev		= {
-		.dma_mask = &pxa3xx_gcu_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
-
-#endif /* CONFIG_PXA3xx || CONFIG_PXA93x */
+#endif	/* CONFIG_PXA3xx || CONFIG_PXA93x || CONFIG_PXA95x */
 
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 7dec811..8d6b066 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -21,6 +21,7 @@ extern void __init pxa26x_init_irq(void);
 extern void __init pxa27x_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
 extern void __init pxa93x_init_irq(void);
+extern void __init pxa95x_init_irq(void);
 
 extern void __init pxa_map_io(void);
 extern void __init pxa25x_map_io(void);
@@ -63,6 +64,12 @@ extern unsigned pxa3xx_get_clk_frequency_khz(int);
 #define pxa3xx_get_clk_frequency_khz(x)		(0)
 #endif
 
+#ifdef CONFIG_PXA95x
+extern void pxa95x_clear_reset_status(unsigned int);
+#else
+static inline void pxa95x_clear_reset_status(unsigned int mask) {}
+#endif
+
 extern struct sysdev_class pxa_irq_sysclass;
 extern struct sysdev_class pxa_gpio_sysclass;
 extern struct sysdev_class pxa2xx_mfp_sysclass;
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index 59f145a..704922d 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -186,14 +186,14 @@
 #define __cpu_is_pxa935(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA950
-#define __cpu_is_pxa950(id)                             \
-	({                                              \
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x697;				\
+#ifdef CONFIG_CPU_PXA955
+#define __cpu_is_pxa955(id)                             	\
+	({                                              	\
+		unsigned int _id = (id) >> 4 & 0xfff;		\
+		_id == 0x581 || _id == 0xc08 || _id == 0xb76;	\
 	 })
 #else
-#define __cpu_is_pxa950(id)	(0)
+#define __cpu_is_pxa955(id)	(0)
 #endif
 
 #define cpu_is_pxa210()					\
@@ -246,10 +246,10 @@
 		__cpu_is_pxa935(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa950()					\
+#define cpu_is_pxa955()					\
 	({						\
-		__cpu_is_pxa950(read_cpuid_id());	\
-	 })
+		__cpu_is_pxa955(read_cpuid_id());	\
+	})
 
 
 /*
@@ -288,6 +288,11 @@
 #define __cpu_is_pxa93x(id)	(0)
 #endif
 
+#define __cpu_is_pxa95x(id)				\
+	({						\
+		__cpu_is_pxa955(id);			\
+	})
+
 #define cpu_is_pxa2xx()					\
 	({						\
 		__cpu_is_pxa2xx(read_cpuid_id());	\
@@ -302,6 +307,12 @@
 	({						\
 		__cpu_is_pxa93x(read_cpuid_id());	\
 	 })
+
+#define cpu_is_pxa95x()					\
+	({						\
+		__cpu_is_pxa95x(read_cpuid_id());	\
+	})
+
 /*
  * return current memory and LCD clock frequency in units of 10kHz
  */
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index cb7ee26..a4285fc 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -84,6 +84,7 @@
 #define IRQ_PXA935_MMC0	PXA_IRQ(72)	/* MMC0 Controller (PXA935) */
 #define IRQ_PXA935_MMC1	PXA_IRQ(73)	/* MMC1 Controller (PXA935) */
 #define IRQ_PXA935_MMC2	PXA_IRQ(74)	/* MMC2 Controller (PXA935) */
+#define IRQ_PXA955_MMC3	PXA_IRQ(75)	/* MMC3 Controller (PXA955) */
 #define IRQ_U2P		PXA_IRQ(93)	/* USB PHY D+/D- Lines (PXA935) */
 
 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
new file mode 100644
index 0000000..b540280
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -0,0 +1,452 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa95x.c
+ *
+ * code specific to pxa95x aka MG
+ *
+ * Copyright (C) 2009-2010 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/pxa3xx-regs.h>
+#include <mach/pxa930.h>
+#include <mach/reset.h>
+#include <mach/pm.h>
+#include <mach/dma.h>
+#include <mach/regs-intc.h>
+#include <plat/i2c.h>
+
+#include "generic.h"
+#include "devices.h"
+#include "clock.h"
+
+/* Crystal clock: 13MHz */
+#define BASE_CLK	13000000
+
+/* Ring Oscillator Clock: 60MHz */
+#define RO_CLK		60000000
+
+#define ACCR_D0CS	(1 << 26)
+#define ACCR_PCCE	(1 << 11)
+
+#define PECR_IE(n)	((1 << ((n) * 2)) << 28)
+#define PECR_IS(n)	((1 << ((n) * 2)) << 29)
+
+/* crystal frequency to static memory controller multiplier (SMCFS) */
+static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
+
+/* crystal frequency to HSIO bus frequency multiplier (HSS) */
+static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
+
+static struct mfp_addr_map pxa95x_mfp_addr_map[] __initdata = {
+
+	MFP_ADDR(GPIO0, 0x02e0),
+	MFP_ADDR(GPIO1, 0x02dc),
+	MFP_ADDR(GPIO2, 0x02e8),
+	MFP_ADDR(GPIO3, 0x02d8),
+	MFP_ADDR(GPIO4, 0x02e4),
+	MFP_ADDR(GPIO5, 0x02ec),
+	MFP_ADDR(GPIO6, 0x02f8),
+	MFP_ADDR(GPIO7, 0x02fc),
+	MFP_ADDR(GPIO8, 0x0300),
+	MFP_ADDR(GPIO9, 0x02d4),
+	MFP_ADDR(GPIO10, 0x02f4),
+	MFP_ADDR(GPIO11, 0x02f0),
+	MFP_ADDR(GPIO12, 0x0304),
+	MFP_ADDR(GPIO13, 0x0310),
+	MFP_ADDR(GPIO14, 0x0308),
+	MFP_ADDR(GPIO15, 0x030c),
+	MFP_ADDR(GPIO16, 0x04e8),
+	MFP_ADDR(GPIO17, 0x04f4),
+	MFP_ADDR(GPIO18, 0x04f8),
+	MFP_ADDR(GPIO19, 0x04fc),
+	MFP_ADDR(GPIO20, 0x0518),
+	MFP_ADDR(GPIO21, 0x051c),
+	MFP_ADDR(GPIO22, 0x04ec),
+	MFP_ADDR(GPIO23, 0x0500),
+	MFP_ADDR(GPIO24, 0x04f0),
+	MFP_ADDR(GPIO25, 0x0504),
+	MFP_ADDR(GPIO26, 0x0510),
+	MFP_ADDR(GPIO27, 0x0514),
+	MFP_ADDR(GPIO28, 0x0520),
+	MFP_ADDR(GPIO29, 0x0600),
+	MFP_ADDR(GPIO30, 0x0618),
+	MFP_ADDR(GPIO31, 0x0610),
+	MFP_ADDR(GPIO32, 0x060c),
+	MFP_ADDR(GPIO33, 0x061c),
+	MFP_ADDR(GPIO34, 0x0620),
+	MFP_ADDR(GPIO35, 0x0628),
+	MFP_ADDR(GPIO36, 0x062c),
+	MFP_ADDR(GPIO37, 0x0630),
+	MFP_ADDR(GPIO38, 0x0634),
+	MFP_ADDR(GPIO39, 0x0638),
+	MFP_ADDR(GPIO40, 0x063c),
+	MFP_ADDR(GPIO41, 0x0614),
+	MFP_ADDR(GPIO42, 0x0624),
+	MFP_ADDR(GPIO43, 0x0608),
+	MFP_ADDR(GPIO44, 0x0604),
+	MFP_ADDR(GPIO45, 0x050c),
+	MFP_ADDR(GPIO46, 0x0508),
+	MFP_ADDR(GPIO47, 0x02bc),
+	MFP_ADDR(GPIO48, 0x02b4),
+	MFP_ADDR(GPIO49, 0x02b8),
+	MFP_ADDR(GPIO50, 0x02c8),
+	MFP_ADDR(GPIO51, 0x02c0),
+	MFP_ADDR(GPIO52, 0x02c4),
+	MFP_ADDR(GPIO53, 0x02d0),
+	MFP_ADDR(GPIO54, 0x02cc),
+	MFP_ADDR(GPIO55, 0x029c),
+	MFP_ADDR(GPIO56, 0x02a0),
+	MFP_ADDR(GPIO57, 0x0294),
+	MFP_ADDR(GPIO58, 0x0298),
+	MFP_ADDR(GPIO59, 0x02a4),
+	MFP_ADDR(GPIO60, 0x02a8),
+	MFP_ADDR(GPIO61, 0x02b0),
+	MFP_ADDR(GPIO62, 0x02ac),
+	MFP_ADDR(GPIO63, 0x0640),
+	MFP_ADDR(GPIO64, 0x065c),
+	MFP_ADDR(GPIO65, 0x0648),
+	MFP_ADDR(GPIO66, 0x0644),
+	MFP_ADDR(GPIO67, 0x0674),
+	MFP_ADDR(GPIO68, 0x0658),
+	MFP_ADDR(GPIO69, 0x0654),
+	MFP_ADDR(GPIO70, 0x0660),
+	MFP_ADDR(GPIO71, 0x0668),
+	MFP_ADDR(GPIO72, 0x0664),
+	MFP_ADDR(GPIO73, 0x0650),
+	MFP_ADDR(GPIO74, 0x066c),
+	MFP_ADDR(GPIO75, 0x064c),
+	MFP_ADDR(GPIO76, 0x0670),
+	MFP_ADDR(GPIO77, 0x0678),
+	MFP_ADDR(GPIO78, 0x067c),
+	MFP_ADDR(GPIO79, 0x0694),
+	MFP_ADDR(GPIO80, 0x069c),
+	MFP_ADDR(GPIO81, 0x06a0),
+	MFP_ADDR(GPIO82, 0x06a4),
+	MFP_ADDR(GPIO83, 0x0698),
+	MFP_ADDR(GPIO84, 0x06bc),
+	MFP_ADDR(GPIO85, 0x06b4),
+	MFP_ADDR(GPIO86, 0x06b0),
+	MFP_ADDR(GPIO87, 0x06c0),
+	MFP_ADDR(GPIO88, 0x06c4),
+	MFP_ADDR(GPIO89, 0x06ac),
+	MFP_ADDR(GPIO90, 0x0680),
+	MFP_ADDR(GPIO91, 0x0684),
+	MFP_ADDR(GPIO92, 0x0688),
+	MFP_ADDR(GPIO93, 0x0690),
+	MFP_ADDR(GPIO94, 0x068c),
+	MFP_ADDR(GPIO95, 0x06a8),
+	MFP_ADDR(GPIO96, 0x06b8),
+	MFP_ADDR(GPIO97, 0x0410),
+	MFP_ADDR(GPIO98, 0x0418),
+	MFP_ADDR(GPIO99, 0x041c),
+	MFP_ADDR(GPIO100, 0x0414),
+	MFP_ADDR(GPIO101, 0x0408),
+	MFP_ADDR(GPIO102, 0x0324),
+	MFP_ADDR(GPIO103, 0x040c),
+	MFP_ADDR(GPIO104, 0x0400),
+	MFP_ADDR(GPIO105, 0x0328),
+	MFP_ADDR(GPIO106, 0x0404),
+
+	MFP_ADDR(GPIO159, 0x0524),
+	MFP_ADDR(GPIO163, 0x0534),
+	MFP_ADDR(GPIO167, 0x0544),
+	MFP_ADDR(GPIO168, 0x0548),
+	MFP_ADDR(GPIO169, 0x054c),
+	MFP_ADDR(GPIO170, 0x0550),
+	MFP_ADDR(GPIO171, 0x0554),
+	MFP_ADDR(GPIO172, 0x0558),
+	MFP_ADDR(GPIO173, 0x055c),
+
+	MFP_ADDR(nXCVREN, 0x0204),
+	MFP_ADDR(DF_CLE_nOE, 0x020c),
+	MFP_ADDR(DF_nADV1_ALE, 0x0218),
+	MFP_ADDR(DF_SCLK_E, 0x0214),
+	MFP_ADDR(DF_SCLK_S, 0x0210),
+	MFP_ADDR(nBE0, 0x021c),
+	MFP_ADDR(nBE1, 0x0220),
+	MFP_ADDR(DF_nADV2_ALE, 0x0224),
+	MFP_ADDR(DF_INT_RnB, 0x0228),
+	MFP_ADDR(DF_nCS0, 0x022c),
+	MFP_ADDR(DF_nCS1, 0x0230),
+	MFP_ADDR(nLUA, 0x0254),
+	MFP_ADDR(nLLA, 0x0258),
+	MFP_ADDR(DF_nWE, 0x0234),
+	MFP_ADDR(DF_nRE_nOE, 0x0238),
+	MFP_ADDR(DF_ADDR0, 0x024c),
+	MFP_ADDR(DF_ADDR1, 0x0250),
+	MFP_ADDR(DF_ADDR2, 0x025c),
+	MFP_ADDR(DF_ADDR3, 0x0260),
+	MFP_ADDR(DF_IO0, 0x023c),
+	MFP_ADDR(DF_IO1, 0x0240),
+	MFP_ADDR(DF_IO2, 0x0244),
+	MFP_ADDR(DF_IO3, 0x0248),
+	MFP_ADDR(DF_IO4, 0x0264),
+	MFP_ADDR(DF_IO5, 0x0268),
+	MFP_ADDR(DF_IO6, 0x026c),
+	MFP_ADDR(DF_IO7, 0x0270),
+	MFP_ADDR(DF_IO8, 0x0274),
+	MFP_ADDR(DF_IO9, 0x0278),
+	MFP_ADDR(DF_IO10, 0x027c),
+	MFP_ADDR(DF_IO11, 0x0280),
+	MFP_ADDR(DF_IO12, 0x0284),
+	MFP_ADDR(DF_IO13, 0x0288),
+	MFP_ADDR(DF_IO14, 0x028c),
+	MFP_ADDR(DF_IO15, 0x0290),
+
+	MFP_ADDR(GSIM_UIO, 0x0314),
+	MFP_ADDR(GSIM_UCLK, 0x0318),
+	MFP_ADDR(GSIM_UDET, 0x031c),
+	MFP_ADDR(GSIM_nURST, 0x0320),
+
+	MFP_ADDR(PMIC_INT, 0x06c8),
+
+	MFP_ADDR(RDY, 0x0200),
+
+	MFP_ADDR_END,
+};
+
+void pxa95x_clear_reset_status(unsigned int mask)
+{
+	/* RESET_STATUS_* has a 1:1 mapping with ARSR */
+	ARSR = mask;
+}
+
+/*
+ * Return the current HSIO bus clock frequency
+ */
+static unsigned long clk_pxa95x_hsio_getrate(struct clk *clk)
+{
+	unsigned long acsr;
+	unsigned int hss, hsio_clk;
+
+	acsr = ACSR;
+
+	hss = (acsr >> 14) & 0x3;
+	hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
+
+	return hsio_clk;
+}
+
+void clk_pxa95x_cken_enable(struct clk *clk)
+{
+	unsigned long mask = 1ul << (clk->cken & 0x1f);
+
+	if (clk->cken < 32)
+		CKENA |= mask;
+	else
+		CKENB |= mask;
+}
+
+void clk_pxa95x_cken_disable(struct clk *clk)
+{
+	unsigned long mask = 1ul << (clk->cken & 0x1f);
+
+	if (clk->cken < 32)
+		CKENA &= ~mask;
+	else
+		CKENB &= ~mask;
+}
+
+const struct clkops clk_pxa95x_cken_ops = {
+	.enable		= clk_pxa95x_cken_enable,
+	.disable	= clk_pxa95x_cken_disable,
+};
+
+static const struct clkops clk_pxa95x_hsio_ops = {
+	.enable		= clk_pxa95x_cken_enable,
+	.disable	= clk_pxa95x_cken_disable,
+	.getrate	= clk_pxa95x_hsio_getrate,
+};
+
+static void clk_pout_enable(struct clk *clk)
+{
+	OSCC |= OSCC_PEN;
+}
+
+static void clk_pout_disable(struct clk *clk)
+{
+	OSCC &= ~OSCC_PEN;
+}
+
+static const struct clkops clk_pout_ops = {
+	.enable		= clk_pout_enable,
+	.disable	= clk_pout_disable,
+};
+
+static void clk_dummy_enable(struct clk *clk)
+{
+}
+
+static void clk_dummy_disable(struct clk *clk)
+{
+}
+
+static const struct clkops clk_dummy_ops = {
+	.enable		= clk_dummy_enable,
+	.disable	= clk_dummy_disable,
+};
+
+static struct clk clk_pxa95x_pout = {
+	.ops		= &clk_pout_ops,
+	.rate		= 13000000,
+	.delay		= 70,
+};
+
+static struct clk clk_dummy = {
+	.ops		= &clk_dummy_ops,
+};
+
+static DEFINE_PXA95_CK(pxa95x_lcd, LCD, &clk_pxa95x_hsio_ops);
+static DEFINE_PXA95_CKEN(pxa95x_ffuart, FFUART, 14857000, 1);
+static DEFINE_PXA95_CKEN(pxa95x_btuart, BTUART, 14857000, 1);
+static DEFINE_PXA95_CKEN(pxa95x_stuart, STUART, 14857000, 1);
+static DEFINE_PXA95_CKEN(pxa95x_i2c, I2C, 32842000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_keypad, KEYPAD, 32768, 0);
+static DEFINE_PXA95_CKEN(pxa95x_ssp1, SSP1, 13000000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_ssp2, SSP2, 13000000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_ssp3, SSP3, 13000000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_ssp4, SSP4, 13000000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_pwm0, PWM0, 13000000, 0);
+static DEFINE_PXA95_CKEN(pxa95x_pwm1, PWM1, 13000000, 0);
+
+static struct clk_lookup pxa95x_clkregs[] = {
+	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
+	/* Power I2C clock is always on */
+	INIT_CLKREG(&clk_dummy, "pxa3xx-pwri2c.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_lcd, "pxa2xx-fb", NULL),
+	INIT_CLKREG(&clk_pxa95x_ffuart, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_pxa95x_btuart, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_stuart, "pxa2xx-uart.2", NULL),
+	INIT_CLKREG(&clk_pxa95x_stuart, "pxa2xx-ir", "UARTCLK"),
+	INIT_CLKREG(&clk_pxa95x_i2c, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_pxa95x_keypad, "pxa27x-keypad", NULL),
+	INIT_CLKREG(&clk_pxa95x_ssp1, "pxa27x-ssp.0", NULL),
+	INIT_CLKREG(&clk_pxa95x_ssp2, "pxa27x-ssp.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_ssp3, "pxa27x-ssp.2", NULL),
+	INIT_CLKREG(&clk_pxa95x_ssp4, "pxa27x-ssp.3", NULL),
+	INIT_CLKREG(&clk_pxa95x_pwm0, "pxa27x-pwm.0", NULL),
+	INIT_CLKREG(&clk_pxa95x_pwm1, "pxa27x-pwm.1", NULL),
+};
+
+static void pxa_ack_ext_wakeup(unsigned int irq)
+{
+	PECR |= PECR_IS(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_mask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 &= ~(1 << ((irq - PXA_IRQ(0)) & 0x1f));
+	PECR &= ~PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static void pxa_unmask_ext_wakeup(unsigned int irq)
+{
+	ICMR2 |= 1 << ((irq - PXA_IRQ(0)) & 0x1f);
+	PECR |= PECR_IE(irq - IRQ_WAKEUP0);
+}
+
+static int pxa_set_ext_wakeup_type(unsigned int irq, unsigned int flow_type)
+{
+	if (flow_type & IRQ_TYPE_EDGE_RISING)
+		PWER |= 1 << (irq - IRQ_WAKEUP0);
+
+	if (flow_type & IRQ_TYPE_EDGE_FALLING)
+		PWER |= 1 << (irq - IRQ_WAKEUP0 + 2);
+
+	return 0;
+}
+
+static struct irq_chip pxa_ext_wakeup_chip = {
+	.name		= "WAKEUP",
+	.ack		= pxa_ack_ext_wakeup,
+	.mask		= pxa_mask_ext_wakeup,
+	.unmask		= pxa_unmask_ext_wakeup,
+	.set_type	= pxa_set_ext_wakeup_type,
+};
+
+static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+{
+	set_irq_chip(IRQ_WAKEUP0, &pxa_ext_wakeup_chip);
+	set_irq_handler(IRQ_WAKEUP0, handle_edge_irq);
+	set_irq_flags(IRQ_WAKEUP0, IRQF_VALID);
+
+	pxa_ext_wakeup_chip.set_wake = fn;
+}
+
+void __init pxa95x_init_irq(void)
+{
+	/* enable CP6 access */
+	u32 value;
+	__asm__ __volatile__("mrc p15, 0, %0, c15, c1, 0\n": "=r"(value));
+	value |= (1 << 6);
+	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));
+
+	pxa_init_irq(96, NULL);
+	pxa_init_ext_wakeup_irq(NULL);
+	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
+}
+
+/*
+ * device registration specific to PXA93x.
+ */
+
+void __init pxa95x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
+{
+	pxa_register_device(&pxa3xx_device_i2c_power, info);
+}
+
+static struct platform_device *devices[] __initdata = {
+	&sa1100_device_rtc,
+	&pxa_device_rtc,
+	&pxa27x_device_ssp1,
+	&pxa27x_device_ssp2,
+	&pxa27x_device_ssp3,
+	&pxa3xx_device_ssp4,
+	&pxa27x_device_pwm0,
+	&pxa27x_device_pwm1,
+};
+
+static int __init pxa95x_init(void)
+{
+	int ret = 0;
+
+	if (cpu_is_pxa95x()) {
+		mfp_init_base(io_p2v(MFPR_BASE));
+		mfp_init_addr(pxa95x_mfp_addr_map);
+
+		reset_status = ARSR;
+
+		/*
+		 * clear RDH bit every time after reset
+		 *
+		 * Note: the last 3 bits DxS are write-1-to-clear so carefully
+		 * preserve them here in case they will be referenced later
+		 */
+		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
+
+		clkdev_add_table(pxa95x_clkregs, ARRAY_SIZE(pxa95x_clkregs));
+
+		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
+			return ret;
+
+		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+	}
+
+	return ret;
+}
+
+postcore_initcall(pxa95x_init);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4414a01..a099efe 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -382,6 +382,12 @@ config CPU_FEROCEON_OLD_ID
 	  for which the CPU ID is equal to the ARM926 ID.
 	  Relevant for Feroceon-1850 and early Feroceon-2850.
 
+# Marvell PJ4
+config CPU_PJ4
+	bool
+	select CPU_V7
+	select ARM_THUMBEE
+
 # ARMv6
 config CPU_V6
 	bool "Support ARM V6 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
@@ -789,7 +795,7 @@ config CACHE_PL310
 
 config CACHE_TAUROS2
 	bool "Enable the Tauros2 L2 cache controller"
-	depends on (ARCH_DOVE || ARCH_MMP)
+	depends on (ARCH_DOVE || ARCH_MMP || CPU_PJ4)
 	default y
 	select OUTER_CACHE
 	help
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 4ac2fd9..bcdd9ce 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -7,6 +7,7 @@ obj-y	:= dma.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_PXA93x)		+= mfp.o
+obj-$(CONFIG_PXA95x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
 
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
diff --git a/arch/arm/plat-pxa/include/plat/mfp.h b/arch/arm/plat-pxa/include/plat/mfp.h
index a3a2a65..bd7bbf8 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -423,7 +423,8 @@ typedef unsigned long mfp_cfg_t;
 	((MFP_CFG_DEFAULT & ~(MFP_AF_MASK | MFP_DS_MASK | MFP_LPM_STATE_MASK)) |\
 	 (MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_##drv | MFP_LPM_##lpm))
 
-#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x) || defined(CONFIG_ARCH_MMP)
+#if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA93x)			\
+	|| defined(CONFIG_PXA95x) || defined(CONFIG_ARCH_MMP)
 /*
  * each MFP pin will have a MFPR register, since the offset of the
  * register varies between processors, the processor specific code
@@ -470,6 +471,6 @@ void mfp_write(int mfp, unsigned long mfpr_val);
 void mfp_config(unsigned long *mfp_cfgs, int num);
 void mfp_config_run(void);
 void mfp_config_lpm(void);
-#endif /* CONFIG_PXA3xx || CONFIG_PXA93x || CONFIG_ARCH_MMP */
+#endif /* CONFIG_PXA3xx || CONFIG_PXA93x || CONFIG_PXA95x || CONFIG_ARCH_MMP */
 
 #endif /* __ASM_PLAT_MFP_H */
-- 
1.5.6.5
