From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Mar 2015 10:40:38 -0400
Subject: [PATCH v2] ring-buffer: Replace this_cpu_*() with __this_cpu_*()
In-Reply-To: <20150317101113.32f5618a@gandalf.local.home>
References: <20150316173154.537b80ee@gandalf.local.home>
 <alpine.DEB.2.11.1503170049300.9309@gentwo.org>
 <20150317081341.0f9a8b4c@gandalf.local.home>
 <20150317101113.32f5618a@gandalf.local.home>
Message-ID: <20150317104038.312e73d1@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has come to my attention that this_cpu_read/write are horrible on
architectures other than x86. Worse yet, they actually disable
preemption or interrupts! This caused some unexpected tracing results
on ARM.

   101.356868: preempt_count_add <-ring_buffer_lock_reserve
   101.356870: preempt_count_sub <-ring_buffer_lock_reserve

The ring_buffer_lock_reserve has recursion protection that requires
accessing a per cpu variable. But since preempt_disable() is traced, it
too got traced while accessing the variable that is suppose to prevent
recursion like this.

The generic version of this_cpu_read() and write() are:

#define _this_cpu_generic_read(pcp)					\
({	typeof(pcp) ret__;						\
	preempt_disable();						\
	ret__ = *this_cpu_ptr(&(pcp));					\
	preempt_enable();						\
	ret__;								\
})

#define _this_cpu_generic_to_op(pcp, val, op)				\
do {									\
	unsigned long flags;						\
	raw_local_irq_save(flags);					\
	*__this_cpu_ptr(&(pcp)) op val;					\
	raw_local_irq_restore(flags);					\
} while (0)


Which is unacceptable for locations that know they are within preempt
disabled or interrupt disabled locations.

Paul McKenney stated that __this_cpu_() versions produce much better code on
other architectures than this_cpu_() does, if we know that the call is done in
a preempt disabled location.

I also changed the recursive_unlock() to use two local variables instead
of accessing the per_cpu variable twice.

Link: http://lkml.kernel.org/r/20150317114411.GE3589 at linux.vnet.ibm.com

Cc: stable at vger.kernel.org
Cc: Christoph Lameter <cl@linux.com>
Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1:
  Use __this_cpu_*() instead of this_cpu_ptr()

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5040d44fe5a3..363b9ec58aae 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2679,7 +2679,7 @@ static DEFINE_PER_CPU(unsigned int, current_context);
 
 static __always_inline int trace_recursive_lock(void)
 {
-	unsigned int val = this_cpu_read(current_context);
+	unsigned int val = __this_cpu_read(current_context);
 	int bit;
 
 	if (in_interrupt()) {
@@ -2696,18 +2696,19 @@ static __always_inline int trace_recursive_lock(void)
 		return 1;
 
 	val |= (1 << bit);
-	this_cpu_write(current_context, val);
+	__this_cpu_write(current_context, val);
 
 	return 0;
 }
 
 static __always_inline void trace_recursive_unlock(void)
 {
-	unsigned int val = this_cpu_read(current_context);
+	unsigned int val = __this_cpu_read(current_context);
+	unsigned int val2;
 
-	val--;
-	val &= this_cpu_read(current_context);
-	this_cpu_write(current_context, val);
+	val2 = val - 1;
+	val &= val2;
+	__this_cpu_write(current_context, val);
 }
 
 #else
