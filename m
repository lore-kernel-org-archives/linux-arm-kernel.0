From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Fri, 10 Feb 2017 10:54:57 +0100
Subject: [PATCHv2] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170207191829.GA27190@nuc>
References: <1485300291-29722-1-git-send-email-abelvesa@linux.com>
 <CACh+v5Nav1XQMUZpVwjNjGtyz_WiNfpd+oQnGgCxncZOYnVomA@mail.gmail.com>
 <20170207191829.GA27190@nuc>
Message-ID: <CACh+v5OR+uuDoUFCvfuyywKVk39=phU7scuRp6NE_ROruCo=Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-07 20:18 GMT+01:00 Abel Vesa <abelvesa@gmail.com>:
> On Wed, Jan 25, 2017 at 07:30:32PM +0100, Jean-Jacques Hiblot wrote:
>
>> Abel, I tested it partially.
>
> OK, so I managed to find exactly what is happening.
>
>> It's seems OK if I have FRAME_POINTER enabled and it breaks otherwise.
>
> FRAME_POINTER is needed by OLD_MCOUNT.
>
> OLD_MCOUNT is needed by __ftrace_modify_code in order to be able to do set_kernel_text_rw.
> (The other implementation does not allow writing to kernel text therefore the warning
> happens)

That seems strange. It shouldn't make a difference whether the
old_mcount is enabled or not, we need to be able to modify the code.
IMO the ARM implementation of __ftrace_modify_code() and
arch_ftrace_update_code() must not be excluded when CONFIG_OLD_MCOUNT
is not defined.

>
> If you try the same thing without the patch you will get an "Invalid argument" at
> module loading.
>
>>
>> My test case attaches a  tracing handler to a function "myfunc":
>>
>> static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
>> .func = jjh_ftrace_handler,
>> .flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_DYNAMIC,
>> };
>>
>> ftrace_set_filter(&kprobe_ftrace_ops,  "myfunc", 4, 0);
>> register_ftrace_function(&kprobe_ftrace_ops);
>>
>> I won't send the actual code because it's too messy. If you need help
>> to reproduce, I'll try to extract the relevant part.
>>
>> Before the crash I observe the following warning.
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 9 at kernel/trace/ftrace.c:2526
>> ftrace_modify_all_code+0xd8/0x158
>> Modules linked in: jjh_test(+)
>> CPU: 0 PID: 9 Comm: migration/0 Tainted: G        W       4.7.0+ #53
>> Hardware name: ARM-Versatile Express
>> [<8010f7bc>] (unwind_backtrace) from [<8010b6f8>] (show_stack+0x18/0x1c)
>> [<8010b6f8>] (show_stack) from [<803a1548>] (dump_stack+0x80/0xa0)
>> [<803a1548>] (dump_stack) from [<8011ef20>] (__warn+0xe0/0x10c)
>> [<8011ef20>] (__warn) from [<8011ef74>] (warn_slowpath_null+0x28/0x30)
>> [<8011ef74>] (warn_slowpath_null) from [<8019d2a4>]
>> (ftrace_modify_all_code+0xd8/0x158)
>> [<8019d2a4>] (ftrace_modify_all_code) from [<8019d330>]
>> (__ftrace_modify_code+0xc/0x14)
>> [<8019d330>] (__ftrace_modify_code) from [<80198908>]
>> (multi_cpu_stop+0xe8/0x114)
>> [<80198908>] (multi_cpu_stop) from [<80198588>] (cpu_stopper_thread+0x60/0x134)
>> [<80198588>] (cpu_stopper_thread) from [<8013f428>]
>> (smpboot_thread_fn+0x148/0x1c4)
>> [<8013f428>] (smpboot_thread_fn) from [<8013c00c>] (kthread+0xe0/0xfc)
>> [<8013c00c>] (kthread) from [<80107db8>] (ret_from_fork+0x14/0x3c)
>> ---[ end trace f7d50cc2a4627fb1 ]---
>>
>> Jean-Jacques
>>
>>
>>
>>
>> 2017-01-25 0:24 GMT+01:00 Abel Vesa <abelvesa@linux.com>:
>> > The DYNAMIC_FTRACE_WITH_REGS configuration makes it possible for a ftrace
>> > operation to specify if registers need to saved/restored by the ftrace handler.
>> > This is needed by kgraft and possibly other ftrace-based tools, and the ARM
>> > architecture is currently lacking this feature. It would also be the first step
>> > to support the "Kprobes-on-ftrace" optimization on ARM.
>> >
>> > This patch introduces a new ftrace handler that stores the registers on the
>> > stack before calling the next stage. The registers are restored from the stack
>> > before going back to the instrumented function.
>> >
>> > A side-effect of this patch is to activate the support for ftrace_modify_call()
>> > as it defines ARCH_SUPPORTS_FTRACE_OPS for the ARM architecture.
>> >
>> > Signed-off-by: Abel Vesa <abelvesa@linux.com>
>> > ---
>> >  arch/arm/Kconfig               |  1 +
>> >  arch/arm/include/asm/ftrace.h  |  4 +++
>> >  arch/arm/kernel/entry-ftrace.S | 79 ++++++++++++++++++++++++++++++++++++++++++
>> >  arch/arm/kernel/ftrace.c       | 33 ++++++++++++++++++
>> >  4 files changed, 117 insertions(+)
>> >
>> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > index 186c4c2..db40973 100644
>> > --- a/arch/arm/Kconfig
>> > +++ b/arch/arm/Kconfig
>> > @@ -50,6 +50,7 @@ config ARM
>> >         select HAVE_DMA_API_DEBUG
>> >         select HAVE_DMA_CONTIGUOUS if MMU
>> >         select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
>
> The solution is to replace this:
>> > +       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> with this:
> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE && OLD_MCOUNT
>
>> >         select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>> >         select HAVE_EXIT_THREAD
>> >         select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
>> > diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
>> > index 22b7311..f379881 100644
>> > --- a/arch/arm/include/asm/ftrace.h
>> > +++ b/arch/arm/include/asm/ftrace.h
>> > @@ -1,6 +1,10 @@
>> >  #ifndef _ASM_ARM_FTRACE
>> >  #define _ASM_ARM_FTRACE
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +#define ARCH_SUPPORTS_FTRACE_OPS 1
>> > +#endif
>> > +
>> >  #ifdef CONFIG_FUNCTION_TRACER
>> >  #define MCOUNT_ADDR            ((unsigned long)(__gnu_mcount_nc))
>> >  #define MCOUNT_INSN_SIZE       4 /* sizeof mcount call */
>> > diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
>> > index c73c403..fcdcc3a 100644
>> > --- a/arch/arm/kernel/entry-ftrace.S
>> > +++ b/arch/arm/kernel/entry-ftrace.S
>> > @@ -92,12 +92,74 @@
>> >  2:     mcount_exit
>> >  .endm
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +
>> > +.macro __ftrace_regs_caller
>> > +
>> > +       add     ip, sp, #4      @ move in IP the value of SP as it was
>> > +                               @ before the push {lr} of the mcount mechanism
>> > +       stmdb   sp!, {ip,lr,pc}
>> > +       stmdb   sp!, {r0-r11,lr}
>> > +
>> > +       @ stack content at this point:
>> > +       @ 0  4          44    48   52       56   60   64
>> > +       @ RO | R1 | ... | R11 | LR | SP + 4 | LR | PC | previous LR |
>> > +
>> > +       mov r3, sp                              @ struct pt_regs*
>> > +       ldr r2, =function_trace_op
>> > +       ldr r2, [r2]                            @ pointer to the current
>> > +                                               @ function tracing op
>> > +       ldr     r1, [sp, #64]                   @ lr of instrumented func
>> > +       mcount_adjust_addr      r0, lr          @ instrumented function
>> > +
>> > +       .globl ftrace_regs_call
>> > +ftrace_regs_call:
>> > +       bl      ftrace_stub
>> > +
>> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> > +       .globl ftrace_graph_regs_call
>> > +ftrace_graph_regs_call:
>> > +       mov     r0, r0
>> > +#endif
>> > +       ldr     lr, [sp, #64]           @ get the previous LR value from stack
>> > +       ldmia   sp, {r0-r11, ip, sp}    @ pop the saved registers INCLUDING
>> > +                                       @ the stack pointer
>> > +       ret     ip
>> > +.endm
>> > +
>> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> > +.macro __ftrace_graph_regs_caller
>> > +
>> > +       sub     r0, fp, #4              @ lr of instrumented routine (parent)
>> > +
>> > +       @ called from __ftrace_regs_caller
>> > +       ldr     r1, [sp, #56]           @ instrumented routine (func)
>> > +       mcount_adjust_addr      r1, r1
>> > +
>> > +       sub     r2, r0, #4              @ frame pointer
>> > +       bl      prepare_ftrace_return
>> > +
>> > +       ldr     lr, [sp, #64]           @ restore lr from the stack
>> > +       ldmia   sp, {r0-r11, ip, sp}    @ restore r0 through sp
>> > +       ret     ip
>> > +
>> > +.endm
>> > +#endif
>> > +#endif
>> > +
>> >  .macro __ftrace_caller suffix
>> >         mcount_enter
>> >
>> >         mcount_get_lr   r1                      @ lr of instrumented func
>> >         mcount_adjust_addr      r0, lr          @ instrumented function
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +       ldr r2, =function_trace_op
>> > +       ldr r2, [r2]                            @ pointer to the current
>> > +                                               @ function tracing op
>> > +       mov r3, #0                              @ regs is NULL
>> > +#endif
>> > +
>> >         .globl ftrace_call\suffix
>> >  ftrace_call\suffix:
>> >         bl      ftrace_stub
>> > @@ -212,6 +274,15 @@ UNWIND(.fnstart)
>> >         __ftrace_caller
>> >  UNWIND(.fnend)
>> >  ENDPROC(ftrace_caller)
>> > +
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +ENTRY(ftrace_regs_caller)
>> > +UNWIND(.fnstart)
>> > +       __ftrace_regs_caller
>> > +UNWIND(.fnend)
>> > +ENDPROC(ftrace_regs_caller)
>> > +#endif
>> > +
>> >  #endif
>> >
>> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> > @@ -220,6 +291,14 @@ UNWIND(.fnstart)
>> >         __ftrace_graph_caller
>> >  UNWIND(.fnend)
>> >  ENDPROC(ftrace_graph_caller)
>> > +
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +ENTRY(ftrace_graph_regs_caller)
>> > +UNWIND(.fnstart)
>> > +       __ftrace_graph_regs_caller
>> > +UNWIND(.fnend)
>> > +ENDPROC(ftrace_graph_regs_caller)
>> > +#endif
>> >  #endif
>> >
>> >  .purgem mcount_enter
>> > diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
>> > index 3f17594..d8d4753 100644
>> > --- a/arch/arm/kernel/ftrace.c
>> > +++ b/arch/arm/kernel/ftrace.c
>> > @@ -139,6 +139,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>> >
>> >         ret = ftrace_modify_code(pc, 0, new, false);
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +       if (!ret) {
>> > +               pc = (unsigned long)&ftrace_regs_call;
>> > +               new = ftrace_call_replace(pc, (unsigned long)func);
>> > +
>> > +               ret = ftrace_modify_code(pc, 0, new, false);
>> > +       }
>> > +#endif
>> > +
>> >  #ifdef CONFIG_OLD_MCOUNT
>> >         if (!ret) {
>> >                 pc = (unsigned long)&ftrace_call_old;
>> > @@ -157,6 +166,20 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>> >         unsigned long ip = rec->ip;
>> >
>> >         old = ftrace_nop_replace(rec);
>> > +
>> > +       new = ftrace_call_replace(ip, adjust_address(rec, addr));
>> > +
>> > +       return ftrace_modify_code(rec->ip, old, new, true);
>> > +}
>> > +
>
> Also this function implementation needs to be in an #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS clause:
>
>> > +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>> > +                               unsigned long addr)
>> > +{
>> > +       unsigned long new, old;
>> > +       unsigned long ip = rec->ip;
>> > +
>> > +       old = ftrace_call_replace(ip, adjust_address(rec, old_addr));
>> > +
>> >         new = ftrace_call_replace(ip, adjust_address(rec, addr));
>> >
>> >         return ftrace_modify_code(rec->ip, old, new, true);
>> > @@ -229,6 +252,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>> >  extern unsigned long ftrace_graph_call;
>> >  extern unsigned long ftrace_graph_call_old;
>> >  extern void ftrace_graph_caller_old(void);
>> > +extern unsigned long ftrace_graph_regs_call;
>> > +extern void ftrace_graph_regs_caller(void);
>> >
>> >  static int __ftrace_modify_caller(unsigned long *callsite,
>> >                                   void (*func) (void), bool enable)
>> > @@ -251,6 +276,14 @@ static int ftrace_modify_graph_caller(bool enable)
>> >                                      ftrace_graph_caller,
>> >                                      enable);
>> >
>> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> > +       if (!ret)
>> > +               ret = __ftrace_modify_caller(&ftrace_graph_regs_call,
>> > +                                    ftrace_graph_regs_caller,
>> > +                                    enable);
>> > +#endif
>> > +
>> > +
>> >  #ifdef CONFIG_OLD_MCOUNT
>> >         if (!ret)
>> >                 ret = __ftrace_modify_caller(&ftrace_graph_call_old,
>> > --
>> > 2.7.4
>> >
>
> I tested it and it works now. An update version of this patch will follow.
> (It also include all fixes for all the other comments on this thread)
>
> Thanks,
> Abel
