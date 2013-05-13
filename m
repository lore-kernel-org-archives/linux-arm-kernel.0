From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 May 2013 12:26:05 -0700
Subject: [PATCHv6 01/11] clockevents: Prefer CPU local devices over global
 devices
In-Reply-To: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
References: <1368473175-4841-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1368473175-4841-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On an SMP system with only one global clockevent and a dummy
clockevent per CPU we run into problems. We want the dummy
clockevents to be registered as the per CPU tick devices, but
we can only achieve that if we register the dummy clockevents
before the global clockevent or if we artificially inflate the
rating of the dummy clockevents to be higher than the rating
of the global clockevent. Failure to do so leads to boot
hangs when the dummy timers are registered on all other CPUs
besides the CPU that accepted the global clockevent as its tick
device and there is no broadcast timer to poke the dummy
devices.

If we're registering multiple clockevents and one clockevent is
global and the other is local to a particular CPU we should
choose to use the local clockevent regardless of the rating of
the device. This way, if the clockevent is a dummy it will take
the tick device duty as long as there isn't a higher rated tick
device and any global clockevent will be bumped out into
broadcast mode, fixing the problem described above.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/time/tick-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 5d3fb10..3da62de 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -254,9 +254,10 @@ static int tick_check_new_device(struct clock_event_device *newdev)
 		    !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
 			goto out_bc;
 		/*
-		 * Check the rating
+		 * Check the rating, but prefer CPU local devices
 		 */
-		if (curdev->rating >= newdev->rating)
+		if (curdev->rating >= newdev->rating &&
+		    cpumask_equal(curdev->cpumask, newdev->cpumask))
 			goto out_bc;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
