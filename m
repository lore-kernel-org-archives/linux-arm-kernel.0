From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 24 Nov 2014 05:31:59 +0100
Subject: [PATCH] Fix PXA2xx RTC, interrupts before register ioremap
Message-ID: <5472B4BF.3020300@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix commits:

a44802f8fb7e593adabc6ef53c8df45a1717fa9b drivers/rtc/rtc-pxa.c: fix alarm can't wake up system issue
2f6e5f9458646263d3d9ffadd5e11e3d8d15a7d0 drivers/rtc: remove IRQF_DISABLED

Interrupts appear before registers of the RTC controller are ioremapped.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/rtc/rtc-pxa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 4561f37..d7d83e5 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -346,7 +346,7 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		dev_err(dev, "No alarm IRQ resource defined\n");
 		return -ENXIO;
 	}
-	pxa_rtc_open(dev);
+
 	pxa_rtc->base = devm_ioremap(dev, pxa_rtc->ress->start,
 				resource_size(pxa_rtc->ress));
 	if (!pxa_rtc->base) {
@@ -375,6 +375,10 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pxa_rtc_open(dev);
+	if (ret)
+		return ret;
+
 	device_init_wakeup(dev, 1);
 
 	return 0;
-- 
1.7.12.1
