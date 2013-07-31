From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 31 Jul 2013 15:31:07 -0700
Subject: [PATCH 08/18] ARM: msm: Switch to sched_clock_register()
In-Reply-To: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
References: <1375309877-16617-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1375309877-16617-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index b6418fd..3c9b4da 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -170,7 +170,7 @@ static struct local_timer_ops msm_local_timer_ops __cpuinitdata = {
 };
 #endif /* CONFIG_LOCAL_TIMERS */
 
-static notrace u32 msm_sched_clock_read(void)
+static u64 notrace msm_sched_clock_read(void)
 {
 	return msm_clocksource.read(&msm_clocksource);
 }
@@ -215,7 +215,7 @@ err:
 	res = clocksource_register_hz(cs, dgt_hz);
 	if (res)
 		pr_err("clocksource_register failed\n");
-	setup_sched_clock(msm_sched_clock_read, sched_bits, dgt_hz);
+	sched_clock_register(msm_sched_clock_read, sched_bits, dgt_hz);
 }
 
 #ifdef CONFIG_OF
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
