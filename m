From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Dec 2015 16:54:32 +0000
Subject: [PATCH] arm64: cmpxchg: Don't incldue linux/mmdebug.h
In-Reply-To: <E1a6wEp-0000hU-7o@optimist>
References: <E1a6wEp-0000hU-7o@optimist>
Message-ID: <1449766472-15359-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 asm/cmpxchg.h includes linux/mmdebug.h but doesn't so far as I
can tell actually use anything from it.  Removing the inclusion reduces
spurious header dependency rebuilds and also avoids issues with
recursive inclusions of headers causing build breaks due to attempts to
use things before they are defined if linux/mmdebug.h starts pulling in
more low level headers.

Such errors have happened in -next recently, for example:

In file included from include/linux/completion.h:11:0,
                 from include/linux/rcupdate.h:43,
                 from include/linux/tracepoint.h:19,
                 from include/linux/mmdebug.h:6,
                 from ./arch/arm64/include/asm/cmpxchg.h:22,
                 from ./arch/arm64/include/asm/atomic.h:41,
                 from include/linux/atomic.h:4,
                 from include/linux/spinlock.h:406,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/uapi/linux/timex.h:56,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
include/linux/wait.h: In function 'wait_on_atomic_t':
include/linux/wait.h:1218:2: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
 if (atomic_read(val) == 0)

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cmpxchg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 9ea611ea69df..510c7b404454 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -19,7 +19,6 @@
 #define __ASM_CMPXCHG_H
 
 #include <linux/bug.h>
-#include <linux/mmdebug.h>
 
 #include <asm/atomic.h>
 #include <asm/barrier.h>
-- 
2.6.2
