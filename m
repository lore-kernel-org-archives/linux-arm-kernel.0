From: yandong77520@gmail.com (Yandong.Zhao)
Date: Sat,  7 Jul 2018 12:02:51 +0800
Subject: [PATCH] arm64: neon: Do not access kernel_neon_busy with preemption
 enabled
Message-ID: <1530936171-16169-1-git-send-email-yandong77520@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yandong Zhao <yandong77520@gmail.com>

Dear, Dave
Thank you very much for reading my email. I have a question and
I hope toget your reply.
It is a bug to not close the preemption when executing
raw_cpu_read(kernel_neon_busy) in the function may_use_simd()!
We encountered a ?sysdump? problem on Kernel 4.14 code because
the program entered BUG_ON() in the function kernel_neon_begin().
Our analysis concludes that the process is migrating while executing
raw_cpu_read(kernel_neon_busy).

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..0d91084 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,20 +29,13 @@
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
+	 * instead. Because of the kernel_neon_busy here we have to make sure
+	 * that it is the current cpu.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1
