From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 24 May 2018 17:56:31 +0100
Subject: [PATCH v11 02/19] thread_info: Add update_thread_flag() helpers
In-Reply-To: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
References: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1527181008-13549-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a number of bits of code sprinkled around the kernel to
set a thread flag if a certain condition is true, and clear it
otherwise.

To help make those call sites terser and less cumbersome, this
patch adds a new family of thread flag manipulators

	update*_thread_flag([...,] flag, cond)

which do the equivalent of:

	if (cond)
		set*_thread_flag([...,] flag);
	else
		clear*_thread_flag([...,] flag);

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched.h       |  6 ++++++
 include/linux/thread_info.h | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f..c2c3051 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1578,6 +1578,12 @@ static inline void clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 	clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
+static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
+					  bool value)
+{
+	update_ti_thread_flag(task_thread_info(tsk), flag, value);
+}
+
 static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index cf2862b..8d8821b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -60,6 +60,15 @@ static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
 	clear_bit(flag, (unsigned long *)&ti->flags);
 }
 
+static inline void update_ti_thread_flag(struct thread_info *ti, int flag,
+					 bool value)
+{
+	if (value)
+		set_ti_thread_flag(ti, flag);
+	else
+		clear_ti_thread_flag(ti, flag);
+}
+
 static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
 {
 	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
@@ -79,6 +88,8 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 	set_ti_thread_flag(current_thread_info(), flag)
 #define clear_thread_flag(flag) \
 	clear_ti_thread_flag(current_thread_info(), flag)
+#define update_thread_flag(flag, value) \
+	update_ti_thread_flag(current_thread_info(), flag, value)
 #define test_and_set_thread_flag(flag) \
 	test_and_set_ti_thread_flag(current_thread_info(), flag)
 #define test_and_clear_thread_flag(flag) \
-- 
2.1.4
