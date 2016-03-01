From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Mar 2016 19:37:16 +0000
Subject: [PATCH v1] kasan, arm64: Unpoison dirty stack frames when
 resuming from suspend.
In-Reply-To: <CAG_fn=XowizL_=tt5aiHBF=_UNYKZsGWQOR7Ju-NYz2kre-7bA@mail.gmail.com>
References: <c08aa050cb03e40098775dc8d200f073451c342e.1456489933.git.glider@google.com>
 <20160226135335.GC8728@leverpostej>
 <CAG_fn=XowizL_=tt5aiHBF=_UNYKZsGWQOR7Ju-NYz2kre-7bA@mail.gmail.com>
Message-ID: <20160301193529.GA335@leverpostej>
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
> >
> > The problem also applies for hotplug, as leftover poison from the
> > hot-unplug path isn't cleaned before a CPU is hotplugged back on. The
> > first few functions are likely deterministic in their stack usage, so
> > it's not seen with a defconfig, but I think it's possible to trigger,
> > and it's also a cross-architecture problem shared with x86.
> Agreed, but since I haven't yet seen problems with hotplug, it's hard
> to test the fix for them.

For testing, I used the below to deliberately hit stale poison after a
hotplug. It deliberately creates large stack frames, accessing as much
of the stack as possible to increase the chance of hitting any posion.

Mark.

---->8----
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 544a713..ef4693f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -195,6 +195,21 @@ exit_idle:
 
 DEFINE_PER_CPU(bool, cpu_dead_idle);
 
+#define NR_STACK_ELEMS 128
+static noinline void hit_stale_poison(unsigned int frames)
+{
+       volatile unsigned long magic[NR_STACK_ELEMS];
+       int i;
+
+       for (i = 0; i < NR_STACK_ELEMS; i++)
+               magic[i] = 0;
+
+       if (frames)
+               hit_stale_poison(frames - 1);
+
+       return;
+}
+
 /*
  * Generic idle loop implementation
  *
@@ -202,6 +217,8 @@ DEFINE_PER_CPU(bool, cpu_dead_idle);
  */
 static void cpu_idle_loop(void)
 {
+       hit_stale_poison(4);
+
        while (1) {
                /*
                 * If the arch has a polling bit, we maintain an invariant:
