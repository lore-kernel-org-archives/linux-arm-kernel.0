From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jan 2014 17:30:07 -0800
Subject: [PATCH] ARM: footbridge: Switch to sched_clock_register()
Message-ID: <1389922207-5154-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface supports 64 bits since 3.13-rc1.
Upgrade to the 64 bit function to allow us to remove the 32 bit
registration interface.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Based on rmk/for-next

 arch/arm/mach-footbridge/dc21285-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 3971104d32d4..5d2725fd878c 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -125,7 +125,7 @@ void __init footbridge_timer_init(void)
 	clockevents_config_and_register(ce, rate, 0x4, 0xffffff);
 }
 
-static u32 notrace footbridge_read_sched_clock(void)
+static u64 notrace footbridge_read_sched_clock(void)
 {
 	return ~*CSR_TIMER3_VALUE;
 }
@@ -138,5 +138,5 @@ void __init footbridge_sched_clock(void)
 	*CSR_TIMER3_CLR = 0;
 	*CSR_TIMER3_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV16;
 
-	setup_sched_clock(footbridge_read_sched_clock, 24, rate);
+	sched_clock_register(footbridge_read_sched_clock, 24, rate);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
