From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Jul 2018 15:35:26 +0100
Subject: Applied "ASoC: qdsp6: q6afe-dai: do not close port if its not opened"
 to the asoc tree
In-Reply-To: <20180704094944.16440-6-srinivas.kandagatla@linaro.org>
Message-ID: <E1faisQ-0003PO-Rt@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: q6afe-dai: do not close port if its not opened

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 110743189c863e96dc08a581d56c50b965870a3f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:43 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: do not close port if its not opened

afe ports are open as part of prepare, so for use cases like
"aplay sample.wav" were sample.wav is not present. This would
call port close eventhough port was never opened. DSP would
return errors for such use cases.

Avoid doing this by checking the port state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 5002dd05bf27..a373ca5523ff 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -315,6 +315,9 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int rc;
 
+	if (!dai_data->is_port_started[dai->id])
+		return;
+
 	rc = q6afe_port_stop(dai_data->port[dai->id]);
 	if (rc < 0)
 		dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
-- 
2.18.0.rc2
