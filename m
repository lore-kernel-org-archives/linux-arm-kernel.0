From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jul 2011 17:43:43 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E251465.4070001@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
	<20110714113625.GB20903@e102144-lin.cambridge.arm.com>
	<4E241E60.7040403@st.com>
	<20110718125719.GA7410@e102144-lin.cambridge.arm.com>
	<4E24446C.4060204@st.com>
	<20110718170952.GC7410@e102144-lin.cambridge.arm.com>
	<4E251465.4070001@st.com>
Message-ID: <20110719164343.GD1560@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 06:21:41AM +0100, Wolfgang BETZ wrote:
>     We don't use fake PIDs for anything. The only thing that can go wrong is
>     during task switch where we switch the mm and then switch the PID in your
>     thread notifier. Reading the context ID between these two points will give
>     you the PID of the previous task.
> 
> Well, don't we set the CONTEXTIDR also during mm switch (in cpu_switch_mm())?
> And in this occasion we will copy the value coming from mm->context.id, i.e.
> with a "PID" value which does not correspond to a thread identifier but to what
> is used for ASID rollover handling!?! I am afraid that this will/can confuse
> external tools.

Yes, but that's easy to fix. We just make switch_mm do read-modify-write of
the upper bits. It also doesn't require us to change the type signature of
that function (see patch below)

> Furthermore, I do not like the idea that we are sending out over the trace
> logic two times the CONTEXTIDR content for each context switch. Seems not to be
> a very clean solution to me :-\

Fair enough, but I think it's a lot better than changing the ASID handling
code.

>     I don't think this is a big problem since
>     we're in the middle of context switch anyway, so it's hard to define when
>     the thread switch has completed. You just have to be aware that the
>     current mm_struct / ASID may not correspond to the PID. One nice property is
>     that you can be sure the PID is correct once you've returned to userspace.
> 
> OK, once you return to user-space everything will be good, but the tools we are
> talking about here do not care (only) about user- or kernel-space, these want
> to trace both (simultaneously)!

I was just giving an example as to an easy way of knowing when the PID is in
sync with the ASID by looking at traces.

Will


So here's something I hacked up. I've compiled it but that's all. I'm also
not sure that the notifier belongs in mm/context.c and you may or may not want
an isb after updating the register.


diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index b0ee9ba..59ab68a 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
 static DEFINE_SPINLOCK(cpu_asid_lock);
@@ -155,3 +156,43 @@ void __new_context(struct mm_struct *mm)
 	set_mm_context(mm, asid);
 	spin_unlock(&cpu_asid_lock);
 }
+
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
+			       void *t)
+{
+	unsigned long flags;
+	u32 contextid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	local_irq_save(flags);
+	asm volatile("mrc	p15, 0, %0, c15, c0, 1\n"
+		     "bic	%0, %0, #0xffffff00\n"
+		     "orr	%0, %0, %1, lsl #8\n"
+		     "mcr	p15, 0, %0, c15, c0, 1"
+		     : "=&r" (contextid)
+		     : "r" (task_tgid_vnr(thread->task)));
+	local_irq_restore(flags);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block contextidr_notifier_block = {
+	.notifier_call = contextidr_notifier,
+};
+
+static int __init contextidr_init(void)
+{
+	unsigned int cpu_arch = cpu_architecture();
+
+	if (cpu_arch < CPU_ARCH_ARMv6)
+		return 0;
+
+	thread_register_notifier(&contextidr_notifier_block);
+	return 0;
+}
+arch_initcall(contextidr_init);
+#endif
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 089c0b5..3605c00 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -111,6 +111,12 @@ ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_ARM_ERRATA_754322
 	dsb
 #endif
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrc	p15, 0, r2, c15, c0, 1
+	bic	r2, r2, #0xff
+	bfc	r1, #8, #24
+	orr	r1, r1, r2
+#endif
 	mcr	p15, 0, r2, c13, c0, 1		@ set reserved context ID
 	isb
 1:	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
