From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Nov 2013 15:26:16 -0800
Subject: [PATCH 08/17] ARM: msm: Switch to sched_clock_register()
In-Reply-To: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1384557985-9414-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 1e9c338..fd16449 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -187,7 +187,7 @@ static struct notifier_block msm_timer_cpu_nb = {
 	.notifier_call = msm_timer_cpu_notify,
 };
 
-static notrace u32 msm_sched_clock_read(void)
+static u64 notrace msm_sched_clock_read(void)
 {
 	return msm_clocksource.read(&msm_clocksource);
 }
@@ -229,7 +229,7 @@ err:
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
