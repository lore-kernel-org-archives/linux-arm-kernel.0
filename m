From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 23 Sep 2013 12:34:48 +0530
Subject: [RFC PATCH 1/2] Aarch64: KGDB: Add Basic KGDB support
In-Reply-To: <20130916112943.GG21320@mudshark.cambridge.arm.com>
References: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
 <1379321750-907-2-git-send-email-vijay.kilari@gmail.com>
 <20130916112943.GG21320@mudshark.cambridge.arm.com>
Message-ID: <CALicx6v1eGHRwWPrjzihzBZxCu8t1vpMoq-YfutSm4mRmP6gEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 4:59 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hello,
>
> [Adding Jason for regset question later on]
>
> On Mon, Sep 16, 2013 at 09:55:49AM +0100, vijay.kilari at gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>
>> Add KGDB debug support for kernel debugging.
>> With these changes, basic KGDB debugging is possible.
>> Target waits for GDB tool on hitting compile time inserted
>> break point and GDB tool can establish connection with target
>> and can set/clear breakpoints and continue.
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>> ---
>>  arch/arm64/include/asm/kgdb.h |   61 +++++++++
>>  arch/arm64/kernel/Makefile    |    1 +
>>  arch/arm64/kernel/kgdb.c      |  287 +++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 349 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
>> new file mode 100644
>> index 0000000..5b5f59e
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kgdb.h
>> @@ -0,0 +1,61 @@
>> +/*
>> + * Aarch64 KGDB support
>> + *
>> + * Author: Vijaya Kumar <vijaya.kumar@caviumnetworks.com>
>> + *
>> + * contents are extracted from arch/arm/include/kgdb.h
>> + *
>> + */
>> +
>> +#ifndef __ARM_KGDB_H__
>> +#define __ARM_KGDB_H__
>> +
>> +#include <linux/ptrace.h>
>> +
>> +/*
>> + * Break Instruction encoding
>> + */
>> +
>> +#define BREAK_INSTR_SIZE               4
>> +#define KGDB_BREAKINST_ESR_VAL         0xf2000000
>> +#define KGDB_COMPILED_BREAK_ESR_VAL    0xf2000001
>
> These ESR values are tied directly to your immediate choices for the BRK
> instruction, so I'd rather they were constructed that way (then we can
> #define all of the immediates in a common header, like debug-monitors.h).
>

Yes, these values are constructed. However to distinguish between
normal break point and compile time break point, I have chosen value
0x1 as immediate
value.

>> +#define CACHE_FLUSH_IS_SAFE            1
>> +
>> +#ifndef        __ASSEMBLY__
>> +
>> +static inline void arch_kgdb_breakpoint(void)
>> +{
>> +#ifndef __ARMEB__
>> +     asm(".word 0xd4200020");
>> +#else
>> +     asm(".word 0x200020d4");
>> +#endif
>
> Huh? Instructions are always little endian. Why can't you just do:
>
>   asm ("brk %0" :: "I" (ARM64_KGDB_BRK_IMM));
>
> or something like that?
>
OK. I will check with this

>> +}
>> +
>> +
>> +extern void kgdb_handle_bus_error(void);
>> +extern int kgdb_fault_expected;
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +/*
>> + * gdb is expecting the following registers layout.
>> + *
>> + * r0-r31: 64bit each
>> + * f0-f31: unused
>> + * fps:    unused
>> + *
>> + */
>> +
>> +#define _GP_REGS             34
>> +#define _FP_REGS             32
>> +#define _EXTRA_REGS          2
>> +#define GDB_MAX_REGS         (_GP_REGS + (_FP_REGS * 3) + _EXTRA_REGS)
>> +#define DBG_MAX_REG_NUM              (_GP_REGS + _FP_REGS + _EXTRA_REGS)
>
> This doesn't appear to match the comment above, and it's not obvious at all
> how you've laid things out. Could you improve the comment please?
>
>> +#define KGDB_MAX_NO_CPUS     1
>
> Where is this used?
Not used. I will correct it
>
>> +#define BUFMAX                       400
>
> Why did you choose this value? Are you sure it's big enough?
>
>> +#define NUMREGBYTES          (DBG_MAX_REG_NUM << 2)
>
> << 2? Are you sure?
>
 These values are used for defining size of buffer to be used.
This value is legacy and should be enough as there is no major
changes in GDB host side in terms of buffer requirement.

>> +
>> +#endif /* __ASM_KGDB_H__ */
>> +
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index f667a09..b46a177 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -20,6 +20,7 @@ arm64-obj-$(CONFIG_SMP)                     += smp.o smp_spin_table.o smp_psci.o
>>  arm64-obj-$(CONFIG_HW_PERF_EVENTS)   += perf_event.o
>>  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
>>  arm64-obj-$(CONFIG_EARLY_PRINTK)     += early_printk.o
>> +arm64-obj-$(CONFIG_KGDB)             += kgdb.o
>>
>>  obj-y                                        += $(arm64-obj-y) vdso/
>>  obj-$(CONFIG_ARM64_ILP32)            += vdsoilp32/
>
> ILP32 doesn't exist in mainline. Please write your patches against an
> upstream kernel.
>
OK

>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> new file mode 100644
>> index 0000000..a3a7712
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kgdb.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * Aarch64 KGDB support.
>> + *
>> + * most part of code copied from arch/arm/kernel/kgdb.c
>> + *
>> + * Author:  Vijaya Kumar K <vijaya.kumar@caviumnetworks.com>
>> + */
>> +
>> +#include <linux/irq.h>
>> +#include <linux/kdebug.h>
>> +#include <linux/kgdb.h>
>> +#include <asm/traps.h>
>> +#include <asm/debug-monitors.h>
>> +
>> +struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
>> +{
>> +     { "x0", 8, offsetof(struct pt_regs, regs[0])},
>> +     { "x1", 8, offsetof(struct pt_regs, regs[1])},
>> +     { "x2", 8, offsetof(struct pt_regs, regs[2])},
>> +     { "x3", 8, offsetof(struct pt_regs, regs[3])},
>> +     { "x4", 8, offsetof(struct pt_regs, regs[4])},
>> +     { "x5", 8, offsetof(struct pt_regs, regs[5])},
>> +     { "x6", 8, offsetof(struct pt_regs, regs[6])},
>> +     { "x7", 8, offsetof(struct pt_regs, regs[7])},
>> +     { "x8", 8, offsetof(struct pt_regs, regs[8])},
>> +     { "x9", 8, offsetof(struct pt_regs, regs[9])},
>> +     { "x10", 8, offsetof(struct pt_regs, regs[10])},
>> +     { "x11", 8, offsetof(struct pt_regs, regs[11])},
>> +     { "x12", 8, offsetof(struct pt_regs, regs[12])},
>> +     { "x13", 8, offsetof(struct pt_regs, regs[13])},
>> +     { "x14", 8, offsetof(struct pt_regs, regs[14])},
>> +     { "x15", 8, offsetof(struct pt_regs, regs[15])},
>> +     { "x16", 8, offsetof(struct pt_regs, regs[16])},
>> +     { "x17", 8, offsetof(struct pt_regs, regs[17])},
>> +     { "x18", 8, offsetof(struct pt_regs, regs[18])},
>> +     { "x19", 8, offsetof(struct pt_regs, regs[19])},
>> +     { "x20", 8, offsetof(struct pt_regs, regs[20])},
>> +     { "x21", 8, offsetof(struct pt_regs, regs[21])},
>> +     { "x22", 8, offsetof(struct pt_regs, regs[22])},
>> +     { "x23", 8, offsetof(struct pt_regs, regs[23])},
>> +     { "x24", 8, offsetof(struct pt_regs, regs[24])},
>> +     { "x25", 8, offsetof(struct pt_regs, regs[25])},
>> +     { "x26", 8, offsetof(struct pt_regs, regs[26])},
>> +     { "x27", 8, offsetof(struct pt_regs, regs[27])},
>> +     { "x28", 8, offsetof(struct pt_regs, regs[28])},
>> +     { "x29", 8, offsetof(struct pt_regs, regs[29])},
>> +     { "x30", 8, offsetof(struct pt_regs, regs[30])},
>> +     { "sp", 8, offsetof(struct pt_regs, sp)},
>> +     { "pc", 8, offsetof(struct pt_regs, pc)},
>> +     { "cpsr", 4, offsetof(struct pt_regs, pstate)},
>
> There isn't a cpsr. Please use the correct terminology. Also, isn't there
> some dependency on GDB here, so this interface should be fixed already?
>
OK. I will correct the terminology
Yes, GDB dependency is in terms of offset and size.

>> +     { "v0", 16, -1 },
>> +     { "v1", 16, -1 },
>> +     { "v2", 16, -1 },
>> +     { "v3", 16, -1 },
>> +     { "v4", 16, -1 },
>> +     { "v5", 16, -1 },
>> +     { "v6", 16, -1 },
>> +     { "v7", 16, -1 },
>> +     { "v8", 16, -1 },
>> +     { "v9", 16, -1 },
>> +     { "v10", 16, -1 },
>> +     { "v11", 16, -1 },
>> +     { "v12", 16, -1 },
>> +     { "v13", 16, -1 },
>> +     { "v14", 16, -1 },
>> +     { "v15", 16, -1 },
>> +     { "v16", 16, -1 },
>> +     { "v17", 16, -1 },
>> +     { "v18", 16, -1 },
>> +     { "v19", 16, -1 },
>> +     { "v20", 16, -1 },
>> +     { "v21", 16, -1 },
>> +     { "v22", 16, -1 },
>> +     { "v23", 16, -1 },
>> +     { "v24", 16, -1 },
>> +     { "v25", 16, -1 },
>> +     { "v26", 16, -1 },
>> +     { "v27", 16, -1 },
>> +     { "v28", 16, -1 },
>> +     { "v29", 16, -1 },
>> +     { "v30", 16, -1 },
>> +     { "v31", 16, -1 },
>> +     { "fpsr", 4, -1 },
>> +     { "fpcr", 4, -1 },
>
> Ard added support for NEON in the kernel, so maybe it's worth reporting the
> vector regs after all.
>
>> +};
>> +
>> +char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>> +{
>> +     if (regno >= DBG_MAX_REG_NUM || regno < 0)
>> +             return NULL;
>> +
>> +     if (dbg_reg_def[regno].offset != -1)
>> +             memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>> +                     dbg_reg_def[regno].size);
>> +     else
>> +             memset(mem, 0, dbg_reg_def[regno].size);
>> +     return dbg_reg_def[regno].name;
>> +}
>> +
>> +int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>> +{
>> +     if (regno >= DBG_MAX_REG_NUM || regno < 0)
>> +             return -EINVAL;
>> +
>> +     if (dbg_reg_def[regno].offset != -1)
>> +             memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
>> +                     dbg_reg_def[regno].size);
>> +     return 0;
>> +}
>
> Has nobody ported this lot to use regsets yet? I don't see why we have to
> reinvent all of the "please copy register x from register file y to this
> buffer" logic all over again.
>
Nothing I am aware of this.

>> +
>> +void
>> +sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>> +{
>> +     struct pt_regs *thread_regs;
>> +     int regno;
>> +     int i;
>> +
>> +     /* Just making sure... */
>> +     if (task == NULL)
>> +             return;
>> +
>> +     /* Initialize to zero */
>> +     for (regno = 0; regno < GDB_MAX_REGS; regno++)
>> +             gdb_regs[regno] = 0;
>> +
>> +     thread_regs = task_pt_regs(task);
>> +
>> +     for(i = 0; i < 31; i++)
>> +             gdb_regs[i] = thread_regs->regs[i];
>> +
>> +     gdb_regs[31] = thread_regs->sp;
>> +     gdb_regs[32] = thread_regs->pc;
>> +     gdb_regs[33] = thread_regs->pstate;
>> +}
>> +
>> +void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>> +{
>> +     regs->pc = pc;
>> +}
>> +
>> +static int compiled_break;
>> +int kgdb_arch_handle_exception(int exception_vector, int signo, int err_code,
>> +                            char *remcom_in_buffer, char *remcom_out_buffer,
>> +                            struct pt_regs *linux_regs)
>> +{
>> +     unsigned long addr;
>> +     char *ptr;
>> +     int err;
>> +
>> +     switch (remcom_in_buffer[0]) {
>> +     case 'D':
>> +     case 'k':
>
> What are the 'D' and 'k' packets? Do they actually get used for AArch64?
> Again, comments would help in explaining the protocol.
>
D & k packets are used for GDB detach & Kill packets. This is as good
as 'c' packet where in GDB is disconnected and allows target to continue
to run. So architecture handling of 'D','k' & 'c' are same

>> +     case 'c':
>> +             /*
>> +              * Try to read optional parameter, pc unchanged if no parm.
>> +              * If this was a compiled breakpoint, we need to move
>> +              * to the next instruction or we will just breakpoint
>> +              * over and over again.
>> +              */
>> +             ptr = &remcom_in_buffer[1];
>> +             if (kgdb_hex2long(&ptr, &addr))
>> +                     linux_regs->pc = addr;
>> +             else if (compiled_break == 1)
>> +                     linux_regs->pc += 4;
>> +
>> +             compiled_break = 0;
>
> I'm not familiar with how kdgb works, but why does this not cause problems
> with SMP? Does KGDB just park the secondaries and only deal with exceptions
> on the primary CPU?
>
Yes, KGDB parks other CPU's and only once CPU (primary / Secondary) will
be responding to GDB requests

>> +void kgdb_arch_exit(void)
>> +{
>> +     unregister_break_hook(&kgdb_brkpt_hook);
>> +     unregister_break_hook(&kgdb_compiled_brkpt_hook);
>> +     unregister_die_notifier(&kgdb_notifier);
>> +}
>> +
>> +/*
>> + * Register our undef instruction hooks with ARM undef core.
>> + * We regsiter a hook specifically looking for the KGB break inst
>> + * and we handle the normal undef case within the do_undefinstr
>> + * handler.
>> + */
>> +struct kgdb_arch arch_kgdb_ops = {
>> +#ifndef __ARMEB__
>> +     .gdb_bpt_instr          = {0x00, 0x00, 0x20, 0xd4}
>> +#else /* ! __ARMEB__ */
>> +     .gdb_bpt_instr          = {0xd4, 0x20, 0x00, 0x00}
>> +#endif
>
> __ARMEB__????
 ARMEB is for Big endian encoding.
>
> Will
