From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Dec 2012 15:11:07 +0000
Subject: [PATCHv2 08/11] arm: arch_timer: add arch_counter_set_user_access
In-Reply-To: <1355929870-30252-1-git-send-email-mark.rutland@arm.com>
References: <1355929870-30252-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1355929870-30252-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several bits in CNTKCTL reset to 0, including PL0VTEN. For platforms
using the generic timer which wish to have a fast gettimeofday vDSO
implementation, these bits must be set to 1 by the kernel. On other
platforms, the bootloader might enable userspace access when we don't
want it.

This patch adds arch_counter_set_user_access, which sets the PL0 access
permissions to that required by the platform. For arm, this currently
means disabling all userspace access.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/arch_timer.h |   11 +++++++++++
 arch/arm/kernel/arch_timer.c      |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 701f2b7..05e3593 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -108,6 +108,17 @@ static inline u64 arch_counter_get_cntvct(void)
 	return cval;
 }
 
+static inline void __cpuinit arch_counter_set_user_access(void)
+{
+	u32 cntkctl;
+
+	asm volatile("mrc p15, 0, %0, c14, c1, 0" : "=r" (cntkctl));
+
+	/* disable user access to everything */
+	cntkctl &= ~((3 << 8) | (7 << 0));
+
+	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
+}
 
 #else
 static inline int arch_timer_of_register(void)
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 834d347..4f39e68 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -155,6 +155,8 @@ static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
 			enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
 	}
 
+	arch_counter_set_user_access();
+
 	return 0;
 }
 
-- 
1.7.0.4
