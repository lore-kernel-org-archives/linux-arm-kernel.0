From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 19 Oct 2010 16:39:07 +0200
Subject: [PATCH 12/12] ARM: shark: Convert leds_lock to raw_spinlock
In-Reply-To: <20101019143717.GH11713@pengutronix.de>
References: <20101019143717.GH11713@pengutronix.de>
Message-ID: <1287499147-13846-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

leds_lock needs to be a real spinlock on preempt-rt. Convert it to a
raw_spinlock. No change for !RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-shark/leds.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shark/leds.c b/arch/arm/mach-shark/leds.c
index c9e32de..ccd4918 100644
--- a/arch/arm/mach-shark/leds.c
+++ b/arch/arm/mach-shark/leds.c
@@ -36,7 +36,7 @@ static char led_state;
 static short hw_led_state;
 static short saved_state;
 
-static DEFINE_SPINLOCK(leds_lock);
+static DEFINE_RAW_SPINLOCK(leds_lock);
 
 short sequoia_read(int addr) {
   outw(addr,0x24);
@@ -52,7 +52,7 @@ static void sequoia_leds_event(led_event_t evt)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&leds_lock, flags);
+	raw_spin_lock_irqsave(&leds_lock, flags);
 
 	hw_led_state = sequoia_read(0x09);
 
@@ -144,7 +144,7 @@ static void sequoia_leds_event(led_event_t evt)
 	if  (led_state & LED_STATE_ENABLED)
 		sequoia_write(hw_led_state,0x09);
 
-	spin_unlock_irqrestore(&leds_lock, flags);
+	raw_spin_unlock_irqrestore(&leds_lock, flags);
 }
 
 static int __init leds_init(void)
-- 
1.7.2.3
