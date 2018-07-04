From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jul 2018 10:49:43 +0100
Subject: [PATCH 5/6] ASoC: qdsp6: q6afe-dai: do not close port if its not
 opened
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180704094944.16440-6-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

afe ports are open as part of prepare, so for use cases like
"aplay sample.wav" were sample.wav is not present. This would
call port close eventhough port was never opened. DSP would
return errors for such use cases.

Avoid doing this by checking the port state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 074582afda85..e7f809e3ee1f 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -314,6 +314,9 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int rc;
 
+	if (!dai_data->is_port_started[dai->id])
+		return;
+
 	rc = q6afe_port_stop(dai_data->port[dai->id]);
 	if (rc < 0)
 		dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
-- 
2.16.2
