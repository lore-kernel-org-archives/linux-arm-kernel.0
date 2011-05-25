From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 25 May 2011 19:08:55 +0200
Subject: [BUG]  "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306272750.2497.79.camel@laptop>
References: <1306260792.27474.133.camel@e102391-lin.cambridge.arm.com>
	<1306272750.2497.79.camel@laptop>
Message-ID: <1306343335.21578.65.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-24 at 23:32 +0200, Peter Zijlstra wrote:
> On Tue, 2011-05-24 at 19:13 +0100, Marc Zyngier wrote:
> > Peter,
> > 
> > I've experienced all kind of lock-ups on ARM SMP platforms recently, and
> > finally tracked it down to the following patch:
> > 
> > e4a52bcb9a18142d79e231b6733cabdbf2e67c1f [sched: Remove rq->lock from the first half of ttwu()].
> > 
> > Even on moderate load, the machine locks up, often silently, and
> > sometimes with a few messages like:
> > INFO: rcu_preempt_state detected stalls on CPUs/tasks: { 0} (detected by 1, t=12002 jiffies)
> > 
> > Another side effect of this patch is that the load average is always 0,
> > whatever load I throw at the system.
> > 
> > Reverting the sched changes up to that patch (included) gives me a
> > working system again, which happily survives parallel kernel
> > compilations without complaining.
> > 
> > My knowledge of the scheduler being rather limited, I haven't been able
> > to pinpoint the exact problem (though it probably have something to do
> > with __ARCH_WANT_INTERRUPTS_ON_CTXSW being defined on ARM). The enclosed
> > patch somehow papers over the load average problem, but the system ends
> > up locking up anyway:
> 
> Hurm.. I'll try and make x86 use __ARCH_WANT_INTERRUPTS_ON_CTXSW, IIRC
> Ingo once said that that is possible and try to see if I can reproduce.
> No clear ideas atm.

So I checked out that particular commit and build with the below patch
on-top. grep __ARCH_WANT /proc/sched_debug did indeed return those
strings so I'm assuming CPP did its magic and I'm indeed running a
kernel that enables IRQs around context switches.

The sad news however is that a make -j8 (on a dual core) seems to result
in a kernel image, not an oops. 

Ooh, shiny, whilst typing this I got an NMI-watchdog error reporting me
that CPU1 got stuck in try_to_wake_up(), so it looks like I can indeed
reproduce some funnies.

/me goes dig in.

---
 arch/x86/include/asm/system.h |    2 ++
 kernel/sched_debug.c          |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/system.h b/arch/x86/include/asm/system.h
index 12569e6..56103bb 100644
--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -10,6 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
 
+#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
+
 /* entries in ARCH_DLINFO: */
 #if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
 # define AT_VECTOR_SIZE_ARCH 2
diff --git a/kernel/sched_debug.c b/kernel/sched_debug.c
index 3669bec6..18b4ace 100644
--- a/kernel/sched_debug.c
+++ b/kernel/sched_debug.c
@@ -335,6 +335,13 @@ static int sched_debug_show(struct seq_file *m, void *v)
 		(int)strcspn(init_utsname()->version, " "),
 		init_utsname()->version);
 
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+	SEQ_printf(m, "__ARCH_WANT_INTERRUPTS_ON_CTXSW\n");
+#endif
+#ifdef __ARCH_WANT_UNLOCKED_CTXSW
+	SEQ_printf(m, "__ARCH_WANT_UNLOCKED_CTXSW\n");                                  
+#endif
+
 #define P(x) \
 	SEQ_printf(m, "%-40s: %Ld\n", #x, (long long)(x))
 #define PN(x) \
