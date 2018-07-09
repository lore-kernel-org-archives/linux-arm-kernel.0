From: yandong77520@gmail.com (Yandong.Zhao)
Date: Mon,  9 Jul 2018 20:19:43 +0800
Subject: [PATCH] arm64: neon: Add preemption protection for kernel_neon_busy
Message-ID: <1531138783-21418-1-git-send-email-yandong77520@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yandong Zhao <yandong77520@gmail.com>

Dear Dave,

The scenario for this bug is:
The A process is sched out when the CPU0 executes the function
raw_cpu_read(kernel_neon_busy) and just gets the address of
kernel_neon_busy without reading.
The B process starts running kernel_neon_begin() on CPU0, and the variable
kernel_neon_busy on CPU0 becomes true. At this time, the A process is
executed on CPU1 and the kernel_neon_busy value is CPU0 (true),so BUG_ON()!

crash64> kernel_neon_busy
PER-CPU DATA TYPE:
  bool kernel_neon_busy;
PER-CPU ADDRESSES:
  [0]: ffffffc07fee30a0
  [1]: ffffffc07fef90a0
  [2]: ffffffc07ff0f0a0
  [3]: ffffffc07ff250a0

          CPU0                                       CPU1
           |                                          |
A task have get addr ffffffc07fee30a0                 |
      and sched out                                   |
           |                                          |
B task kernel_neon_begin()                            |
	[ffffffc07fee30a0]=1                              |
           |                                          |
           |                               A task sched in and read
		   |                            [ffffffc07fee30a0]==1,so BUG_ON.
           |                                          |
B task kernel_neon_end()                              |
 [ffffffc07fee30a0]=0                                 |
           |                                          |

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..6580dcd 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,12 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
-	 * This is not a bug: kernel_neon_busy is only set when
-	 * preemption is disabled, so we cannot migrate to another CPU
-	 * while it is set, nor can we migrate to a CPU where it is set.
-	 * So, if we find it clear on some CPU then we're guaranteed to
-	 * find it clear on any CPU we could migrate to.
-	 *
-	 * If we are in between kernel_neon_begin()...kernel_neon_end(),
-	 * the flag will be set, but preemption is also disabled, so we
-	 * can't migrate to another CPU and spuriously see it become
-	 * false.
+	 * Operations for contexts where we do not want to do any checks for
+	 * preemptions.  Unless strictly necessary, always use this_cpu_*()
+	 * instead.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1
