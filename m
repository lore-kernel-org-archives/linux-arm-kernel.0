From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri,  4 Sep 2015 14:23:07 +0000
Subject: [RFC PATCH 3/3] arm64: Reduce kernel stack size when using IRQ stack
In-Reply-To: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
References: <1441376587-12979-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <1441376587-12979-4-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is a principal objective of IRQ stack feature to reduce kernel
stack size. Therefore, the size is set to 8KB when a separate IRQ
stack is active.

Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/include/asm/thread_info.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 5345a67..e79210d 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -24,10 +24,18 @@
 #include <linux/compiler.h>
 
 #ifndef CONFIG_ARM64_64K_PAGES
+#ifdef CONFIG_IRQ_STACK
+#define THREAD_SIZE_ORDER	1
+#else
 #define THREAD_SIZE_ORDER	2
 #endif
+#endif
 
+#ifdef CONFIG_IRQ_STACK
+#define THREAD_SIZE		8192
+#else
 #define THREAD_SIZE		16384
+#endif
 #define THREAD_START_SP		(THREAD_SIZE - 16)
 
 #ifndef __ASSEMBLY__
-- 
1.9.1
