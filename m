From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Fri, 28 Feb 2014 16:38:58 +0530
Subject: [RFC v2 PATCH 1/1] ARM64: KGDB: Add FP/SIMD debug support
In-Reply-To: <CALicx6uRtxhj0+Fj98WtFAXssbV5G6sNQjkWikxaZnbMkBmWhA@mail.gmail.com>
References: <1384776417-29076-1-git-send-email-vijay.kilari@gmail.com>
 <1384776417-29076-2-git-send-email-vijay.kilari@gmail.com>
 <CAKv+Gu_yMFE7YLKG=KuiW-vCjbjkpWDjyBx+43PW4t32M7P22g@mail.gmail.com>
 <CALicx6t+V8Vt7u-8saV=e1KzK99D=_O_UsSvPrdMY3j9xR3opw@mail.gmail.com>
 <CAKv+Gu9-XqLmvZ1HhCKvgM5=BvZWbR8SSnb7oJzMqGja_LHbAw@mail.gmail.com>
 <CALicx6uRtxhj0+Fj98WtFAXssbV5G6sNQjkWikxaZnbMkBmWhA@mail.gmail.com>
Message-ID: <CALicx6v12DWQSqpP=pa_gJmyOqm4LmFHWc_9=n8Rt7M=krB+dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Nov 29, 2013 at 3:27 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Fri, Nov 29, 2013 at 2:57 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 29 November 2013 10:20, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>>> On Fri, Nov 29, 2013 at 2:23 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 18 November 2013 13:06,  <vijay.kilari@gmail.com> wrote:
>>>>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>>>
>>>>> Add KGDB debug support for FP/SIMD processor.This support
>>>>> only debugging of FP/SIMD in kernel mode.
>>>>> With this patch one can view or set FP/SIMD registers in
>>>>> kernel context
>>>>>
>>>>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/fpsimd.h |    1 +
>>>>>  arch/arm64/kernel/fpsimd.c      |    5 ++
>>>>>  arch/arm64/kernel/kgdb.c        |  105 +++++++++++++++++++++++++--------------
>>>>>  3 files changed, 73 insertions(+), 38 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
>>>>> index 609bc44..5039d6d 100644
>>>>> --- a/arch/arm64/include/asm/fpsimd.h
>>>>> +++ b/arch/arm64/include/asm/fpsimd.h
>>>>> @@ -60,6 +60,7 @@ extern void fpsimd_load_state(struct fpsimd_state *state);
>>>>>  extern void fpsimd_thread_switch(struct task_struct *next);
>>>>>  extern void fpsimd_flush_thread(void);
>>>>>  extern void fpsimd_reload_fpstate(void);
>>>>> +extern int  fpsimd_thread_state(void);
>>>>>
>>>>>  #endif
>>>>>
>>>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>>>> index 5b13c17..27604c1 100644
>>>>> --- a/arch/arm64/kernel/fpsimd.c
>>>>> +++ b/arch/arm64/kernel/fpsimd.c
>>>>> @@ -124,6 +124,11 @@ void fpsimd_flush_thread(void)
>>>>>         set_thread_flag(TIF_FOREIGN_FPSTATE);
>>>>>  }
>>>>>
>>>>> +int fpsimd_thread_state(void)
>>>>
>>>> Please use a meaningful name for the function. Currently, it returns
>>>> true iff 'current' is a non-kernel thread whose FPSIMD state is /not/
>>>> present in the FPSIMD register file. You should choose a name that
>>>> reflects that purpose.
>>>>
>>>  do you have any reason why only TIF_FOREIGN_FPSTATE flag is
>>> set only for non-kernel threads in kernel_neon_begin()?
>>>
>>
>> The purpose of the TIF_FOREIGN_FPSTATE flag is to convey that the
>> FPSIMD context should be restored before a task enters userland. A
>> kernel thread never enters userland by definition so the flag has no
>> meaning there.
>>
>>>>> +{
>>>>> +       return (current->mm && test_thread_flag(TIF_FOREIGN_FPSTATE)) ? 1 : 0;
>>>>> +}
>>>>> +
>>>>
>>>> As Will pointed out, the expression before ? already evaluates to 1 or
>>>> 0, so appending '? 1 : 0' is redundant.
>>>>
>>>>>  void fpsimd_reload_fpstate(void)
>>>>>  {
>>>>>         preempt_disable();
>>>>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>>>>> index f10f2ba..5e34852 100644
>>>>> --- a/arch/arm64/kernel/kgdb.c
>>>>> +++ b/arch/arm64/kernel/kgdb.c
>>>>> @@ -23,6 +23,14 @@
>>>>>  #include <linux/kdebug.h>
>>>>>  #include <linux/kgdb.h>
>>>>>  #include <asm/traps.h>
>>>>> +#include <asm/fpsimd.h>
>>>>> +
>>>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>>>> +/*
>>>>> + * Structure to hold FP/SIMD register contents
>>>>> + */
>>>>> +struct fpsimd_state kgdb_fpsimd_regs;
>>>>
>>>> 'static' if it's local to this source file
>>>>
>>>    OK
>>>>> +#endif
>>>>>
>>>>>  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>>>>>         { "x0", 8, offsetof(struct pt_regs, regs[0])},
>>>>> @@ -59,40 +67,40 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>>>>>         { "sp", 8, offsetof(struct pt_regs, sp)},
>>>>>         { "pc", 8, offsetof(struct pt_regs, pc)},
>>>>>         { "pstate", 4, offsetof(struct pt_regs, pstate)},
>>>>> -       { "v0", 16, -1 },
>>>>> -       { "v1", 16, -1 },
>>>>> -       { "v2", 16, -1 },
>>>>> -       { "v3", 16, -1 },
>>>>> -       { "v4", 16, -1 },
>>>>> -       { "v5", 16, -1 },
>>>>> -       { "v6", 16, -1 },
>>>>> -       { "v7", 16, -1 },
>>>>> -       { "v8", 16, -1 },
>>>>> -       { "v9", 16, -1 },
>>>>> -       { "v10", 16, -1 },
>>>>> -       { "v11", 16, -1 },
>>>>> -       { "v12", 16, -1 },
>>>>> -       { "v13", 16, -1 },
>>>>> -       { "v14", 16, -1 },
>>>>> -       { "v15", 16, -1 },
>>>>> -       { "v16", 16, -1 },
>>>>> -       { "v17", 16, -1 },
>>>>> -       { "v18", 16, -1 },
>>>>> -       { "v19", 16, -1 },
>>>>> -       { "v20", 16, -1 },
>>>>> -       { "v21", 16, -1 },
>>>>> -       { "v22", 16, -1 },
>>>>> -       { "v23", 16, -1 },
>>>>> -       { "v24", 16, -1 },
>>>>> -       { "v25", 16, -1 },
>>>>> -       { "v26", 16, -1 },
>>>>> -       { "v27", 16, -1 },
>>>>> -       { "v28", 16, -1 },
>>>>> -       { "v29", 16, -1 },
>>>>> -       { "v30", 16, -1 },
>>>>> -       { "v31", 16, -1 },
>>>>> -       { "fpsr", 4, -1 },
>>>>> -       { "fpcr", 4, -1 },
>>>>> +       { "v0", 16, offsetof(struct fpsimd_state, vregs[0])},
>>>>> +       { "v1", 16, offsetof(struct fpsimd_state, vregs[1])},
>>>>> +       { "v2", 16, offsetof(struct fpsimd_state, vregs[2])},
>>>>> +       { "v3", 16, offsetof(struct fpsimd_state, vregs[3])},
>>>>> +       { "v4", 16, offsetof(struct fpsimd_state, vregs[4])},
>>>>> +       { "v5", 16, offsetof(struct fpsimd_state, vregs[5])},
>>>>> +       { "v6", 16, offsetof(struct fpsimd_state, vregs[6])},
>>>>> +       { "v7", 16, offsetof(struct fpsimd_state, vregs[7])},
>>>>> +       { "v8", 16, offsetof(struct fpsimd_state, vregs[8])},
>>>>> +       { "v9", 16, offsetof(struct fpsimd_state, vregs[9])},
>>>>> +       { "v10", 16, offsetof(struct fpsimd_state, vregs[10])},
>>>>> +       { "v11", 16, offsetof(struct fpsimd_state, vregs[11])},
>>>>> +       { "v12", 16, offsetof(struct fpsimd_state, vregs[12])},
>>>>> +       { "v13", 16, offsetof(struct fpsimd_state, vregs[13])},
>>>>> +       { "v14", 16, offsetof(struct fpsimd_state, vregs[14])},
>>>>> +       { "v15", 16, offsetof(struct fpsimd_state, vregs[15])},
>>>>> +       { "v16", 16, offsetof(struct fpsimd_state, vregs[16])},
>>>>> +       { "v17", 16, offsetof(struct fpsimd_state, vregs[17])},
>>>>> +       { "v18", 16, offsetof(struct fpsimd_state, vregs[18])},
>>>>> +       { "v19", 16, offsetof(struct fpsimd_state, vregs[19])},
>>>>> +       { "v20", 16, offsetof(struct fpsimd_state, vregs[20])},
>>>>> +       { "v21", 16, offsetof(struct fpsimd_state, vregs[21])},
>>>>> +       { "v22", 16, offsetof(struct fpsimd_state, vregs[22])},
>>>>> +       { "v23", 16, offsetof(struct fpsimd_state, vregs[23])},
>>>>> +       { "v24", 16, offsetof(struct fpsimd_state, vregs[24])},
>>>>> +       { "v25", 16, offsetof(struct fpsimd_state, vregs[25])},
>>>>> +       { "v26", 16, offsetof(struct fpsimd_state, vregs[26])},
>>>>> +       { "v27", 16, offsetof(struct fpsimd_state, vregs[27])},
>>>>> +       { "v28", 16, offsetof(struct fpsimd_state, vregs[28])},
>>>>> +       { "v29", 16, offsetof(struct fpsimd_state, vregs[29])},
>>>>> +       { "v30", 16, offsetof(struct fpsimd_state, vregs[30])},
>>>>> +       { "v31", 16, offsetof(struct fpsimd_state, vregs[31])},
>>>>> +       { "fpsr", 4, offsetof(struct fpsimd_state, fpsr)},
>>>>> +       { "fpcr", 4, offsetof(struct fpsimd_state, fpcr)},
>>>>>  };
>>>>>
>>>>>  char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>>>>> @@ -100,11 +108,22 @@ char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>>>>>         if (regno >= DBG_MAX_REG_NUM || regno < 0)
>>>>>                 return NULL;
>>>>>
>>>>> -       if (dbg_reg_def[regno].offset != -1)
>>>>> +       if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
>>>>>                 memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>>>>>                        dbg_reg_def[regno].size);
>>>>> -       else
>>>>> +       else {
>>>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>>>
>>>> else if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON)) {
>>>>
>>>>> +               if (fpsimd_thread_state()) {
>>>>> +                       fpsimd_save_state(&kgdb_fpsimd_regs);
>>>>> +                       memcpy(mem, (void *)&kgdb_fpsimd_regs +
>>>>> +                                       dbg_reg_def[regno].offset,
>>>>> +                                       dbg_reg_def[regno].size);
>>>>
>>>> Why do this conditionally? Shouldn't kgdb return whatever is currently
>>>> present in the register file, regardless of whether 'current' is a
>>>> kernel thread or has had its FPSIMD state swapped out?
>>>> Also, one could wonder why this is dependent on KERNEL_MODE_NEON being set
>>>>
>>>
>>> KGDB, being kernel debugger it was thought that allow
>>> debugging only if kernel mode is supported.
>>> In fact, I proposed (previous email)  to remove this condition and
>>> allow to reading neon
>>> registers always and allow write only if neon is in kernel mode.
>>>
>>
>> I think KGDB is a special case here and should not considered as a
>> user of kernel mode NEON. So even writing the registers should
>> allowable regardless of this setting imo.
>>

 Can we avoid checking on NEON state and allow debugger to
access NEON registers irrespective of state to keep it simple?
and just compile config is enough?

>>> But completely removing this condition check and allowing to modify
>>> is user choice to ensure neon registers state.
>>>
>>> Will, Please let me know your opinion?
>>>
>>>>> +               } else
>>>>> +                       memset(mem, 0, dbg_reg_def[regno].size);
>>>>> +#else
>>>>>                 memset(mem, 0, dbg_reg_def[regno].size);
>>>>> +#endif
>>>>> +       }
>>>>>         return dbg_reg_def[regno].name;
>>>>>  }
>>>>>
>>>>> @@ -113,9 +132,19 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>>>>>         if (regno >= DBG_MAX_REG_NUM || regno < 0)
>>>>>                 return -EINVAL;
>>>>>
>>>>> -       if (dbg_reg_def[regno].offset != -1)
>>>>> +       if (dbg_reg_def[regno].offset != -1 && regno < _GP_REGS)
>>>>>                 memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
>>>>> -                      dbg_reg_def[regno].size);
>>>>> +                       dbg_reg_def[regno].size);
>>>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>>>> +       else {
>>>>> +               if (fpsimd_thread_state()) {
>>>>
>>>> Again, why the conditional?
>>>>
>>>>> +                       memcpy((void *)&kgdb_fpsimd_regs +
>>>>> +                                       dbg_reg_def[regno].offset,
>>>>> +                                       mem, dbg_reg_def[regno].size);
>>>>> +                       fpsimd_load_state(&kgdb_fpsimd_regs);
>>>>
>>>> Are you sure it is safe to clobber all the registers here? Shouldn't
>>>> you save the state first, do the memcpy() and then load?
>>>>
>>> yes it is safe. gdb read registers after every command so all registers
>>> are saved first before they are modified
>>>
>>
>> Does that imply that -after every command- the whole NEON state (32*16
>> bytes) is saved to kgdb_fpsimd_regs 32 times, each time to access the
>> contents of a single register?
>>
> Yes, I mentioned this overhead in cover letter. There is no single call to
> architecture specific code to read all the registers at once for gdb
> 'register read'
> command. The kgdb makes one call for every register read.
>
> I can think of saving this registers for every debug exception call,
> but that too is not optimized because gdb tool issues multiple step commands
> for every 'next' command.
> IMO, this little overhead is still ok as it is used only in step debugging
>
>> --
>> Ard.
