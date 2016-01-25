From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 18:07:33 +0100
Subject: [PATCH 2/2] ASoC: s3c24xx: use const snd_soc_component_driver pointer
In-Reply-To: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Message-ID: <1453741678-1988125-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An older patch to convert the API in the s3c i2s driver
ended up passing a const pointer into a function that takes
a non-const pointer, so we now get a warning:

sound/soc/samsung/s3c2412-i2s.c: In function 's3c2412_iis_dev_probe':
sound/soc/samsung/s3c2412-i2s.c:172:9: error: passing argument 3 of 's3c_i2sv2_register_component' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

However, the s3c_i2sv2_register_component() function again
passes the pointer into another function taking a const, so
we just need to change its prototype.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: eca3b01d0885 ("ASoC: switch over to use snd_soc_register_component() on s3c i2s")
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 sound/soc/samsung/s3c-i2s-v2.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index df65c5b494b1..b6ab3fc5789e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -709,7 +709,7 @@ static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 #endif
 
 int s3c_i2sv2_register_component(struct device *dev, int id,
-			   struct snd_soc_component_driver *cmp_drv,
+			   const struct snd_soc_component_driver *cmp_drv,
 			   struct snd_soc_dai_driver *dai_drv)
 {
 	struct snd_soc_dai_ops *ops = (struct snd_soc_dai_ops *)dai_drv->ops;
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
index 90abab364b49..d0684145ed1f 100644
--- a/sound/soc/samsung/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -101,7 +101,7 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
  * soc core.
  */
 extern int s3c_i2sv2_register_component(struct device *dev, int id,
-					struct snd_soc_component_driver *cmp_drv,
+					const struct snd_soc_component_driver *cmp_drv,
 					struct snd_soc_dai_driver *dai_drv);
 
 #endif /* __SND_SOC_S3C24XX_S3C_I2SV2_I2S_H */
-- 
2.7.0
