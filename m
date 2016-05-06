From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 09:27:13 +0200
Subject: [PATCH v6 6/9] rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
In-Reply-To: <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462519636-3250-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regmap_irq_get_virq() can return zero or negative ERRNO, so it is
insufficient to check only for non-zero value.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/rtc/rtc-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 4998aee0f07f..1a06e17ebe9b 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -497,7 +497,7 @@ static int max8997_rtc_probe(struct platform_device *pdev)
 	}
 
 	virq = regmap_irq_get_virq(max8997->irq_data, MAX8997_PMICIRQ_RTCA1);
-	if (!virq) {
+	if (virq <= 0) {
 		dev_err(&pdev->dev, "Failed to create mapping alarm IRQ\n");
 		ret = -ENXIO;
 		goto err_out;
-- 
1.9.1
