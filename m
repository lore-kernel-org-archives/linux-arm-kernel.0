From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Mar 2016 19:42:04 +0000
Subject: [PATCH v1] kasan, arm64: Unpoison dirty stack frames when
 resuming from suspend.
In-Reply-To: <CAG_fn=XowizL_=tt5aiHBF=_UNYKZsGWQOR7Ju-NYz2kre-7bA@mail.gmail.com>
References: <c08aa050cb03e40098775dc8d200f073451c342e.1456489933.git.glider@google.com>
 <20160226135335.GC8728@leverpostej>
 <CAG_fn=XowizL_=tt5aiHBF=_UNYKZsGWQOR7Ju-NYz2kre-7bA@mail.gmail.com>
Message-ID: <20160301194204.GB335@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 06:28:27PM +0100, Alexander Potapenko wrote:
> On Fri, Feb 26, 2016 at 2:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > On Fri, Feb 26, 2016 at 01:38:37PM +0100, Alexander Potapenko wrote:
> >> Before an ARM64 CPU is suspended, the kernel saves the context which will
> >> be used to initialize the register state upon resume. After that and
> >> before the actual execution of the SMC instruction the kernel creates
> >> several stack frames which are never unpoisoned because arm_smccc_smc()
> >> does not return. This may cause false positive stack buffer overflow
> >> reports from KASAN.
> >>
> >> The solution is to record the stack pointer value just before the CPU is
> >> suspended, and unpoison the part of stack between the saved value and
> >> the stack pointer upon resume.
> >
> > Thanks for looking into this! That's much appreciated.
> >
> > I think the general approach (unposioning the stack upon cold return to
> > the kernel) is fine, but I have concerns with the implementation, which
> > I've noted below.

For the idle case I intend to respin my patch [1] which calls
kasan_unpoison_shadow from assembly in the resume path, as I think
that's the only reliable approach.

> > The problem also applies for hotplug, as leftover poison from the
> > hot-unplug path isn't cleaned before a CPU is hotplugged back on. The
> > first few functions are likely deterministic in their stack usage, so
> > it's not seen with a defconfig, but I think it's possible to trigger,
> > and it's also a cross-architecture problem shared with x86.
> Agreed, but since I haven't yet seen problems with hotplug, it's hard
> to test the fix for them.

For the common hotplug case, how about the below?

I've given it a spin locally on arm64 with the reproducer I posted
earlier.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409466.html

---->8----
>From 34839286826c88338cd91a142b1bcc3c077a87aa Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 1 Mar 2016 19:27:23 +0000
Subject: [PATCH] sched/kasan: clear stale stack poison

CPUs get hotplugged out some levels deep in C code, and hence when KASAN
is in use, the instrumented function preambles will have left the stack
shadow area poisoned.

This poison is not cleared, so when a CPU re-enters the kernel, it is
possible for accesses in instrumented functions to hit this stale
poison, resulting in (spurious) KASAN splats.

This patch forcefully unpoisons an idle task's stack shadow when it is
re-initialised prior to a hotplug, avoiding spurious hits against stale
poison.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/kasan.h |  4 ++++
 kernel/sched/core.c   |  3 +++
 mm/kasan/kasan.c      | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 4b9f85c..e00486f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -43,6 +43,8 @@ static inline void kasan_disable_current(void)
 
 void kasan_unpoison_shadow(const void *address, size_t size);
 
+void kasan_unpoison_task_stack(struct task_struct *idle);
+
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
 
@@ -66,6 +68,8 @@ void kasan_free_shadow(const struct vm_struct *vm);
 
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
 
+static inline void kasan_unpoison_task_stack(struct task_struct *idle) {}
+
 static inline void kasan_enable_current(void) {}
 static inline void kasan_disable_current(void) {}
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9503d59..41f6b22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -26,6 +26,7 @@
  *              Thomas Gleixner, Mike Kravetz
  */
 
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/nmi.h>
@@ -5096,6 +5097,8 @@ void init_idle(struct task_struct *idle, int cpu)
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 
+	kasan_unpoison_task_stack(idle);
+
 #ifdef CONFIG_SMP
 	/*
 	 * Its possible that init_idle() gets called multiple times on a task,
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index bc0a8d8..467f394 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -60,6 +60,16 @@ void kasan_unpoison_shadow(const void *address, size_t size)
 	}
 }
 
+/*
+ * Remove any poison left on the stack from a prior hot-unplug.
+ */
+void kasan_unpoison_task_stack(struct task_struct *idle)
+{
+	void *base = task_stack_page(idle) + sizeof(struct thread_info);
+	size_t size = THREAD_SIZE - sizeof(struct thread_info);
+
+	kasan_unpoison_shadow(base, size);
+}
 
 /*
  * All functions below always inlined so compiler could
-- 
1.9.1
