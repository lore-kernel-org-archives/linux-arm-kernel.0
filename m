From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Dec 2013 11:04:26 +0100
Subject: [PATCH 1/6] ALSA: AACI: Convert to modern PM ops
In-Reply-To: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
References: <1386065071-9529-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386065071-9529-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if the CONFIG_PM explicity is undefined, let's convert to the
modern PM ops.

Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 sound/arm/aaci.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 1ca8dc2..c421fdb 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -753,7 +753,7 @@ static struct snd_pcm_ops aaci_capture_ops = {
  * Power Management.
  */
 #ifdef CONFIG_PM
-static int aaci_do_suspend(struct snd_card *card, unsigned int state)
+static int aaci_do_suspend(struct snd_card *card)
 {
 	struct aaci *aaci = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3cold);
@@ -761,28 +761,28 @@ static int aaci_do_suspend(struct snd_card *card, unsigned int state)
 	return 0;
 }
 
-static int aaci_do_resume(struct snd_card *card, unsigned int state)
+static int aaci_do_resume(struct snd_card *card)
 {
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
 
-static int aaci_suspend(struct amba_device *dev, pm_message_t state)
+static int aaci_suspend(struct device *dev)
 {
-	struct snd_card *card = amba_get_drvdata(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	return card ? aaci_do_suspend(card) : 0;
 }
 
-static int aaci_resume(struct amba_device *dev)
+static int aaci_resume(struct device *dev)
 {
-	struct snd_card *card = amba_get_drvdata(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	return card ? aaci_do_resume(card) : 0;
 }
+
+static SIMPLE_DEV_PM_OPS(aaci_dev_pm_ops, aaci_suspend, aaci_resume);
+#define AACI_DEV_PM_OPS (&aaci_dev_pm_ops)
 #else
-#define aaci_do_suspend		NULL
-#define aaci_do_resume		NULL
-#define aaci_suspend		NULL
-#define aaci_resume		NULL
+#define AACI_DEV_PM_OPS NULL
 #endif
 
 
@@ -1100,11 +1100,10 @@ MODULE_DEVICE_TABLE(amba, aaci_ids);
 static struct amba_driver aaci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
+		.pm	= AACI_DEV_PM_OPS,
 	},
 	.probe		= aaci_probe,
 	.remove		= aaci_remove,
-	.suspend	= aaci_suspend,
-	.resume		= aaci_resume,
 	.id_table	= aaci_ids,
 };
 
-- 
1.7.9.5
