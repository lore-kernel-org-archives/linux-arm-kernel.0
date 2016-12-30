From: dave@stgolabs.net (Davidlohr Bueso)
Date: Fri, 30 Dec 2016 10:17:53 -0800
Subject: [RFC PATCH] sched: Remove set_task_state()
Message-ID: <1483121873-21528-1-git-send-email-dave@stgolabs.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a nasty interface and setting the state of a foreign task
must not be done. While as of be628be0956 (bcache: Make gc wakeup
sane, remove set_task_state()) everyone in the kernel calls
set_task_state() with current, allowing the helper to be removed.
However, as the comment indicates, it is still around for those
archs where computing current is more expensive than using a pointer,
at least in theory. 

Of all the callers, if any, it's the locking bits that would care
most about this -- ie: we end up passing a tsk pointer to a lot of
the lock slowpath, and setting ->state on that. The following numbers
are based on two tests: a custom ad-hoc microbenchmark that just
measures latencies (for ~65 million calls) between get_task_state()
vs get_current_state().

Secondly for a higher overview, an unlink microbenchmark was used,
which pounds on a single file with open, close,unlink combos with
increasing thread counts (up to 4x ncpus). While the workload is
quite unrealistic, it does contend a lot on the inode mutex or now
rwsem. With the archs I had access to, the differences are as follows:

== 1. arm64 ==

0000000000002784 <set_task_state>:
    2784:       f9000c1f        str     xzr, [x0,#24]

0000000000002790 <set_current_state>:
    2790:       d5384100        mrs     x0, sp_el0
    2794:       f9000c1f        str     xzr, [x0,#24]

Avg runtime set_task_state():    2648 msecs
Avg runtime set_current_state(): 2686 msecs

                                            vanilla                 dirty
Hmean    unlink1-processes-2       8146.94 (  0.00%)     9564.74 ( 17.40%)
Hmean    unlink1-processes-5       9627.49 (  0.00%)     8935.47 ( -7.19%)
Hmean    unlink1-processes-8       9148.07 (  0.00%)     8867.29 ( -3.07%)
Hmean    unlink1-processes-12      9168.15 (  0.00%)     8952.79 ( -2.35%)
Hmean    unlink1-processes-21      9067.45 (  0.00%)     9246.20 (  1.97%)
Hmean    unlink1-processes-30      9310.21 (  0.00%)     8831.77 ( -5.14%)
Hmean    unlink1-processes-48      9100.57 (  0.00%)     9084.36 ( -0.18%)
Hmean    unlink1-processes-79      9022.37 (  0.00%)     8178.66 ( -9.35%)
Hmean    unlink1-processes-110     8940.33 (  0.00%)     8186.77 ( -8.43%)
Hmean    unlink1-processes-141     9001.95 (  0.00%)     8429.08 ( -6.36%)
Hmean    unlink1-processes-172     8990.60 (  0.00%)     8059.33 (-10.36%)
Hmean    unlink1-processes-203     8456.43 (  0.00%)     8065.69 ( -4.62%)
Hmean    unlink1-processes-234     9020.57 (  0.00%)     8495.15 ( -5.82%)
Hmean    unlink1-processes-265     8849.48 (  0.00%)     8123.47 ( -8.20%)
Hmean    unlink1-processes-296     8890.80 (  0.00%)     8272.24 ( -6.96%)
Hmean    unlink1-processes-327     8637.74 (  0.00%)     8377.55 ( -3.01%)
Hmean    unlink1-processes-358     8690.21 (  0.00%)     8492.25 ( -2.28%)
Hmean    unlink1-processes-384     8687.64 (  0.00%)     8510.68 ( -2.04%)

== 2. x86-64 ==

0000000000002cc0 <set_task_state>:
    2cc1:       48 c7 47 08 00 00 00    movq   $0x0,0x8(%rdi)
    2cc9:       48 89 e5                mov    %rsp,%rbp

0000000000002cd0 <set_current_state>:
    2cd1:       65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
    2cda:       48 89 e5                mov    %rsp,%rbp
    2cdd:       48 c7 40 08 00 00 00    movq   $0x0,0x8(%rax)

Avg runtime set_task_state():    601 msecs
Avg runtime set_current_state(): 552 msecs

                                            vanilla                 dirty
Hmean    unlink1-processes-2      36089.26 (  0.00%)    38977.33 (  8.00%)
Hmean    unlink1-processes-5      28555.01 (  0.00%)    29832.55 (  4.28%)
Hmean    unlink1-processes-8      37323.75 (  0.00%)    44974.57 ( 20.50%)
Hmean    unlink1-processes-12     43571.88 (  0.00%)    44283.01 (  1.63%)
Hmean    unlink1-processes-21     34431.52 (  0.00%)    38284.45 ( 11.19%)
Hmean    unlink1-processes-30     34813.26 (  0.00%)    37975.17 (  9.08%)
Hmean    unlink1-processes-48     37048.90 (  0.00%)    39862.78 (  7.59%)
Hmean    unlink1-processes-79     35630.01 (  0.00%)    36855.30 (  3.44%)
Hmean    unlink1-processes-110    36115.85 (  0.00%)    39843.91 ( 10.32%)
Hmean    unlink1-processes-141    32546.96 (  0.00%)    35418.52 (  8.82%)
Hmean    unlink1-processes-172    34674.79 (  0.00%)    36899.21 (  6.42%)
Hmean    unlink1-processes-203    37303.11 (  0.00%)    36393.04 ( -2.44%)
Hmean    unlink1-processes-224    35712.13 (  0.00%)    36685.96 (  2.73%)


== 3. ppc64le ==

Avg runtime set_task_state():  938 msecs
Avg runtime set_current_state: 940 msecs

                                            vanilla                 dirty
Hmean    unlink1-processes-2      19269.19 (  0.00%)    30704.50 ( 59.35%)
Hmean    unlink1-processes-5      20106.15 (  0.00%)    21804.15 (  8.45%)
Hmean    unlink1-processes-8      17496.97 (  0.00%)    17243.28 ( -1.45%)
Hmean    unlink1-processes-12     14224.15 (  0.00%)    17240.21 ( 21.20%)
Hmean    unlink1-processes-21     14155.66 (  0.00%)    15681.23 ( 10.78%)
Hmean    unlink1-processes-30     14450.70 (  0.00%)    15995.83 ( 10.69%)
Hmean    unlink1-processes-48     16945.57 (  0.00%)    16370.42 ( -3.39%)
Hmean    unlink1-processes-79     15788.39 (  0.00%)    14639.27 ( -7.28%)
Hmean    unlink1-processes-110    14268.48 (  0.00%)    14377.40 (  0.76%)
Hmean    unlink1-processes-141    14023.65 (  0.00%)    16271.69 ( 16.03%)
Hmean    unlink1-processes-172    13417.62 (  0.00%)    16067.55 ( 19.75%)
Hmean    unlink1-processes-203    15293.08 (  0.00%)    15440.40 (  0.96%)
Hmean    unlink1-processes-234    13719.32 (  0.00%)    16190.74 ( 18.01%)
Hmean    unlink1-processes-265    16400.97 (  0.00%)    16115.22 ( -1.74%)
Hmean    unlink1-processes-296    14388.60 (  0.00%)    16216.13 ( 12.70%)
Hmean    unlink1-processes-320    15771.85 (  0.00%)    15905.96 (  0.85%)


Unsurprisingly, the big looser is arm64, due to the masking of sp_el0.
otoh, x86-64 (known to be fast for get_current()/this_cpu_read_stable()
caching) and ppc64 (with paca) show similar improvements in the unlink
microbenches. x86's write latencies delta is similar to the opposite of
arm64: 50ms vs -40ms, respectively. The small delta for ppc64 (2ms), does
not represent the gains on the unlink runs. In the case of x86, there was
a decent amount of variation in the latency runs, but always within a 20
to 50ms increase), ppc was more constant.

So, do we want to get rid of the interface (and improve performance on
other archs) at the expense of arm64? Can arm64 do better?

Applies against v4.10-rc1.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/um/drivers/random.c                           |  2 +-
 drivers/md/dm-bufio.c                              |  2 +-
 drivers/md/dm-crypt.c                              |  4 ++--
 drivers/md/persistent-data/dm-block-manager.c      |  4 ++--
 .../staging/lustre/lnet/libcfs/linux/linux-debug.c |  2 +-
 drivers/tty/tty_ldsem.c                            | 10 ++++----
 include/linux/sched.h                              | 27 +---------------------
 kernel/exit.c                                      |  4 ++--
 kernel/locking/mutex.c                             |  8 +++----
 kernel/locking/rwsem-spinlock.c                    |  8 +++----
 kernel/locking/rwsem-xadd.c                        |  4 ++--
 kernel/locking/semaphore.c                         |  2 +-
 12 files changed, 26 insertions(+), 51 deletions(-)

diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 05523f14d7b2..57f03050c850 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -76,7 +76,7 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
 			add_sigio_fd(random_fd);
 
 			add_wait_queue(&host_read_wait, &wait);
-			set_task_state(current, TASK_INTERRUPTIBLE);
+			set_current_state(TASK_INTERRUPTIBLE);
 
 			schedule();
 			remove_wait_queue(&host_read_wait, &wait);
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 84d2f0e4c754..d36d427a9efb 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -794,7 +794,7 @@ static void __wait_for_free_buffer(struct dm_bufio_client *c)
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(&c->free_buffer_wait, &wait);
-	set_task_state(current, TASK_UNINTERRUPTIBLE);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	dm_bufio_unlock(c);
 
 	io_schedule();
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 7c6c57216bf2..96692d13a6e4 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1210,14 +1210,14 @@ static int dmcrypt_write(void *data)
 		spin_unlock_irq(&cc->write_thread_wait.lock);
 
 		if (unlikely(kthread_should_stop())) {
-			set_task_state(current, TASK_RUNNING);
+			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&cc->write_thread_wait, &wait);
 			break;
 		}
 
 		schedule();
 
-		set_task_state(current, TASK_RUNNING);
+		set_current_state(TASK_RUNNING);
 		spin_lock_irq(&cc->write_thread_wait.lock);
 		__remove_wait_queue(&cc->write_thread_wait, &wait);
 		goto continue_locked;
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index a6dde7cab458..758d90cc2733 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -120,7 +120,7 @@ static int __check_holder(struct block_lock *lock)
 static void __wait(struct waiter *w)
 {
 	for (;;) {
-		set_task_state(current, TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 
 		if (!w->task)
 			break;
@@ -128,7 +128,7 @@ static void __wait(struct waiter *w)
 		schedule();
 	}
 
-	set_task_state(current, TASK_RUNNING);
+	set_current_state(TASK_RUNNING);
 }
 
 static void __wake_waiter(struct waiter *w)
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
index 39a72e3f0c18..7035356e56b3 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
@@ -107,7 +107,7 @@ void __noreturn lbug_with_loc(struct libcfs_debug_msg_data *msgdata)
 		libcfs_debug_dumplog();
 	if (libcfs_panic_on_lbug)
 		panic("LBUG");
-	set_task_state(current, TASK_UNINTERRUPTIBLE);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	while (1)
 		schedule();
 }
diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 1bf8ed13f827..c94bc0eef85d 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -232,7 +232,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 
 	/* wait to be given the lock */
 	for (;;) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 
 		if (!waiter.task)
 			break;
@@ -241,7 +241,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 		timeout = schedule_timeout(timeout);
 	}
 
-	__set_task_state(tsk, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 
 	if (!timeout) {
 		/* lock timed out but check if this task was just
@@ -291,14 +291,14 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
 
 	waiter.task = tsk;
 
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	for (;;) {
 		if (!timeout)
 			break;
 		raw_spin_unlock_irq(&sem->wait_lock);
 		timeout = schedule_timeout(timeout);
 		raw_spin_lock_irq(&sem->wait_lock);
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		locked = writer_trylock(sem);
 		if (locked)
 			break;
@@ -309,7 +309,7 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
 	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
 
-	__set_task_state(tsk, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 
 	/* lock wait may have timed out */
 	if (!locked)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d1905245c7a..8edf16d82f8c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -227,7 +227,7 @@ extern void proc_sched_set_task(struct task_struct *p);
 extern char ___assert_task_state[1 - 2*!!(
 		sizeof(TASK_STATE_TO_CHAR_STR)-1 != ilog2(TASK_STATE_MAX)+1)];
 
-/* Convenience macros for the sake of set_task_state */
+/* Convenience macros for the sake of set_current_state */
 #define TASK_KILLABLE		(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED		(TASK_WAKEKILL | __TASK_STOPPED)
 #define TASK_TRACED		(TASK_WAKEKILL | __TASK_TRACED)
@@ -254,17 +254,6 @@ extern char ___assert_task_state[1 - 2*!!(
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
-#define __set_task_state(tsk, state_value)			\
-	do {							\
-		(tsk)->task_state_change = _THIS_IP_;		\
-		(tsk)->state = (state_value);			\
-	} while (0)
-#define set_task_state(tsk, state_value)			\
-	do {							\
-		(tsk)->task_state_change = _THIS_IP_;		\
-		smp_store_mb((tsk)->state, (state_value));	\
-	} while (0)
-
 #define __set_current_state(state_value)			\
 	do {							\
 		current->task_state_change = _THIS_IP_;		\
@@ -277,20 +266,6 @@ extern char ___assert_task_state[1 - 2*!!(
 	} while (0)
 
 #else
-
-/*
- * @tsk had better be current, or you get to keep the pieces.
- *
- * The only reason is that computing current can be more expensive than
- * using a pointer that's already available.
- *
- * Therefore, see set_current_state().
- */
-#define __set_task_state(tsk, state_value)		\
-	do { (tsk)->state = (state_value); } while (0)
-#define set_task_state(tsk, state_value)		\
-	smp_store_mb((tsk)->state, (state_value))
-
 /*
  * set_current_state() includes a barrier so that the write of current->state
  * is correctly serialised wrt the caller's subsequent test of whether to
diff --git a/kernel/exit.c b/kernel/exit.c
index 8f14b866f9f6..184add6f4bfa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -501,12 +501,12 @@ static void exit_mm(struct task_struct *tsk)
 			complete(&core_state->startup);
 
 		for (;;) {
-			set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			if (!self.task) /* see coredump_finish() */
 				break;
 			freezable_schedule();
 		}
-		__set_task_state(tsk, TASK_RUNNING);
+		__set_current_state(TASK_RUNNING);
 		down_read(&mm->mmap_sem);
 	}
 	atomic_inc(&mm->mm_count);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 9b349619f431..821c1d115974 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -667,7 +667,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 	lock_contended(&lock->dep_map, ip);
 
-	set_task_state(task, state);
+	set_current_state(state);
 	for (;;) {
 		/*
 		 * Once we hold wait_lock, we're serialized against
@@ -702,7 +702,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 		}
 
-		set_task_state(task, state);
+		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
 		 * state back to RUNNING and fall through the next schedule(),
@@ -716,7 +716,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 	spin_lock_mutex(&lock->wait_lock, flags);
 acquired:
-	__set_task_state(task, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 
 	mutex_remove_waiter(lock, &waiter, task);
 	if (likely(list_empty(&lock->wait_list)))
@@ -736,7 +736,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	return 0;
 
 err:
-	__set_task_state(task, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, task);
 	spin_unlock_mutex(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/rwsem-spinlock.c b/kernel/locking/rwsem-spinlock.c
index 1591f6b3539f..f3c1c0734da6 100644
--- a/kernel/locking/rwsem-spinlock.c
+++ b/kernel/locking/rwsem-spinlock.c
@@ -141,7 +141,7 @@ void __sched __down_read(struct rw_semaphore *sem)
 	}
 
 	tsk = current;
-	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	set_current_state(TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
 	waiter.task = tsk;
@@ -158,10 +158,10 @@ void __sched __down_read(struct rw_semaphore *sem)
 		if (!waiter.task)
 			break;
 		schedule();
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 	}
 
-	__set_task_state(tsk, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
  out:
 	;
 }
@@ -220,7 +220,7 @@ int __sched __down_write_common(struct rw_semaphore *sem, int state)
 			ret = -EINTR;
 			goto out;
 		}
-		set_task_state(tsk, state);
+		set_current_state(state);
 		raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
 		schedule();
 		raw_spin_lock_irqsave(&sem->wait_lock, flags);
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 631506004f9e..45a6afeed2c2 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -254,13 +254,13 @@ struct rw_semaphore __sched *rwsem_down_read_failed(struct rw_semaphore *sem)
 
 	/* wait to be given the lock */
 	while (true) {
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (!waiter.task)
 			break;
 		schedule();
 	}
 
-	__set_task_state(tsk, TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	return sem;
 }
 EXPORT_SYMBOL(rwsem_down_read_failed);
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index b8120abe594b..2f8cdb712b63 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -216,7 +216,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 			goto interrupted;
 		if (unlikely(timeout <= 0))
 			goto timed_out;
-		__set_task_state(task, state);
+		__set_current_state(state);
 		raw_spin_unlock_irq(&sem->lock);
 		timeout = schedule_timeout(timeout);
 		raw_spin_lock_irq(&sem->lock);
-- 
2.6.6
