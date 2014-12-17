From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 17 Dec 2014 20:53:43 +0100
Subject: [PATCH] ARM: at91/pit: don't suspend/resume if unused
Message-ID: <1418846023-8581-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Waiting for PIT to stop counting takes a long time:
  1/(Master clock/prescaler/PIVR)
= 1/(133 MHz     /16       /2^20)
= 126 ms

Up to 126 ms if master clock is set to 133 MHz, skipping suspend/resume
of the unused PIT device reduce (suspend time + resume time) from ~140 ms
to ~17 ms.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 arch/arm/mach-at91/at91sam926x_time.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index e3344b4..44526aa 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -106,6 +106,10 @@ pit_clkevt_mode(enum clock_event_mode mode, struct clock_event_device *dev)
 
 static void at91sam926x_pit_suspend(struct clock_event_device *cedev)
 {
+	/* Don't suspend PIT if unused */
+	if (cedev->mode == CLOCK_EVT_MODE_UNUSED)
+		return;
+
 	/* Disable timer */
 	pit_write(AT91_PIT_MR, 0);
 }
@@ -125,6 +129,10 @@ static void at91sam926x_pit_reset(void)
 
 static void at91sam926x_pit_resume(struct clock_event_device *cedev)
 {
+	/* Don't resume PIT if unused */
+	if (cedev->mode == CLOCK_EVT_MODE_UNUSED)
+		return;
+
 	at91sam926x_pit_reset();
 }
 
-- 
2.1.3
