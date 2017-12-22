From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Dec 2017 09:55:53 +0000
Subject: [PATCH 2/2] ARM: probes: avoid adding kprobes to sensitive
 kernel-entry/exit code
In-Reply-To: <CAKaJLVtKjojgX6kf0XtePK5sYkLC29UNihqg4DW8OFrUqCfvcQ@mail.gmail.com>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYic-0007t7-Df@rmk-PC.armlinux.org.uk>
 <CAKaJLVtKjojgX6kf0XtePK5sYkLC29UNihqg4DW8OFrUqCfvcQ@mail.gmail.com>
Message-ID: <20171222095553.GN10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 09:40:05PM +0200, Sam Protsenko wrote:
> On 25 November 2017 at 13:33, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Avoid adding kprobes to any of the kernel entry/exit or startup
> > assembly code, or code in the identity-mapped region.  This code does
> > not conform to the standard C conventions, which means that the
> > expectations of the kprobes code is not forfilled.
> >
> > Placing kprobes at some of these locations results in the kernel trying
> > to return to userspace addresses while retaining the CPU in kernel mode.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  arch/arm/include/asm/exception.h |  3 +--
> >  arch/arm/include/asm/sections.h  | 21 +++++++++++++++++++++
> >  arch/arm/include/asm/traps.h     | 12 ------------
> >  arch/arm/kernel/entry-armv.S     |  6 +-----
> >  arch/arm/kernel/entry-common.S   |  1 +
> >  arch/arm/kernel/stacktrace.c     | 14 ++------------
> >  arch/arm/kernel/traps.c          |  4 ++--
> >  arch/arm/kernel/vmlinux.lds.S    |  6 +++---
> >  arch/arm/mm/fault.c              |  5 ++---
> >  arch/arm/probes/kprobes/core.c   | 14 +++++++++++---
> >  10 files changed, 44 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/arm/include/asm/exception.h b/arch/arm/include/asm/exception.h
> > index a7273ad9587a..58e039a851af 100644
> > --- a/arch/arm/include/asm/exception.h
> > +++ b/arch/arm/include/asm/exception.h
> > @@ -10,11 +10,10 @@
> >
> >  #include <linux/interrupt.h>
> >
> > -#define __exception    __attribute__((section(".exception.text")))
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  #define __exception_irq_entry  __irq_entry
> >  #else
> > -#define __exception_irq_entry  __exception
> > +#define __exception_irq_entry
> >  #endif
> >
> >  #endif /* __ASM_ARM_EXCEPTION_H */
> > diff --git a/arch/arm/include/asm/sections.h b/arch/arm/include/asm/sections.h
> > index 63dfe1f10335..4ceb4f757d4d 100644
> > --- a/arch/arm/include/asm/sections.h
> > +++ b/arch/arm/include/asm/sections.h
> > @@ -6,4 +6,25 @@
> >
> >  extern char _exiprom[];
> >
> > +extern char __idmap_text_start[];
> > +extern char __idmap_text_end[];
> > +extern char __entry_text_start[];
> > +extern char __entry_text_end[];
> > +extern char __hyp_idmap_text_start[];
> > +extern char __hyp_idmap_text_end[];
> > +
> > +static inline bool in_entry_text(unsigned long addr)
> > +{
> > +       return memory_contains(__entry_text_start, __entry_text_end,
> > +                              (void *)addr, 1);
> > +}
> > +
> > +static inline bool in_idmap_text(unsigned long addr)
> > +{
> > +       void *a = (void *)addr;
> > +       return memory_contains(__idmap_text_start, __idmap_text_end, a, 1) ||
> > +              memory_contains(__hyp_idmap_text_start, __hyp_idmap_text_end,
> > +                              a, 1);
> > +}
> > +
> >  #endif /* _ASM_ARM_SECTIONS_H */
> > diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
> > index f9a6c5fc3fd1..a00288d75ee6 100644
> > --- a/arch/arm/include/asm/traps.h
> > +++ b/arch/arm/include/asm/traps.h
> > @@ -28,18 +28,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
> >                ptr < (unsigned long)&__irqentry_text_end;
> >  }
> >
> > -static inline int in_exception_text(unsigned long ptr)
> > -{
> > -       extern char __exception_text_start[];
> > -       extern char __exception_text_end[];
> > -       int in;
> > -
> > -       in = ptr >= (unsigned long)&__exception_text_start &&
> > -            ptr < (unsigned long)&__exception_text_end;
> > -
> > -       return in ? : __in_irqentry_text(ptr);
> > -}
> > -
> >  extern void __init early_trap_init(void *);
> >  extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
> >  extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
> > diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> > index 10ad44f3886a..b8ab97dfdd17 100644
> > --- a/arch/arm/kernel/entry-armv.S
> > +++ b/arch/arm/kernel/entry-armv.S
> > @@ -82,11 +82,7 @@
> >  #endif
> >         .endm
> >
> > -#ifdef CONFIG_KPROBES
> > -       .section        .kprobes.text,"ax",%progbits
> > -#else
> > -       .text
> > -#endif
> > +       .section        .entry.text,"ax",%progbits
> >
> >  /*
> >   * Invalid mode handlers
> > diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> > index e655dcd0a933..3c4f88701f22 100644
> > --- a/arch/arm/kernel/entry-common.S
> > +++ b/arch/arm/kernel/entry-common.S
> > @@ -37,6 +37,7 @@ saved_pc      .req    lr
> >  #define TRACE(x...)
> >  #endif
> >
> > +       .section .entry.text,"ax",%progbits
> >         .align  5
> >  #if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
> >  /*
> > diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> > index 65228bf4c6df..a56e7c856ab5 100644
> > --- a/arch/arm/kernel/stacktrace.c
> > +++ b/arch/arm/kernel/stacktrace.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/sched/debug.h>
> >  #include <linux/stacktrace.h>
> >
> > +#include <asm/sections.h>
> >  #include <asm/stacktrace.h>
> >  #include <asm/traps.h>
> >
> > @@ -63,7 +64,6 @@ EXPORT_SYMBOL(walk_stackframe);
> >  #ifdef CONFIG_STACKTRACE
> >  struct stack_trace_data {
> >         struct stack_trace *trace;
> > -       unsigned long last_pc;
> >         unsigned int no_sched_functions;
> >         unsigned int skip;
> >  };
> > @@ -87,16 +87,7 @@ static int save_trace(struct stackframe *frame, void *d)
> >         if (trace->nr_entries >= trace->max_entries)
> >                 return 1;
> >
> > -       /*
> > -        * in_exception_text() is designed to test if the PC is one of
> > -        * the functions which has an exception stack above it, but
> > -        * unfortunately what is in frame->pc is the return LR value,
> > -        * not the saved PC value.  So, we need to track the previous
> > -        * frame PC value when doing this.
> > -        */
> > -       addr = data->last_pc;
> > -       data->last_pc = frame->pc;
> > -       if (!in_exception_text(addr))
> > +       if (!in_entry_text(frame->pc))
> >                 return 0;
> >
> >         regs = (struct pt_regs *)frame->sp;
> > @@ -114,7 +105,6 @@ static noinline void __save_stack_trace(struct task_struct *tsk,
> >         struct stackframe frame;
> >
> >         data.trace = trace;
> > -       data.last_pc = ULONG_MAX;
> >         data.skip = trace->skip;
> >         data.no_sched_functions = nosched;
> >
> > diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> > index 5de2bc46153f..95978073db53 100644
> > --- a/arch/arm/kernel/traps.c
> > +++ b/arch/arm/kernel/traps.c
> > @@ -73,7 +73,7 @@ void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long
> >         printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
> >  #endif
> >
> > -       if (in_exception_text(where))
> > +       if (in_entry_text(from))
> >                 dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
> >  }
> >
> > @@ -434,7 +434,7 @@ static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
> >         return fn ? fn(regs, instr) : 1;
> >  }
> >
> > -asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
> > +asmlinkage void do_undefinstr(struct pt_regs *regs)
> >  {
> >         unsigned int instr;
> >         siginfo_t info;
> > diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> > index ee53f6518872..84a1ae3ce46e 100644
> > --- a/arch/arm/kernel/vmlinux.lds.S
> > +++ b/arch/arm/kernel/vmlinux.lds.S
> > @@ -105,9 +105,9 @@ SECTIONS
> >         .text : {                       /* Real text segment            */
> >                 _stext = .;             /* Text and read-only data      */
> >                         IDMAP_TEXT
> > -                       __exception_text_start = .;
> > -                       *(.exception.text)
> > -                       __exception_text_end = .;
> > +                       __entry_text_start = .;
> > +                       *(.entry.text)
> > +                       __entry_text_end = .;
> >                         IRQENTRY_TEXT
> >                         SOFTIRQENTRY_TEXT
> >                         TEXT_TEXT
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 42f585379e19..b75eada23d0a 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -21,7 +21,6 @@
> >  #include <linux/highmem.h>
> >  #include <linux/perf_event.h>
> >
> > -#include <asm/exception.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/system_misc.h>
> >  #include <asm/system_info.h>
> > @@ -545,7 +544,7 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
> >  /*
> >   * Dispatch a data abort to the relevant handler.
> >   */
> > -asmlinkage void __exception
> > +asmlinkage void
> >  do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  {
> >         const struct fsr_info *inf = fsr_info + fsr_fs(fsr);
> > @@ -578,7 +577,7 @@ hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *
> >         ifsr_info[nr].name = name;
> >  }
> >
> > -asmlinkage void __exception
> > +asmlinkage void
> >  do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
> >  {
> >         const struct fsr_info *inf = ifsr_info + fsr_fs(ifsr);
> > diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> > index 52d1cd14fda4..e90cc8a08186 100644
> > --- a/arch/arm/probes/kprobes/core.c
> > +++ b/arch/arm/probes/kprobes/core.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/bug.h>
> >  #include <asm/patch.h>
> > +#include <asm/sections.h>
> >
> >  #include "../decode-arm.h"
> >  #include "../decode-thumb.h"
> > @@ -64,9 +65,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >         int is;
> >         const struct decode_checker **checkers;
> >
> > -       if (in_exception_text(addr))
> > -               return -EINVAL;
> > -
> >  #ifdef CONFIG_THUMB2_KERNEL
> >         thumb = true;
> >         addr &= ~1; /* Bit 0 would normally be set to indicate Thumb code */
> > @@ -680,3 +678,13 @@ int __init arch_init_kprobes()
> >  #endif
> >         return 0;
> >  }
> > +
> > +bool arch_within_kprobe_blacklist(unsigned long addr)
> > +{
> > +       void *a = (void *)addr;
> > +
> > +       return __in_irqentry_text(addr) ||
> > +              in_entry_text(addr) ||
> > +              in_idmap_text(addr) ||
> > +              memory_contains(__kprobes_text_start, __kprobes_text_end, a, 1);
> > +}
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> Hi Russel,

Hi Sa,

> Can you please tell us what is the status of this patch? It fixes the
> issue for us ([1]), but we are waiting for it to be merged.
> 
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
> Thanks!
> 
> [1] https://bugs.linaro.org/show_bug.cgi?id=3297

It's queued for the next merge window because it's not a regression,
but rather a large patch to fix a long standing bug.  Given that the
bug has been around for a long time (probably since kprobes was
originally added), I see no reason to push it for the -rc kernels,
especially given that it has taken about a month to get any kind of
feedback on this particular patch.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
