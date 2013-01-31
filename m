From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:32 +0000
Subject: [PATCHv5 09/16] arm: arch_timer: add arch_counter_set_user_access
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-10-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several bits in CNTKCTL reset to 0, including PL0VTEN. For architectures
using the generic timer which wish to have a fast gettimeofday vDSO
implementation, these bits must be set to 1 by the kernel. For
architectures without a vDSO, it's best to leave the bits set to 0 for
now to ensure that if and when support is added, it's implemented sanely
architecture wide.

As the bootloader might set PL0VTEN to a value that doesn't correspond
to that which the kernel prefers, we must explicitly set it to the
architecture port's preferred value.

This patch adds arch_counter_set_user_access, which sets the PL0 access
permissions to that required by the architecture. For arch/arm, this
currently means disabling all userspace access.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/arch_timer.h | 12 ++++++++++++
 arch/arm/kernel/arch_timer.c      |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 75975d9..729f6d9 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -106,6 +106,18 @@ static inline u64 arch_counter_get_cntvct(void)
 	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cval));
 	return cval;
 }
+
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
 {
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c8dfec0..94f5033 100644
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
1.8.1.1
