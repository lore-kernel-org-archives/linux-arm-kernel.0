From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 28 Nov 2013 15:32:12 +0530
Subject: [PATCH] ASoC: samsung: Initialize the dma_data for secondary dai
Message-ID: <1385632932-16579-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch initializes the dma_data for the secondary dai.
Without this patch there is crash due to NULL pointer
dereference during boot time on systems where secondary dai
is initialized.

Below is the crash log:
[    1.630000] smdk-audio-wm8894 sound.7:  wm8994-aif1 <-> 3830000.i2s mapping ok
[    1.630000] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[    1.630000] pgd = c0004000
[    1.630000] [00000010] *pgd=00000000
[    1.630000] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[    1.630000] Modules linked in:
...
...
[<c0342d6c>] (dmaengine_pcm_new+0x284/0x2ac) from [<c0341ae8>] (soc_new_pcm+0x2fc/0x3f4)
[<c0341ae8>] (soc_new_pcm+0x2fc/0x3f4) from [<c0338558>] (snd_soc_register_card+0x1898/0x18d8)
[<c0338558>] (snd_soc_register_card+0x1898/0x18d8) from [<c034cc34>] (smdk_audio_probe+0xa8/0xe8)
[<c034cc34>] (smdk_audio_probe+0xa8/0xe8) from [<c0252368>] (platform_drv_probe+0x18/0x1c)
[<c0252368>] (platform_drv_probe+0x18/0x1c) from [<c02510a4>] (driver_probe_device+0xf4/0x204)
[<c02510a4>] (driver_probe_device+0xf4/0x204) from [<c0251240>] (__driver_attach+0x8c/0x90)
[<c0251240>] (__driver_attach+0x8c/0x90) from [<c024f70c>] (bus_for_each_dev+0x54/0x88)
[<c024f70c>] (bus_for_each_dev+0x54/0x88) from [<c0250724>] (bus_add_driver+0xe0/0x2b8)
[<c0250724>] (bus_add_driver+0xe0/0x2b8) from [<c0251868>] (driver_register+0x78/0xf4)
[<c0251868>] (driver_register+0x78/0xf4) from [<c00086e8>] (do_one_initcall+0x34/0x150)
[<c00086e8>] (do_one_initcall+0x34/0x150) from [<c0543c30>] (kernel_init_freeable+0x12c/0x1d0)
[<c0543c30>] (kernel_init_freeable+0x12c/0x1d0) from [<c03ebf9c>] (kernel_init+0x8/0xe8)
[<c03ebf9c>] (kernel_init+0x8/0xe8) from [<c000e978>] (ret_from_fork+0x14/0x3c)

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
This is made based on Mark Brown for-next branch of sound.git
This patch is based on Mark Brown below patches for
generic dma engine support for samsung audio IPs.
ASoC: samsung: Use ASoC dmaengine code where possible
ASoC: samsung: Provide helper for DMA init

 sound/soc/samsung/dmaengine.c |    3 ++-
 sound/soc/samsung/i2s.c       |    5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index ad0a371..3f60479 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -67,7 +67,8 @@ EXPORT_SYMBOL_GPL(samsung_asoc_init_dma_data);
 int samsung_asoc_dma_platform_register(struct device *dev)
 {
 	return snd_dmaengine_pcm_register(dev, &samsung_dmaengine_pcm_config,
-					  SND_DMAENGINE_PCM_FLAG_COMPAT);
+					  SND_DMAENGINE_PCM_FLAG_COMPAT |
+				SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME);
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_dma_platform_register);
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 67d9fa9..0bcd7fb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -946,8 +946,11 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
 
-	if (other && other->clk) /* If this is probe on secondary */
+	if (other && other->clk) { /* If this is probe on secondary */
+		samsung_asoc_init_dma_data(dai, &other->sec_dai->dma_playback,
+						NULL);
 		goto probe_exit;
+	}
 
 	i2s->addr = ioremap(i2s->base, 0x100);
 	if (i2s->addr == NULL) {
-- 
1.7.4.4
