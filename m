From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 00:45:31 +0530
Subject: [PATCH 09/10] Input: sirfsoc-onkey: Handle return value of
 platform_get_irq
In-Reply-To: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510946132-13554-10-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/sirfsoc-onkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4fd038d..de04b48 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -149,6 +149,9 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	sirfsoc_pwrc_toggle_interrupts(pwrcdrv, false);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	error = devm_request_irq(&pdev->dev, irq,
 				 sirfsoc_pwrc_isr, 0,
 				 "sirfsoc_pwrc_int", pwrcdrv);
-- 
2.7.4
