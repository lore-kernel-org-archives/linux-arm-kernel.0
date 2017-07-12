From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Jul 2017 23:33:00 +0100
Subject: [RFC PATCH 3/6] arm64: pad stacks to PAGE_SIZE for VMAP_STACK
In-Reply-To: <1499898783-25732-1-git-send-email-mark.rutland@arm.com>
References: <1499898783-25732-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1499898783-25732-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our THREAD_SIZE may be smaller than PAGE_SIZE. With VMAP_STACK, we can't
allow stacks to share a page with anything else, so may as well pad
up-to PAGE_SIZE, and have 64K stacks when we have 64K pages.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6d0c59a..3684f86 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -25,7 +25,13 @@
 
 #include <asm/page.h>
 
-#define THREAD_SHIFT		14
+#define __THREAD_SHIFT		14
+
+#if defined(CONFIG_VMAP_STACK) && (__THREAD_SHIFT < PAGE_SHIFT)
+#define THREAD_SHIFT		PAGE_SHIFT
+#else
+#define THREAD_SHIFT		__THREAD_SHIFT
+#endif
 
 #if THREAD_SHIFT >= PAGE_SHIFT
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
-- 
1.9.1
