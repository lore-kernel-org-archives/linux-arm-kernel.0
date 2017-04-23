From: bianpan201602@163.com (Pan Bian)
Date: Sun, 23 Apr 2017 20:48:07 +0800
Subject: [PATCH 1/1] rtc: gemini: add return value validation
Message-ID: <1492951687-16777-1-git-send-email-bianpan201602@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pan Bian <bianpan2016@163.com>

Function devm_ioremap() will return a NULL pointer if it fails to remap
IO address, and its return value should be validated before it is used.
However, in function gemini_rtc_probe(), its return value is not
checked. This may result in bad memory access bugs on future access,
e.g. calling the function gemini_rtc_read_time().

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/rtc/rtc-gemini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index ccf0dba..5279390 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -139,6 +139,8 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc_base = devm_ioremap(dev, res->start,
 				     resource_size(res));
+	if (!rtc->rtc_base)
+		return -ENOMEM;
 
 	ret = devm_request_irq(dev, rtc->rtc_irq, gemini_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
-- 
1.9.1
