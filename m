From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 6 Jul 2013 00:53:36 +0200
Subject: [PATCH 4/9] clocksource: dw_apb_timer: use the eoi callback to clear
 pending interrupts
In-Reply-To: <201307060051.09716.heiko@sntech.de>
References: <201307060051.09716.heiko@sntech.de>
Message-ID: <201307060053.36885.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some timer variants have different mechanisms to clear a pending timer
interrupt. Therefore don't hardcode the reading of the eoi register to
clear them, but instead use the already existing eoi callback for this.

Signed-off-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 drivers/clocksource/dw_apb_timer.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index bd45351..5f80a30 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -121,11 +121,14 @@ static irqreturn_t dw_apb_clockevent_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void apbt_enable_int(struct dw_apb_timer *timer)
+static void apbt_enable_int(struct dw_apb_clock_event_device *dw_ced)
 {
+	struct dw_apb_timer *timer = &dw_ced->timer;
 	unsigned long ctrl = apbt_readl(timer, timer->reg_control);
+
 	/* clear pending intr */
-	apbt_readl(timer, timer->reg_eoi);
+	if (dw_ced->eoi)
+		dw_ced->eoi(timer);
 	ctrl &= ~APBTMR_CONTROL_INT;
 	apbt_writel(timer, ctrl, timer->reg_control);
 }
@@ -200,7 +203,7 @@ static void apbt_set_mode(enum clock_event_mode mode,
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
-		apbt_enable_int(timer);
+		apbt_enable_int(dw_ced);
 		break;
 	}
 }
@@ -325,7 +328,7 @@ void dw_apb_clockevent_register(struct dw_apb_clock_event_device *dw_ced)
 
 	apbt_writel(timer, 0, timer->reg_control);
 	clockevents_register_device(&dw_ced->ced);
-	apbt_enable_int(timer);
+	apbt_enable_int(dw_ced);
 }
 
 /**
-- 
1.7.10.4
