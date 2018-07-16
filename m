From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 16 Jul 2018 11:08:14 +0200
Subject: [PATCH v2] media: i2c: lm3560: use conservative defaults
In-Reply-To: <20180506080250.GA24114@amd>
References: <20180506080250.GA24114@amd>
Message-ID: <20180716090814.GA4505@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no pdata is found, we should use lowest current settings, not highest.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

v2: I got notification from patchwork that patch no longer applies, so
I'm rediffing the patch.

diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
index b600e03a..c4e5ed5 100644
--- a/drivers/media/i2c/lm3560.c
+++ b/drivers/media/i2c/lm3560.c
@@ -420,14 +434,14 @@ static int lm3560_probe(struct i2c_client *client,
 		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 		if (pdata == NULL)
 			return -ENODEV;
-		pdata->peak = LM3560_PEAK_3600mA;
-		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MAX;
+		pdata->peak = LM3560_PEAK_1600mA;
+		pdata->max_flash_timeout = LM3560_FLASH_TOUT_MIN;
 		/* led 1 */
-		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED0] = LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED0] = LM3560_TORCH_BRT_MIN;
 		/* led 2 */
-		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MAX;
-		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MAX;
+		pdata->max_flash_brt[LM3560_LED1] = LM3560_FLASH_BRT_MIN;
+		pdata->max_torch_brt[LM3560_LED1] = LM3560_TORCH_BRT_MIN;
 	}
 	flash->pdata = pdata;
 	flash->dev = &client->dev;



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/85c917e2/attachment.sig>
