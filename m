From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 15:21:41 +0200
Subject: [PATCH 2/4] rtc: stm32: fix alarm interrupt flags by removing
 IRQF_TRIGGER_RISING
In-Reply-To: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524144103-21432-3-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC alarm interrupt is active high and already configured by device tree.
So remove IRQF_TRIGGER_RISING from driver.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/rtc/rtc-stm32.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 79d9e86..6a06078 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -663,8 +663,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	/* Handle RTC alarm interrupts */
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_alarm, NULL,
-					stm32_rtc_alarm_irq,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					stm32_rtc_alarm_irq, IRQF_ONESHOT,
 					pdev->name, rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ%d (alarm interrupt) already claimed\n",
-- 
2.7.4
