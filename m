From: dvyukov@google.com (Dmitry Vyukov)
Date: Sat, 6 Feb 2016 13:30:18 +0100
Subject: [PATCH v8] kernel: add kcov code coverage
In-Reply-To: <20160204143007.674a7e847b4c8fed957bba7c@linux-foundation.org>
References: <1454600441-70701-1-git-send-email-dvyukov@google.com>
 <20160204143007.674a7e847b4c8fed957bba7c@linux-foundation.org>
Message-ID: <CACT4Y+YLOK0+T9n6bZuqoFZpMyn+z-PxHCRufdhXMjPEPfavPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 11:30 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu,  4 Feb 2016 16:40:41 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> kcov provides code coverage collection for coverage-guided fuzzing
>> (randomized testing). Coverage-guided fuzzing is a testing technique
>> that uses coverage feedback to determine new interesting inputs to a
>> system. A notable user-space example is AFL
>> (http://lcamtuf.coredump.cx/afl/). However, this technique is not
>> widely used for kernel testing due to missing compiler and kernel
>> support.
>>
>> kcov does not aim to collect as much coverage as possible. It aims
>> to collect more or less stable coverage that is function of syscall
>> inputs. To achieve this goal it does not collect coverage in
>> soft/hard interrupts and instrumentation of some inherently
>> non-deterministic or non-interesting parts of kernel is disbled
>> (e.g. scheduler, locking).
>>
>> Currently there is a single coverage collection mode (tracing),
>> but the API anticipates additional collection modes.
>> Initially I also implemented a second mode which exposes
>> coverage in a fixed-size hash table of counters (what Quentin
>> used in his original patch). I've dropped the second mode for
>> simplicity.
>>
>> This patch adds the necessary support on kernel side.
>> The complimentary compiler support was added in gcc revision 231296.
>>
>> We've used this support to build syzkaller system call fuzzer,
>> which has found 90 kernel bugs in just 2 months:
>> https://github.com/google/syzkaller/wiki/Found-Bugs
>> We've also found 30+ bugs in our internal systems with syzkaller.
>> Another (yet unexplored) direction where kcov coverage would greatly
>> help is more traditional "blob mutation". For example, mounting
>> a random blob as a filesystem, or receiving a random blob over wire.
>>
>> Why not gcov. Typical fuzzing loop looks as follows: (1) reset
>> coverage, (2) execute a bit of code, (3) collect coverage, repeat.
>> A typical coverage can be just a dozen of basic blocks (e.g. an
>> invalid input). In such context gcov becomes prohibitively expensive
>> as reset/collect coverage steps depend on total number of basic
>> blocks/edges in program (in case of kernel it is about 2M). Cost of
>> kcov depends only on number of executed basic blocks/edges. On top of
>> that, kernel requires per-thread coverage because there are
>> always background threads and unrelated processes that also produce
>> coverage. With inlined gcov instrumentation per-thread coverage is not
>> possible.
>>
>> kcov exposes kernel PCs and control flow to user-space which
>> is insecure. But debugfs should not be mapped as user accessible.
>
> So the proposed user interface is ioctls against /sys/kernel/debug/kcov.
>
> I guess that's OK.  We could just add sys_kcov() - syscalls are cheap
> enough.  But we store state within the fd, don't we?  So sys_kcov()
> would take an fd argument.
>
>> Based on a patch by Quentin Casasnovas.
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>> Anticipating reasonable questions regarding usage of this feature.
>> Quentin Casasnovas and Vegard Nossum also plan to use kcov for
>> coverage-guided fuzzing. Currently they use a custom kernel patch
>> for their fuzzer and found several dozens of bugs.
>> There is also interest from Intel 0-DAY kernel test infrastructure.
>>
>> ...
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1811,6 +1811,16 @@ struct task_struct {
>>       /* bitmask and counter of trace recursion */
>>       unsigned long trace_recursion;
>>  #endif /* CONFIG_TRACING */
>> +#ifdef CONFIG_KCOV
>> +     /* Coverage collection mode enabled for this task (0 if disabled). */
>> +     int             kcov_mode;
>
> Should really be enum kcov_mode.  We could move it into <linux/kcov.h>:
>
> --- a/include/linux/kcov.h~kernel-add-kcov-code-coverage-fix
> +++ a/include/linux/kcov.h
> @@ -10,6 +10,14 @@ struct task_struct;
>  void kcov_task_init(struct task_struct *t);
>  void kcov_task_exit(struct task_struct *t);
>
> +enum kcov_mode {
> +       /*
> +        * Tracing coverage collection mode.
> +        * Covered PCs are collected in a per-task buffer.
> +        */
> +       KCOV_MODE_TRACE = 1,
> +};
> +
>  #else
>
>  static inline void kcov_task_init(struct task_struct *t) {}
> --- a/include/linux/sched.h~kernel-add-kcov-code-coverage-fix
> +++ a/include/linux/sched.h
> @@ -51,6 +51,7 @@ struct sched_param {
>  #include <linux/resource.h>
>  #include <linux/timer.h>
>  #include <linux/hrtimer.h>
> +#include <linux/kcov.h>
>  #include <linux/task_io_accounting.h>
>  #include <linux/latencytop.h>
>  #include <linux/cred.h>
> @@ -1814,7 +1815,7 @@ struct task_struct {
>  #endif /* CONFIG_TRACING */
>  #ifdef CONFIG_KCOV
>         /* Coverage collection mode enabled for this task (0 if disabled). */
> -       int             kcov_mode;
> +       enum kcov_mode kcov_mode;
>         /* Size of the kcov_area. */
>         unsigned        kcov_size;
>         /* Buffer for coverage collection. */
> --- a/kernel/kcov.c~kernel-add-kcov-code-coverage-fix
> +++ a/kernel/kcov.c
> @@ -13,14 +13,6 @@
>  #include <linux/uaccess.h>
>  #include <linux/kcov.h>
>
> -enum kcov_mode {
> -       /*
> -        * Tracing coverage collection mode.
> -        * Covered PCs are collected in a per-task buffer.
> -        */
> -       KCOV_MODE_TRACE = 1,
> -};
> -
>  /*
>   * kcov descriptor (one per opened debugfs file).
>   * State transitions of the descriptor:
>
>>
>> ...
>>
>> +/*
>> + * kcov descriptor (one per opened debugfs file).
>> + * State transitions of the descriptor:
>> + * - initial state after open()
>> + * - then there must be a single ioctl(KCOV_INIT_TRACE) call
>> + * - then, mmap() call (several calls are allowed but not useful)
>> + * - then, repeated enable/disable for a task (only one task a time allowed)
>> + */
>> +struct kcov {
>> + /*
>> + * Reference counter.  We keep one for:
>> + * - opened file descriptor
>> + * - task with enabled coverage (we can't unwire it from another task)
>> + */
>> +     atomic_t rc;
>
> "rc" usually means "return code".  Calling this "refcount" would cause
> less surprise.


Thanks for the fixes, Andrew. I will be OOO next week, but I will send
cleanup patch the week after next.
