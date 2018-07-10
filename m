From: yandong77520@gmail.com (Yandong.Zhao)
Date: Tue, 10 Jul 2018 10:21:40 +0800
Subject: [PATCH] arm64: neon: Fix function may_use_simd() return error status
Message-ID: <1531189300-26216-1-git-send-email-yandong77520@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yandong Zhao <yandong77520@gmail.com>

Operations for contexts where we do not want to do any checks for
preemptions.  Unless strictly necessary, always use this_cpu_read()
instead.  Because of the kernel_neon_busy here we have to make sure
that it is the current cpu.

Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
---
 arch/arm64/include/asm/simd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index fa8b3fe..8b97f8b 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,7 +29,8 @@
 static __must_check inline bool may_use_simd(void)
 {
 	/*
-	 * The raw_cpu_read() is racy if called with preemption enabled.
+	 * The this_cpu_read() is racy if called with preemption enabled,
+	 * since the task my subsequently migrate to another CPU.
 	 * This is not a bug: kernel_neon_busy is only set when
 	 * preemption is disabled, so we cannot migrate to another CPU
 	 * while it is set, nor can we migrate to a CPU where it is set.
@@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
 	 * false.
 	 */
 	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!raw_cpu_read(kernel_neon_busy);
+		!this_cpu_read(kernel_neon_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
1.9.1
