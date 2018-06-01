From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:17 +0100
Subject: [PATCH 03/33] thread_info: Add update_thread_flag() helpers
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/sched.h       |  6 ++++++
 include/linux/thread_info.h | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..c2c305199721 100644
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
index cf2862bd134a..8d8821b3689a 100644
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
2.17.1
