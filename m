From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 00:45:28 +0530
Subject: [PATCH 06/10] Input: w90p910_ts: Handle return value of
 platform_get_irq
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510946132-13554-7-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/w90p910_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index 638c1d7..fa74f2c 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -277,6 +277,10 @@ static int w90x900ts_probe(struct platform_device *pdev)
 	input_set_drvdata(input_dev, w90p910_ts);
 
 	w90p910_ts->irq_num = platform_get_irq(pdev, 0);
+	if (w90p910_ts->irq_num < 0) {
+		err = w90p910_ts->irq_num;
+		goto fail4;
+	}
 	if (request_irq(w90p910_ts->irq_num, w90p910_ts_interrupt,
 			0, "w90p910ts", w90p910_ts)) {
 		err = -EBUSY;
-- 
2.7.4
