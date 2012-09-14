From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Fri, 14 Sep 2012 15:29:23 -0700
Subject: [PATCH v2 1/2] ARM: arch timer: Set the TVAL before timer is enabled
Message-ID: <1347661764-3934-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some hardware, the timer deasserts the interrupt when a
new TVAL is written only when the enable bit is cleared.
Hence explicitly disable the timer and then program the
TVAL followed by enabling the timer.
If this order is not followed, there are chances that
you would not receive any timer interrupts.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
---
 arch/arm/kernel/arch_timer.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c04c2a6..8672a75 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -206,9 +206,10 @@ static inline void set_next_event(const int access, unsigned long evt)
 {
 	unsigned long ctrl;
 	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
-	ctrl |= ARCH_TIMER_CTRL_ENABLE;
-	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+	ctrl &= ~(ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK);
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
 	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
