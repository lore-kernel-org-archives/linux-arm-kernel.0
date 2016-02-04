From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 4 Feb 2016 14:30:07 -0800
Subject: [PATCH v8] kernel: add kcov code coverage
In-Reply-To: <1454600441-70701-1-git-send-email-dvyukov@google.com>
References: <1454600441-70701-1-git-send-email-dvyukov@google.com>
Message-ID: <20160204143007.674a7e847b4c8fed957bba7c@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Feb 2016 16:40:41 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:

> kcov provides code coverage collection for coverage-guided fuzzing
> (randomized testing). Coverage-guided fuzzing is a testing technique
> that uses coverage feedback to determine new interesting inputs to a
> system. A notable user-space example is AFL
> (http://lcamtuf.coredump.cx/afl/). However, this technique is not
> widely used for kernel testing due to missing compiler and kernel
> support.
> 
> kcov does not aim to collect as much coverage as possible. It aims
> to collect more or less stable coverage that is function of syscall
> inputs. To achieve this goal it does not collect coverage in
> soft/hard interrupts and instrumentation of some inherently
> non-deterministic or non-interesting parts of kernel is disbled
> (e.g. scheduler, locking).
> 
> Currently there is a single coverage collection mode (tracing),
> but the API anticipates additional collection modes.
> Initially I also implemented a second mode which exposes
> coverage in a fixed-size hash table of counters (what Quentin
> used in his original patch). I've dropped the second mode for
> simplicity.
> 
> This patch adds the necessary support on kernel side.
> The complimentary compiler support was added in gcc revision 231296.
> 
> We've used this support to build syzkaller system call fuzzer,
> which has found 90 kernel bugs in just 2 months:
> https://github.com/google/syzkaller/wiki/Found-Bugs
> We've also found 30+ bugs in our internal systems with syzkaller.
> Another (yet unexplored) direction where kcov coverage would greatly
> help is more traditional "blob mutation". For example, mounting
> a random blob as a filesystem, or receiving a random blob over wire.
> 
> Why not gcov. Typical fuzzing loop looks as follows: (1) reset
> coverage, (2) execute a bit of code, (3) collect coverage, repeat.
> A typical coverage can be just a dozen of basic blocks (e.g. an
> invalid input). In such context gcov becomes prohibitively expensive
> as reset/collect coverage steps depend on total number of basic
> blocks/edges in program (in case of kernel it is about 2M). Cost of
> kcov depends only on number of executed basic blocks/edges. On top of
> that, kernel requires per-thread coverage because there are
> always background threads and unrelated processes that also produce
> coverage. With inlined gcov instrumentation per-thread coverage is not
> possible.
> 
> kcov exposes kernel PCs and control flow to user-space which
> is insecure. But debugfs should not be mapped as user accessible.

So the proposed user interface is ioctls against /sys/kernel/debug/kcov.

I guess that's OK.  We could just add sys_kcov() - syscalls are cheap
enough.  But we store state within the fd, don't we?  So sys_kcov()
would take an fd argument.

> Based on a patch by Quentin Casasnovas.
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Anticipating reasonable questions regarding usage of this feature.
> Quentin Casasnovas and Vegard Nossum also plan to use kcov for
> coverage-guided fuzzing. Currently they use a custom kernel patch
> for their fuzzer and found several dozens of bugs.
> There is also interest from Intel 0-DAY kernel test infrastructure.
> 
> ...
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1811,6 +1811,16 @@ struct task_struct {
>  	/* bitmask and counter of trace recursion */
>  	unsigned long trace_recursion;
>  #endif /* CONFIG_TRACING */
> +#ifdef CONFIG_KCOV
> +	/* Coverage collection mode enabled for this task (0 if disabled). */
> +	int		kcov_mode;

Should really be enum kcov_mode.  We could move it into <linux/kcov.h>:

--- a/include/linux/kcov.h~kernel-add-kcov-code-coverage-fix
+++ a/include/linux/kcov.h
@@ -10,6 +10,14 @@ struct task_struct;
 void kcov_task_init(struct task_struct *t);
 void kcov_task_exit(struct task_struct *t);
 
+enum kcov_mode {
+	/*
+	 * Tracing coverage collection mode.
+	 * Covered PCs are collected in a per-task buffer.
+	 */
+	KCOV_MODE_TRACE = 1,
+};
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
--- a/include/linux/sched.h~kernel-add-kcov-code-coverage-fix
+++ a/include/linux/sched.h
@@ -51,6 +51,7 @@ struct sched_param {
 #include <linux/resource.h>
 #include <linux/timer.h>
 #include <linux/hrtimer.h>
+#include <linux/kcov.h>
 #include <linux/task_io_accounting.h>
 #include <linux/latencytop.h>
 #include <linux/cred.h>
@@ -1814,7 +1815,7 @@ struct task_struct {
 #endif /* CONFIG_TRACING */
 #ifdef CONFIG_KCOV
 	/* Coverage collection mode enabled for this task (0 if disabled). */
-	int		kcov_mode;
+	enum kcov_mode kcov_mode;
 	/* Size of the kcov_area. */
 	unsigned	kcov_size;
 	/* Buffer for coverage collection. */
--- a/kernel/kcov.c~kernel-add-kcov-code-coverage-fix
+++ a/kernel/kcov.c
@@ -13,14 +13,6 @@
 #include <linux/uaccess.h>
 #include <linux/kcov.h>
 
-enum kcov_mode {
-	/*
-	 * Tracing coverage collection mode.
-	 * Covered PCs are collected in a per-task buffer.
-	 */
-	KCOV_MODE_TRACE = 1,
-};
-
 /*
  * kcov descriptor (one per opened debugfs file).
  * State transitions of the descriptor:

>
> ...
>
> +/*
> + * kcov descriptor (one per opened debugfs file). 
> + * State transitions of the descriptor:
> + * - initial state after open()
> + * - then there must be a single ioctl(KCOV_INIT_TRACE) call
> + * - then, mmap() call (several calls are allowed but not useful)
> + * - then, repeated enable/disable for a task (only one task a time allowed)
> + */
> +struct kcov {
> + /*
> + * Reference counter.  We keep one for:
> + * - opened file descriptor
> + * - task with enabled coverage (we can't unwire it from another task)
> + */
> +	atomic_t rc;

"rc" usually means "return code".  Calling this "refcount" would cause
less surprise.

> +	/* The lock protects mode, size, area and t. */
> +	spinlock_t		lock;
> +	enum kcov_mode		mode;
> +	unsigned		size;
> +	void			*area;
> +	struct task_struct	*t;

Can we get some documentation in place for the above?  I find that
documenting the data structures is more valuable than documenting the
code.

> +};
> +
> +/*
> + * Entry point from instrumented code.
> + * This is called once per basic-block/edge.
> + */
> +void __sanitizer_cov_trace_pc(void)
> +{
> +	struct task_struct *t;
> +	enum kcov_mode mode;
> +
> +	t = current;
> +	/*
> +	 * We are interested in code coverage as a function of a syscall inputs,
> +	 * so we ignore code executed in interrupts.
> +	 */
> +	if (!t || in_interrupt())
> +		return;
> +	mode = READ_ONCE(t->kcov_mode);
> +	if (mode == KCOV_MODE_TRACE) {
> +		unsigned long *area;
> +		unsigned long pos;
> +
> +		/*
> +		 * There is some code that runs in interrupts but for which
> +		 * in_interrupt() returns false (e.g. preempt_schedule_irq()).
> +		 * READ_ONCE()/barrier() effectively provides load-acquire wrt
> +		 * interrupts, there are paired barrier()/WRITE_ONCE() in
> +		 * kcov_ioctl_locked().
> +		 */
> +		barrier();
> +		area = t->kcov_area;
> +		/* The first word is number of subsequent PCs. */
> +		pos = READ_ONCE(area[0]) + 1;
> +		if (likely(pos < t->kcov_size)) {
> +			area[pos] = _RET_IP_;
> +			WRITE_ONCE(area[0], pos);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(__sanitizer_cov_trace_pc);

Why is this exported to modules?  gcc emits the call?

>
> ...
>
> +static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	int res = 0;
> +	void *area;
> +	struct kcov *kcov = vma->vm_file->private_data;
> +	unsigned long size, off;
> +	struct page *page;
> +
> +	area = vmalloc_user(vma->vm_end - vma->vm_start);
> +	if (!area)
> +		return -ENOMEM;
> +
> +	spin_lock(&kcov->lock);
> +	size = kcov->size * sizeof(unsigned long);
> +	if (kcov->mode == 0 || vma->vm_pgoff != 0 ||

kcov->mode has type `enum kcov_mode'.  We should hard-wire a zero in
here: neater to create KCOV_MODE_DISABLED or whatever?  In multiple
places.

> +	    vma->vm_end - vma->vm_start != size) {
> +		res = -EINVAL;
> +		goto exit;
> +	}
> +	if (!kcov->area) {
> +		kcov->area = area;
> +		vma->vm_flags |= VM_DONTEXPAND;
> +		spin_unlock(&kcov->lock);
> +		for (off = 0; off < size; off += PAGE_SIZE) {
> +			page = vmalloc_to_page(kcov->area + off);
> +			if (vm_insert_page(vma, vma->vm_start + off, page))
> +				WARN_ONCE(1, "vm_insert_page() failed");
> +		}
> +		return 0;
> +	}
> +exit:
> +	spin_unlock(&kcov->lock);
> +	vfree(area);
> +	return res;
> +}
> +
>
> ...
>
> +static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct task_struct *t;
> +
> +	switch (cmd) {
> +	case KCOV_INIT_TRACE:
> +		/*
> +		 * Enable kcov in trace mode and setup buffer size.
> +		 * Must happen before anything else.
> +		 * Size must be at least 2 to hold current position and one PC.
> +		 */
> +		if (arg < 2 || arg > INT_MAX)
> +			return -EINVAL;
> +		if (kcov->mode != 0)
> +			return -EBUSY;
> +		kcov->mode = KCOV_MODE_TRACE;
> +		kcov->size = arg;

kcov->size comes in from userspace and later get multiplied by
sizeof(unsigned long).  This means that userspace can trigger math
overflows (on 32-bit if that happens) and havoc might ensue.  So can we
please get some better checks in place for `size'?

Also, move these checks (of `arg') so they immediately precede this
*usage* of `arg' so the reader can better see what's happening.

> +		return 0;
> +	case KCOV_ENABLE:
> +		/*
> +		 * Enable coverage for the current task.
> +		 * At this point user must have been enabled trace mode,
> +		 * and mmapped the file. Coverage collection is disabled only
> +		 * at task exit or voluntary by KCOV_DISABLE. After that it can
> +		 * be enabled for another task.
> +		 */
> +		if (arg != 0 || kcov->mode == 0 || kcov->area == NULL)
> +			return -EINVAL;

This reader doesn't know what is in "arg".  Documentation, please.  Or
copy `arg' into a suitably named local.

> +		if (kcov->t != NULL)
> +			return -EBUSY;
> +		t = current;
> +		/* Cache in task struct for performance. */
> +		t->kcov_size = kcov->size;
> +		t->kcov_area = kcov->area;
> +		/* See comment in __sanitizer_cov_trace_pc(). */
> +		barrier();
> +		WRITE_ONCE(t->kcov_mode, kcov->mode);
> +		t->kcov = kcov;
> +		kcov->t = t;
> +		/* This is put either in kcov_task_exit() or in KCOV_DISABLE. */
> +		kcov_get(kcov);

We didn't get a ref on the task_struct.  I guess that's OK because
task_struct.kcov gets torn down in kcov_task_exit().

But what happens if userspace simply closes the fd without running
KCOV_DISABLE?  ?

> +		return 0;
> +	case KCOV_DISABLE:
> +		/* Disable coverage for the current task. */
> +		if (arg != 0 || current->kcov != kcov)
> +			return -EINVAL;

This reader doesn't know what `arg' means.

> +		t = current;
> +		if (WARN_ON(kcov->t != t))
> +			return -EINVAL;
> +		kcov_task_init(t);
> +		kcov->t = NULL;
> +		kcov_put(kcov);
> +		return 0;
> +	default:
> +		return -EINVAL;

For reasons I don't recall, we conventionally return -ENOTTY for
unimplemented ioctl modes.  Alan Cox will remember ;)

http://www.makelinux.net/ldd3/chp-6-sect-1 says

: This error code is interpreted by the C library as "inappropriate ioctl
: for device," which is usually exactly what the programmer needs to
: hear.  It's still pretty common, though, to return -EINVAL in response
: to an invalid ioctl command.

> +	}
> +}
> +
> +static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> +{
> +	struct kcov *kcov;
> +	int res;
> +
> +	kcov = filep->private_data;
> +	spin_lock(&kcov->lock);
> +	res = kcov_ioctl_locked(kcov, cmd, arg);
> +	spin_unlock(&kcov->lock);
> +	return res;
> +}

Wait.  `unsigned long arg' is going to be a 32-bit quantity when a
32-bit executable is running on a 64-bit kernel.  Doesn't this ioctl
need compat handling?

>
> ...
>
