From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 15 Jul 2011 20:09:36 +0800
Subject: [PATCH v3 06/10] ARM: mxs: add saif device
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Message-ID: <1310731780-1645-7-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig                       |    1 +
 arch/arm/mach-mxs/devices-mx28.h                |    3 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |   60 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   20 ++++++++
 7 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 4cd0231..405c28d 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -48,6 +48,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_FLEXCAN
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
+	select MXS_HAVE_PLATFORM_MXS_SAIF
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 79b9452..c0f21ce 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -45,3 +45,6 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 
 struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
+
+extern const struct mxs_saif_data mx28_saif_data[] __initconst;
+#define mx28_add_saif(id)              mxs_add_saif(&mx28_saif_data[id])
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index acf9eea..b554371 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -23,3 +23,6 @@ config MXS_HAVE_PLATFORM_MXS_PWM
 
 config MXS_HAVE_PLATFORM_MXSFB
 	bool
+
+config MXS_HAVE_PLATFORM_MXS_SAIF
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 351915c..d3e8cc3 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
 obj-y += platform-gpio-mxs.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_SAIF) += platform-mxs-saif.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-saif.c b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
new file mode 100644
index 0000000..1ec965e
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-saif.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define mxs_saif_data_entry_single(soc, _id)				\
+	{								\
+		.id = _id,						\
+		.iobase = soc ## _SAIF ## _id ## _BASE_ADDR,		\
+		.irq = soc ## _INT_SAIF ## _id,				\
+		.dma = soc ## _DMA_SAIF ## _id,				\
+		.dmairq = soc ## _INT_SAIF ## _id ##_DMA,		\
+	}
+
+#define mxs_saif_data_entry(soc, _id)					\
+	[_id] = mxs_saif_data_entry_single(soc, _id)
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_saif_data mx28_saif_data[] __initconst = {
+	mxs_saif_data_entry(MX28, 0),
+	mxs_saif_data_entry(MX28, 1),
+};
+#endif
+
+struct platform_device *__init mxs_add_saif(const struct mxs_saif_data *data)
+{
+	struct resource res[] = {
+		{
+			.start = data->iobase,
+			.end = data->iobase + SZ_4K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = data->irq,
+			.end = data->irq,
+			.flags = IORESOURCE_IRQ,
+		}, {
+			.start = data->dma,
+			.end = data->dma,
+			.flags = IORESOURCE_DMA,
+		}, {
+			.start = data->dmairq,
+			.end = data->dmairq,
+			.flags = IORESOURCE_IRQ,
+		},
+
+	};
+
+	return mxs_add_platform_device("mxs-saif", data->id, res,
+					ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 812d7a8..a8080f4 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -92,3 +92,15 @@ struct platform_device *__init mxs_add_mxs_mmc(
 /* pwm */
 struct platform_device *__init mxs_add_mxs_pwm(
 		resource_size_t iobase, int id);
+
+/* saif */
+struct mxs_saif_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t irq;
+	resource_size_t dma;
+	resource_size_t dmairq;
+};
+
+struct platform_device *__init mxs_add_saif(
+		const struct mxs_saif_data *data);
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index eaaf6ff..7837a87 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -40,6 +40,8 @@
 #define MX28EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(3, 28)
 #define MX28EVK_MMC1_SLOT_POWER		MXS_GPIO_NR(3, 29)
 
+#define DIGCTRL_BASE_ADDR      MX28_IO_ADDRESS(MX28_DIGCTL_BASE_ADDR)
+
 static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* duart */
 	MX28_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
@@ -183,6 +185,18 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 
 	/* led */
 	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
+
+	/* saif0 & saif1 */
+	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0 |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0 |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
 };
 
 /* led */
@@ -392,6 +406,12 @@ static void __init mx28evk_init(void)
 
 	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 
+	mx28_add_saif(0);
+	mx28_add_saif(1);
+
+	/*set the saif clk mux, both saif0/saif1 use saif0 clk*/
+	__raw_writel(0x2 << 10, DIGCTRL_BASE_ADDR);
+
 	/* power on mmc slot by writing 0 to the gpio */
 	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
-- 
1.7.0.4
