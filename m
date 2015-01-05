From: cychiang@chromium.org (Cheng-Yi Chiang)
Date: Mon,  5 Jan 2015 19:26:59 +0800
Subject: [PATCH] ASoC: ts3a227e: Check and report jack status at probe
Message-ID: <1420457219-23098-1-git-send-email-cychiang@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ts3a227e does not trigger interrupt to report jack status when system
boots from warm reset because ts3a227e's power remains on during warm reset.
Read jack status at probe to get current jack status.
Note that if system boots from EC reset, then this issue will not
happen.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/codecs/ts3a227e.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 1d12057..9f2dced 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -254,6 +254,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	struct ts3a227e *ts3a227e;
 	struct device *dev = &i2c->dev;
 	int ret;
+	unsigned int acc_reg;
 
 	ts3a227e = devm_kzalloc(&i2c->dev, sizeof(*ts3a227e), GFP_KERNEL);
 	if (ts3a227e == NULL)
@@ -283,6 +284,11 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 			   INTB_DISABLE | ADC_COMPLETE_INT_DISABLE,
 			   ADC_COMPLETE_INT_DISABLE);
 
+	/* Read jack status because chip might not trigger interrupt at boot. */
+	regmap_read(ts3a227e->regmap, TS3A227E_REG_ACCESSORY_STATUS, &acc_reg);
+	ts3a227e_new_jack_state(ts3a227e, acc_reg);
+	ts3a227e_jack_report(ts3a227e);
+
 	return 0;
 }
 
-- 
2.1.2
