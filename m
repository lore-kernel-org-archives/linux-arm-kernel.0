From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 22 Nov 2017 20:43:18 +0900
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Message-ID: <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds for UniPhier AIO audio sound system.
This provides commonly used APIs for input/output
control registers and DMA interfaces for UniPhier AIO.

This module provides all sound devices for I2S, S/PDIF and so on.
Since the AIO has mixed register map for those I/Os, it is hard
to split register areas for each sound devices.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/uniphier/Kconfig       |   5 +
 sound/soc/uniphier/Makefile      |   4 +
 sound/soc/uniphier/aio-core.c    | 368 +++++++++++++++++++++
 sound/soc/uniphier/aio-dma.c     | 266 +++++++++++++++
 sound/soc/uniphier/aio-regctrl.c | 699 +++++++++++++++++++++++++++++++++++++++
 sound/soc/uniphier/aio-regctrl.h | 495 +++++++++++++++++++++++++++
 sound/soc/uniphier/aio.h         | 261 +++++++++++++++
 7 files changed, 2098 insertions(+)
 create mode 100644 sound/soc/uniphier/aio-core.c
 create mode 100644 sound/soc/uniphier/aio-dma.c
 create mode 100644 sound/soc/uniphier/aio-regctrl.c
 create mode 100644 sound/soc/uniphier/aio-regctrl.h
 create mode 100644 sound/soc/uniphier/aio.h

diff --git a/sound/soc/uniphier/Kconfig b/sound/soc/uniphier/Kconfig
index 02886a457eaf..38a02879b9d5 100644
--- a/sound/soc/uniphier/Kconfig
+++ b/sound/soc/uniphier/Kconfig
@@ -8,6 +8,11 @@ config SND_SOC_UNIPHIER
 	  audio interfaces to support below.
 	  If unsure select "N".
 
+config SND_SOC_UNIPHIER_AIO
+	tristate
+	select REGMAP_MMIO
+	depends on SND_SOC_UNIPHIER
+
 config SND_SOC_UNIPHIER_EVEA_CODEC
 	tristate "UniPhier SoC internal audio codec"
 	depends on SND_SOC_UNIPHIER
diff --git a/sound/soc/uniphier/Makefile b/sound/soc/uniphier/Makefile
index 3be00d72f5e5..705a60cb2aa5 100644
--- a/sound/soc/uniphier/Makefile
+++ b/sound/soc/uniphier/Makefile
@@ -1,3 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+snd-soc-uniphier-aio-objs := aio-regctrl.o aio-dma.o aio-core.o
+
+obj-$(CONFIG_SND_SOC_UNIPHIER_AIO) += snd-soc-uniphier-aio.o
+
 snd-soc-uniphier-evea-objs := evea.o
 obj-$(CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC) += snd-soc-uniphier-evea.o
diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
new file mode 100644
index 000000000000..08f33f2c7c99
--- /dev/null
+++ b/sound/soc/uniphier/aio-core.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "aio.h"
+#include "aio-regctrl.h"
+
+static int match_name(const struct uniphier_aio_spec *spec,
+		      const char *name, int direction)
+{
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
+	    spec->swm.dir != PORT_DIR_OUTPUT) {
+		return 0;
+	}
+
+	if (direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    spec->swm.dir != PORT_DIR_INPUT) {
+		return 0;
+	}
+
+	if (spec->name && strcmp(spec->name, name) == 0)
+		return 1;
+
+	if (spec->gname && strcmp(spec->gname, name) == 0)
+		return 1;
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_find_spec - find HW specification info by name
+ * @aio: the AIO device pointer
+ * @name: name of device
+ * @direction: the direction of substream, SNDRV_PCM_STREAM_*
+ *
+ * Find hardware specification information from list by device name. This
+ * information is used for telling the difference of SoCs to driver.
+ *
+ * Specification list is array of 'struct uniphier_aio_spec' which is defined
+ * in each drivers (see: aio-i2s.c).
+ *
+ * Return: The pointer of hardware specification of AIO if successful,
+ * otherwise NULL on error.
+ */
+const struct uniphier_aio_spec *find_spec(struct uniphier_aio *aio,
+					  const char *name, int direction)
+{
+	const struct uniphier_aio_chip_spec *chip_spec = aio->chip->chip_spec;
+	int i;
+
+	for (i = 0; i < chip_spec->num_aio_specs; i++) {
+		const struct uniphier_aio_spec *spec =
+			&chip_spec->aio_specs[i];
+
+		if (!match_name(spec, name, direction))
+			continue;
+
+		return spec;
+	}
+
+	return NULL;
+}
+
+int uniphier_aio_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+
+	sub->substream = substream;
+	aio->dai = dai;
+
+	uniphier_aio_init(sub);
+
+	return 0;
+}
+
+void uniphier_aio_shutdown(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+
+	sub->substream = NULL;
+	aio->dai = NULL;
+}
+
+int uniphier_aio_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+
+	sub->params = *params;
+	sub->setting = 1;
+
+	uniphier_aio_port_reset(sub);
+	uniphier_aio_srcport_reset(sub);
+
+	return 0;
+}
+
+int uniphier_aio_hw_free(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+
+	sub->setting = 0;
+
+	return 0;
+}
+
+int uniphier_aio_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+
+	uniphier_aio_port_set_param(sub, aio->pass_through, &sub->params);
+	uniphier_aio_srcport_set_param(sub, &sub->params);
+	if (sub->swm->type == PORT_TYPE_SPDIF && aio->pass_through)
+		uniphier_aio_oport_set_stream_type(sub, IEC61937_PC_AC3);
+	uniphier_aio_port_set_enable(sub, 1);
+
+	uniphier_aio_if_set_param(sub, aio->pass_through);
+	if (sub->swm->type == PORT_TYPE_CONV) {
+		uniphier_aio_srcif_set_param(sub);
+		uniphier_aio_srcch_set_param(sub);
+		uniphier_aio_srcch_set_enable(sub, 1);
+	}
+
+	return 0;
+}
+
+int uniphier_aio_dai_probe(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(aio->sub); i++) {
+		struct uniphier_aio_sub *sub = &aio->sub[i];
+		const struct uniphier_aio_spec *spec;
+
+		spec = find_spec(aio, dai->name, i);
+		if (!spec)
+			continue;
+
+		sub->swm = &spec->swm;
+		sub->spec = spec;
+	}
+
+	uniphier_aio_chip_init(aio->chip);
+	aio->chip->active = 1;
+
+	return 0;
+}
+
+int uniphier_aio_dai_remove(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+
+	aio->chip->active = 0;
+
+	return 0;
+}
+
+int uniphier_aio_dai_suspend(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+
+	reset_control_assert(aio->chip->rst);
+	clk_disable_unprepare(aio->chip->clk);
+
+	return 0;
+}
+
+int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio *aio = uniphier_priv(dai);
+	int ret, i;
+
+	if (!aio->chip->active)
+		return 0;
+
+	ret = clk_prepare_enable(aio->chip->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(aio->chip->rst);
+	if (ret)
+		goto err_out_clock;
+
+	uniphier_aio_chip_init(aio->chip);
+
+	for (i = 0; i < ARRAY_SIZE(aio->sub); i++) {
+		struct uniphier_aio_sub *sub = &aio->sub[i];
+
+		if (!sub->spec || !sub->substream)
+			continue;
+
+		uniphier_aio_init(sub);
+
+		if (!sub->setting)
+			continue;
+
+		uniphier_aio_port_reset(sub);
+		uniphier_aio_srcport_reset(sub);
+	}
+
+	return 0;
+
+err_out_clock:
+	clk_disable_unprepare(aio->chip->clk);
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver uniphier_aio_component = {
+	.name = "uniphier-aio",
+};
+
+static int uniphier_aio_probe(struct platform_device *pdev)
+{
+	struct uniphier_aio_chip *chip;
+	struct device *dev = &pdev->dev;
+	int ret, i, j;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->chip_spec = of_device_get_match_data(dev);
+	if (!chip->chip_spec)
+		return -EINVAL;
+
+	chip->clk = devm_clk_get(dev, "aio");
+	if (IS_ERR(chip->clk))
+		return PTR_ERR(chip->clk);
+
+	chip->rst = devm_reset_control_get_shared(dev, "aio");
+	if (IS_ERR(chip->rst))
+		return PTR_ERR(chip->rst);
+
+	chip->num_aios = chip->chip_spec->num_dais;
+	chip->aios = devm_kzalloc(dev,
+				  sizeof(struct uniphier_aio) * chip->num_aios,
+				  GFP_KERNEL);
+	if (!chip->aios)
+		return -ENOMEM;
+
+	for (i = 0; i < chip->num_aios; i++) {
+		struct uniphier_aio *aio = &chip->aios[i];
+
+		aio->chip = chip;
+
+		for (j = 0; j < ARRAY_SIZE(aio->sub); j++) {
+			struct uniphier_aio_sub *sub = &aio->sub[j];
+
+			sub->aio = aio;
+			spin_lock_init(&sub->spin);
+		}
+	}
+
+	chip->pdev = pdev;
+	platform_set_drvdata(pdev, chip);
+
+	ret = clk_prepare_enable(chip->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(chip->rst);
+	if (ret)
+		goto err_out_clock;
+
+	ret = devm_snd_soc_register_component(dev, &uniphier_aio_component,
+					      chip->chip_spec->dais,
+					      chip->chip_spec->num_dais);
+	if (ret) {
+		dev_err(dev, "Register component failed.\n");
+		goto err_out_reset;
+	}
+
+	ret = uniphier_aiodma_soc_register_platform(pdev);
+	if (ret) {
+		dev_err(dev, "Register platform failed.\n");
+		goto err_out_reset;
+	}
+
+	return 0;
+
+err_out_reset:
+	reset_control_assert(chip->rst);
+
+err_out_clock:
+	clk_disable_unprepare(chip->clk);
+
+	return ret;
+}
+
+static int uniphier_aio_remove(struct platform_device *pdev)
+{
+	struct uniphier_aio_chip *chip = platform_get_drvdata(pdev);
+
+	reset_control_assert(chip->rst);
+	clk_disable_unprepare(chip->clk);
+
+	return 0;
+}
+
+static const struct of_device_id uniphier_aio_of_match[] = {
+#ifdef CONFIG_SND_SOC_UNIPHIER_LD11
+	{
+		.compatible = "socionext,uniphier-ld11-aio",
+		.data = &uniphier_aio_ld11_spec,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-aio",
+		.data = &uniphier_aio_ld20_spec,
+	},
+#endif /* CONFIG_SND_SOC_UNIPHIER_LD11 */
+	{},
+};
+MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
+
+static struct platform_driver uniphier_aio_driver = {
+	.driver = {
+		.name = "snd-uniphier-aio",
+		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+	},
+	.probe    = uniphier_aio_probe,
+	.remove   = uniphier_aio_remove,
+};
+module_platform_driver(uniphier_aio_driver);
+
+MODULE_AUTHOR("Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier AIO ALSA driver.");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
new file mode 100644
index 000000000000..bac0eb37c2e5
--- /dev/null
+++ b/sound/soc/uniphier/aio-dma.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Socionext UniPhier AIO DMA driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "aio.h"
+#include "aio-regctrl.h"
+
+static struct snd_pcm_hardware uniphier_aiodma_hw = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_INTERLEAVED,
+	.period_bytes_min = 256,
+	.period_bytes_max = 4096,
+	.periods_min      = 4,
+	.periods_max      = 1024,
+	.buffer_bytes_max = 128 * 1024,
+};
+
+static irqreturn_t uniphier_aiodma_irq(int irq, void *p)
+{
+	struct platform_device *pdev = p;
+	struct uniphier_aio_chip *chip = platform_get_drvdata(pdev);
+	irqreturn_t ret = IRQ_NONE;
+	int i, j;
+
+	for (i = 0; i < chip->num_aios; i++) {
+		struct uniphier_aio *aio = &chip->aios[i];
+
+		for (j = 0; j < ARRAY_SIZE(aio->sub); j++) {
+			struct uniphier_aio_sub *sub = &aio->sub[j];
+
+			if (!sub->running)
+				continue;
+
+			spin_lock(&sub->spin);
+			uniphier_aio_rb_sync(sub);
+			uniphier_aio_rb_clear_int(sub);
+			spin_unlock(&sub->spin);
+
+			snd_pcm_period_elapsed(sub->substream);
+
+			ret = IRQ_HANDLED;
+		}
+	}
+
+	return ret;
+}
+
+static int uniphier_aiodma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	snd_soc_set_runtime_hwparams(substream, &uniphier_aiodma_hw);
+
+	return snd_pcm_hw_constraint_step(runtime, 0,
+		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 256);
+}
+
+static int uniphier_aiodma_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	substream->runtime->dma_bytes = params_buffer_bytes(params);
+
+	return 0;
+}
+
+static int uniphier_aiodma_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	substream->runtime->dma_bytes = 0;
+
+	return 0;
+}
+
+static int uniphier_aiodma_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+	unsigned long flags;
+
+	uniphier_aio_ch_set_param(sub);
+
+	spin_lock_irqsave(&sub->spin, flags);
+	uniphier_aio_rb_set_buffer(sub, runtime->dma_addr,
+				   runtime->dma_addr + runtime->dma_bytes);
+	spin_unlock_irqrestore(&sub->spin, flags);
+
+	return 0;
+}
+
+static int uniphier_aiodma_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+	struct device *dev = &aio->chip->pdev->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sub->spin, flags);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		uniphier_aio_rb_sync(sub);
+		uniphier_aio_ch_set_enable(sub, 1);
+		sub->running = 1;
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		sub->running = 0;
+		uniphier_aio_ch_set_enable(sub, 0);
+
+		break;
+	default:
+		dev_warn(dev, "Unknown trigger %d, ignored.\n", cmd);
+		break;
+	}
+	spin_unlock_irqrestore(&sub->spin, flags);
+
+	return 0;
+}
+
+static snd_pcm_uframes_t uniphier_aiodma_pointer(
+					struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
+	struct uniphier_aio *aio = uniphier_priv(rtd->cpu_dai);
+	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
+	unsigned long flags;
+	snd_pcm_uframes_t pos;
+
+	spin_lock_irqsave(&sub->spin, flags);
+	uniphier_aio_rb_sync(sub);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		pos = bytes_to_frames(runtime, sub->rd_offs);
+	else
+		pos = bytes_to_frames(runtime, sub->wr_offs);
+	spin_unlock_irqrestore(&sub->spin, flags);
+
+	return pos;
+}
+
+static int uniphier_aiodma_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+{
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	return remap_pfn_range(vma, vma->vm_start,
+			       substream->dma_buffer.addr >> PAGE_SHIFT,
+			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
+
+static const struct snd_pcm_ops uniphier_aiodma_ops = {
+	.open      = uniphier_aiodma_open,
+	.ioctl     = snd_pcm_lib_ioctl,
+	.hw_params = uniphier_aiodma_hw_params,
+	.hw_free   = uniphier_aiodma_hw_free,
+	.prepare   = uniphier_aiodma_prepare,
+	.trigger   = uniphier_aiodma_trigger,
+	.pointer   = uniphier_aiodma_pointer,
+	.mmap      = uniphier_aiodma_mmap,
+};
+
+static int uniphier_aiodma_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct device *dev = rtd->card->snd_card->dev;
+	struct snd_pcm *pcm = rtd->pcm;
+	int ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
+	if (ret)
+		return ret;
+
+	return snd_pcm_lib_preallocate_pages_for_all(pcm,
+		SNDRV_DMA_TYPE_DEV, dev,
+		uniphier_aiodma_hw.buffer_bytes_max,
+		uniphier_aiodma_hw.buffer_bytes_max);
+}
+
+static void uniphier_aiodma_free(struct snd_pcm *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static const struct snd_soc_platform_driver uniphier_soc_platform = {
+	.pcm_new  = uniphier_aiodma_new,
+	.pcm_free = uniphier_aiodma_free,
+	.ops      = &uniphier_aiodma_ops,
+};
+
+static const struct regmap_config aiodma_regmap_config = {
+	.reg_bits      = 32,
+	.reg_stride    = 4,
+	.val_bits      = 32,
+	.max_register  = 0x7fffc,
+	.cache_type    = REGCACHE_NONE,
+};
+
+/**
+ * uniphier_aiodma_soc_register_platform - register the AIO DMA
+ * @pdev: the platform device
+ *
+ * Register and setup the DMA of AIO to transfer the sound data to device.
+ * This function need to call once at driver startup and need NOT to call
+ * unregister function.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aiodma_soc_register_platform(struct platform_device *pdev)
+{
+	struct uniphier_aio_chip *chip = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *preg;
+	int irq, ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	preg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(preg))
+		return PTR_ERR(preg);
+
+	chip->regmap = devm_regmap_init_mmio(dev, preg,
+					     &aiodma_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Could not get irq.\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, uniphier_aiodma_irq,
+			       IRQF_SHARED, dev_name(dev), pdev);
+	if (ret)
+		return ret;
+
+	return devm_snd_soc_register_platform(dev, &uniphier_soc_platform);
+}
diff --git a/sound/soc/uniphier/aio-regctrl.c b/sound/soc/uniphier/aio-regctrl.c
new file mode 100644
index 000000000000..1e3623f2df51
--- /dev/null
+++ b/sound/soc/uniphier/aio-regctrl.c
@@ -0,0 +1,699 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "aio.h"
+#include "aio-regctrl.h"
+
+/**
+ * uniphier_aio_chip_init - initialize AIO whole settings
+ * @chip: the AIO chip pointer
+ *
+ * Sets AIO fixed and whole device settings to AIO.
+ * This function need to call once at driver startup.
+ *
+ * The register area that is changed by this function is shared by all
+ * modules of AIO. But there is not race condition since this function
+ * has always set the same initialize values.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_chip_init(struct uniphier_aio_chip *chip)
+{
+	struct regmap *r = chip->regmap;
+
+	regmap_update_bits(r, A2APLLCTR0,
+			   A2APLLCTR0_APLLXPOW_MASK,
+			   A2APLLCTR0_APLLXPOW_PWON);
+
+	regmap_update_bits(r, A2APLLCTR1, A2APLLCTR1_APLL_MASK,
+			   A2APLLCTR1_APLLF2_33MHZ | A2APLLCTR1_APLLA2_33MHZ |
+			   A2APLLCTR1_APLLF1_36MHZ | A2APLLCTR1_APLLA1_36MHZ);
+
+	regmap_update_bits(r, A2EXMCLKSEL0,
+			   A2EXMCLKSEL0_EXMCLK_MASK,
+			   A2EXMCLKSEL0_EXMCLK_OUTPUT);
+
+	regmap_update_bits(r, A2AIOINPUTSEL, A2AIOINPUTSEL_RXSEL_MASK,
+			   A2AIOINPUTSEL_RXSEL_PCMI1_HDMIRX1 |
+			   A2AIOINPUTSEL_RXSEL_PCMI2_SIF |
+			   A2AIOINPUTSEL_RXSEL_PCMI3_EVEA |
+			   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1);
+
+	if (chip->chip_spec->addr_ext)
+		regmap_update_bits(r, CDA2D_TEST, CDA2D_TEST_DDR_MODE_MASK,
+				   CDA2D_TEST_DDR_MODE_EXTON0);
+	else
+		regmap_update_bits(r, CDA2D_TEST, CDA2D_TEST_DDR_MODE_MASK,
+				   CDA2D_TEST_DDR_MODE_EXTOFF1);
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_init - initialize AIO substream
+ * @sub: the AIO substream pointer
+ *
+ * Sets fixed settings of each AIO substreams.
+ * This function need to call once at substream startup.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_init(struct uniphier_aio_sub *sub)
+{
+	struct device *dev = &sub->aio->chip->pdev->dev;
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, A2RBNMAPCTR0(sub->swm->rb.hw),
+		     MAPCTR0_EN | sub->swm->rb.map);
+	regmap_write(r, A2CHNMAPCTR0(sub->swm->ch.hw),
+		     MAPCTR0_EN | sub->swm->ch.map);
+
+	switch (sub->swm->type) {
+	case PORT_TYPE_I2S:
+	case PORT_TYPE_SPDIF:
+	case PORT_TYPE_EVE:
+		if (sub->swm->dir == PORT_DIR_INPUT) {
+			regmap_write(r, A2IIFNMAPCTR0(sub->swm->iif.hw),
+				     MAPCTR0_EN | sub->swm->iif.map);
+			regmap_write(r, A2IPORTNMAPCTR0(sub->swm->iport.hw),
+				     MAPCTR0_EN | sub->swm->iport.map);
+		} else {
+			regmap_write(r, A2OIFNMAPCTR0(sub->swm->oif.hw),
+				     MAPCTR0_EN | sub->swm->oif.map);
+			regmap_write(r, A2OPORTNMAPCTR0(sub->swm->oport.hw),
+				     MAPCTR0_EN | sub->swm->oport.map);
+		}
+		break;
+	case PORT_TYPE_CONV:
+		regmap_write(r, A2OIFNMAPCTR0(sub->swm->oif.hw),
+			     MAPCTR0_EN | sub->swm->oif.map);
+		regmap_write(r, A2OPORTNMAPCTR0(sub->swm->oport.hw),
+			     MAPCTR0_EN | sub->swm->oport.map);
+		regmap_write(r, A2CHNMAPCTR0(sub->swm->och.hw),
+			     MAPCTR0_EN | sub->swm->och.map);
+		regmap_write(r, A2IIFNMAPCTR0(sub->swm->iif.hw),
+			     MAPCTR0_EN | sub->swm->iif.map);
+		break;
+	default:
+		dev_err(dev, "Unknown port type %d.\n", sub->swm->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_port_reset - reset AIO port block
+ * @sub: the AIO substream pointer
+ *
+ * Resets the digital signal input/output port block of AIO.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_port_reset(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_write(r, AOUTRSTCTR0, BIT(sub->swm->oport.map));
+		regmap_write(r, AOUTRSTCTR1, BIT(sub->swm->oport.map));
+	} else {
+		regmap_update_bits(r, IPORTMXRSTCTR(sub->swm->iport.map),
+				   IPORTMXRSTCTR_RSTPI_MASK,
+				   IPORTMXRSTCTR_RSTPI_RESET);
+		regmap_update_bits(r, IPORTMXRSTCTR(sub->swm->iport.map),
+				   IPORTMXRSTCTR_RSTPI_MASK,
+				   IPORTMXRSTCTR_RSTPI_RELEASE);
+	}
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_port_set_param - set parameters of AIO port block
+ * @sub: the AIO substream pointer
+ * @pass_through: Zero if sound data is LPCM, otherwise if data is not LPCM.
+ * This parameter has no effect if substream is I2S or PCM.
+ * @params: hardware parameters of ALSA
+ *
+ * Set suitable setting to input/output port block of AIO to process the
+ * specified in params.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
+				const struct snd_pcm_hw_params *params)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (pass_through)
+			v = OPORTMXCTR1_I2SLRSEL_LEFT;
+		else
+			v = OPORTMXCTR1_I2SLRSEL_I2S;
+
+		v |= OPORTMXCTR1_OUTBITSEL_24 |
+			OPORTMXCTR1_FSSEL_48;
+		regmap_write(r, OPORTMXCTR1(sub->swm->oport.map), v);
+
+		if (sub->swm->type == PORT_TYPE_EVE)
+			v = OPORTMXCTR2_ACLKSEL_A2PLL;
+		else
+			v = OPORTMXCTR2_ACLKSEL_A1;
+
+		v |= OPORTMXCTR2_MSSEL_MASTER |
+			OPORTMXCTR2_EXTLSIFSSEL_36 |
+			OPORTMXCTR2_DACCKSEL_1_2;
+		regmap_write(r, OPORTMXCTR2(sub->swm->oport.map), v);
+
+		if (pass_through)
+			v = OPORTMXCTR3_SRCSEL_STREAM |
+				OPORTMXCTR3_VALID_STREAM;
+		else
+			v = OPORTMXCTR3_SRCSEL_PCM |
+				OPORTMXCTR3_VALID_PCM;
+
+		v |= OPORTMXCTR3_IECTHUR_IECOUT |
+			OPORTMXCTR3_PMSEL_PAUSE |
+			OPORTMXCTR3_PMSW_MUTE_OFF;
+		regmap_write(r, OPORTMXCTR3(sub->swm->oport.map), v);
+	} else {
+		regmap_write(r, IPORTMXCTR1(sub->swm->iport.map),
+			     IPORTMXCTR1_LRSEL_I2S | IPORTMXCTR1_OUTBITSEL_24 |
+			     IPORTMXCTR1_CHSEL_ALL | IPORTMXCTR1_FSSEL_48);
+
+		v = IPORTMXCTR2_ACLKSEL_A1 |
+			IPORTMXCTR2_MSSEL_SLAVE |
+			IPORTMXCTR2_EXTLSIFSSEL_36 |
+			IPORTMXCTR2_DACCKSEL_1_2;
+		regmap_write(r, IPORTMXCTR2(sub->swm->iport.map), v);
+
+		regmap_write(r, IPORTMXACLKSEL0EX(sub->swm->iport.map),
+			     IPORTMXACLKSEL0EX_ACLKSEL0EX_INTERNAL);
+		regmap_write(r, IPORTMXEXNOE(sub->swm->iport.map),
+			     IPORTMXEXNOE_PCMINOE_INPUT);
+	}
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_port_set_enable - start or stop of AIO port block
+ * @sub: the AIO substream pointer
+ * @enable: zero to stop the block, otherwise to start
+ *
+ * Start or stop the signal input/output port block of AIO.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_port_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_write(r, OPORTMXPATH(sub->swm->oport.map),
+			     sub->swm->oif.map);
+
+		regmap_update_bits(r, OPORTMXMASK(sub->swm->oport.map),
+				   OPORTMXMASK_IUDXMSK_MASK |
+				   OPORTMXMASK_IUXCKMSK_MASK |
+				   OPORTMXMASK_DXMSK_MASK |
+				   OPORTMXMASK_XCKMSK_MASK,
+				   OPORTMXMASK_IUDXMSK_OFF |
+				   OPORTMXMASK_IUXCKMSK_OFF |
+				   OPORTMXMASK_DXMSK_OFF |
+				   OPORTMXMASK_XCKMSK_OFF);
+
+		if (enable)
+			regmap_write(r, AOUTENCTR0, BIT(sub->swm->oport.map));
+		else
+			regmap_write(r, AOUTENCTR1, BIT(sub->swm->oport.map));
+	} else {
+		regmap_update_bits(r, IPORTMXMASK(sub->swm->iport.map),
+				   IPORTMXMASK_IUXCKMSK_MASK |
+				   IPORTMXMASK_XCKMSK_MASK,
+				   IPORTMXMASK_IUXCKMSK_OFF |
+				   IPORTMXMASK_XCKMSK_OFF);
+
+		if (enable)
+			regmap_update_bits(r,
+					   IPORTMXCTR2(sub->swm->iport.map),
+					   IPORTMXCTR2_REQEN_MASK,
+					   IPORTMXCTR2_REQEN_ENABLE);
+		else
+			regmap_update_bits(r,
+					   IPORTMXCTR2(sub->swm->iport.map),
+					   IPORTMXCTR2_REQEN_MASK,
+					   IPORTMXCTR2_REQEN_DISABLE);
+	}
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_if_set_param - set parameters of AIO DMA I/F block
+ * @sub: the AIO substream pointer
+ * @pass_through: Zero if sound data is LPCM, otherwise if data is not LPCM.
+ * This parameter has no effect if substream is I2S or PCM.
+ *
+ * Set suitable setting to DMA interface block of AIO to process the
+ * specified in settings.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (pass_through)
+			v = PBOUTMXCTR0_ENDIAN_0123 |
+				PBOUTMXCTR0_MEMFMT_STREAM;
+		else
+			v = PBOUTMXCTR0_ENDIAN_3210 |
+				PBOUTMXCTR0_MEMFMT_2CH;
+
+		regmap_write(r, PBOUTMXCTR0(sub->swm->oif.map), v);
+		regmap_write(r, PBOUTMXCTR1(sub->swm->oif.map), 0);
+	} else {
+		regmap_write(r, PBINMXCTR(sub->swm->iif.map),
+			     PBINMXCTR_NCONNECT_CONNECT |
+			     PBINMXCTR_INOUTSEL_IN |
+			     (sub->swm->iport.map << PBINMXCTR_PBINSEL_SHIFT) |
+			     PBINMXCTR_ENDIAN_3210 |
+			     PBINMXCTR_MEMFMT_D0);
+	}
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_oport_set_stream_type - set parameters of AIO port block
+ * @sub: the AIO substream pointer
+ * @pc: Pc type of IEC61937
+ *
+ * Set special setting to output port block of AIO to output the stream
+ * via S/PDIF.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_oport_set_stream_type(struct uniphier_aio_sub *sub,
+				       enum IEC61937_PC pc)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 repet = 0, pause = OPORTMXPAUDAT_PAUSEPC_CMN;
+
+	switch (pc) {
+	case IEC61937_PC_AC3:
+		repet = OPORTMXREPET_STRLENGTH_AC3 |
+			OPORTMXREPET_PMLENGTH_AC3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_AC3;
+		break;
+	case IEC61937_PC_MPA:
+		repet = OPORTMXREPET_STRLENGTH_MPA |
+			OPORTMXREPET_PMLENGTH_MPA;
+		pause |= OPORTMXPAUDAT_PAUSEPD_MPA;
+		break;
+	case IEC61937_PC_MP3:
+		repet = OPORTMXREPET_STRLENGTH_MP3 |
+			OPORTMXREPET_PMLENGTH_MP3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_MP3;
+		break;
+	case IEC61937_PC_DTS1:
+		repet = OPORTMXREPET_STRLENGTH_DTS1 |
+			OPORTMXREPET_PMLENGTH_DTS1;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS1;
+		break;
+	case IEC61937_PC_DTS2:
+		repet = OPORTMXREPET_STRLENGTH_DTS2 |
+			OPORTMXREPET_PMLENGTH_DTS2;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS2;
+		break;
+	case IEC61937_PC_DTS3:
+		repet = OPORTMXREPET_STRLENGTH_DTS3 |
+			OPORTMXREPET_PMLENGTH_DTS3;
+		pause |= OPORTMXPAUDAT_PAUSEPD_DTS3;
+		break;
+	case IEC61937_PC_AAC:
+		repet = OPORTMXREPET_STRLENGTH_AAC |
+			OPORTMXREPET_PMLENGTH_AAC;
+		pause |= OPORTMXPAUDAT_PAUSEPD_AAC;
+		break;
+	case IEC61937_PC_PAUSE:
+		/* Do nothing */
+		break;
+	}
+
+	regmap_write(r, OPORTMXREPET(sub->swm->oport.map), repet);
+	regmap_write(r, OPORTMXPAUDAT(sub->swm->oport.map), pause);
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_srcport_reset - reset AIO SRC port block
+ * @sub: the AIO substream pointer
+ *
+ * Resets the digital signal input/output port with sampling rate converter
+ * block of AIO.
+ * This function has no effect if substream is not supported rate converter.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_srcport_reset(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	regmap_write(r, AOUTSRCRSTCTR0, BIT(sub->swm->oport.map));
+	regmap_write(r, AOUTSRCRSTCTR1, BIT(sub->swm->oport.map));
+
+	return 0;
+}
+
+/**
+ * uniphier_aio_srcport_set_param - set parameters of AIO SRC port block
+ * @sub: the AIO substream pointer
+ * @params: hardware parameters of ALSA
+ *
+ * Set suitable setting to input/output port with sampling rate converter
+ * block of AIO to process the specified in params.
+ * This function has no effect if substream is not supported rate converter.
+ *
+ * Return: Zero if successful, otherwise a negative value on error.
+ */
+int uniphier_aio_srcport_set_param(struct uniphier_aio_sub *sub,
+				   const struct snd_pcm_hw_params *params)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (sub->substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	regmap_write(r, OPORTMXSRC1CTR(sub->swm->oport.map),
+		     OPORTMXSRC1CTR_THMODE_SRC |
+		     OPORTMXSRC1CTR_SRCPATH_CALC |
+		     OPORTMXSRC1CTR_SYNC_ASYNC |
+		     OPORTMXSRC1CTR_FSIIPSEL_INNER |
+		     OPORTMXSRC1CTR_FSISEL_ACLK);
+
+	switch (params_rate(params)) {
+	default:
+	case 48000:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA1 |
+			OPORTMXRATE_I_MCKSEL_36 |
+			OPORTMXRATE_I_FSSEL_48;
+		break;
+	case 44100:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA2 |
+			OPORTMXRATE_I_MCKSEL_33 |
+			OPORTMXRATE_I_FSSEL_44_1;
+		break;
+	case 32000:
+		v = OPORTMXRATE_I_ACLKSEL_APLLA1 |
+			OPORTMXRATE_I_MCKSEL_36 |
+			OPORTMXRATE_I_FSSEL_32;
+		break;
+	}
+
+	regmap_write(r, OPORTMXRATE_I(sub->swm->oport.map),
+		     v | OPORTMXRATE_I_ACLKSRC_APLL |
+		     OPORTMXRATE_I_LRCKSTP_STOP);
+	regmap_update_bits(r, OPORTMXRATE_I(sub->swm->oport.map),
+			   OPORTMXRATE_I_LRCKSTP_MASK,
+			   OPORTMXRATE_I_LRCKSTP_START);
+
+	return 0;
+}
+
+int uniphier_aio_srcif_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, PBINMXCTR(sub->swm->iif.map),
+		     PBINMXCTR_NCONNECT_CONNECT |
+		     PBINMXCTR_INOUTSEL_OUT |
+		     (sub->swm->oport.map << PBINMXCTR_PBINSEL_SHIFT) |
+		     PBINMXCTR_ENDIAN_3210 |
+		     PBINMXCTR_MEMFMT_D0);
+
+	return 0;
+}
+
+int uniphier_aio_srcch_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	regmap_write(r, CDA2D_CHMXCTRL1(sub->swm->och.map),
+		     CDA2D_CHMXCTRL1_INDSIZE_INFINITE);
+
+	regmap_write(r, CDA2D_CHMXSRCAMODE(sub->swm->och.map),
+		     CDA2D_CHMXAMODE_ENDIAN_3210 |
+		     CDA2D_CHMXAMODE_AUPDT_FIX |
+		     CDA2D_CHMXAMODE_TYPE_NORMAL);
+
+	regmap_write(r, CDA2D_CHMXDSTAMODE(sub->swm->och.map),
+		     CDA2D_CHMXAMODE_ENDIAN_3210 |
+		     CDA2D_CHMXAMODE_AUPDT_INC |
+		     CDA2D_CHMXAMODE_TYPE_RING |
+		     (sub->swm->och.map << CDA2D_CHMXAMODE_RSSEL_SHIFT));
+
+	return 0;
+}
+
+int uniphier_aio_srcch_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	if (enable)
+		v = CDA2D_STRT0_STOP_START;
+	else
+		v = CDA2D_STRT0_STOP_STOP;
+
+	regmap_write(r, CDA2D_STRT0,
+		     v | BIT(sub->swm->och.map));
+
+	return 0;
+}
+
+int uniphier_aio_ch_set_param(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 v;
+
+	regmap_write(r, CDA2D_CHMXCTRL1(sub->swm->ch.map),
+		     CDA2D_CHMXCTRL1_INDSIZE_INFINITE);
+
+	v = CDA2D_CHMXAMODE_ENDIAN_3210 |
+		CDA2D_CHMXAMODE_AUPDT_INC |
+		CDA2D_CHMXAMODE_TYPE_NORMAL |
+		(sub->swm->rb.map << CDA2D_CHMXAMODE_RSSEL_SHIFT);
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		regmap_write(r, CDA2D_CHMXSRCAMODE(sub->swm->ch.map), v);
+	else
+		regmap_write(r, CDA2D_CHMXDSTAMODE(sub->swm->ch.map), v);
+
+	return 0;
+}
+
+int uniphier_aio_ch_set_enable(struct uniphier_aio_sub *sub, int enable)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (enable) {
+		regmap_write(r, CDA2D_STRT0,
+			     CDA2D_STRT0_STOP_START | BIT(sub->swm->ch.map));
+
+		regmap_update_bits(r, INTRBIM(0),
+				   BIT(sub->swm->rb.map),
+				   BIT(sub->swm->rb.map));
+	} else {
+		regmap_write(r, CDA2D_STRT0,
+			     CDA2D_STRT0_STOP_STOP | BIT(sub->swm->ch.map));
+
+		regmap_update_bits(r, INTRBIM(0),
+				   BIT(sub->swm->rb.map),
+				   0);
+	}
+
+	return 0;
+}
+
+static u64 uniphier_aio_rb_get_rp(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 pos_u, pos_l;
+	int i;
+
+	regmap_write(r, CDA2D_RDPTRLOAD,
+		     CDA2D_RDPTRLOAD_LSFLAG_STORE | BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &pos_l);
+
+	regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &pos_l);
+	regmap_read(r, CDA2D_RBMXRDPTRU(sub->swm->rb.map), &pos_u);
+	pos_u = FIELD_GET(CDA2D_RBMXPTRU_PTRU_MASK, pos_u);
+
+	return ((u64)pos_u << 32) | pos_l;
+}
+
+static int uniphier_aio_rb_set_rp(struct uniphier_aio_sub *sub, u64 pos)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 tmp;
+	int i;
+
+	regmap_write(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), (u32)pos);
+	regmap_write(r, CDA2D_RBMXRDPTRU(sub->swm->rb.map), (u32)(pos >> 32));
+	regmap_write(r, CDA2D_RDPTRLOAD, BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXRDPTR(sub->swm->rb.map), &tmp);
+
+	return 0;
+}
+
+static u64 uniphier_aio_rb_get_wp(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 pos_u, pos_l;
+	int i;
+
+	regmap_write(r, CDA2D_WRPTRLOAD,
+		     CDA2D_WRPTRLOAD_LSFLAG_STORE | BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &pos_l);
+
+	regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &pos_l);
+	regmap_read(r, CDA2D_RBMXWRPTRU(sub->swm->rb.map), &pos_u);
+	pos_u = FIELD_GET(CDA2D_RBMXPTRU_PTRU_MASK, pos_u);
+
+	return ((u64)pos_u << 32) | pos_l;
+}
+
+static int uniphier_aio_rb_set_wp(struct uniphier_aio_sub *sub, u64 pos)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	u32 tmp;
+	int i;
+
+	regmap_write(r, CDA2D_RBMXWRPTR(sub->swm->rb.map),
+		     lower_32_bits(pos));
+	regmap_write(r, CDA2D_RBMXWRPTRU(sub->swm->rb.map),
+		     upper_32_bits(pos));
+	regmap_write(r, CDA2D_WRPTRLOAD, BIT(sub->swm->rb.map));
+	/* Wait for setup */
+	for (i = 0; i < 6; i++)
+		regmap_read(r, CDA2D_RBMXWRPTR(sub->swm->rb.map), &tmp);
+
+	return 0;
+}
+
+int uniphier_aio_rb_set_buffer(struct uniphier_aio_sub *sub,
+			       u64 start, u64 end)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+	struct snd_pcm_runtime *runtime = sub->substream->runtime;
+	int byte_per_period = runtime->period_size *
+		runtime->channels * samples_to_bytes(runtime, 1);
+
+	regmap_write(r, CDA2D_RBMXCNFG(sub->swm->rb.map), 0);
+	regmap_write(r, CDA2D_RBMXBGNADRS(sub->swm->rb.map),
+		     lower_32_bits(start));
+	regmap_write(r, CDA2D_RBMXBGNADRSU(sub->swm->rb.map),
+		     upper_32_bits(start));
+	regmap_write(r, CDA2D_RBMXENDADRS(sub->swm->rb.map),
+		     lower_32_bits(end));
+	regmap_write(r, CDA2D_RBMXENDADRSU(sub->swm->rb.map),
+		     upper_32_bits(end));
+
+	regmap_write(r, CDA2D_RBADRSLOAD, BIT(sub->swm->rb.map));
+
+	uniphier_aio_rb_set_rp(sub, start);
+	uniphier_aio_rb_set_wp(sub, end - byte_per_period);
+
+	regmap_write(r, CDA2D_RBMXBTH(sub->swm->rb.map), byte_per_period * 2);
+	regmap_write(r, CDA2D_RBMXRTH(sub->swm->rb.map), byte_per_period * 2);
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		regmap_update_bits(r, CDA2D_RBMXIE(sub->swm->rb.map),
+				   CDA2D_RBMXIX_SPACE,
+				   CDA2D_RBMXIX_SPACE);
+	else
+		regmap_update_bits(r, CDA2D_RBMXIE(sub->swm->rb.map),
+				   CDA2D_RBMXIX_REMAIN,
+				   CDA2D_RBMXIX_REMAIN);
+
+	sub->rd_offs = 0;
+	sub->wr_offs = 0;
+
+	return 0;
+}
+
+void uniphier_aio_rb_sync(struct uniphier_aio_sub *sub)
+{
+	struct snd_pcm_runtime *runtime = sub->substream->runtime;
+	u64 start = runtime->dma_addr;
+	int byte_per_period = runtime->period_size *
+		runtime->channels * samples_to_bytes(runtime, 1);
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		sub->rd_offs = uniphier_aio_rb_get_rp(sub) - start;
+		sub->wr_offs = sub->rd_offs - byte_per_period;
+		if (sub->rd_offs < byte_per_period)
+			sub->wr_offs += runtime->dma_bytes;
+		uniphier_aio_rb_set_wp(sub, sub->wr_offs + start);
+	} else {
+		sub->wr_offs = uniphier_aio_rb_get_wp(sub) - start;
+		sub->rd_offs = sub->wr_offs - byte_per_period;
+		if (sub->wr_offs < byte_per_period)
+			sub->rd_offs += runtime->dma_bytes;
+		uniphier_aio_rb_set_rp(sub, sub->rd_offs + start);
+	}
+}
+
+int uniphier_aio_rb_clear_int(struct uniphier_aio_sub *sub)
+{
+	struct regmap *r = sub->aio->chip->regmap;
+
+	if (sub->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		regmap_write(r, CDA2D_RBMXIR(sub->swm->rb.map),
+			     CDA2D_RBMXIX_SPACE);
+	else
+		regmap_write(r, CDA2D_RBMXIR(sub->swm->rb.map),
+			     CDA2D_RBMXIX_REMAIN);
+
+	return 0;
+}
diff --git a/sound/soc/uniphier/aio-regctrl.h b/sound/soc/uniphier/aio-regctrl.h
new file mode 100644
index 000000000000..d9dfc8e03b89
--- /dev/null
+++ b/sound/soc/uniphier/aio-regctrl.h
@@ -0,0 +1,495 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SND_UNIPHIER_AIO_REGCTRL_H__
+#define SND_UNIPHIER_AIO_REGCTRL_H__
+
+#include <linux/bitops.h>
+
+#include "aio.h"
+
+/* SW view */
+#define A2CHNMAPCTR0(n)                 (0x00000 + 0x40 * (n))
+#define A2RBNMAPCTR0(n)                 (0x01000 + 0x40 * (n))
+#define A2IPORTNMAPCTR0(n)              (0x02000 + 0x40 * (n))
+#define A2IPORTNMAPCTR1(n)              (0x02004 + 0x40 * (n))
+#define A2IIFNMAPCTR0(n)                (0x03000 + 0x40 * (n))
+#define A2OPORTNMAPCTR0(n)              (0x04000 + 0x40 * (n))
+#define A2OPORTNMAPCTR1(n)              (0x04004 + 0x40 * (n))
+#define A2OPORTNMAPCTR2(n)              (0x04008 + 0x40 * (n))
+#define A2OIFNMAPCTR0(n)                (0x05000 + 0x40 * (n))
+#define A2ATNMAPCTR0(n)                 (0x06000 + 0x40 * (n))
+
+#define MAPCTR0_EN                      0x80000000
+
+/* CTL */
+#define A2APLLCTR0                      0x07000
+#define   A2APLLCTR0_APLLXPOW_MASK        GENMASK(3, 0)
+#define   A2APLLCTR0_APLLXPOW_PWOFF       (0x0 << 0)
+#define   A2APLLCTR0_APLLXPOW_PWON        (0xf << 0)
+#define A2APLLCTR1                      0x07004
+#define   A2APLLCTR1_APLL_MASK            (A2APLLCTR1_APLLF2_MASK | \
+					   A2APLLCTR1_APLLA2_MASK | \
+					   A2APLLCTR1_APLLF1_MASK | \
+					   A2APLLCTR1_APLLA1_MASK)
+#define   A2APLLCTR1_APLLF2_MASK          0x00080808
+#define   A2APLLCTR1_APLLF2_33MHZ         0x00000008
+#define   A2APLLCTR1_APLLA2_MASK          0x00040404
+#define   A2APLLCTR1_APLLA2_33MHZ         0x00000004
+#define   A2APLLCTR1_APLLF1_MASK          0x00020202
+#define   A2APLLCTR1_APLLF1_36MHZ         0x00000000
+#define   A2APLLCTR1_APLLA1_MASK          0x00010101
+#define   A2APLLCTR1_APLLA1_36MHZ         0x00000000
+#define A2EXMCLKSEL0                    0x07030
+#define   A2EXMCLKSEL0_EXMCLK_MASK        GENMASK(2, 0)
+#define   A2EXMCLKSEL0_EXMCLK_OUTPUT      (0x0 << 0)
+#define   A2EXMCLKSEL0_EXMCLK_INPUT       (0x7 << 0)
+#define A2SSIFSW                        0x07050
+#define A2CH22_2CTR                     0x07054
+#define A2AIOINPUTSEL                   0x070e0
+#define   A2AIOINPUTSEL_RXSEL_PCMI1_MASK      GENMASK(2, 0)
+#define   A2AIOINPUTSEL_RXSEL_PCMI1_HDMIRX1   (0x2 << 0)
+#define   A2AIOINPUTSEL_RXSEL_PCMI2_MASK      GENMASK(6, 4)
+#define   A2AIOINPUTSEL_RXSEL_PCMI2_SIF       (0x7 << 4)
+#define   A2AIOINPUTSEL_RXSEL_PCMI3_MASK      GENMASK(10, 8)
+#define   A2AIOINPUTSEL_RXSEL_PCMI3_EVEA      (0x1 << 8)
+#define   A2AIOINPUTSEL_RXSEL_IECI1_MASK      GENMASK(14, 12)
+#define   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1   (0x2 << 12)
+#define   A2AIOINPUTSEL_RXSEL_MASK        (A2AIOINPUTSEL_RXSEL_PCMI1_MASK | \
+					   A2AIOINPUTSEL_RXSEL_PCMI2_MASK | \
+					   A2AIOINPUTSEL_RXSEL_PCMI3_MASK | \
+					   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1)
+
+/* INTC */
+#define INTCHIM(m)                       (0x9028 + 0x80 * (m))
+#define INTRBIM(m)                       (0x9030 + 0x80 * (m))
+#define INTCHID(m)                       (0xa028 + 0x80 * (m))
+#define INTRBID(m)                       (0xa030 + 0x80 * (m))
+
+/* AIN(PCMINN) */
+#define IPORTMXCTR1(n)                   (0x22000 + 0x400 * (n))
+#define   IPORTMXCTR1_LRSEL_MASK           GENMASK(11, 10)
+#define   IPORTMXCTR1_LRSEL_RIGHT          (0x0 << 10)
+#define   IPORTMXCTR1_LRSEL_LEFT           (0x1 << 10)
+#define   IPORTMXCTR1_LRSEL_I2S            (0x2 << 10)
+#define   IPORTMXCTR1_OUTBITSEL_MASK       (0x800003 << 8)
+#define   IPORTMXCTR1_OUTBITSEL_32         (0x800000 << 8)
+#define   IPORTMXCTR1_OUTBITSEL_24         (0x000000 << 8)
+#define   IPORTMXCTR1_OUTBITSEL_20         (0x000001 << 8)
+#define   IPORTMXCTR1_OUTBITSEL_16         (0x000002 << 8)
+#define   IPORTMXCTR1_CHSEL_MASK           GENMASK(6, 4)
+#define   IPORTMXCTR1_CHSEL_ALL            (0x0 << 4)
+#define   IPORTMXCTR1_CHSEL_D0_D2          (0x1 << 4)
+#define   IPORTMXCTR1_CHSEL_D0             (0x2 << 4)
+#define   IPORTMXCTR1_CHSEL_D1             (0x3 << 4)
+#define   IPORTMXCTR1_CHSEL_D2             (0x4 << 4)
+#define   IPORTMXCTR1_CHSEL_DMIX           (0x5 << 4)
+#define   IPORTMXCTR1_FSSEL_MASK           GENMASK(3, 0)
+#define   IPORTMXCTR1_FSSEL_48             (0x0 << 0)
+#define   IPORTMXCTR1_FSSEL_96             (0x1 << 0)
+#define   IPORTMXCTR1_FSSEL_192            (0x2 << 0)
+#define   IPORTMXCTR1_FSSEL_32             (0x3 << 0)
+#define   IPORTMXCTR1_FSSEL_44_1           (0x4 << 0)
+#define   IPORTMXCTR1_FSSEL_88_2           (0x5 << 0)
+#define   IPORTMXCTR1_FSSEL_176_4          (0x6 << 0)
+#define   IPORTMXCTR1_FSSEL_16             (0x8 << 0)
+#define   IPORTMXCTR1_FSSEL_22_05          (0x9 << 0)
+#define   IPORTMXCTR1_FSSEL_24             (0xa << 0)
+#define   IPORTMXCTR1_FSSEL_8              (0xb << 0)
+#define   IPORTMXCTR1_FSSEL_11_025         (0xc << 0)
+#define   IPORTMXCTR1_FSSEL_12             (0xd << 0)
+#define IPORTMXCTR2(n)                   (0x22004 + 0x400 * (n))
+#define   IPORTMXCTR2_ACLKSEL_MASK         GENMASK(19, 16)
+#define   IPORTMXCTR2_ACLKSEL_A1           (0x0 << 16)
+#define   IPORTMXCTR2_ACLKSEL_F1           (0x1 << 16)
+#define   IPORTMXCTR2_ACLKSEL_A2           (0x2 << 16)
+#define   IPORTMXCTR2_ACLKSEL_F2           (0x3 << 16)
+#define   IPORTMXCTR2_ACLKSEL_A2PLL        (0x4 << 16)
+#define   IPORTMXCTR2_ACLKSEL_RX1          (0x5 << 16)
+#define   IPORTMXCTR2_ACLKSEL_RX2          (0x6 << 16)
+#define   IPORTMXCTR2_MSSEL_MASK           BIT(15)
+#define   IPORTMXCTR2_MSSEL_SLAVE          (0x0 << 15)
+#define   IPORTMXCTR2_MSSEL_MASTER         (0x1 << 15)
+#define   IPORTMXCTR2_EXTLSIFSSEL_MASK     BIT(14)
+#define   IPORTMXCTR2_EXTLSIFSSEL_36       (0x0 << 14)
+#define   IPORTMXCTR2_EXTLSIFSSEL_24       (0x1 << 14)
+#define   IPORTMXCTR2_DACCKSEL_MASK        GENMASK(9, 8)
+#define   IPORTMXCTR2_DACCKSEL_1_2         (0x0 << 8)
+#define   IPORTMXCTR2_DACCKSEL_1_3         (0x1 << 8)
+#define   IPORTMXCTR2_DACCKSEL_1_1         (0x2 << 8)
+#define   IPORTMXCTR2_DACCKSEL_2_3         (0x3 << 8)
+#define   IPORTMXCTR2_REQEN_MASK           BIT(0)
+#define   IPORTMXCTR2_REQEN_DISABLE        (0x0 << 0)
+#define   IPORTMXCTR2_REQEN_ENABLE         (0x1 << 0)
+#define IPORTMXCNTCTR(n)                 (0x22010 + 0x400 * (n))
+#define IPORTMXCOUNTER(n)                (0x22014 + 0x400 * (n))
+#define IPORTMXCNTMONI(n)                (0x22018 + 0x400 * (n))
+#define IPORTMXACLKSEL0EX(n)             (0x22020 + 0x400 * (n))
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_MASK        GENMASK(3, 0)
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_INTERNAL    (0x0 << 0)
+#define   IPORTMXACLKSEL0EX_ACLKSEL0EX_EXTERNAL    (0xf << 0)
+#define IPORTMXEXNOE(n)                  (0x22070 + 0x400 * (n))
+#define   IPORTMXEXNOE_PCMINOE_MASK        BIT(0)
+#define   IPORTMXEXNOE_PCMINOE_OUTPUT      (0x0 << 0)
+#define   IPORTMXEXNOE_PCMINOE_INPUT       (0x1 << 0)
+#define IPORTMXMASK(n)                   (0x22078 + 0x400 * (n))
+#define   IPORTMXMASK_IUXCKMSK_MASK        GENMASK(18, 16)
+#define   IPORTMXMASK_IUXCKMSK_ON          (0x0 << 16)
+#define   IPORTMXMASK_IUXCKMSK_OFF         (0x7 << 16)
+#define   IPORTMXMASK_XCKMSK_MASK          GENMASK(2, 0)
+#define   IPORTMXMASK_XCKMSK_ON            (0x0 << 0)
+#define   IPORTMXMASK_XCKMSK_OFF           (0x7 << 0)
+#define IPORTMXRSTCTR(n)                 (0x2207c + 0x400 * (n))
+#define   IPORTMXRSTCTR_RSTPI_MASK         BIT(7)
+#define   IPORTMXRSTCTR_RSTPI_RELEASE      (0x0 << 7)
+#define   IPORTMXRSTCTR_RSTPI_RESET        (0x1 << 7)
+
+/* AIN(PBinMX) */
+#define PBINMXCTR(n)                     (0x20200 + 0x40 * (n))
+#define   PBINMXCTR_NCONNECT_MASK          BIT(15)
+#define   PBINMXCTR_NCONNECT_CONNECT       (0x0 << 15)
+#define   PBINMXCTR_NCONNECT_DISCONNECT    (0x1 << 15)
+#define   PBINMXCTR_INOUTSEL_MASK          BIT(14)
+#define   PBINMXCTR_INOUTSEL_IN            (0x0 << 14)
+#define   PBINMXCTR_INOUTSEL_OUT           (0x1 << 14)
+#define   PBINMXCTR_PBINSEL_SHIFT          (8)
+#define   PBINMXCTR_ENDIAN_MASK            GENMASK(5, 4)
+#define   PBINMXCTR_ENDIAN_3210            (0x0 << 4)
+#define   PBINMXCTR_ENDIAN_0123            (0x1 << 4)
+#define   PBINMXCTR_ENDIAN_1032            (0x2 << 4)
+#define   PBINMXCTR_ENDIAN_2301            (0x3 << 4)
+#define   PBINMXCTR_MEMFMT_MASK            GENMASK(3, 0)
+#define   PBINMXCTR_MEMFMT_D0              (0x0 << 0)
+#define   PBINMXCTR_MEMFMT_5_1CH_DMIX      (0x1 << 0)
+#define   PBINMXCTR_MEMFMT_6CH             (0x2 << 0)
+#define   PBINMXCTR_MEMFMT_4CH             (0x3 << 0)
+#define   PBINMXCTR_MEMFMT_DMIX            (0x4 << 0)
+#define   PBINMXCTR_MEMFMT_1CH             (0x5 << 0)
+#define   PBINMXCTR_MEMFMT_16LR            (0x6 << 0)
+#define   PBINMXCTR_MEMFMT_7_1CH           (0x7 << 0)
+#define   PBINMXCTR_MEMFMT_7_1CH_DMIX      (0x8 << 0)
+#define   PBINMXCTR_MEMFMT_STREAM          (0xf << 0)
+#define PBINMXPAUSECTR0(n)               (0x20204 + 0x40 * (n))
+#define PBINMXPAUSECTR1(n)               (0x20208 + 0x40 * (n))
+
+/* AOUT */
+#define AOUTENCTR0                       0x40040
+#define AOUTENCTR1                       0x40044
+#define AOUTENCTR2                       0x40048
+#define AOUTRSTCTR0                      0x40060
+#define AOUTRSTCTR1                      0x40064
+#define AOUTRSTCTR2                      0x40068
+#define AOUTSRCRSTCTR0                   0x400c0
+#define AOUTSRCRSTCTR1                   0x400c4
+#define AOUTSRCRSTCTR2                   0x400c8
+
+/* AOUT(PCMOUTN) */
+#define OPORTMXCTR1(n)                   (0x42000 + 0x400 * (n))
+#define   OPORTMXCTR1_I2SLRSEL_MASK        (0x11 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_RIGHT       (0x00 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_LEFT        (0x01 << 10)
+#define   OPORTMXCTR1_I2SLRSEL_I2S         (0x11 << 10)
+#define   OPORTMXCTR1_OUTBITSEL_MASK       (0x800003 << 8)
+#define   OPORTMXCTR1_OUTBITSEL_32         (0x800000 << 8)
+#define   OPORTMXCTR1_OUTBITSEL_24         (0x000000 << 8)
+#define   OPORTMXCTR1_OUTBITSEL_20         (0x000001 << 8)
+#define   OPORTMXCTR1_OUTBITSEL_16         (0x000002 << 8)
+#define   OPORTMXCTR1_FSSEL_MASK           GENMASK(3, 0)
+#define   OPORTMXCTR1_FSSEL_48             (0x0 << 0)
+#define   OPORTMXCTR1_FSSEL_96             (0x1 << 0)
+#define   OPORTMXCTR1_FSSEL_192            (0x2 << 0)
+#define   OPORTMXCTR1_FSSEL_32             (0x3 << 0)
+#define   OPORTMXCTR1_FSSEL_44_1           (0x4 << 0)
+#define   OPORTMXCTR1_FSSEL_88_2           (0x5 << 0)
+#define   OPORTMXCTR1_FSSEL_176_4          (0x6 << 0)
+#define   OPORTMXCTR1_FSSEL_16             (0x8 << 0)
+#define   OPORTMXCTR1_FSSEL_22_05          (0x9 << 0)
+#define   OPORTMXCTR1_FSSEL_24             (0xa << 0)
+#define   OPORTMXCTR1_FSSEL_8              (0xb << 0)
+#define   OPORTMXCTR1_FSSEL_11_025         (0xc << 0)
+#define   OPORTMXCTR1_FSSEL_12             (0xd << 0)
+#define OPORTMXCTR2(n)                   (0x42004 + 0x400 * (n))
+#define   OPORTMXCTR2_ACLKSEL_MASK         GENMASK(19, 16)
+#define   OPORTMXCTR2_ACLKSEL_A1           (0x0 << 16)
+#define   OPORTMXCTR2_ACLKSEL_F1           (0x1 << 16)
+#define   OPORTMXCTR2_ACLKSEL_A2           (0x2 << 16)
+#define   OPORTMXCTR2_ACLKSEL_F2           (0x3 << 16)
+#define   OPORTMXCTR2_ACLKSEL_A2PLL        (0x4 << 16)
+#define   OPORTMXCTR2_ACLKSEL_RX1          (0x5 << 16)
+#define   OPORTMXCTR2_ACLKSEL_RX2          (0x6 << 16)
+#define   OPORTMXCTR2_MSSEL_MASK           BIT(15)
+#define   OPORTMXCTR2_MSSEL_SLAVE          (0x0 << 15)
+#define   OPORTMXCTR2_MSSEL_MASTER         (0x1 << 15)
+#define   OPORTMXCTR2_EXTLSIFSSEL_MASK     BIT(14)
+#define   OPORTMXCTR2_EXTLSIFSSEL_36       (0x0 << 14)
+#define   OPORTMXCTR2_EXTLSIFSSEL_24       (0x1 << 14)
+#define   OPORTMXCTR2_DACCKSEL_MASK        GENMASK(9, 8)
+#define   OPORTMXCTR2_DACCKSEL_1_2         (0x0 << 8)
+#define   OPORTMXCTR2_DACCKSEL_1_3         (0x1 << 8)
+#define   OPORTMXCTR2_DACCKSEL_1_1         (0x2 << 8)
+#define   OPORTMXCTR2_DACCKSEL_2_3         (0x3 << 8)
+#define OPORTMXCTR3(n)                   (0x42008 + 0x400 * (n))
+#define   OPORTMXCTR3_IECTHUR_MASK         BIT(19)
+#define   OPORTMXCTR3_IECTHUR_IECOUT       (0x0 << 19)
+#define   OPORTMXCTR3_IECTHUR_IECIN        (0x1 << 19)
+#define   OPORTMXCTR3_SRCSEL_MASK          GENMASK(18, 16)
+#define   OPORTMXCTR3_SRCSEL_PCM           (0x0 << 16)
+#define   OPORTMXCTR3_SRCSEL_STREAM        (0x1 << 16)
+#define   OPORTMXCTR3_SRCSEL_CDDTS         (0x2 << 16)
+#define   OPORTMXCTR3_VALID_MASK           BIT(12)
+#define   OPORTMXCTR3_VALID_PCM            (0x0 << 12)
+#define   OPORTMXCTR3_VALID_STREAM         (0x1 << 12)
+#define   OPORTMXCTR3_PMSEL_MASK           BIT(3)
+#define   OPORTMXCTR3_PMSEL_MUTE           (0x0 << 3)
+#define   OPORTMXCTR3_PMSEL_PAUSE          (0x1 << 3)
+#define   OPORTMXCTR3_PMSW_MASK            BIT(2)
+#define   OPORTMXCTR3_PMSW_MUTE_OFF        (0x0 << 2)
+#define   OPORTMXCTR3_PMSW_MUTE_ON         (0x1 << 2)
+#define OPORTMXSRC1CTR(n)                (0x4200c + 0x400 * (n))
+#define   OPORTMXSRC1CTR_FSIIPNUM_SHIFT    (24)
+#define   OPORTMXSRC1CTR_THMODE_MASK       BIT(23)
+#define   OPORTMXSRC1CTR_THMODE_SRC        (0x0 << 23)
+#define   OPORTMXSRC1CTR_THMODE_BYPASS     (0x1 << 23)
+#define   OPORTMXSRC1CTR_LOCK_MASK         BIT(16)
+#define   OPORTMXSRC1CTR_LOCK_UNLOCK       (0x0 << 16)
+#define   OPORTMXSRC1CTR_LOCK_LOCK         (0x1 << 16)
+#define   OPORTMXSRC1CTR_SRCPATH_MASK      BIT(15)
+#define   OPORTMXSRC1CTR_SRCPATH_BYPASS    (0x0 << 15)
+#define   OPORTMXSRC1CTR_SRCPATH_CALC      (0x1 << 15)
+#define   OPORTMXSRC1CTR_SYNC_MASK         BIT(14)
+#define   OPORTMXSRC1CTR_SYNC_ASYNC        (0x0 << 14)
+#define   OPORTMXSRC1CTR_SYNC_SYNC         (0x1 << 14)
+#define   OPORTMXSRC1CTR_FSOCK_MASK        GENMASK(11, 10)
+#define   OPORTMXSRC1CTR_FSOCK_44_1        (0x0 << 10)
+#define   OPORTMXSRC1CTR_FSOCK_48          (0x1 << 10)
+#define   OPORTMXSRC1CTR_FSOCK_32          (0x2 << 10)
+#define   OPORTMXSRC1CTR_FSICK_MASK        GENMASK(9, 8)
+#define   OPORTMXSRC1CTR_FSICK_44_1        (0x0 << 8)
+#define   OPORTMXSRC1CTR_FSICK_48          (0x1 << 8)
+#define   OPORTMXSRC1CTR_FSICK_32          (0x2 << 8)
+#define   OPORTMXSRC1CTR_FSIIPSEL_MASK     GENMASK(5, 4)
+#define   OPORTMXSRC1CTR_FSIIPSEL_INNER    (0x0 << 4)
+#define   OPORTMXSRC1CTR_FSIIPSEL_OUTER    (0x1 << 4)
+#define   OPORTMXSRC1CTR_FSISEL_MASK       GENMASK(3, 0)
+#define   OPORTMXSRC1CTR_FSISEL_ACLK       (0x0 << 0)
+#define   OPORTMXSRC1CTR_FSISEL_DD         (0x1 << 0)
+#define OPORTMXDSDMUTEDAT(n)             (0x42020 + 0x400 * (n))
+#define OPORTMXDXDFREQMODE(n)            (0x42024 + 0x400 * (n))
+#define OPORTMXDSDSEL(n)                 (0x42028 + 0x400 * (n))
+#define OPORTMXDSDPORT(n)                (0x4202c + 0x400 * (n))
+#define OPORTMXACLKSEL0EX(n)             (0x42030 + 0x400 * (n))
+#define OPORTMXPATH(n)                   (0x42040 + 0x400 * (n))
+#define OPORTMXSYNC(n)                   (0x42044 + 0x400 * (n))
+#define OPORTMXREPET(n)                  (0x42050 + 0x400 * (n))
+#define   OPORTMXREPET_STRLENGTH_AC3       SBF_(IEC61937_FRM_STR_AC3, 16)
+#define   OPORTMXREPET_STRLENGTH_MPA       SBF_(IEC61937_FRM_STR_MPA, 16)
+#define   OPORTMXREPET_STRLENGTH_MP3       SBF_(IEC61937_FRM_STR_MP3, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS1      SBF_(IEC61937_FRM_STR_DTS1, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS2      SBF_(IEC61937_FRM_STR_DTS2, 16)
+#define   OPORTMXREPET_STRLENGTH_DTS3      SBF_(IEC61937_FRM_STR_DTS3, 16)
+#define   OPORTMXREPET_STRLENGTH_AAC       SBF_(IEC61937_FRM_STR_AAC, 16)
+#define   OPORTMXREPET_PMLENGTH_AC3        SBF_(IEC61937_FRM_PAU_AC3, 0)
+#define   OPORTMXREPET_PMLENGTH_MPA        SBF_(IEC61937_FRM_PAU_MPA, 0)
+#define   OPORTMXREPET_PMLENGTH_MP3        SBF_(IEC61937_FRM_PAU_MP3, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS1       SBF_(IEC61937_FRM_PAU_DTS1, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS2       SBF_(IEC61937_FRM_PAU_DTS2, 0)
+#define   OPORTMXREPET_PMLENGTH_DTS3       SBF_(IEC61937_FRM_PAU_DTS3, 0)
+#define   OPORTMXREPET_PMLENGTH_AAC        SBF_(IEC61937_FRM_PAU_AAC, 0)
+#define OPORTMXPAUDAT(n)                 (0x42054 + 0x400 * (n))
+#define   OPORTMXPAUDAT_PAUSEPC_CMN        (IEC61937_PC_PAUSE << 16)
+#define   OPORTMXPAUDAT_PAUSEPD_AC3        (IEC61937_FRM_PAU_AC3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_MPA        (IEC61937_FRM_PAU_MPA * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_MP3        (IEC61937_FRM_PAU_MP3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS1       (IEC61937_FRM_PAU_DTS1 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS2       (IEC61937_FRM_PAU_DTS2 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_DTS3       (IEC61937_FRM_PAU_DTS3 * 4)
+#define   OPORTMXPAUDAT_PAUSEPD_AAC        (IEC61937_FRM_PAU_AAC * 4)
+#define OPORTMXRATE_I(n)                 (0x420e4 + 0x400 * (n))
+#define   OPORTMXRATE_I_EQU_MASK           BIT(31)
+#define   OPORTMXRATE_I_EQU_NOTEQUAL       (0x0 << 31)
+#define   OPORTMXRATE_I_EQU_EQUAL          (0x1 << 31)
+#define   OPORTMXRATE_I_SRCBPMD_MASK       BIT(29)
+#define   OPORTMXRATE_I_SRCBPMD_BYPASS     (0x0 << 29)
+#define   OPORTMXRATE_I_SRCBPMD_SRC        (0x1 << 29)
+#define   OPORTMXRATE_I_LRCKSTP_MASK       BIT(24)
+#define   OPORTMXRATE_I_LRCKSTP_START      (0x0 << 24)
+#define   OPORTMXRATE_I_LRCKSTP_STOP       (0x1 << 24)
+#define   OPORTMXRATE_I_ACLKSRC_MASK       GENMASK(15, 12)
+#define   OPORTMXRATE_I_ACLKSRC_APLL       (0x0 << 12)
+#define   OPORTMXRATE_I_ACLKSRC_USB        (0x1 << 12)
+#define   OPORTMXRATE_I_ACLKSRC_HSC        (0x3 << 12)
+/* if OPORTMXRATE_I_ACLKSRC_APLL */
+#define   OPORTMXRATE_I_ACLKSEL_MASK       GENMASK(11, 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLA1     (0x0 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLF1     (0x1 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLA2     (0x2 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLLF2     (0x3 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_APLL       (0x4 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_HDMI1      (0x5 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_HDMI2      (0x6 << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI1ADCCK   (0xc << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI2ADCCK   (0xd << 8)
+#define   OPORTMXRATE_I_ACLKSEL_AI3ADCCK   (0xe << 8)
+#define   OPORTMXRATE_I_MCKSEL_MASK        GENMASK(7, 4)
+#define   OPORTMXRATE_I_MCKSEL_36          (0x0 << 4)
+#define   OPORTMXRATE_I_MCKSEL_33          (0x1 << 4)
+#define   OPORTMXRATE_I_MCKSEL_HSC27       (0xb << 4)
+#define   OPORTMXRATE_I_FSSEL_MASK         GENMASK(3, 0)
+#define   OPORTMXRATE_I_FSSEL_48           (0x0 << 0)
+#define   OPORTMXRATE_I_FSSEL_96           (0x1 << 0)
+#define   OPORTMXRATE_I_FSSEL_192          (0x2 << 0)
+#define   OPORTMXRATE_I_FSSEL_32           (0x3 << 0)
+#define   OPORTMXRATE_I_FSSEL_44_1         (0x4 << 0)
+#define   OPORTMXRATE_I_FSSEL_88_2         (0x5 << 0)
+#define   OPORTMXRATE_I_FSSEL_176_4        (0x6 << 0)
+#define   OPORTMXRATE_I_FSSEL_16           (0x8 << 0)
+#define   OPORTMXRATE_I_FSSEL_22_05        (0x9 << 0)
+#define   OPORTMXRATE_I_FSSEL_24           (0xa << 0)
+#define   OPORTMXRATE_I_FSSEL_8            (0xb << 0)
+#define   OPORTMXRATE_I_FSSEL_11_025       (0xc << 0)
+#define   OPORTMXRATE_I_FSSEL_12           (0xd << 0)
+#define OPORTMXEXNOE(n)                  (0x420f0 + 0x400 * (n))
+#define OPORTMXMASK(n)                   (0x420f8 + 0x400 * (n))
+#define   OPORTMXMASK_IUDXMSK_MASK         GENMASK(28, 24)
+#define   OPORTMXMASK_IUDXMSK_ON           (0x00 << 24)
+#define   OPORTMXMASK_IUDXMSK_OFF          (0x1f << 24)
+#define   OPORTMXMASK_IUXCKMSK_MASK        GENMASK(18, 16)
+#define   OPORTMXMASK_IUXCKMSK_ON          (0x0 << 16)
+#define   OPORTMXMASK_IUXCKMSK_OFF         (0x7 << 16)
+#define   OPORTMXMASK_DXMSK_MASK           GENMASK(12, 8)
+#define   OPORTMXMASK_DXMSK_ON             (0x00 << 8)
+#define   OPORTMXMASK_DXMSK_OFF            (0x1f << 8)
+#define   OPORTMXMASK_XCKMSK_MASK          GENMASK(2, 0)
+#define   OPORTMXMASK_XCKMSK_ON            (0x0 << 0)
+#define   OPORTMXMASK_XCKMSK_OFF           (0x7 << 0)
+#define OPORTMXDEBUG(n)                  (0x420fc + 0x400 * (n))
+#define OPORTMXT0RSTCTR(n)               (0x4211c + 0x400 * (n))
+#define OPORTMXT1RSTCTR(n)               (0x4213c + 0x400 * (n))
+#define OPORTMXT2RSTCTR(n)               (0x4215c + 0x400 * (n))
+#define OPORTMXT3RSTCTR(n)               (0x4217c + 0x400 * (n))
+#define OPORTMXT4RSTCTR(n)               (0x4219c + 0x400 * (n))
+
+#define SBF_(frame, shift)    (((frame) * 2 - 1) << shift)
+
+/* AOUT(PBoutMX) */
+#define PBOUTMXCTR0(n)                   (0x40200 + 0x40 * (n))
+#define   PBOUTMXCTR0_ENDIAN_MASK         GENMASK(5, 4)
+#define   PBOUTMXCTR0_ENDIAN_3210         (0x0 << 4)
+#define   PBOUTMXCTR0_ENDIAN_0123         (0x1 << 4)
+#define   PBOUTMXCTR0_ENDIAN_1032         (0x2 << 4)
+#define   PBOUTMXCTR0_ENDIAN_2301         (0x3 << 4)
+#define   PBOUTMXCTR0_MEMFMT_MASK         GENMASK(3, 0)
+#define   PBOUTMXCTR0_MEMFMT_10CH         (0x0 << 0)
+#define   PBOUTMXCTR0_MEMFMT_8CH          (0x1 << 0)
+#define   PBOUTMXCTR0_MEMFMT_6CH          (0x2 << 0)
+#define   PBOUTMXCTR0_MEMFMT_4CH          (0x3 << 0)
+#define   PBOUTMXCTR0_MEMFMT_2CH          (0x4 << 0)
+#define   PBOUTMXCTR0_MEMFMT_STREAM       (0x5 << 0)
+#define   PBOUTMXCTR0_MEMFMT_1CH          (0x6 << 0)
+#define PBOUTMXCTR1(n)                   (0x40204 + 0x40 * (n))
+#define PBOUTMXINTCTR(n)                 (0x40208 + 0x40 * (n))
+
+/* A2D(subsystem) */
+#define CDA2D_STRT0                      0x10000
+#define   CDA2D_STRT0_STOP_MASK            BIT(31)
+#define   CDA2D_STRT0_STOP_START           (0x0 << 31)
+#define   CDA2D_STRT0_STOP_STOP            (0x1 << 31)
+#define CDA2D_STAT0                      0x10020
+#define CDA2D_TEST                       0x100a0
+#define   CDA2D_TEST_DDR_MODE_MASK         GENMASK(3, 2)
+#define   CDA2D_TEST_DDR_MODE_EXTON0       (0x0 << 2)
+#define   CDA2D_TEST_DDR_MODE_EXTOFF1      (0x3 << 2)
+#define CDA2D_STRTADRSLOAD               0x100b0
+
+#define CDA2D_CHMXCTRL1(n)               (0x12000 + 0x80 * (n))
+#define   CDA2D_CHMXCTRL1_INDSIZE_MASK     BIT(0)
+#define   CDA2D_CHMXCTRL1_INDSIZE_FINITE   (0x0 << 0)
+#define   CDA2D_CHMXCTRL1_INDSIZE_INFINITE (0x1 << 0)
+#define CDA2D_CHMXCTRL2(n)               (0x12004 + 0x80 * (n))
+#define CDA2D_CHMXSRCAMODE(n)            (0x12020 + 0x80 * (n))
+#define CDA2D_CHMXDSTAMODE(n)            (0x12024 + 0x80 * (n))
+#define   CDA2D_CHMXAMODE_ENDIAN_MASK      GENMASK(17, 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_3210      (0x0 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_0123      (0x1 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_1032      (0x2 << 16)
+#define   CDA2D_CHMXAMODE_ENDIAN_2301      (0x3 << 16)
+#define   CDA2D_CHMXAMODE_RSSEL_SHIFT      (8)
+#define   CDA2D_CHMXAMODE_AUPDT_MASK       GENMASK(5, 4)
+#define   CDA2D_CHMXAMODE_AUPDT_INC        (0x0 << 4)
+#define   CDA2D_CHMXAMODE_AUPDT_FIX        (0x2 << 4)
+#define   CDA2D_CHMXAMODE_TYPE_MASK        GENMASK(3, 2)
+#define   CDA2D_CHMXAMODE_TYPE_NORMAL      (0x0 << 2)
+#define   CDA2D_CHMXAMODE_TYPE_RING        (0x1 << 2)
+#define CDA2D_CHMXSRCSTRTADRS(n)         (0x12030 + 0x80 * (n))
+#define CDA2D_CHMXSRCSTRTADRSU(n)        (0x12034 + 0x80 * (n))
+#define CDA2D_CHMXDSTSTRTADRS(n)         (0x12038 + 0x80 * (n))
+#define CDA2D_CHMXDSTSTRTADRSU(n)        (0x1203c + 0x80 * (n))
+
+/* A2D(ring buffer) */
+#define CDA2D_RBFLUSH0                   0x10040
+#define CDA2D_RBADRSLOAD                 0x100b4
+#define CDA2D_RDPTRLOAD                  0x100b8
+#define   CDA2D_RDPTRLOAD_LSFLAG_LOAD      (0x0 << 31)
+#define   CDA2D_RDPTRLOAD_LSFLAG_STORE     (0x1 << 31)
+#define CDA2D_WRPTRLOAD                  0x100bc
+#define   CDA2D_WRPTRLOAD_LSFLAG_LOAD      (0x0 << 31)
+#define   CDA2D_WRPTRLOAD_LSFLAG_STORE     (0x1 << 31)
+
+#define CDA2D_RBMXBGNADRS(n)             (0x14000 + 0x80 * (n))
+#define CDA2D_RBMXBGNADRSU(n)            (0x14004 + 0x80 * (n))
+#define CDA2D_RBMXENDADRS(n)             (0x14008 + 0x80 * (n))
+#define CDA2D_RBMXENDADRSU(n)            (0x1400c + 0x80 * (n))
+#define CDA2D_RBMXBTH(n)                 (0x14038 + 0x80 * (n))
+#define CDA2D_RBMXRTH(n)                 (0x1403c + 0x80 * (n))
+#define CDA2D_RBMXRDPTR(n)               (0x14020 + 0x80 * (n))
+#define CDA2D_RBMXRDPTRU(n)              (0x14024 + 0x80 * (n))
+#define CDA2D_RBMXWRPTR(n)               (0x14028 + 0x80 * (n))
+#define CDA2D_RBMXWRPTRU(n)              (0x1402c + 0x80 * (n))
+#define   CDA2D_RBMXPTRU_PTRU_MASK         GENMASK(1, 0)
+#define CDA2D_RBMXCNFG(n)                (0x14030 + 0x80 * (n))
+#define CDA2D_RBMXIR(n)                  (0x14014 + 0x80 * (n))
+#define CDA2D_RBMXIE(n)                  (0x14018 + 0x80 * (n))
+#define CDA2D_RBMXID(n)                  (0x1401c + 0x80 * (n))
+#define   CDA2D_RBMXIX_SPACE               BIT(3)
+#define   CDA2D_RBMXIX_REMAIN              BIT(4)
+
+int uniphier_aio_chip_init(struct uniphier_aio_chip *chip);
+int uniphier_aio_init(struct uniphier_aio_sub *sub);
+int uniphier_aio_port_reset(struct uniphier_aio_sub *sub);
+int uniphier_aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
+				const struct snd_pcm_hw_params *params);
+int uniphier_aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
+int uniphier_aio_if_set_param(struct uniphier_aio_sub *sub, int pass_through);
+int uniphier_aio_oport_set_stream_type(struct uniphier_aio_sub *sub,
+				       enum IEC61937_PC iec61937_pc);
+int uniphier_aio_srcif_set_param(struct uniphier_aio_sub *sub);
+int uniphier_aio_srcch_set_param(struct uniphier_aio_sub *sub);
+int uniphier_aio_srcch_set_enable(struct uniphier_aio_sub *sub, int enable);
+int uniphier_aio_srcport_reset(struct uniphier_aio_sub *sub);
+int uniphier_aio_srcport_set_param(struct uniphier_aio_sub *sub,
+				   const struct snd_pcm_hw_params *params);
+int uniphier_aio_ch_set_param(struct uniphier_aio_sub *sub);
+int uniphier_aio_ch_set_enable(struct uniphier_aio_sub *sub, int enable);
+int uniphier_aio_rb_set_buffer(struct uniphier_aio_sub *sub,
+			       u64 start, u64 end);
+void uniphier_aio_rb_sync(struct uniphier_aio_sub *sub);
+int uniphier_aio_rb_clear_int(struct uniphier_aio_sub *sub);
+
+#endif /* SND_UNIPHIER_AIO_REGCTRL_H__ */
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
new file mode 100644
index 000000000000..542467688821
--- /dev/null
+++ b/sound/soc/uniphier/aio.h
@@ -0,0 +1,261 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Socionext UniPhier AIO ALSA driver.
+ *
+ * Copyright (c) 2016-2017 Socionext Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SND_UNIPHIER_AIO_H__
+#define SND_UNIPHIER_AIO_H__
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+struct platform_device;
+
+enum ID_PORT_TYPE {
+	PORT_TYPE_UNKNOWN,
+	PORT_TYPE_I2S,
+	PORT_TYPE_SPDIF,
+	PORT_TYPE_EVE,
+	PORT_TYPE_CONV,
+};
+
+enum ID_PORT_DIR {
+	PORT_DIR_UNKNOWN,
+	PORT_DIR_INPUT,
+	PORT_DIR_OUTPUT,
+};
+
+enum IEC61937_PC {
+	IEC61937_PC_AC3   = 0x0001,
+	IEC61937_PC_PAUSE = 0x0003,
+	IEC61937_PC_MPA   = 0x0004,
+	IEC61937_PC_MP3   = 0x0005,
+	IEC61937_PC_DTS1  = 0x000b,
+	IEC61937_PC_DTS2  = 0x000c,
+	IEC61937_PC_DTS3  = 0x000d,
+	IEC61937_PC_AAC   = 0x0007,
+};
+
+/* IEC61937 Repetition period of data-burst in IEC60958 frames */
+#define IEC61937_FRM_STR_AC3       1536
+#define IEC61937_FRM_STR_MPA       1152
+#define IEC61937_FRM_STR_MP3       1152
+#define IEC61937_FRM_STR_DTS1      512
+#define IEC61937_FRM_STR_DTS2      1024
+#define IEC61937_FRM_STR_DTS3      2048
+#define IEC61937_FRM_STR_AAC       1024
+
+/* IEC61937 Repetition period of Pause data-burst in IEC60958 frames */
+#define IEC61937_FRM_PAU_AC3       3
+#define IEC61937_FRM_PAU_MPA       32
+#define IEC61937_FRM_PAU_MP3       32
+#define IEC61937_FRM_PAU_DTS1      3
+#define IEC61937_FRM_PAU_DTS2      3
+#define IEC61937_FRM_PAU_DTS3      3
+#define IEC61937_FRM_PAU_AAC       32
+
+#define AUD_HW_PCMIN1    0
+#define AUD_HW_PCMIN2    1
+#define AUD_HW_PCMIN3    2
+#define AUD_HW_IECIN1    3
+#define AUD_HW_DIECIN1   4
+
+#define AUD_NAME_PCMIN1     "aio-pcmin1"
+#define AUD_NAME_PCMIN2     "aio-pcmin2"
+#define AUD_NAME_PCMIN3     "aio-pcmin3"
+#define AUD_NAME_IECIN1     "aio-iecin1"
+#define AUD_NAME_DIECIN1    "aio-diecin1"
+
+#define AUD_HW_HPCMOUT1    0
+#define AUD_HW_PCMOUT1     1
+#define AUD_HW_PCMOUT2     2
+#define AUD_HW_PCMOUT3     3
+#define AUD_HW_EPCMOUT1    4
+#define AUD_HW_EPCMOUT2    5
+#define AUD_HW_EPCMOUT3    6
+#define AUD_HW_EPCMOUT6    9
+#define AUD_HW_HIECOUT1    10
+#define AUD_HW_IECOUT1     11
+#define AUD_HW_CMASTER     31
+
+#define AUD_NAME_HPCMOUT1    "aio-hpcmout1"
+#define AUD_NAME_PCMOUT1     "aio-pcmout1"
+#define AUD_NAME_PCMOUT2     "aio-pcmout2"
+#define AUD_NAME_PCMOUT3     "aio-pcmout3"
+#define AUD_NAME_EPCMOUT1    "aio-epcmout1"
+#define AUD_NAME_EPCMOUT2    "aio-epcmout2"
+#define AUD_NAME_EPCMOUT3    "aio-epcmout3"
+#define AUD_NAME_EPCMOUT6    "aio-epcmout6"
+#define AUD_NAME_HIECOUT1    "aio-hiecout1"
+#define AUD_NAME_IECOUT1     "aio-iecout1"
+#define AUD_NAME_CMASTER     "aio-cmaster"
+
+#define AUD_GNAME_HDMI    "aio-hdmi"
+#define AUD_GNAME_LINE    "aio-line"
+#define AUD_GNAME_IEC     "aio-iec"
+
+/*
+ * This is a selector for virtual register map of AIO.
+ *
+ * map:  Specify the index of virtual register map.
+ * hw :  Specify the ID of real register map, selector uses this value.
+ *       A meaning of this value depends specification of SoC.
+ */
+struct uniphier_aio_selector {
+	int map;
+	int hw;
+};
+
+/**
+ * 'SoftWare MAPping' setting of UniPhier AIO registers.
+ *
+ * We have to setup 'virtual' register maps to access 'real' registers of AIO.
+ * This feature is legacy and meaningless but AIO needs this to work.
+ *
+ * Each hardware blocks have own virtual register maps as following:
+ *
+ * Address Virtual                      Real
+ * ------- ---------                    ---------------
+ * 0x12000 DMAC map0 --> [selector] --> DMAC hardware 3
+ * 0x12080 DMAC map1 --> [selector] --> DMAC hardware 1
+ * ...
+ * 0x42000 Port map0 --> [selector] --> Port hardware 1
+ * 0x42400 Port map1 --> [selector] --> Port hardware 2
+ * ...
+ *
+ * ch   : Input or output channel of DMAC
+ * rb   : Ring buffer
+ * iport: PCM input port
+ * iif  : Input interface
+ * oport: PCM output port
+ * oif  : Output interface
+ * och  : Output channel of DMAC for sampling rate converter
+ *
+ * These are examples for sound data paths:
+ *
+ * For caputure device:
+ *   (outer of AIO) -> iport -> iif -> ch -> rb -> (CPU)
+ * For playback device:
+ *   (CPU) -> rb -> ch -> oif -> oport -> (outer of AIO)
+ * For sampling rate converter device:
+ *   (CPU) -> rb -> ch -> oif -> (HW SRC) -> iif -> och -> orb -> (CPU)
+ */
+struct uniphier_aio_swmap {
+	int type;
+	int dir;
+
+	struct uniphier_aio_selector ch;
+	struct uniphier_aio_selector rb;
+	struct uniphier_aio_selector iport;
+	struct uniphier_aio_selector iif;
+	struct uniphier_aio_selector oport;
+	struct uniphier_aio_selector oif;
+	struct uniphier_aio_selector och;
+};
+
+struct uniphier_aio_spec {
+	const char *name;
+	const char *gname;
+	struct uniphier_aio_swmap swm;
+};
+
+struct uniphier_aio_chip_spec {
+	const struct uniphier_aio_spec *aio_specs;
+	int num_aio_specs;
+	struct snd_soc_dai_driver *dais;
+	int num_dais;
+
+	/* DMA access mode, this is workaround for DMA hungup */
+	int addr_ext;
+};
+
+struct uniphier_aio_sub {
+	struct uniphier_aio *aio;
+
+	/* Guard sub->rd_offs and wr_offs from IRQ handler. */
+	spinlock_t spin;
+
+	const struct uniphier_aio_swmap *swm;
+	const struct uniphier_aio_spec *spec;
+
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_hw_params params;
+
+	int setting;
+	int running;
+	u64 rd_offs;
+	u64 wr_offs;
+};
+
+struct uniphier_aio {
+	struct uniphier_aio_chip *chip;
+
+	struct snd_soc_dai *dai;
+
+	struct uniphier_aio_sub sub[2];
+
+	u8 iec_status[24];
+	int pass_through;
+};
+
+struct uniphier_aio_chip {
+	struct platform_device *pdev;
+	const struct uniphier_aio_chip_spec *chip_spec;
+
+	struct uniphier_aio *aios;
+	int num_aios;
+
+	struct clk *clk;
+	struct reset_control *rst;
+	struct regmap *regmap;
+	int active;
+};
+
+static inline struct uniphier_aio *uniphier_priv(struct snd_soc_dai *dai)
+{
+	struct uniphier_aio_chip *chip = snd_soc_dai_get_drvdata(dai);
+
+	return &chip->aios[dai->id];
+}
+
+int uniphier_aiodma_soc_register_platform(struct platform_device *pdev);
+
+int uniphier_aio_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai);
+void uniphier_aio_shutdown(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai);
+int uniphier_aio_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params,
+			   struct snd_soc_dai *dai);
+int uniphier_aio_hw_free(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai);
+int uniphier_aio_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai);
+
+int uniphier_aio_dai_probe(struct snd_soc_dai *dai);
+int uniphier_aio_dai_remove(struct snd_soc_dai *dai);
+int uniphier_aio_dai_suspend(struct snd_soc_dai *dai);
+int uniphier_aio_dai_resume(struct snd_soc_dai *dai);
+
+extern const struct uniphier_aio_chip_spec uniphier_aio_ld11_spec;
+extern const struct uniphier_aio_chip_spec uniphier_aio_ld20_spec;
+
+#endif /* SND_UNIPHIER_AIO_H__ */
-- 
2.15.0
