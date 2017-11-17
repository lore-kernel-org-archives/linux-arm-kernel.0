From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 00:45:29 +0530
Subject: [PATCH 07/10] Input: sun4i-ts: Handle return value of platform_get_irq
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510946132-13554-8-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9..2753fd3 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -315,6 +315,9 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 		return PTR_ERR(ts->base);
 
 	ts->irq = platform_get_irq(pdev, 0);
+	if (ts->irq < 0)
+		return ts->irq;
+
 	error = devm_request_irq(dev, ts->irq, sun4i_ts_irq, 0, "sun4i-ts", ts);
 	if (error)
 		return error;
-- 
2.7.4
