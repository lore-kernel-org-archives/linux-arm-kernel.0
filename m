From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:16:08 +0800
Subject: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time before writting
In-Reply-To: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit af8ee11 (ASoC: sgtl5000: Fix driver probe after reset),
it's very ofen to run into the following probe error on imx28. It is
caused by the regmap_write() failure in sgtl5000_fill_defaults().
However, the regmap_read() before this has already been working.  It
seems that sgtl5000 takes a longer ramping time to get the registers
ready for write than read.

[    1.991579] sgtl5000 0-000a: sgtl5000 revision 0x11
[    2.021655] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
[    2.039087] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)
[    2.046299] platform sound.12: Driver mxs-sgtl5000 requests probe deferral

Fix the regression by giving it a ramping time before the first write.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d441559..20bca03 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1552,6 +1552,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, sgtl5000);
 
+	/*
+	 * It seems that sgtl5000 takes a longer time to get the registers
+	 * ready for write than bread.  Let's give it a ramping time before
+	 * the first write goes.
+	 */
+	msleep(50);
+
 	/* Ensure sgtl5000 will start with sane register values */
 	ret = sgtl5000_fill_defaults(sgtl5000);
 	if (ret)
-- 
1.7.9.5
