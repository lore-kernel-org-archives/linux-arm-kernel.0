From: geoff@infradead.org (Geoff Levand)
Date: Fri, 03 Jun 2016 18:13:40 +0000
Subject: [PATCH v17 02/13] arm64: Add cpus_are_stuck_in_kernel
In-Reply-To: <cover.1464974516.git.geoff@infradead.org>
References: <cover.1464974516.git.geoff@infradead.org>
Message-ID: <d4f8c7961adc4b0afe733306fbc21e5bb7c8f6ee.1464974516.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Morse <james.morse@arm.com>

kernel/smp.c has a fancy counter that keeps track of the number of CPUs
it marked as not-present and left in cpu_park_loop(). If there are any
CPUs spinning in here, kexec will release them once the memory is re-used
by the new kernel.

We can't return an error once we reach machine_kexec(), so as a sanity check
we forbid kexec images to be loaded if there are already cpus stuck in the
kernel, or we have multiple cpus and no way of disabling them.

Signed-off-by: James Morse <james.morse@arm.com>
[Split off from a larger patch]
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/smp.h | 10 ++++++++++
 arch/arm64/kernel/smp.c      |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 433e504..38712f4 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -124,6 +124,16 @@ static inline void cpu_panic_kernel(void)
 	cpu_park_loop();
 }
 
+/*
+ * If a secondary CPU fails to come online, (e.g. due to mismatched features),
+ * it will try to call cpu_die(). If this fails, it updates
+ * cpus_stuck_in_kernel and sits in cpu_park_loop().
+ *
+ * Kexec checks this counter and refuses to load/kexec if it is non-zero, as
+ * cpu_park_loop() would be overwritten releasing the parked cpus.
+ */
+bool cpus_are_stuck_in_kernel(void);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 678e084..d0bcd55 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -909,3 +909,8 @@ int setup_profiling_timer(unsigned int multiplier)
 {
 	return -EINVAL;
 }
+
+bool cpus_are_stuck_in_kernel(void)
+{
+	return !!cpus_stuck_in_kernel;
+}
-- 
2.5.0
