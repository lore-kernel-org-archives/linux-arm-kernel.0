From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Wed, 18 Apr 2018 18:46:37 +0100
Subject: [PATCH] ASoC: msm8916-wcd-analog: use threaded context for mbhc events
Message-ID: <20180418174637.24041-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

As snd_soc_jack_report() can sleep, move handling of mbhc events to a
thread context rather than in interrupt context.

Fixes: de66b3455023 ('ASoC: codecs: msm8916-wcd-analog: add MBHC support')
Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 12ee83d52405..b7cf7cce95fe 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1187,7 +1187,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	ret = devm_request_irq(dev, irq, pm8916_mbhc_switch_irq_handler,
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+			       pm8916_mbhc_switch_irq_handler,
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
 			       IRQF_ONESHOT,
 			       "mbhc switch irq", priv);
@@ -1201,7 +1202,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_press_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_press_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn press irq", priv);
@@ -1214,7 +1216,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_release_irq_handler,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				       mbhc_btn_release_irq_handler,
 				       IRQF_TRIGGER_RISING |
 				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				       "mbhc btn release irq", priv);
-- 
2.16.2
