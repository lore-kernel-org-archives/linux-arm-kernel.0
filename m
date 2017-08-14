From: thgarnie@google.com (Thomas Garnier)
Date: Mon, 14 Aug 2017 14:37:29 -0700
Subject: [PATCH v3 1/4] syscalls: Use CHECK_DATA_CORRUPTION for
 addr_limit_user_check
Message-ID: <20170814213732.104301-1-thgarnie@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use CHECK_DATA_CORRUPTION instead of BUG_ON to provide more flexibility
on address limit failures. By default, send a SIGKILL signal to kill the
current process preventing exploitation of a bad address limit.

Make the TIF_FSCHECK flag optional so ARM can use this function.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 include/linux/syscalls.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 88951b795ee3..65e273aadada 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -219,21 +219,25 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	}								\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
-#ifdef TIF_FSCHECK
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
  * address limit different than USER_DS can allow to overwrite kernel memory.
  */
 static inline void addr_limit_user_check(void)
 {
-
+#ifdef TIF_FSCHECK
 	if (!test_thread_flag(TIF_FSCHECK))
 		return;
+#endif
 
-	BUG_ON(!segment_eq(get_fs(), USER_DS));
+	if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+				  "Invalid address limit on user-mode return"))
+		force_sig(SIGKILL, current);
+
+#ifdef TIF_FSCHECK
 	clear_thread_flag(TIF_FSCHECK);
-}
 #endif
+}
 
 asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
 			       qid_t id, void __user *addr);
-- 
2.14.1.480.gb18f417b89-goog
