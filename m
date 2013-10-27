From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 28 Oct 2013 06:23:48 +0800
Subject: [PATCH v2 1/6] ASoC: sirf: add sirf platform driver which provides DMA
Message-ID: <1382912628-13796-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

this driver uses dmaengine APIs and provides DMA to the CPU DAIs
of I2S, USP and SiRF-soc-inner.
SiRFSoC has 3 audio DAIs: I2S, USP(Universal Serial Ports) and DAI
connected to soc-inner-codec, all of them will use the same DMA
driver here.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2: use the generic dmaengine PCM driver as Lars-Peter Clausen's comments;

 sound/soc/Kconfig         |  1 +
 sound/soc/Makefile        |  1 +
 sound/soc/sirf/Kconfig    |  4 ++
 sound/soc/sirf/Makefile   |  3 ++
 sound/soc/sirf/sirf-pcm.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-pcm.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 5138b84..d5dce2b 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -48,6 +48,7 @@ source "sound/soc/pxa/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/sirf/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 61a64d2..1a47ff9 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SND_SOC)	+= pxa/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
+obj-$(CONFIG_SND_SOC)	+= sirf/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
new file mode 100644
index 0000000..1637089
--- /dev/null
+++ b/sound/soc/sirf/Kconfig
@@ -0,0 +1,4 @@
+config SND_SIRF_SOC
+	tristate "Platform DMA driver for the SiRF SoC chips"
+	depends on ARCH_SIRF && SND_SOC
+	select SND_SOC_GENERIC_DMAENGINE_PCM
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
new file mode 100644
index 0000000..f268b83
--- /dev/null
+++ b/sound/soc/sirf/Makefile
@@ -0,0 +1,3 @@
+snd-soc-sirf-objs := sirf-pcm.o
+
+obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
diff --git a/sound/soc/sirf/sirf-pcm.c b/sound/soc/sirf/sirf-pcm.c
new file mode 100644
index 0000000..1d53786
--- /dev/null
+++ b/sound/soc/sirf/sirf-pcm.c
@@ -0,0 +1,99 @@
+/*
+ * ALSA PCM interface for the SiRF SoC
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/sirfsoc_dma.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+static struct snd_pcm_hardware sirf_pcm_hardware = {
+	.info                   = (SNDRV_PCM_INFO_MMAP
+			| SNDRV_PCM_INFO_MMAP_VALID
+			| SNDRV_PCM_INFO_INTERLEAVED
+			| SNDRV_PCM_INFO_BLOCK_TRANSFER
+			| SNDRV_PCM_INFO_RESUME
+			| SNDRV_PCM_INFO_PAUSE),
+	.formats                = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates                  = (SNDRV_PCM_RATE_48000),
+	.rate_min               = 512,
+	.rate_max               = 115200,
+	.channels_min           = 1,
+	.channels_max           = 2,
+	.buffer_bytes_max       = 64 * 1024,
+	.period_bytes_min       = 128,
+	.period_bytes_max       = 32 * 1024,
+	.periods_min            = 2,
+	.periods_max            = 2,
+};
+
+static bool filter(struct dma_chan *chan, void *param)
+{
+	struct snd_dmaengine_dai_dma_data *dma_data = param;
+
+	if (!sirfsoc_dma_filter_id(chan, dma_data->filter_data))
+		return false;
+
+	chan->private = dma_data->filter_data;
+
+	return true;
+}
+
+static const struct snd_dmaengine_pcm_config sirf_dmaengine_pcm_config = {
+	.pcm_hardware = &sirf_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = filter,
+	.prealloc_buffer_size = 64 * 1024,
+};
+
+static int sirf_pcm_probe(struct platform_device *pdev)
+{
+	return snd_dmaengine_pcm_register(&pdev->dev,
+		&sirf_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+
+static int sirf_pcm_remove(struct platform_device *pdev)
+{
+	snd_dmaengine_pcm_unregister(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver sirf_pcm_driver = {
+	.driver = {
+		.name = "sirf-pcm-audio",
+		.owner = THIS_MODULE,
+	},
+	.probe = sirf_pcm_probe,
+	.remove = sirf_pcm_remove,
+};
+
+static int __init sirf_pcm_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&sirf_pcm_driver);
+	if (ret)
+		pr_err("failed to register platform driver\n");
+	return ret;
+}
+
+static void __exit sirf_pcm_exit(void)
+{
+	platform_driver_unregister(&sirf_pcm_driver);
+}
+
+module_init(sirf_pcm_init);
+module_exit(sirf_pcm_exit);
+
+MODULE_DESCRIPTION("SiRF PCM audio interface driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.8.2.3
