From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Apr 2018 12:50:33 +0100
Subject: Applied "ASoC: msm8916-wcd-analog: use threaded context for mbhc
 events" to the asoc tree
In-Reply-To: <20180418174637.24041-1-srinivas.kandagatla@linaro.org>
Message-ID: <E1fBfQ1-0007MB-76@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: msm8916-wcd-analog: use threaded context for mbhc events

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

>From a8419a0cd98ddf628a9e38a92110af7cc650dde7 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 18 Apr 2018 18:46:37 +0100
Subject: [PATCH] ASoC: msm8916-wcd-analog: use threaded context for mbhc
 events

As snd_soc_jack_report() can sleep, move handling of mbhc events to a
thread context rather than in interrupt context.

Fixes: de66b3455023 ('ASoC: codecs: msm8916-wcd-analog: add MBHC support')
Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0
