From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:24 -0500
Subject: [PATCH 09/18] ARM: imx: Removed the SoC relating codes in
 mxc_timer_interrupt
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-10-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the SoC relating codes in the function of
mxc_timer_interrupt.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index cf07401..e41bad9 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -320,17 +320,16 @@ static void mxc_set_mode(enum clock_event_mode mode,
  */
 static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = &clockevent_mxc;
-	uint32_t tstat;
+	struct imx_timer *tm = dev_id;
+	void (*event_handler)(struct clock_event_device *);
 
-	if (timer_is_v2())
-		tstat = __raw_readl(timer_base + V2_TSTAT);
-	else
-		tstat = __raw_readl(timer_base + MX1_2_TSTAT);
+	BUG_ON(!tm);
 
-	gpt_irq_acknowledge();
+	tm->gpt_irq_acknowledge(tm);
 
-	evt->event_handler(evt);
+	event_handler = ACCESS_ONCE(tm->evt.event_handler);
+	if (event_handler)
+		event_handler(&tm->evt);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.1
