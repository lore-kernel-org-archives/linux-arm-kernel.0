From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 Aug 2013 10:06:40 -0700
Subject: [PATCH 1/2] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <52138784.7050703@linaro.org>
References: <52138784.7050703@linaro.org>
Message-ID: <1377191201-14696-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On most ARM systems the per-cpu clockevents are truly per-cpu in
the sense that they can't be controlled on any other CPU besides
the CPU that they interrupt. If one of these clockevents were to
become a broadcast source we will run into a lot of trouble
because the broadcast source is enabled on the first CPU to go
into deep idle (if that CPU suffers from FEAT_C3_STOP) and that
could be a different CPU than what the clockevent is interrupting
(or even worse the CPU that the clockevent interrupts could be
offline).

Theoretically it's possible to support per-cpu clockevents as the
broadcast source but so far we haven't needed this and supporting
it is rather complicated. Let's just deny the possibility for now
until this becomes a reality (let's hope it never does!).

Reported-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/time/tick-broadcast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 218bcb5..d3539e5 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -77,6 +77,9 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
 	    !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return false;
 
+	if (cpumask_equal(newdev->cpumask, cpumask_of(smp_processor_id())))
+		return false;
+
 	return !curdev || newdev->rating > curdev->rating;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
