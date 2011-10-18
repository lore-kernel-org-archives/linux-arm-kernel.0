From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 18 Oct 2011 16:34:02 -0700
Subject: [PATCH 3/3] ARM 4Kstacks: Decrease poll and select stack usage, when
	using 4K stacks
In-Reply-To: <4E9E0B71.9020708@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
Message-ID: <4E9E0CEA.6030102@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce the max allowed size for struct poll_wqueue to avoid
using too much stack space in do_select() and do_sys_poll(),
when the kernel is using 4K stacks.

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
---
 include/linux/poll.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/poll.h b/include/linux/poll.h
index cf40010..b7153a3 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -16,7 +16,11 @@
 extern struct ctl_table epoll_table[]; /* for sysctl */
 /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
    additional memory. */
+#ifndef CONFIG_4KSTACKS
 #define MAX_STACK_ALLOC 832
+#else
+#define MAX_STACK_ALLOC 448
+#endif
 #define FRONTEND_STACK_ALLOC	256
 #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
 #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
-- 
1.6.6
