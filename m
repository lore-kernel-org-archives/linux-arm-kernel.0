From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 1 May 2013 20:27:38 +0100
Subject: [PATCH 1/3] arm_arch_timer: introduce arch_timer_stolen_ticks
In-Reply-To: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
Message-ID: <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a function, called arch_timer_stolen_ticks, called from the
arch_timer interrupt handler to account for stolen ticks.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: linux at arm.linux.org.uk
CC: john.stultz at linaro.org
CC: catalin.marinas at arm.com
CC: marc.zyngier at arm.com
---
 arch/arm/include/asm/arch_timer.h    |    5 +++++
 drivers/clocksource/arm_arch_timer.c |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 7ade91d..30db413 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -13,6 +13,11 @@
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
 
+/* per-platform function to calculate stolen ticks (clock cycles stolen
+ * to the vcpu by the hypervisor).
+ */
+extern void (*arch_timer_stolen_ticks)(void);
+
 /*
  * These register accessors are marked inline so the compiler can
  * nicely work out which register we want, and chuck away the rest of
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d7ad425..d1ddf0b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -37,6 +37,8 @@ static int arch_timer_ppi[MAX_TIMER_PPI];
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
+void (*arch_timer_stolen_ticks)(void);
+
 static bool arch_timer_use_virtual = true;
 
 /*
@@ -52,6 +54,10 @@ static inline irqreturn_t timer_handler(const int access,
 		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
 		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
 		evt->event_handler(evt);
+
+		if ( arch_timer_stolen_ticks != NULL )
+			arch_timer_stolen_ticks();
+
 		return IRQ_HANDLED;
 	}
 
-- 
1.7.2.5
