From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Fri,  8 Jun 2018 16:31:09 +0800
Subject: [PATCH] ASoC: rockchip: add config for rockchip dmaengine pcm register
Message-ID: <1528446669-18141-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the rockchip i2s pcm configurable by adding
rockchip pcm config for devm_snd_dmaengine_pcm_register.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/Makefile       |  3 ++-
 sound/soc/rockchip/rockchip_i2s.c |  3 ++-
 sound/soc/rockchip/rockchip_pcm.c | 45 +++++++++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_pcm.h | 14 ++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/rockchip/rockchip_pcm.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.h

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 05b078e..65e814d 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # ROCKCHIP Platform Support
 snd-soc-rockchip-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-pcm-objs := rockchip_pcm.o
 snd-soc-rockchip-pdm-objs := rockchip_pdm.o
 snd-soc-rockchip-spdif-objs := rockchip_spdif.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o snd-soc-rockchip-pcm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_PDM) += snd-soc-rockchip-pdm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 908211e..5e60181 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -22,6 +22,7 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "rockchip_i2s.h"
+#include "rockchip_pcm.h"
 
 #define DRV_NAME "rockchip-i2s"
 
@@ -667,7 +668,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = rockchip_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		return ret;
diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
new file mode 100644
index 0000000..f775383
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "rockchip_pcm.h"
+
+static const struct snd_pcm_hardware snd_rockchip_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE |
+				  SNDRV_PCM_INFO_RESUME,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 52,
+	.buffer_bytes_max	= 64 * 1024,
+	.fifo_size		= 32,
+};
+
+static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
+	.pcm_hardware = &snd_rockchip_hardware,
+	.prealloc_buffer_size = 32 * 1024,
+};
+
+int rockchip_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_dmaengine_pcm_register(dev, &rk_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+EXPORT_SYMBOL_GPL(rockchip_pcm_platform_register);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/rockchip/rockchip_pcm.h b/sound/soc/rockchip/rockchip_pcm.h
new file mode 100644
index 0000000..d6c3611
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ROCKCHIP_PCM_H
+#define _ROCKCHIP_PCM_H
+
+int rockchip_pcm_platform_register(struct device *dev);
+
+#endif
-- 
1.9.1
