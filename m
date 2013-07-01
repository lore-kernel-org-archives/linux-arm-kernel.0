From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:16:09 +0800
Subject: [PATCH 2/4] ASoC: sgtl5000: defer the probe if clock is not found
In-Reply-To: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not always the case that clock is already available when sgtl5000
get probed at the first time, e.g. the clock is provided by CPU DAI
which may be probed after sgtl5000.  So let's defer the probe when
devm_clk_get() call fails and give it chance to try later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/codecs/sgtl5000.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 20bca03..1b7003c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1527,7 +1527,8 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	if (IS_ERR(sgtl5000->mclk)) {
 		ret = PTR_ERR(sgtl5000->mclk);
 		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
-		return ret;
+		/* Defer the probe to see if the clk will be provided later */
+		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 	}
 
 	ret = clk_prepare_enable(sgtl5000->mclk);
-- 
1.7.9.5
