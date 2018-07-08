From: yandong77520@gmail.com (Yandong.Zhao)
Date: Sun,  8 Jul 2018 12:19:21 +0800
Subject: [PATCH] arm64: neon: This is a bug
Message-ID: <1531023561-24195-1-git-send-email-yandong77520@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yandong Zhao <yandong77520@gmail.com>

Dear, Dave.Martin

This is a bug that calls may_use_busy() when preemption is enabled.

We encountered a ?sysdump? problem on Kernel 4.14 code, calling
may_use_simd() in the function kernel_neon_begin() return null.
Our analysis concludes that the thread is migrating while executing
raw_cpu_read(kernel_neon_busy).

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 17 +++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..0d91084 100644
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
+	 * instead. The 'kernel_neon_busy' here must be the current cpu.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1
