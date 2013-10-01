From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Tue, 1 Oct 2013 16:23:01 +0530
Subject: [PATCH v2 2/3] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <20130930163654.GJ26036@mudshark.cambridge.arm.com>
References: <1380534251-4464-1-git-send-email-vijay.kilari@gmail.com>
 <1380534251-4464-3-git-send-email-vijay.kilari@gmail.com>
 <20130930163654.GJ26036@mudshark.cambridge.arm.com>
Message-ID: <CALicx6vpX6nm=zdBZTY57EgPRphcjMzwFxug6CAa_U21u4_4Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 10:06 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Sep 30, 2013 at 10:44:10AM +0100, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> Add KGDB debug support for kernel debugging.
>> With this patch, basic KGDB debugging is possible.GDB register
>> layout is updated and GDB tool can establish connection with
>> target and can set/clear breakpoints.
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>> ---
>>  arch/arm64/include/asm/debug-monitors.h |   10 ++
>>  arch/arm64/include/asm/kgdb.h           |   81 +++++++++
>>  arch/arm64/kernel/Makefile              |    1 +
>>  arch/arm64/kernel/kgdb.c                |  298 +++++++++++++++++++++++++++++++
>>  4 files changed, 390 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
>> index 19e429e..ed376ce 100644
>> --- a/arch/arm64/include/asm/debug-monitors.h
>> +++ b/arch/arm64/include/asm/debug-monitors.h
>> @@ -28,6 +28,16 @@
>>  #define DBG_ESR_EVT_HWWP       0x2
>>  #define DBG_ESR_EVT_BRK                0x6
>>
>> +/*
>> + * Break point instruction encoding
>> + */
>> +#define BREAK_INSTR_SIZE               4
>> +#define KGDB_BREAKINST_ESR_VAL         0xf2000000
>> +#define KGDB_COMPILED_BREAK_ESR_VAL    0xf2000001
>> +#define KGDB_ARM64_COMPILE_BRK_IMM     1
>> +#define CACHE_FLUSH_IS_SAFE            1
>
> #define DBG_BRK_KGDB_DYN        0
> #define DBG_BRK_KGDB_COMPILED   1
>
> #define DBG_ESR_VAL_BRK(x)      (0xf2000000 | ((x) & 0xffff))
>
> Then you can use the latter to construct your ESR values dynamically and
> adding a new brk handler is straightforward.
>
OK, agreed

>> diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
>> new file mode 100644
>> index 0000000..15b36fd
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kgdb.h
>> @@ -0,0 +1,81 @@
>> +/*
>> + * AArch64 KGDB support
>> + *
>> + * Based on arch/arm/include/kgdb.h
>> + *
>> + * Copyright (C) 2013 Cavium Inc.
>> + * Author: Vijaya Kumar K <vijaya.kumar@caviumnetworks.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARM_KGDB_H__
>> +#define __ARM_KGDB_H__
>> +
>> +#include <linux/ptrace.h>
>> +#include <asm/debug-monitors.h>
>> +
>> +#ifndef        __ASSEMBLY__
>> +
>> +static inline void arch_kgdb_breakpoint(void)
>> +{
>> +       asm ("brk %0" :: "I" (KGDB_ARM64_COMPILE_BRK_IMM));
>> +}
>
> Hmm, I need to find me a compiler guy, but I don't have much faith in this
> function in the face of inlining. Sure a breakpoint needs to happen at a
> specific point in the program? If so, why can't GCC re-order this asm block
> as it likes?
>
> Or is there a restricted use-case for compiled breakpoints in kgdb?
>
As per Andrew,
arch_kgdb_breakpoint is declared as static inline for the x86, arm, tile
and powerpc.  Since the inline-asm does not have any output constraints
it is considered volatile just like if you declare the inline-asm as volatile.
The compiler might reorder some stuff around it due to all uses being explicit
just like any other volatile inline-asm.

In fact, the arch_kgdb_breakpoint is called from only one place from
kernel/debug/debug_core.c and there is no way for the compiler to
reorder the block
as it has two write barriers around it:
        wmb(); /* Sync point before breakpoint */
        arch_kgdb_breakpoint();
        wmb(); /* Sync point after breakpoint */

>> +void
>> +sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>> +{
>> +       struct pt_regs *thread_regs;
>> +       int regno;
>> +       int i;
>> +
>> +       /* Just making sure... */
>> +       if (task == NULL)
>> +               return;
>
> Erm... that comment just raises more questions. I appreciate ARM has the
> same check, but why doesn't x86? Can task *actually* be NULL?
>
generally, the task will not be NULL. The check made because the
caller (gdbstub.c)
fetches task information from gdb global structure and calls this function.
This helps in case the caller fails to pass task info. I think should not be
problem with this check. In fact this is legacy code

>> +
>> +       /* Initialize to zero */
>> +       for (regno = 0; regno < DBG_MAX_REG_NUM; regno++)
>> +               gdb_regs[regno] = 0;
>
> memset?
OK. agreed
>
>> +
>> +       thread_regs             = task_pt_regs(task);
>> +
>> +       for(i = 0; i < 31; i++)
>> +               gdb_regs[i] = thread_regs->regs[i];
>
> memcpy?
>
OK. agreed
>> +int kgdb_arch_handle_exception(int exception_vector, int signo,
>> +                              int err_code, char *remcom_in_buffer,
>> +                              char *remcom_out_buffer,
>> +                              struct pt_regs *linux_regs)
>> +{
>> +       unsigned long addr;
>> +       char *ptr;
>> +       int err;
>> +
>> +       switch (remcom_in_buffer[0]) {
>> +       case 'D':
>> +       case 'k':
>> +       case 'c':
>> +               /*
>> +                * Packet D (Detach), k (kill) & c (Continue) requires
>> +                * to continue executing. Set pc to required address.
>> +                * Try to read optional parameter, pc unchanged if no parm.
>> +                * If this was a compiled breakpoint, we need to move
>> +                * to the next instruction or we will just breakpoint
>> +                * over and over again.
>> +                */
>> +               ptr = &remcom_in_buffer[1];
>> +               if (kgdb_hex2long(&ptr, &addr))
>> +                       kgdb_arch_set_pc(linux_regs, addr);
>> +               else if (compiled_break == 1)
>> +                       kgdb_arch_set_pc(linux_regs, linux_regs->pc + 4);
>> +
>> +               compiled_break = 0;
>> +
>> +               err = 0;
>> +               break;
>> +       default:
>> +               err = -1;
>> +       }
>> +       return err;
>> +}
>> +
>> +static int
>> +kgdb_brk_fn(struct pt_regs *regs, unsigned int esr, unsigned long addr)
>> +{
>> +       kgdb_handle_exception(1, SIGTRAP, 0, regs);
>> +       return 0;
>> +}
>> +
>> +static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr,
>> +                               unsigned long addr)
>> +{
>> +       compiled_break = 1;
>> +       kgdb_handle_exception(1, SIGTRAP, 0, regs);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct break_hook kgdb_brkpt_hook = {
>> +       .esr_mask               = 0xffffffff,
>> +       .esr_val                = KGDB_BREAKINST_ESR_VAL,
>> +       .fn                     = kgdb_brk_fn
>> +};
>> +
>> +static struct break_hook kgdb_compiled_brkpt_hook = {
>> +       .esr_mask               = 0xffffffff,
>> +       .esr_val                = KGDB_COMPILED_BREAK_ESR_VAL,
>> +       .fn                     = kgdb_compiled_brk_fn
>> +};
>> +
>> +static void kgdb_call_nmi_hook(void *ignored)
>> +{
>> +       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>> +}
>> +
>> +void kgdb_roundup_cpus(unsigned long flags)
>> +{
>> +       local_irq_enable();
>> +       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>> +       local_irq_disable();
>> +}
>> +
>> +static int __kgdb_notify(struct die_args *args, unsigned long cmd)
>> +{
>> +       struct pt_regs *regs = args->regs;
>> +
>> +       if (kgdb_handle_exception(1, args->signr, cmd, regs))
>> +               return NOTIFY_DONE;
>> +       return NOTIFY_STOP;
>> +}
>> +
>> +static int
>> +kgdb_notify(struct notifier_block *self, unsigned long cmd, void *ptr)
>> +{
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       local_irq_save(flags);
>> +       ret = __kgdb_notify(ptr, cmd);
>> +       local_irq_restore(flags);
>> +
>> +       return ret;
>> +}
>> +
>> +static struct notifier_block kgdb_notifier = {
>> +       .notifier_call  = kgdb_notify,
>> +       .priority       = -INT_MAX,
>> +};
>> +
>> +
>> +/*
>> + *     kgdb_arch_init - Perform any architecture specific initalization.
>> + *
>> + *     This function will handle the initalization of any architecture
>> + *     specific callbacks.
>> + */
>> +int kgdb_arch_init(void)
>> +{
>> +       int ret = register_die_notifier(&kgdb_notifier);
>> +
>> +       if (ret != 0)
>> +               return ret;
>> +
>> +       register_break_hook(&kgdb_brkpt_hook);
>> +       register_break_hook(&kgdb_compiled_brkpt_hook);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + *     kgdb_arch_exit - Perform any architecture specific uninitalization.
>> + *
>> + *     This function will handle the uninitalization of any architecture
>> + *     specific callbacks, for dynamic registration and unregistration.
>> + */
>> +void kgdb_arch_exit(void)
>> +{
>> +       unregister_break_hook(&kgdb_brkpt_hook);
>> +       unregister_break_hook(&kgdb_compiled_brkpt_hook);
>> +       unregister_die_notifier(&kgdb_notifier);
>> +}
>> +
>> +/*
>> + * ARM instructions are always in LE.
>> + * Break instruction is encoded in LE format
>> + */
>> +struct kgdb_arch arch_kgdb_ops = {
>> +       .gdb_bpt_instr          = {0x00, 0x00, 0x20, 0xd4}
>
> Again, you should probably try and encode the dynamic breakpoint immediate
> in here (which is sadly offset by 5 bits in the instruction encoding).
>
Yes, I propose to change like this

#define  KGDB_DYN_BRK_INS_BYTE0  ((KGDB_DYN_DGB_BRK_IMM & 0x7) << 5)
#define  KGDB_DYN_BRK_INS_BYTE1  ((KGDB_DYN_DGB_BRK_IMM & 0x7f8) >> 3)
#define  KGDB_DYN_BRK_INS_BYTE2  (0x20 | \
                                 ((KGDB_DYN_DGB_BRK_IMM & 0xf800) >> 11))
#define  KGDB_DYN_BRK_INS_BYTE3  0xd4

struct kgdb_arch arch_kgdb_ops = {
        .gdb_bpt_instr          = {
                KGDB_DYN_BRK_INS_BYTE0,
                KGDB_DYN_BRK_INS_BYTE1,
                KGDB_DYN_BRK_INS_BYTE2,
                KGDB_DYN_BRK_INS_BYTE3
        }
};

> Will
