From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 12 Feb 2013 17:12:17 +0000
Subject: [PATCH] HACK: ARM: Fix generic timer broadcast for TWD
In-Reply-To: <20130212155516.GP17833@n2100.arm.linux.org.uk>
References: <1360684194-10894-1-git-send-email-thierry.reding@avionic-design.de>
 <20130212155516.GP17833@n2100.arm.linux.org.uk>
Message-ID: <20130212171217.GB13775@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> So, things to be done here:
> 1. Fix the #else part of the code.
> 2. Fix the reported oops.

I believe the patch below solves point 1. Nothing refers to smp_timer_broadcast
any more (as I've tested with git grep), so removing it shouldn't create any
additional problems.

Russell, are you happy for me to drop this in the patch system?

Thanks,
Mark.

---->8----
>From 1954a075d0ce7f5ce5466b20f7aee9a0ac044cda Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 12 Feb 2013 16:50:18 +0000
Subject: [PATCH] arm: remove unused smp_timer_broadcast #define

The assignment of clock_event_device::broadcast can be done by timer
core as of 12ad100046: "clockevents: Add generic timer broadcast
function", and the arm code moved over to this as of 3d06770eef: "arm:
Add generic timer broadcast support", but left a dangling #define when
!CONFIG_GENERIC_TIMER_BROADCAST.

This patch removes the now unused #define.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/kernel/smp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index b7e3b50..ab9458d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -480,8 +480,6 @@ void tick_broadcast(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_TIMER);
 }
-#else
-#define smp_timer_broadcast	NULL
 #endif
 
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
-- 
1.8.1.1
