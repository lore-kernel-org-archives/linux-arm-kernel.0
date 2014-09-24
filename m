From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 Sep 2014 18:20:08 +0200
Subject: [PATCH v2 1/3] clocksource: vf_pit_timer: Support shutdown mode
In-Reply-To: <1411575610-20895-1-git-send-email-stefan@agner.ch>
References: <1411575610-20895-1-git-send-email-stefan@agner.ch>
Message-ID: <1411575610-20895-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid waking up the system in a low power mode, the
clocksource should not generate interrupts anymore. Disable the PIT
timer interrupt when changing into the CLOCK_EVT_MODE_SHUTDOWN mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clocksource/vf_pit_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index a918bc4..eb354b4 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -89,10 +89,15 @@ static int pit_set_next_event(unsigned long delta,
 static void pit_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
+
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
 		pit_set_next_event(cycle_per_jiffy, evt);
 		break;
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		pit_timer_disable();
+		break;
 	default:
 		break;
 	}
-- 
2.1.0
