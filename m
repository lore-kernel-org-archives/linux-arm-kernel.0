From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jun 2017 16:35:12 +0100
Subject: [PATCH 1/2] arm64: avoid open-coding THREAD_SIZE{,_ORDER}
In-Reply-To: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
References: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1496849713-17078-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we define THREAD_SIZE_ORDER dependent on which arm64-specific
page size kconfig symbol was selected. This is unfortunate, as it hides
the relationship between THREAD_SIZE_ORDER and THREAD_SIZE, and makes it
painful more painful than necessary to modify the thread size as we will
need to do for some debug configurations.

This patch follows arch/metag's approach of consistently defining
THREAD_SIZE in terms of THREAD_SIZE_ORDER. This avoids having ifdefs for
particular page size configurations, and allows us to change a single
definition to change the thread size.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 46c3b93..4f42275 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -23,13 +23,17 @@
 
 #include <linux/compiler.h>
 
-#ifdef CONFIG_ARM64_4K_PAGES
-#define THREAD_SIZE_ORDER	2
-#elif defined(CONFIG_ARM64_16K_PAGES)
+#include <asm/page.h>
+
+#define THREAD_SHIFT		14
+
+#if THREAD_SHIFT >= PAGE_SHIFT
+#define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
+#else
 #define THREAD_SIZE_ORDER	0
 #endif
 
-#define THREAD_SIZE		16384
+#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 #define THREAD_START_SP		(THREAD_SIZE - 16)
 
 #ifndef __ASSEMBLY__
-- 
1.9.1
