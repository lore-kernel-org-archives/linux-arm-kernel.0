From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Fri, 10 Aug 2012 14:57:34 -0700
Subject: [PATCH 1/2] ARM: local timers: Unmask interrupt before new TVAL is set
Message-ID: <1344635854-5033-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Level triggered interrupt is deasserted when a new TVAL is written
only when the interrupt is unmasked. Make sure that the interrupt
is unmasked in CTL register before TVAL is written.
If this order is not followed, there are chances that on some
hardware you would not receive any timer interrupts.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
---
 arch/arm/kernel/arch_timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index dd58035..1d0d9df 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -126,8 +126,8 @@ static int arch_timer_set_next_event(unsigned long evt,
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
-	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
 	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
 
 	return 0;
 }
-- 
Sent by an employee of the Qualcomm Innovation Center,Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
