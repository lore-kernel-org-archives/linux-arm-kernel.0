From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 21 Aug 2017 18:00:38 +0200
Subject: [PATCH] rtc: sa1100: fix unbalanced
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <20170821160038.22650-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the error path of sa1100_rtc_open(), info->clk is disabled which will
happen again in sa1100_rtc_remove() when the module is removed whereas it
is only enabled once in sa1100_rtc_init().

Fixes: 0cc0c38e9139 ("drivers/rtc/rtc-sa1100.c: move clock enable/disable to probe/remove")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-sa1100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index c2187bf6c7e4..fe8ebf47bbe5 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -104,7 +104,7 @@ static int sa1100_rtc_open(struct device *dev)
 	ret = request_irq(info->irq_1hz, sa1100_rtc_interrupt, 0, "rtc 1Hz", dev);
 	if (ret) {
 		dev_err(dev, "IRQ %d already in use.\n", info->irq_1hz);
-		goto fail_ui;
+		return ret;
 	}
 	ret = request_irq(info->irq_alarm, sa1100_rtc_interrupt, 0, "rtc Alrm", dev);
 	if (ret) {
@@ -118,8 +118,6 @@ static int sa1100_rtc_open(struct device *dev)
 
  fail_ai:
 	free_irq(info->irq_1hz, dev);
- fail_ui:
-	clk_disable_unprepare(info->clk);
 	return ret;
 }
 
-- 
2.14.1
