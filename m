From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sat,  1 Jun 2013 23:39:39 -0700
Subject: [PATCHv2 2/6] ARM: sched_clock: Return suspended count earlier
In-Reply-To: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1370155183-31421-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're suspended and sched_clock() is called we're going to
read the hardware one more time and throw away that value and
return back the cached value we saved during the suspend
callback. This is wasteful. Let's short circuit all that and
return the cached value as early as possible if we're suspended.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/sched_clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index 45efe86..a781c59 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -55,9 +55,6 @@ static unsigned long long notrace cyc_to_sched_clock(u32 cyc, u32 mask)
 	u64 epoch_ns;
 	u32 epoch_cyc;
 
-	if (cd.suspended)
-		return cd.epoch_ns;
-
 	/*
 	 * Load the epoch_cyc and epoch_ns atomically.  We do this by
 	 * ensuring that we always write epoch_cyc, epoch_ns and
@@ -174,6 +171,9 @@ unsigned long long __read_mostly (*sched_clock_func)(void) = sched_clock_32;
 
 unsigned long long notrace sched_clock(void)
 {
+	if (cd.suspended)
+		return cd.epoch_ns;
+
 	return sched_clock_func();
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
