From: ran.algawi@gmail.com (Ran Algawi)
Date: Mon, 6 Feb 2017 14:56:23 +0200
Subject: [PATCH] Signed-off-by: Ran Algawi <ran.algawi@gmail.com>
Message-ID: <20170206125623.GA2390@LestatChateau>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

linux-arm-kernel at lists.infradead.org, linux-kernel at vger.kernel.org
Bcc: 
Subject: [PATCH] Signed-off-by: Ran Algawi <ran.algawi@gmail.com>
Reply-To: 
Signed-off-by: Ran Algawi <ran.algawi@gmail.com>
Description: fixed errors and warnings in file at:
/drivers/staging/bcm2835-audio/bcm
mostly, i have changed syntax, like using null isntead of ! or
intialiazing stastics wil NULL.

fixed erros in drivers/staging/bcm2835-audio/bcm2835.c
---
 drivers/staging/bcm2835-audio/bcm2835.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.c b/drivers/staging/bcm2835-audio/bcm2835.c
index a84d74d..2e2c91d 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/bcm2835-audio/bcm2835.c
@@ -28,8 +28,8 @@
  * to debug if we run into issues
  */
 
-static struct snd_card *g_card = NULL;
-static struct bcm2835_chip *g_chip = NULL;
+static struct snd_card *g_card;
+static struct bcm2835_chip *g_chip;
 
 static int snd_bcm2835_free(struct bcm2835_chip *chip)
 {
@@ -49,8 +49,7 @@ static int snd_bcm2835_dev_free(struct snd_device *device)
  * (see "Management of Cards and Components")
  */
 static int snd_bcm2835_create(struct snd_card *card,
-	struct platform_device *pdev,
-	struct bcm2835_chip ** rchip)
+struct platform_device *pdev, struct bcm2835_chip **rchip);
 {
 	struct bcm2835_chip *chip;
 	int err;
@@ -61,7 +60,7 @@ static int snd_bcm2835_create(struct snd_card *card,
 	*rchip = NULL;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	if (!chip)
 		return -ENOMEM;
 
 	chip->card = card;
@@ -163,7 +162,7 @@ static int snd_bcm2835_alsa_remove(struct platform_device *pdev)
 
 	drv_data = platform_get_drvdata(pdev);
 
-	if (drv_data == (void *) g_card) {
+	if (drv_data == (void *)g_card) {
 		/* This is the card device */
 		snd_card_free((struct snd_card *)drv_data);
 		g_card = NULL;
@@ -171,18 +170,18 @@ static int snd_bcm2835_alsa_remove(struct platform_device *pdev)
 	} else {
 		idx = (int)(long)drv_data;
 		if (g_card) {
-			BUG_ON(!g_chip);
+			WARN_ON(!g_chip);
 			/* We pass chip device numbers in audio ipc devices
 			 * other than the one we registered our card with
 			 */
 			idx = (int)(long)drv_data;
-			BUG_ON(!idx || idx > MAX_SUBSTREAMS);
+			WARN_ON(!idx || idx > MAX_SUBSTREAMS);
 			g_chip->avail_substreams &= ~(1 << idx);
 			/* There should be atleast one substream registered
 			 * after we are done here, as it wil be removed when
 			 * the *remove* is called for the card device
 			 */
-			BUG_ON(!g_chip->avail_substreams);
+			WARN_ON(!g_chip->avail_substreams);
 		}
 	}
 
@@ -219,8 +218,7 @@ static struct platform_driver bcm2835_alsa0_driver = {
 	.suspend = snd_bcm2835_alsa_suspend,
 	.resume = snd_bcm2835_alsa_resume,
 #endif
-	.driver =
-	{
+	.driver = {
 		.name = "bcm2835_AUD0",
 		.owner = THIS_MODULE,
 		.of_match_table = snd_bcm2835_of_match_table,
@@ -230,7 +228,9 @@ static struct platform_driver bcm2835_alsa0_driver = {
 static int bcm2835_alsa_device_init(void)
 {
 	int err;
+
 	err = platform_driver_register(&bcm2835_alsa0_driver);
+
 	if (err) {
 		pr_err("Error registering bcm2835_alsa0_driver %d .\n", err);
 		return err;
-- 
2.7.4
