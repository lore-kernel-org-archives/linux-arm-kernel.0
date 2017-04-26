From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Apr 2017 16:50:29 +0100
Subject: Applied "ASoC: stm32: add SAI driver" to the asoc tree
In-Reply-To: <1491837596-2924-3-git-send-email-olivier.moysan@st.com>
Message-ID: <E1d3PD3-0002QQ-Qo@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: add SAI driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3e086edfe0c73daaabd929b926bbe26536272d9a Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 10 Apr 2017 17:19:56 +0200
Subject: [PATCH] ASoC: stm32: add SAI driver

This patch implements SAI ASoC driver for STM32.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/Kconfig             |   1 +
 sound/soc/Makefile            |   1 +
 sound/soc/stm/Kconfig         |   8 +
 sound/soc/stm/Makefile        |   6 +
 sound/soc/stm/stm32_sai.c     | 115 ++++++
 sound/soc/stm/stm32_sai.h     | 200 ++++++++++
 sound/soc/stm/stm32_sai_sub.c | 884 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1215 insertions(+)
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_sai.c
 create mode 100644 sound/soc/stm/stm32_sai.h
 create mode 100644 sound/soc/stm/stm32_sai_sub.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 182d92efc7c8..3836ebe8938f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -63,6 +63,7 @@ source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sti/Kconfig"
+source "sound/soc/stm/Kconfig"
 source "sound/soc/sunxi/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9a30f21d16ee..5440cf77c39a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sti/
+obj-$(CONFIG_SND_SOC)	+= stm/
 obj-$(CONFIG_SND_SOC)	+= sunxi/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
new file mode 100644
index 000000000000..972970f0890a
--- /dev/null
+++ b/sound/soc/stm/Kconfig
@@ -0,0 +1,8 @@
+menuconfig SND_SOC_STM32
+	tristate "STMicroelectronics STM32 SOC audio support"
+	depends on ARCH_STM32 || COMPILE_TEST
+	depends on SND_SOC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select REGMAP_MMIO
+	help
+	  Say Y if you want to enable ASoC-support for STM32
diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
new file mode 100644
index 000000000000..e466a4759698
--- /dev/null
+++ b/sound/soc/stm/Makefile
@@ -0,0 +1,6 @@
+# SAI
+snd-soc-stm32-sai-sub-objs := stm32_sai_sub.o
+obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
+
+snd-soc-stm32-sai-objs := stm32_sai.o
+obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
new file mode 100644
index 000000000000..2a27a26bf7a1
--- /dev/null
+++ b/sound/soc/stm/stm32_sai.c
@@ -0,0 +1,115 @@
+/*
+ * STM32 ALSA SoC Digital Audio Interface (SAI) driver.
+ *
+ * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
+ * Author(s): Olivier Moysan <olivier.moysan@st.com> for STMicroelectronics.
+ *
+ * License terms: GPL V2.0.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/reset.h>
+
+#include <sound/dmaengine_pcm.h>
+#include <sound/core.h>
+
+#include "stm32_sai.h"
+
+static const struct of_device_id stm32_sai_ids[] = {
+	{ .compatible = "st,stm32f4-sai", .data = (void *)SAI_STM32F4 },
+	{}
+};
+
+static int stm32_sai_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct stm32_sai_data *sai;
+	struct reset_control *rst;
+	struct resource *res;
+	void __iomem *base;
+	const struct of_device_id *of_id;
+
+	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
+	if (!sai)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	of_id = of_match_device(stm32_sai_ids, &pdev->dev);
+	if (of_id)
+		sai->version = (enum stm32_sai_version)of_id->data;
+	else
+		return -EINVAL;
+
+	sai->clk_x8k = devm_clk_get(&pdev->dev, "x8k");
+	if (IS_ERR(sai->clk_x8k)) {
+		dev_err(&pdev->dev, "missing x8k parent clock\n");
+		return PTR_ERR(sai->clk_x8k);
+	}
+
+	sai->clk_x11k = devm_clk_get(&pdev->dev, "x11k");
+	if (IS_ERR(sai->clk_x11k)) {
+		dev_err(&pdev->dev, "missing x11k parent clock\n");
+		return PTR_ERR(sai->clk_x11k);
+	}
+
+	/* init irqs */
+	sai->irq = platform_get_irq(pdev, 0);
+	if (sai->irq < 0) {
+		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		return sai->irq;
+	}
+
+	/* reset */
+	rst = reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
+		udelay(2);
+		reset_control_deassert(rst);
+	}
+
+	sai->pdev = pdev;
+	platform_set_drvdata(pdev, sai);
+
+	return of_platform_populate(np, NULL, NULL, &pdev->dev);
+}
+
+static int stm32_sai_remove(struct platform_device *pdev)
+{
+	of_platform_depopulate(&pdev->dev);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(of, stm32_sai_ids);
+
+static struct platform_driver stm32_sai_driver = {
+	.driver = {
+		.name = "st,stm32-sai",
+		.of_match_table = stm32_sai_ids,
+	},
+	.probe = stm32_sai_probe,
+	.remove = stm32_sai_remove,
+};
+
+module_platform_driver(stm32_sai_driver);
+
+MODULE_DESCRIPTION("STM32 Soc SAI Interface");
+MODULE_AUTHOR("Olivier Moysan, <olivier.moysan@st.com>");
+MODULE_ALIAS("platform:st,stm32-sai");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
new file mode 100644
index 000000000000..a801fda5066f
--- /dev/null
+++ b/sound/soc/stm/stm32_sai.h
@@ -0,0 +1,200 @@
+/*
+ * STM32 ALSA SoC Digital Audio Interface (SAI) driver.
+ *
+ * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
+ * Author(s): Olivier Moysan <olivier.moysan@st.com> for STMicroelectronics.
+ *
+ * License terms: GPL V2.0.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
+ * details.
+ */
+
+/******************** SAI Register Map **************************************/
+
+/* common register */
+#define STM_SAI_GCR		0x00
+
+/* Sub-block A&B registers offsets, relative to A&B sub-block addresses */
+#define STM_SAI_CR1_REGX	0x00	/* A offset: 0x04. B offset: 0x24 */
+#define STM_SAI_CR2_REGX	0x04
+#define STM_SAI_FRCR_REGX	0x08
+#define STM_SAI_SLOTR_REGX	0x0C
+#define STM_SAI_IMR_REGX	0x10
+#define STM_SAI_SR_REGX		0x14
+#define STM_SAI_CLRFR_REGX	0x18
+#define STM_SAI_DR_REGX		0x1C
+
+/******************** Bit definition for SAI_GCR register *******************/
+#define SAI_GCR_SYNCIN_SHIFT	0
+#define SAI_GCR_SYNCIN_MASK	GENMASK(1, SAI_GCR_SYNCIN_SHIFT)
+#define SAI_GCR_SYNCIN_SET(x)	((x) << SAI_GCR_SYNCIN_SHIFT)
+
+#define SAI_GCR_SYNCOUT_SHIFT	4
+#define SAI_GCR_SYNCOUT_MASK	GENMASK(5, SAI_GCR_SYNCOUT_SHIFT)
+#define SAI_GCR_SYNCOUT_SET(x)	((x) << SAI_GCR_SYNCOUT_SHIFT)
+
+/******************* Bit definition for SAI_XCR1 register *******************/
+#define SAI_XCR1_RX_TX_SHIFT	0
+#define SAI_XCR1_RX_TX		BIT(SAI_XCR1_RX_TX_SHIFT)
+#define SAI_XCR1_SLAVE_SHIFT	1
+#define SAI_XCR1_SLAVE		BIT(SAI_XCR1_SLAVE_SHIFT)
+
+#define SAI_XCR1_PRTCFG_SHIFT	2
+#define SAI_XCR1_PRTCFG_MASK	GENMASK(3, SAI_XCR1_PRTCFG_SHIFT)
+#define SAI_XCR1_PRTCFG_SET(x)	((x) << SAI_XCR1_PRTCFG_SHIFT)
+
+#define SAI_XCR1_DS_SHIFT	5
+#define SAI_XCR1_DS_MASK	GENMASK(7, SAI_XCR1_DS_SHIFT)
+#define SAI_XCR1_DS_SET(x)	((x) << SAI_XCR1_DS_SHIFT)
+
+#define SAI_XCR1_LSBFIRST_SHIFT	8
+#define SAI_XCR1_LSBFIRST	BIT(SAI_XCR1_LSBFIRST_SHIFT)
+#define SAI_XCR1_CKSTR_SHIFT	9
+#define SAI_XCR1_CKSTR		BIT(SAI_XCR1_CKSTR_SHIFT)
+
+#define SAI_XCR1_SYNCEN_SHIFT	10
+#define SAI_XCR1_SYNCEN_MASK	GENMASK(11, SAI_XCR1_SYNCEN_SHIFT)
+#define SAI_XCR1_SYNCEN_SET(x)	((x) << SAI_XCR1_SYNCEN_SHIFT)
+
+#define SAI_XCR1_MONO_SHIFT	12
+#define SAI_XCR1_MONO		BIT(SAI_XCR1_MONO_SHIFT)
+#define SAI_XCR1_OUTDRIV_SHIFT	13
+#define SAI_XCR1_OUTDRIV	BIT(SAI_XCR1_OUTDRIV_SHIFT)
+#define SAI_XCR1_SAIEN_SHIFT	16
+#define SAI_XCR1_SAIEN		BIT(SAI_XCR1_SAIEN_SHIFT)
+#define SAI_XCR1_DMAEN_SHIFT	17
+#define SAI_XCR1_DMAEN		BIT(SAI_XCR1_DMAEN_SHIFT)
+#define SAI_XCR1_NODIV_SHIFT	19
+#define SAI_XCR1_NODIV		BIT(SAI_XCR1_NODIV_SHIFT)
+
+#define SAI_XCR1_MCKDIV_SHIFT	20
+#define SAI_XCR1_MCKDIV_WIDTH	4
+#define SAI_XCR1_MCKDIV_MASK	GENMASK(24, SAI_XCR1_MCKDIV_SHIFT)
+#define SAI_XCR1_MCKDIV_SET(x)	((x) << SAI_XCR1_MCKDIV_SHIFT)
+#define SAI_XCR1_MCKDIV_MAX	((1 << SAI_XCR1_MCKDIV_WIDTH) - 1)
+
+#define SAI_XCR1_OSR_SHIFT	26
+#define SAI_XCR1_OSR		BIT(SAI_XCR1_OSR_SHIFT)
+
+/******************* Bit definition for SAI_XCR2 register *******************/
+#define SAI_XCR2_FTH_SHIFT	0
+#define SAI_XCR2_FTH_MASK	GENMASK(2, SAI_XCR2_FTH_SHIFT)
+#define SAI_XCR2_FTH_SET(x)	((x) << SAI_XCR2_FTH_SHIFT)
+
+#define SAI_XCR2_FFLUSH_SHIFT	3
+#define SAI_XCR2_FFLUSH		BIT(SAI_XCR2_FFLUSH_SHIFT)
+#define SAI_XCR2_TRIS_SHIFT	4
+#define SAI_XCR2_TRIS		BIT(SAI_XCR2_TRIS_SHIFT)
+#define SAI_XCR2_MUTE_SHIFT	5
+#define SAI_XCR2_MUTE		BIT(SAI_XCR2_MUTE_SHIFT)
+#define SAI_XCR2_MUTEVAL_SHIFT	6
+#define SAI_XCR2_MUTEVAL	BIT(SAI_XCR2_MUTEVAL_SHIFT)
+
+#define SAI_XCR2_MUTECNT_SHIFT	7
+#define SAI_XCR2_MUTECNT_MASK	GENMASK(12, SAI_XCR2_MUTECNT_SHIFT)
+#define SAI_XCR2_MUTECNT_SET(x)	((x) << SAI_XCR2_MUTECNT_SHIFT)
+
+#define SAI_XCR2_CPL_SHIFT	13
+#define SAI_XCR2_CPL		BIT(SAI_XCR2_CPL_SHIFT)
+
+#define SAI_XCR2_COMP_SHIFT	14
+#define SAI_XCR2_COMP_MASK	GENMASK(15, SAI_XCR2_COMP_SHIFT)
+#define SAI_XCR2_COMP_SET(x)	((x) << SAI_XCR2_COMP_SHIFT)
+
+/****************** Bit definition for SAI_XFRCR register *******************/
+#define SAI_XFRCR_FRL_SHIFT	0
+#define SAI_XFRCR_FRL_MASK	GENMASK(7, SAI_XFRCR_FRL_SHIFT)
+#define SAI_XFRCR_FRL_SET(x)	((x) << SAI_XFRCR_FRL_SHIFT)
+
+#define SAI_XFRCR_FSALL_SHIFT	8
+#define SAI_XFRCR_FSALL_MASK	GENMASK(14, SAI_XFRCR_FSALL_SHIFT)
+#define SAI_XFRCR_FSALL_SET(x)	((x) << SAI_XFRCR_FSALL_SHIFT)
+
+#define SAI_XFRCR_FSDEF_SHIFT	16
+#define SAI_XFRCR_FSDEF		BIT(SAI_XFRCR_FSDEF_SHIFT)
+#define SAI_XFRCR_FSPOL_SHIFT	17
+#define SAI_XFRCR_FSPOL		BIT(SAI_XFRCR_FSPOL_SHIFT)
+#define SAI_XFRCR_FSOFF_SHIFT	18
+#define SAI_XFRCR_FSOFF		BIT(SAI_XFRCR_FSOFF_SHIFT)
+
+/****************** Bit definition for SAI_XSLOTR register ******************/
+
+#define SAI_XSLOTR_FBOFF_SHIFT	0
+#define SAI_XSLOTR_FBOFF_MASK	GENMASK(4, SAI_XSLOTR_FBOFF_SHIFT)
+#define SAI_XSLOTR_FBOFF_SET(x)	((x) << SAI_XSLOTR_FBOFF_SHIFT)
+
+#define SAI_XSLOTR_SLOTSZ_SHIFT	6
+#define SAI_XSLOTR_SLOTSZ_MASK	GENMASK(7, SAI_XSLOTR_SLOTSZ_SHIFT)
+#define SAI_XSLOTR_SLOTSZ_SET(x)	((x) << SAI_XSLOTR_SLOTSZ_SHIFT)
+
+#define SAI_XSLOTR_NBSLOT_SHIFT 8
+#define SAI_XSLOTR_NBSLOT_MASK	GENMASK(11, SAI_XSLOTR_NBSLOT_SHIFT)
+#define SAI_XSLOTR_NBSLOT_SET(x) ((x) << SAI_XSLOTR_NBSLOT_SHIFT)
+
+#define SAI_XSLOTR_SLOTEN_SHIFT	16
+#define SAI_XSLOTR_SLOTEN_WIDTH	16
+#define SAI_XSLOTR_SLOTEN_MASK	GENMASK(31, SAI_XSLOTR_SLOTEN_SHIFT)
+#define SAI_XSLOTR_SLOTEN_SET(x) ((x) << SAI_XSLOTR_SLOTEN_SHIFT)
+
+/******************* Bit definition for SAI_XIMR register *******************/
+#define SAI_XIMR_OVRUDRIE	BIT(0)
+#define SAI_XIMR_MUTEDETIE	BIT(1)
+#define SAI_XIMR_WCKCFGIE	BIT(2)
+#define SAI_XIMR_FREQIE		BIT(3)
+#define SAI_XIMR_CNRDYIE	BIT(4)
+#define SAI_XIMR_AFSDETIE	BIT(5)
+#define SAI_XIMR_LFSDETIE	BIT(6)
+
+#define SAI_XIMR_SHIFT	0
+#define SAI_XIMR_MASK		GENMASK(6, SAI_XIMR_SHIFT)
+
+/******************** Bit definition for SAI_XSR register *******************/
+#define SAI_XSR_OVRUDR		BIT(0)
+#define SAI_XSR_MUTEDET		BIT(1)
+#define SAI_XSR_WCKCFG		BIT(2)
+#define SAI_XSR_FREQ		BIT(3)
+#define SAI_XSR_CNRDY		BIT(4)
+#define SAI_XSR_AFSDET		BIT(5)
+#define SAI_XSR_LFSDET		BIT(6)
+
+#define SAI_XSR_SHIFT	0
+#define SAI_XSR_MASK		GENMASK(6, SAI_XSR_SHIFT)
+
+/****************** Bit definition for SAI_XCLRFR register ******************/
+#define SAI_XCLRFR_COVRUDR	BIT(0)
+#define SAI_XCLRFR_CMUTEDET	BIT(1)
+#define SAI_XCLRFR_CWCKCFG	BIT(2)
+#define SAI_XCLRFR_CFREQ	BIT(3)
+#define SAI_XCLRFR_CCNRDY	BIT(4)
+#define SAI_XCLRFR_CAFSDET	BIT(5)
+#define SAI_XCLRFR_CLFSDET	BIT(6)
+
+#define SAI_XCLRFR_SHIFT	0
+#define SAI_XCLRFR_MASK		GENMASK(6, SAI_XCLRFR_SHIFT)
+
+enum stm32_sai_version {
+	SAI_STM32F4
+};
+
+/**
+ * struct stm32_sai_data - private data of SAI instance driver
+ * @pdev: device data pointer
+ * @clk_x8k: SAI parent clock for sampling frequencies multiple of 8kHz
+ * @clk_x11k: SAI parent clock for sampling frequencies multiple of 11kHz
+ * @version: SOC version
+ * @irq: SAI interrupt line
+ */
+struct stm32_sai_data {
+	struct platform_device *pdev;
+	struct clk *clk_x8k;
+	struct clk *clk_x11k;
+	int version;
+	int irq;
+};
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
new file mode 100644
index 000000000000..ae4706ca265b
--- /dev/null
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -0,0 +1,884 @@
+/*
+ * STM32 ALSA SoC Digital Audio Interface (SAI) driver.
+ *
+ * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
+ * Author(s): Olivier Moysan <olivier.moysan@st.com> for STMicroelectronics.
+ *
+ * License terms: GPL V2.0.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+#include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm_params.h>
+
+#include "stm32_sai.h"
+
+#define SAI_FREE_PROTOCOL	0x0
+
+#define SAI_SLOT_SIZE_AUTO	0x0
+#define SAI_SLOT_SIZE_16	0x1
+#define SAI_SLOT_SIZE_32	0x2
+
+#define SAI_DATASIZE_8		0x2
+#define SAI_DATASIZE_10		0x3
+#define SAI_DATASIZE_16		0x4
+#define SAI_DATASIZE_20		0x5
+#define SAI_DATASIZE_24		0x6
+#define SAI_DATASIZE_32		0x7
+
+#define STM_SAI_FIFO_SIZE	8
+#define STM_SAI_DAI_NAME_SIZE	15
+
+#define STM_SAI_IS_PLAYBACK(ip)	((ip)->dir == SNDRV_PCM_STREAM_PLAYBACK)
+#define STM_SAI_IS_CAPTURE(ip)	((ip)->dir == SNDRV_PCM_STREAM_CAPTURE)
+
+#define STM_SAI_A_ID		0x0
+#define STM_SAI_B_ID		0x1
+
+#define STM_SAI_BLOCK_NAME(x)	(((x)->id == STM_SAI_A_ID) ? "A" : "B")
+
+/**
+ * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
+ * @pdev: device data pointer
+ * @regmap: SAI register map pointer
+ * @dma_params: dma configuration data for rx or tx channel
+ * @cpu_dai_drv: DAI driver data pointer
+ * @cpu_dai: DAI runtime data pointer
+ * @substream: PCM substream data pointer
+ * @pdata: SAI block parent data pointer
+ * @sai_ck: kernel clock feeding the SAI clock generator
+ * @phys_addr: SAI registers physical base address
+ * @mclk_rate: SAI block master clock frequency (Hz). set at init
+ * @id: SAI sub block id corresponding to sub-block A or B
+ * @dir: SAI block direction (playback or capture). set at init
+ * @master: SAI block mode flag. (true=master, false=slave) set at init
+ * @fmt: SAI block format. relevant only for custom protocols. set at init
+ * @sync: SAI block synchronization mode. (none, internal or external)
+ * @fs_length: frame synchronization length. depends on protocol settings
+ * @slots: rx or tx slot number
+ * @slot_width: rx or tx slot width in bits
+ * @slot_mask: rx or tx active slots mask. set at init or at runtime
+ * @data_size: PCM data width. corresponds to PCM substream width.
+ */
+struct stm32_sai_sub_data {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	struct snd_dmaengine_dai_dma_data dma_params;
+	struct snd_soc_dai_driver *cpu_dai_drv;
+	struct snd_soc_dai *cpu_dai;
+	struct snd_pcm_substream *substream;
+	struct stm32_sai_data *pdata;
+	struct clk *sai_ck;
+	dma_addr_t phys_addr;
+	unsigned int mclk_rate;
+	unsigned int id;
+	int dir;
+	bool master;
+	int fmt;
+	int sync;
+	int fs_length;
+	int slots;
+	int slot_width;
+	int slot_mask;
+	int data_size;
+};
+
+enum stm32_sai_fifo_th {
+	STM_SAI_FIFO_TH_EMPTY,
+	STM_SAI_FIFO_TH_QUARTER,
+	STM_SAI_FIFO_TH_HALF,
+	STM_SAI_FIFO_TH_3_QUARTER,
+	STM_SAI_FIFO_TH_FULL,
+};
+
+static bool stm32_sai_sub_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case STM_SAI_CR1_REGX:
+	case STM_SAI_CR2_REGX:
+	case STM_SAI_FRCR_REGX:
+	case STM_SAI_SLOTR_REGX:
+	case STM_SAI_IMR_REGX:
+	case STM_SAI_SR_REGX:
+	case STM_SAI_CLRFR_REGX:
+	case STM_SAI_DR_REGX:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_sai_sub_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case STM_SAI_DR_REGX:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case STM_SAI_CR1_REGX:
+	case STM_SAI_CR2_REGX:
+	case STM_SAI_FRCR_REGX:
+	case STM_SAI_SLOTR_REGX:
+	case STM_SAI_IMR_REGX:
+	case STM_SAI_SR_REGX:
+	case STM_SAI_CLRFR_REGX:
+	case STM_SAI_DR_REGX:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config stm32_sai_sub_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = STM_SAI_DR_REGX,
+	.readable_reg = stm32_sai_sub_readable_reg,
+	.volatile_reg = stm32_sai_sub_volatile_reg,
+	.writeable_reg = stm32_sai_sub_writeable_reg,
+	.fast_io = true,
+};
+
+static irqreturn_t stm32_sai_isr(int irq, void *devid)
+{
+	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
+	struct snd_pcm_substream *substream = sai->substream;
+	struct platform_device *pdev = sai->pdev;
+	unsigned int sr, imr, flags;
+	snd_pcm_state_t status = SNDRV_PCM_STATE_RUNNING;
+
+	regmap_read(sai->regmap, STM_SAI_IMR_REGX, &imr);
+	regmap_read(sai->regmap, STM_SAI_SR_REGX, &sr);
+
+	flags = sr & imr;
+	if (!flags)
+		return IRQ_NONE;
+
+	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
+			   SAI_XCLRFR_MASK);
+
+	if (flags & SAI_XIMR_OVRUDRIE) {
+		dev_err(&pdev->dev, "IT %s\n",
+			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
+		status = SNDRV_PCM_STATE_XRUN;
+	}
+
+	if (flags & SAI_XIMR_MUTEDETIE)
+		dev_dbg(&pdev->dev, "IT mute detected\n");
+
+	if (flags & SAI_XIMR_WCKCFGIE) {
+		dev_err(&pdev->dev, "IT wrong clock configuration\n");
+		status = SNDRV_PCM_STATE_DISCONNECTED;
+	}
+
+	if (flags & SAI_XIMR_CNRDYIE)
+		dev_warn(&pdev->dev, "IT Codec not ready\n");
+
+	if (flags & SAI_XIMR_AFSDETIE) {
+		dev_warn(&pdev->dev, "IT Anticipated frame synchro\n");
+		status = SNDRV_PCM_STATE_XRUN;
+	}
+
+	if (flags & SAI_XIMR_LFSDETIE) {
+		dev_warn(&pdev->dev, "IT Late frame synchro\n");
+		status = SNDRV_PCM_STATE_XRUN;
+	}
+
+	if (status != SNDRV_PCM_STATE_RUNNING) {
+		snd_pcm_stream_lock(substream);
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(substream);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_sai_set_sysclk(struct snd_soc_dai *cpu_dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if ((dir == SND_SOC_CLOCK_OUT) && sai->master) {
+		sai->mclk_rate = freq;
+		dev_dbg(cpu_dai->dev, "SAI MCLK frequency is %uHz\n", freq);
+	}
+
+	return 0;
+}
+
+static int stm32_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				      u32 rx_mask, int slots, int slot_width)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int slotr, slotr_mask, slot_size;
+
+	dev_dbg(cpu_dai->dev, "masks tx/rx:%#x/%#x, slots:%d, width:%d\n",
+		tx_mask, rx_mask, slots, slot_width);
+
+	switch (slot_width) {
+	case 16:
+		slot_size = SAI_SLOT_SIZE_16;
+		break;
+	case 32:
+		slot_size = SAI_SLOT_SIZE_32;
+		break;
+	default:
+		slot_size = SAI_SLOT_SIZE_AUTO;
+		break;
+	}
+
+	slotr = SAI_XSLOTR_SLOTSZ_SET(slot_size) |
+		SAI_XSLOTR_NBSLOT_SET(slots - 1);
+	slotr_mask = SAI_XSLOTR_SLOTSZ_MASK | SAI_XSLOTR_NBSLOT_MASK;
+
+	/* tx/rx mask set in machine init, if slot number defined in DT */
+	if (STM_SAI_IS_PLAYBACK(sai)) {
+		sai->slot_mask = tx_mask;
+		slotr |= SAI_XSLOTR_SLOTEN_SET(tx_mask);
+	}
+
+	if (STM_SAI_IS_CAPTURE(sai)) {
+		sai->slot_mask = rx_mask;
+		slotr |= SAI_XSLOTR_SLOTEN_SET(rx_mask);
+	}
+
+	slotr_mask |= SAI_XSLOTR_SLOTEN_MASK;
+
+	regmap_update_bits(sai->regmap, STM_SAI_SLOTR_REGX, slotr_mask, slotr);
+
+	sai->slot_width = slot_width;
+	sai->slots = slots;
+
+	return 0;
+}
+
+static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int cr1 = 0, frcr = 0;
+	int cr1_mask = 0, frcr_mask = 0;
+	int ret;
+
+	dev_dbg(cpu_dai->dev, "fmt %x\n", fmt);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	/* SCK active high for all protocols */
+	case SND_SOC_DAIFMT_I2S:
+		cr1 |= SAI_XCR1_CKSTR;
+		frcr |= SAI_XFRCR_FSOFF | SAI_XFRCR_FSDEF;
+		break;
+	/* Left justified */
+	case SND_SOC_DAIFMT_MSB:
+		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
+		break;
+	/* Right justified */
+	case SND_SOC_DAIFMT_LSB:
+		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		frcr |= SAI_XFRCR_FSPOL;
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Unsupported protocol %#x\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	cr1_mask |= SAI_XCR1_PRTCFG_MASK | SAI_XCR1_CKSTR;
+	frcr_mask |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF |
+		     SAI_XFRCR_FSDEF;
+
+	/* DAI clock strobing. Invert setting previously set */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cr1 ^= SAI_XCR1_CKSTR;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		frcr ^= SAI_XFRCR_FSPOL;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert fs & sck */
+		cr1 ^= SAI_XCR1_CKSTR;
+		frcr ^= SAI_XFRCR_FSPOL;
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Unsupported strobing %#x\n",
+			fmt & SND_SOC_DAIFMT_INV_MASK);
+		return -EINVAL;
+	}
+	cr1_mask |= SAI_XCR1_CKSTR;
+	frcr_mask |= SAI_XFRCR_FSPOL;
+
+	regmap_update_bits(sai->regmap, STM_SAI_FRCR_REGX, frcr_mask, frcr);
+
+	/* DAI clock master masks */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* codec is master */
+		cr1 |= SAI_XCR1_SLAVE;
+		sai->master = false;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		sai->master = true;
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Unsupported mode %#x\n",
+			fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+	cr1_mask |= SAI_XCR1_SLAVE;
+
+	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+		return ret;
+	}
+
+	sai->fmt = fmt;
+
+	return 0;
+}
+
+static int stm32_sai_startup(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int imr, cr2, ret;
+
+	sai->substream = substream;
+
+	ret = clk_prepare_enable(sai->sai_ck);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable ITs */
+	regmap_update_bits(sai->regmap, STM_SAI_SR_REGX,
+			   SAI_XSR_MASK, (unsigned int)~SAI_XSR_MASK);
+
+	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX,
+			   SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
+
+	imr = SAI_XIMR_OVRUDRIE;
+	if (STM_SAI_IS_CAPTURE(sai)) {
+		regmap_read(sai->regmap, STM_SAI_CR2_REGX, &cr2);
+		if (cr2 & SAI_XCR2_MUTECNT_MASK)
+			imr |= SAI_XIMR_MUTEDETIE;
+	}
+
+	if (sai->master)
+		imr |= SAI_XIMR_WCKCFGIE;
+	else
+		imr |= SAI_XIMR_AFSDETIE | SAI_XIMR_LFSDETIE;
+
+	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX,
+			   SAI_XIMR_MASK, imr);
+
+	return 0;
+}
+
+static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
+				struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int cr1, cr1_mask, ret;
+	int fth = STM_SAI_FIFO_TH_HALF;
+
+	/* FIFO config */
+	regmap_update_bits(sai->regmap, STM_SAI_CR2_REGX,
+			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
+			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_SET(fth));
+
+	/* Mode, data format and channel config */
+	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_16);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_32);
+		break;
+	default:
+		dev_err(cpu_dai->dev, "Data format not supported");
+		return -EINVAL;
+	}
+	cr1_mask = SAI_XCR1_DS_MASK | SAI_XCR1_PRTCFG_MASK;
+
+	cr1_mask |= SAI_XCR1_RX_TX;
+	if (STM_SAI_IS_CAPTURE(sai))
+		cr1 |= SAI_XCR1_RX_TX;
+
+	cr1_mask |= SAI_XCR1_MONO;
+	if ((sai->slots == 2) && (params_channels(params) == 1))
+		cr1 |= SAI_XCR1_MONO;
+
+	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+		return ret;
+	}
+
+	/* DMA config */
+	sai->dma_params.maxburst = STM_SAI_FIFO_SIZE * fth / sizeof(u32);
+	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&sai->dma_params);
+
+	return 0;
+}
+
+static int stm32_sai_set_slots(struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int slotr, slot_sz;
+
+	regmap_read(sai->regmap, STM_SAI_SLOTR_REGX, &slotr);
+
+	/*
+	 * If SLOTSZ is set to auto in SLOTR, align slot width on data size
+	 * By default slot width = data size, if not forced from DT
+	 */
+	slot_sz = slotr & SAI_XSLOTR_SLOTSZ_MASK;
+	if (slot_sz == SAI_XSLOTR_SLOTSZ_SET(SAI_SLOT_SIZE_AUTO))
+		sai->slot_width = sai->data_size;
+
+	if (sai->slot_width < sai->data_size) {
+		dev_err(cpu_dai->dev,
+			"Data size %d larger than slot width\n",
+			sai->data_size);
+		return -EINVAL;
+	}
+
+	/* Slot number is set to 2, if not specified in DT */
+	if (!sai->slots)
+		sai->slots = 2;
+
+	/* The number of slots in the audio frame is equal to NBSLOT[3:0] + 1*/
+	regmap_update_bits(sai->regmap, STM_SAI_SLOTR_REGX,
+			   SAI_XSLOTR_NBSLOT_MASK,
+			   SAI_XSLOTR_NBSLOT_SET((sai->slots - 1)));
+
+	/* Set default slots mask if not already set from DT */
+	if (!(slotr & SAI_XSLOTR_SLOTEN_MASK)) {
+		sai->slot_mask = (1 << sai->slots) - 1;
+		regmap_update_bits(sai->regmap,
+				   STM_SAI_SLOTR_REGX, SAI_XSLOTR_SLOTEN_MASK,
+				   SAI_XSLOTR_SLOTEN_SET(sai->slot_mask));
+	}
+
+	dev_dbg(cpu_dai->dev, "slots %d, slot width %d\n",
+		sai->slots, sai->slot_width);
+
+	return 0;
+}
+
+static void stm32_sai_set_frame(struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int fs_active, offset, format;
+	int frcr, frcr_mask;
+
+	format = sai->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	sai->fs_length = sai->slot_width * sai->slots;
+
+	fs_active = sai->fs_length / 2;
+	if ((format == SND_SOC_DAIFMT_DSP_A) ||
+	    (format == SND_SOC_DAIFMT_DSP_B))
+		fs_active = 1;
+
+	frcr = SAI_XFRCR_FRL_SET((sai->fs_length - 1));
+	frcr |= SAI_XFRCR_FSALL_SET((fs_active - 1));
+	frcr_mask = SAI_XFRCR_FRL_MASK | SAI_XFRCR_FSALL_MASK;
+
+	dev_dbg(cpu_dai->dev, "frame length %d, frame active %d\n",
+		sai->fs_length, fs_active);
+
+	regmap_update_bits(sai->regmap, STM_SAI_FRCR_REGX, frcr_mask, frcr);
+
+	if ((sai->fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_LSB) {
+		offset = sai->slot_width - sai->data_size;
+
+		regmap_update_bits(sai->regmap, STM_SAI_SLOTR_REGX,
+				   SAI_XSLOTR_FBOFF_MASK,
+				   SAI_XSLOTR_FBOFF_SET(offset));
+	}
+}
+
+static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
+				     struct snd_pcm_hw_params *params)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int cr1, mask, div = 0;
+	int sai_clk_rate, ret;
+
+	if (!sai->mclk_rate) {
+		dev_err(cpu_dai->dev, "Mclk rate is null\n");
+		return -EINVAL;
+	}
+
+	if (!(params_rate(params) % 11025))
+		clk_set_parent(sai->sai_ck, sai->pdata->clk_x11k);
+	else
+		clk_set_parent(sai->sai_ck, sai->pdata->clk_x8k);
+	sai_clk_rate = clk_get_rate(sai->sai_ck);
+
+	/*
+	 * mclk_rate = 256 * fs
+	 * MCKDIV = 0 if sai_ck < 3/2 * mclk_rate
+	 * MCKDIV = sai_ck / (2 * mclk_rate) otherwise
+	 */
+	if (2 * sai_clk_rate >= 3 * sai->mclk_rate)
+		div = DIV_ROUND_CLOSEST(sai_clk_rate, 2 * sai->mclk_rate);
+
+	if (div > SAI_XCR1_MCKDIV_MAX) {
+		dev_err(cpu_dai->dev, "Divider %d out of range\n", div);
+		return -EINVAL;
+	}
+	dev_dbg(cpu_dai->dev, "SAI clock %d, divider %d\n", sai_clk_rate, div);
+
+	mask = SAI_XCR1_MCKDIV_MASK;
+	cr1 = SAI_XCR1_MCKDIV_SET(div);
+	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, mask, cr1);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stm32_sai_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
+
+	sai->data_size = params_width(params);
+
+	ret = stm32_sai_set_slots(cpu_dai);
+	if (ret < 0)
+		return ret;
+	stm32_sai_set_frame(cpu_dai);
+
+	ret = stm32_sai_set_config(cpu_dai, substream, params);
+	if (ret)
+		return ret;
+
+	if (sai->master)
+		ret = stm32_sai_configure_clock(cpu_dai, params);
+
+	return ret;
+}
+
+static int stm32_sai_trigger(struct snd_pcm_substream *substream, int cmd,
+			     struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dev_dbg(cpu_dai->dev, "Enable DMA and SAI\n");
+
+		regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+				   SAI_XCR1_DMAEN, SAI_XCR1_DMAEN);
+
+		/* Enable SAI */
+		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+					 SAI_XCR1_SAIEN, SAI_XCR1_SAIEN);
+		if (ret < 0)
+			dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_STOP:
+		dev_dbg(cpu_dai->dev, "Disable DMA and SAI\n");
+
+		regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+				   SAI_XCR1_DMAEN,
+				   (unsigned int)~SAI_XCR1_DMAEN);
+
+		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
+					 SAI_XCR1_SAIEN,
+					 (unsigned int)~SAI_XCR1_SAIEN);
+		if (ret < 0)
+			dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+
+	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
+
+	clk_disable_unprepare(sai->sai_ck);
+	sai->substream = NULL;
+}
+
+static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+
+	sai->dma_params.addr = (dma_addr_t)(sai->phys_addr + STM_SAI_DR_REGX);
+	sai->dma_params.maxburst = 1;
+	/* Buswidth will be set by framework at runtime */
+	sai->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	if (STM_SAI_IS_PLAYBACK(sai))
+		snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params, NULL);
+	else
+		snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops stm32_sai_pcm_dai_ops = {
+	.set_sysclk	= stm32_sai_set_sysclk,
+	.set_fmt	= stm32_sai_set_dai_fmt,
+	.set_tdm_slot	= stm32_sai_set_dai_tdm_slot,
+	.startup	= stm32_sai_startup,
+	.hw_params	= stm32_sai_hw_params,
+	.trigger	= stm32_sai_trigger,
+	.shutdown	= stm32_sai_shutdown,
+};
+
+static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
+	.buffer_bytes_max = 8 * PAGE_SIZE,
+	.period_bytes_min = 1024, /* 5ms at 48kHz */
+	.period_bytes_max = PAGE_SIZE,
+	.periods_min = 2,
+	.periods_max = 8,
+};
+
+static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
+{
+		.probe = stm32_sai_dai_probe,
+		.id = 1, /* avoid call to fmt_single_name() */
+		.playback = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			/* DMA does not support 24 bits transfers */
+			.formats =
+				SNDRV_PCM_FMTBIT_S8 |
+				SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &stm32_sai_pcm_dai_ops,
+	}
+};
+
+static struct snd_soc_dai_driver stm32_sai_capture_dai[] = {
+{
+		.probe = stm32_sai_dai_probe,
+		.id = 1, /* avoid call to fmt_single_name() */
+		.capture = {
+			.channels_min = 1,
+			.channels_max = 2,
+			.rate_min = 8000,
+			.rate_max = 192000,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			/* DMA does not support 24 bits transfers */
+			.formats =
+				SNDRV_PCM_FMTBIT_S8 |
+				SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &stm32_sai_pcm_dai_ops,
+	}
+};
+
+static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
+	.pcm_hardware	= &stm32_sai_pcm_hw,
+	.prepare_slave_config	= snd_dmaengine_pcm_prepare_slave_config,
+};
+
+static const struct snd_soc_component_driver stm32_component = {
+	.name = "stm32-sai",
+};
+
+static const struct of_device_id stm32_sai_sub_ids[] = {
+	{ .compatible = "st,stm32-sai-sub-a",
+	  .data = (void *)STM_SAI_A_ID},
+	{ .compatible = "st,stm32-sai-sub-b",
+	  .data = (void *)STM_SAI_B_ID},
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_sai_sub_ids);
+
+static int stm32_sai_sub_parse_of(struct platform_device *pdev,
+				  struct stm32_sai_sub_data *sai)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	void __iomem *base;
+
+	if (!np)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	dev_err(&pdev->dev, "res %pr\n", res);
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	sai->phys_addr = res->start;
+	sai->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &stm32_sai_sub_regmap_config);
+
+	/* Get direction property */
+	if (of_property_match_string(np, "dma-names", "tx") >= 0) {
+		sai->dir = SNDRV_PCM_STREAM_PLAYBACK;
+	} else if (of_property_match_string(np, "dma-names", "rx") >= 0) {
+		sai->dir = SNDRV_PCM_STREAM_CAPTURE;
+	} else {
+		dev_err(&pdev->dev, "Unsupported direction\n");
+		return -EINVAL;
+	}
+
+	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
+	if (IS_ERR(sai->sai_ck)) {
+		dev_err(&pdev->dev, "missing kernel clock sai_ck\n");
+		return PTR_ERR(sai->sai_ck);
+	}
+
+	return 0;
+}
+
+static int stm32_sai_sub_dais_init(struct platform_device *pdev,
+				   struct stm32_sai_sub_data *sai)
+{
+	sai->cpu_dai_drv = devm_kzalloc(&pdev->dev,
+					sizeof(struct snd_soc_dai_driver),
+					GFP_KERNEL);
+	if (!sai->cpu_dai_drv)
+		return -ENOMEM;
+
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
+	if (STM_SAI_IS_PLAYBACK(sai)) {
+		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
+		       sizeof(stm32_sai_playback_dai));
+		sai->cpu_dai_drv->playback.stream_name = sai->cpu_dai_drv->name;
+	} else {
+		memcpy(sai->cpu_dai_drv, &stm32_sai_capture_dai,
+		       sizeof(stm32_sai_capture_dai));
+		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
+	}
+
+	return 0;
+}
+
+static int stm32_sai_sub_probe(struct platform_device *pdev)
+{
+	struct stm32_sai_sub_data *sai;
+	const struct of_device_id *of_id;
+	int ret;
+
+	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
+	if (!sai)
+		return -ENOMEM;
+
+	of_id = of_match_device(stm32_sai_sub_ids, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+	sai->id = (uintptr_t)of_id->data;
+
+	sai->pdev = pdev;
+	platform_set_drvdata(pdev, sai);
+
+	sai->pdata = dev_get_drvdata(pdev->dev.parent);
+	if (!sai->pdata) {
+		dev_err(&pdev->dev, "Parent device data not available\n");
+		return -EINVAL;
+	}
+
+	ret = stm32_sai_sub_parse_of(pdev, sai);
+	if (ret)
+		return ret;
+
+	ret = stm32_sai_sub_dais_init(pdev, sai);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, sai->pdata->irq, stm32_sai_isr,
+			       IRQF_SHARED, dev_name(&pdev->dev), sai);
+	if (ret) {
+		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_component,
+					      sai->cpu_dai_drv, 1);
+	if (ret)
+		return ret;
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
+					      &stm32_sai_pcm_config, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "could not register pcm dma\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver stm32_sai_sub_driver = {
+	.driver = {
+		.name = "st,stm32-sai-sub",
+		.of_match_table = stm32_sai_sub_ids,
+	},
+	.probe = stm32_sai_sub_probe,
+};
+
+module_platform_driver(stm32_sai_sub_driver);
+
+MODULE_DESCRIPTION("STM32 Soc SAI sub-block Interface");
+MODULE_AUTHOR("Olivier Moysan, <olivier.moysan@st.com>");
+MODULE_ALIAS("platform:st,stm32-sai-sub");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
