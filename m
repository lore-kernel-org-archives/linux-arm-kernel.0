From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 14:31:27 +0000
Subject: [PATCH] ARM: smp_twd: make sure timer is stopped before registering it
Message-ID: <1324564287-1742-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On secondary CPUs, the Timer Control Register is not reset
to a sane value before the timer is registered, and the TRM
doesn't seem to indicate any reset value either. In some cases,
the kernel will take an interrupt too early, depending on what
junk was present in the registers at reset time.

The fix is to set the Timer Control Register to 0 before
registering the clock_event_device and enabling the interrupt.

Problem seen on VE (Cortex A5) and Tegra.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/smp_twd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a8a6682..2442bbb 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -167,6 +167,8 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	twd_calibrate_rate();
 
+	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);		
+
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_C3STOP;
-- 
1.7.7.1
