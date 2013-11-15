From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Nov 2013 15:26:20 -0800
Subject: [PATCH 12/17] ARM: sa1100: Switch to sched_clock_register()
In-Reply-To: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1384557985-9414-13-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-sa1100/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 713c86c..6fd4acb 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -20,7 +20,7 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
-static u32 notrace sa1100_read_sched_clock(void)
+static u64 notrace sa1100_read_sched_clock(void)
 {
 	return readl_relaxed(OSCR);
 }
@@ -122,7 +122,7 @@ void __init sa1100_timer_init(void)
 	writel_relaxed(0, OIER);
 	writel_relaxed(OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3, OSSR);
 
-	setup_sched_clock(sa1100_read_sched_clock, 32, 3686400);
+	sched_clock_register(sa1100_read_sched_clock, 32, 3686400);
 
 	ckevt_sa1100_osmr0.cpumask = cpumask_of(0);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
