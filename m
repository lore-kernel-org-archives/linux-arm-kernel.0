From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 14:47:25 -0800
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Larry Bassel <lbassel@quicinc.com>

For 7x27 it is necessary to write to strongly
ordered memory after executing the coprocessor 15
instruction dmb instruction.

This is only for data barrier dmb().
Note that the test for 7x27 is done on all MSM platforms
(even ones such as 7201a whose kernel is distinct from
that of 7x25/7x27).

Acked-by: Willie Ruan <wruan@quicinc.com>
Signed-off-by: Larry Bassel <lbassel@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/include/asm/system.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 058e7e9..55d942b 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -3,6 +3,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/memory.h>
+
 #define CPU_ARCH_UNKNOWN	0
 #define CPU_ARCH_ARMv3		1
 #define CPU_ARCH_ARMv4		2
@@ -114,6 +116,10 @@ extern unsigned int user_debug;
 #define vectors_high()	(0)
 #endif
 
+#ifndef arch_barrier_extra
+#define arch_barrier_extra() do {} while (0)
+#endif
+
 #if __LINUX_ARM_ARCH__ >= 7
 #define isb() __asm__ __volatile__ ("isb" : : : "memory")
 #define dsb() __asm__ __volatile__ ("dsb" : : : "memory")
@@ -123,8 +129,9 @@ extern unsigned int user_debug;
 				    : : "r" (0) : "memory")
 #define dsb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" \
 				    : : "r" (0) : "memory")
-#define dmb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
-				    : : "r" (0) : "memory")
+#define dmb() do { __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
+					 : : "r" (0) : "memory"); \
+		arch_barrier_extra(); } while (0)
 #elif defined(CONFIG_CPU_FA526)
 #define isb() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
 				    : : "r" (0) : "memory")
-- 
1.6.3.3
