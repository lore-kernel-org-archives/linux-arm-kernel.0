From: fkan@apm.com (Feng Kan)
Date: Tue, 23 Jul 2013 10:52:31 -0700
Subject: [PATCH] arm64: Change kernel stack size to 16K.
Message-ID: <1374601951-4091-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Written by Catalin Marinas, tested by APM on storm platform. This is needed 
because of the failures encountered when running SpecWeb benchmark test.

Signed-off-by: Feng Kan <fkan@apm.com>
Acked-by: Kumar Sankaran <ksankaran@apm.com>
---
 arch/arm64/include/asm/thread_info.h |    4 ++--
 arch/arm64/kernel/entry.S            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 3659e46..23a3c47 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -24,10 +24,10 @@
 #include <linux/compiler.h>
 
 #ifndef CONFIG_ARM64_64K_PAGES
-#define THREAD_SIZE_ORDER	1
+#define THREAD_SIZE_ORDER	2
 #endif
 
-#define THREAD_SIZE		8192
+#define THREAD_SIZE		16384
 #define THREAD_START_SP		(THREAD_SIZE - 16)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1d13142..6ad781b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -121,7 +121,7 @@
 
 	.macro	get_thread_info, rd
 	mov	\rd, sp
-	and	\rd, \rd, #~((1 << 13) - 1)	// top of 8K stack
+	and	\rd, \rd, #~(THREAD_SIZE - 1)	// top of stack
 	.endm
 
 /*
-- 
1.7.6.1
