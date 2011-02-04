From: dave.martin@linaro.org (Dave Martin)
Date: Fri,  4 Feb 2011 14:20:43 +0000
Subject: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-v7 processors
Message-ID: <1296829243-21313-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pre-v7 processors don't have wfe/sev, so these are defined for
consistency as empty barrier asms.

For v6, wfi is architected as a defined MCR instruction, so
use that definition.

Doing a no-op instead of wfi() is probably bad, so for older
processors than v6, wfi() is not defined.  If needed, some CPU-
specific wfi() will have to be defined elsewhere.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/system.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 97f6d60..0e1cae3 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -129,7 +129,14 @@ extern unsigned int user_debug;
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#else /* __LINUX_ARM_ARCH__ < 7 */
+#define sev()	__asm__ __volatile__ ("" : : : "memory")
+#define wfe()	__asm__ __volatile__ ("" : : : "memory")
+#if __LINUX_ARM_ARCH__ == 6
+#define wfi()	__asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4" \
+					: : "r" (0) : "memory")
 #endif
+#endif /* __LINUX_ARM_ARCH__ < 7 */
 
 #if __LINUX_ARM_ARCH__ >= 7
 #define isb() __asm__ __volatile__ ("isb" : : : "memory")
-- 
1.7.1
