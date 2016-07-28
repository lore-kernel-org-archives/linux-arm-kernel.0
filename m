From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Jul 2016 15:40:54 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <57993211.1040600@linaro.org>
References: <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
 <57993211.1040600@linaro.org>
Message-ID: <20160728144053.GA26510@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 06:13:37PM -0400, David Long wrote:
> On 07/27/2016 07:50 AM, Daniel Thompson wrote:
> >On 25/07/16 23:27, David Long wrote:
> >>On 07/25/2016 01:13 PM, Catalin Marinas wrote:
> >>>The problem is that the original design was done on x86 for its PCS and
> >>>it doesn't always fit other architectures. So we could either ignore the
> >>>problem, hoping that no probed function requires argument passing on
> >>>stack or we copy all the valid data on the kernel stack:
> >>>
> >>>diff --git a/arch/arm64/include/asm/kprobes.h
> >>>b/arch/arm64/include/asm/kprobes.h
> >>>index 61b49150dfa3..157fd0d0aa08 100644
> >>>--- a/arch/arm64/include/asm/kprobes.h
> >>>+++ b/arch/arm64/include/asm/kprobes.h
> >>>@@ -22,7 +22,7 @@
> >>>
> >>>  #define __ARCH_WANT_KPROBES_INSN_SLOT
> >>>  #define MAX_INSN_SIZE            1
> >>>-#define MAX_STACK_SIZE            128
> >>>+#define MAX_STACK_SIZE            THREAD_SIZE
> >>>
> >>>  #define flush_insn_slot(p)        do { } while (0)
> >>>  #define kretprobe_blacklist_size    0
> >>
> >>I doubt the ARM PCS is unusual.  At any rate I'm certain there are other
> >>architectures that pass aggregate parameters on the stack. I suspect
> >>other RISC(-ish) architectures have similar PCS issues and I think this
> >>is at least a big part of where this simple copy with a 64/128 limit
> >>comes from, or at least why it continues to exist.  That said, I'm not
> >>enthusiastic about researching that assertion in detail as it could be
> >>time consuming.
> >
> >Given Mark shared a test program I *was* curious enough to take a look
> >at this.
> >
> >The only architecture I can find that behaves like arm64 with the
> >implicit pass-by-reference described by Catalin/Mark is sparc64.
> >
> >In contrast alpha, arm (32-bit), hppa64, mips64 and powerpc64 all use a
> >hybrid approach where the first fragments of the structure are passed in
> >registers and the remainder on the stack.
> 
> That's interesting.  It also looks like sparc64 does not copy any stack for
> jprobes. I guess that approach at least makes it clear what will and won't
> work.

I suggest we do the same for arm64 - avoid the copying entirely as it's
not safe anyway. We don't know how much to copy, nor can we be sure it
is safe (see Dave's DMA to the stack example). This would need to be
documented in the kprobes.txt file and MAX_STACK_SIZE removed from the
arm64 kprobes support.

There is also the case that Daniel was talking about - passing more than
8 arguments. I don't think it's worth handling this but we should at
least add a warning and skip the probe:

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bf9768588288..84e02606ec3d 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -491,6 +491,10 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	long stack_ptr = kernel_stack_pointer(regs);
 
+	/* do not allow arguments passed on the stack */
+	if (WARN_ON_ONCE(regs->sp != regs->regs[29]))
+		return 0;
+
 	kcb->jprobe_saved_regs = *regs;
 	/*
 	 * As Linus pointed out, gcc assumes that the callee

Unfortunately, we don't really have a way to detect large composite
types passed as arguments, so we only have to rely on the documentation.

Can you please submit a patch that removes MAX_STACK_SIZE for arm64,
documents it and include the above hunk (once tested that it actually
does what it intends to).

Thanks.

-- 
Catalin
