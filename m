From: marc@cpdesign.com.au (Marc Reilly)
Date: Mon, 30 Jan 2012 09:51:03 +1100
Subject: [PATCH 3/4] input: mc13xxx_ts: handle bad adc conversions
In-Reply-To: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1327877464-23526-4-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before, if the adc conversion failed for some reason then no more
samples would be taken until the after the next pen up/down interrupt.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/input/touchscreen/mc13xxx_ts.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/mc13xxx_ts.c b/drivers/input/touchscreen/mc13xxx_ts.c
index 264b977..8924d66 100644
--- a/drivers/input/touchscreen/mc13xxx_ts.c
+++ b/drivers/input/touchscreen/mc13xxx_ts.c
@@ -199,8 +199,12 @@ static void mc13xxx_ts_work(struct work_struct *work)
 	unsigned int channel = 12;
 
 	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
-				mode, channel, priv->sample) == 0)
+				mode, channel, priv->sample) == 0) {
 		mc13xxx_ts_report_sample(priv);
+	} else {
+		dev_warn(&priv->idev->dev, "bad conversion");
+		queue_delayed_work(priv->workq, &priv->work, HZ / 50);
+	}
 }
 
 static int mc13xxx_ts_open(struct input_dev *dev)
-- 
1.7.3.4
