From: dave.martin@linaro.org (Dave Martin)
Date: Tue,  8 Feb 2011 11:01:25 +0000
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
Message-ID: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For v6, wfi is architected as a defined MCR instruction, so
use that definition.

Doing a no-op instead of wfi() is probably bad, so for older
processors than v6, wfi() is not defined.  If needed, some CPU-
specific wfi() will have to be defined elsewhere.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
--------------------------------------------------------------------
v2 notes:

The first version of this patch incorrectly specified the write
buffer drain MCR (c7, c5, 4) instead of WFI (c7, c0, 5).  Now fixed.
I hang my head in shame!

The first version of this patch attempted to define wfe() and sev()
to empty asms also for pre-v6K processors.  Having thought about
this some more, I think that it may be better to wait until this
is actually needed before attempting to define these to anything.
Having no definition (giving a build error) seems safer than
having a wrong definition.

 arch/arm/include/asm/system.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 97f6d60..f39cf09 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -129,6 +129,9 @@ extern unsigned int user_debug;
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#elif __LINUX_ARM_ARCH__ == 6
+#define wfi() __asm__ __volatile__ ("mcr p15, 0, %0, c7, c0, 4" \
+				    : : "r" (0) : "memory")
 #endif
 
 #if __LINUX_ARM_ARCH__ >= 7
-- 
1.7.1
