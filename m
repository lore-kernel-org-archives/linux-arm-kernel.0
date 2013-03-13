From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Mar 2013 14:36:48 +0530
Subject: [PATCH] ARM: smp: Allow real broadcast device selection instead of
 always dummy
Message-ID: <1363165608-13739-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent arm broadcast time clean-up from Mark Rutland, the dummy
broadcast device is always registered with timer subsystem. And since
the rating of the dummy clock event is very high, it is preferred
over a real broad-cast clock event.

This is a change in behavior from past and not an intended
one. So reduce the rating of the dummy clockevent so that
real broadcast device is selected when available.

Without this all the C states with C3STOP won't work since
the broad cast notifier will take an abort.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Its a regression so hopefully can get into the 3.9-rcx. Noticed
this one on A15 platform. A9 platform the issue may not be seen
since the local timer check avoids dummy timer registration.

 arch/arm/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 31644f1..79078ed 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -480,7 +480,7 @@ static void __cpuinit broadcast_timer_setup(struct clock_event_device *evt)
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
 			  CLOCK_EVT_FEAT_PERIODIC |
 			  CLOCK_EVT_FEAT_DUMMY;
-	evt->rating	= 400;
+	evt->rating	= 100;
 	evt->mult	= 1;
 	evt->set_mode	= broadcast_timer_set_mode;
 
-- 
1.7.9.5
