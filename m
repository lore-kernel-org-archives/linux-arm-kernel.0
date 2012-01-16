From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jan 2012 16:28:34 +0000
Subject: [PATCH] ARM: smp_twd: make sure timer is stopped before registration
Message-ID: <1326731314-24086-1-git-send-email-marc.zyngier@arm.com>
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
index 0feb728..0cc5427 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -237,6 +237,8 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	else
 		twd_calibrate_rate();
 
+	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);		
+
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_C3STOP;
-- 
1.7.7.1
