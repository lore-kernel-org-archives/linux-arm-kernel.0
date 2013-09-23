From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Mon, 23 Sep 2013 12:48:21 +0530
Subject: [RFC PATCH 2/2] Aarch64: KGDB: Add Step debugging support
In-Reply-To: <CALicx6v6hwxMTFy7dnWyy+FokR+gXoa73Hx-Od1yMhTU=FCV6Q@mail.gmail.com>
References: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
 <1379321750-907-3-git-send-email-vijay.kilari@gmail.com>
 <20130916113056.GH21320@mudshark.cambridge.arm.com>
 <CA+b37P1zYuRvVQGjSfMt___12ytZN_fiUJ26XVgxT4CPUm8ZSQ@mail.gmail.com>
 <CALicx6v6hwxMTFy7dnWyy+FokR+gXoa73Hx-Od1yMhTU=FCV6Q@mail.gmail.com>
Message-ID: <CA+b37P2U4pV2e0SqrsFUcpY2Cp0G2=s_uNiYeOmfznBQmaiASA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 September 2013 12:07, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> Hi Will & Sandeepa
>
> On Mon, Sep 16, 2013 at 6:36 PM, Sandeepa Prabhu
> <sandeepa.prabhu@linaro.org> wrote:
>> On 16 September 2013 17:00, Will Deacon <will.deacon@arm.com> wrote:
>>> On Mon, Sep 16, 2013 at 09:55:50AM +0100, vijay.kilari at gmail.com wrote:
>>>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>>
>>>> Add KGDB software step debugging support for EL1 debug
>>>> in Aarch64 mode.
>>>>
>>>> KGDB registers step debug handler with debug monitor.
>>>> On receiving 'step' command from GDB tool, target enables
>>>> software step debugging and step address is written to ELR
>>>> register. If not step address is received from GDB tool,
>>>> target assumes next step address is PC and ERET is
>>>> executed as part of exception return.
>>>>
>>>> ELR register content is protected against context restore in
>>>> exception return by checking against Software Step debug
>>>> bit MDSCR.SS
>>>>
>>>> Software Step debugging is disabled when 'continue' command
>>>> is received
>>>>
>>>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>> ---
>>>>  arch/arm64/include/asm/debug-monitors.h |    3 +++
>>>>  arch/arm64/kernel/debug-monitors.c      |   15 +++++++++++++
>>>>  arch/arm64/kernel/entry.S               |    9 +++++++-
>>>>  arch/arm64/kernel/kgdb.c                |   36 +++++++++++++++++++++++++++++++
>>>>  4 files changed, 62 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
>>>> index aff3a76..3e4ac0d 100644
>>>> --- a/arch/arm64/include/asm/debug-monitors.h
>>>> +++ b/arch/arm64/include/asm/debug-monitors.h
>>>> @@ -94,6 +94,9 @@ void kernel_enable_single_step(struct pt_regs *regs);
>>>>  void kernel_disable_single_step(void);
>>>>  int kernel_active_single_step(void);
>>>>
>>>> +void elr_write(unsigned long elr);
>>>> +unsigned long elr_read(void);
>>>> +
>>>>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>>>>  int reinstall_suspended_bps(struct pt_regs *regs);
>>>>  #else
>>>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>>>> index f8b90c0..0408490 100644
>>>> --- a/arch/arm64/kernel/debug-monitors.c
>>>> +++ b/arch/arm64/kernel/debug-monitors.c
>>>> @@ -64,6 +64,21 @@ static u32 mdscr_read(void)
>>>>       return mdscr;
>>>>  }
>>>>
>>>> +void elr_write(unsigned long elr)
>>>> +{
>>>> +     unsigned long flags;
>>>> +     local_dbg_save(flags);
>>>> +     asm volatile("msr elr_el1, %0" :: "r" (elr));
>> I think right way to update step address would be update
>> instruction_pointer(regs) from your kgdb handler and "kernel_exit"
>> should take care of rest. With this, you don't need to change the low
>> level handlers in entry.S/debug-monitors.c) at all.
>
> As per Spec, the step address should be updated in ELR.
> where as instruction_pointer(regs) updates pc.
> Does PC of pt_regs will be copied to ELR in kernel_exit?

Yes, ERET in case of single step is no different from normal exception
return, where save copy of ELR_EL1 is restored back.
You can look into entry.S, how pt_regs store/restore happen.

kernel_entry:
...
mrs     x22, elr_el1
mrs     x23, spsr_el1
...
stp     x22, x23, [sp, #S_PC]
....
kernel_exit:
....
 ldp     x21, x22, [sp, #S_PC]
.....
msr     elr_el1, x21                    // set up the return data
...
So you really don't need any conditional code inside entry.S, single
stepping is taken care.

>
>>>> +     local_dbg_restore(flags);
>>>> +}
>>>> +
>>>> +unsigned long elr_read(void)
>>>> +{
>>>> +     unsigned long elr;
>>>> +     asm volatile("mrs %0, elr_el1" : "=r" (elr));
>>>> +     return elr;
>>>> +}
>>>
>>> What?! Why are you writing the ELR here, instead of setting up the pc in
>>> current saved regs?
>>>
>>>> +
>>>>  /*
>>>>   * Allow root to disable self-hosted debug from userspace.
>>>>   * This is useful if you want to connect an external JTAG debugger.
>>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>>> index 226be77..23d91f1 100644
>>>> --- a/arch/arm64/kernel/entry.S
>>>> +++ b/arch/arm64/kernel/entry.S
>>>> @@ -100,7 +100,14 @@
>>>>       pop     x4, x5
>>>>       pop     x6, x7
>>>>       pop     x8, x9
>>>> -     msr     elr_el1, x21                    // set up the return data
>>>> +     .if     \el == 1
>>>> +     mrs     x10, mdscr_el1                  // check if step debug is enabled
>>>> +     tbnz    x10, #0, 1f
>>>> +     msr     elr_el1, x21
>>>> +     .else
>>>> +     msr     elr_el1, x21                    // set up the return data
>>>> +     .endif
>>>> +1:
>>>
>>> This is horrible -- if the pt_regs being restored was set up correctly,
>>> you wouldn't need the conditional code.
>>>
>
> As per spec (D2.8.4), the target is responding to GDB tool in
> exception mode (debug exception).
> On receiving GDB command in polling mode, target updates ELR with step
> address and
> waits for ERET of debug exception exit to jump to the instruction to be stepped.
>
> Does updating pc of pt_regs will work?
>
> Here is the excerpt from ARMv8 document.
> To initiate a Software Step debug event, the debugger:
> a. Sets SPSR_ELx.SS to 1.
> b. Programs the ELR_ELx to point to the instruction to be stepped.
> c. Executes an ERET instruction to jump to the instruction to be
> stepped. If all of the
> conditions defined in Setting PSTATE.SS to 1 to enable software step
> to step an item
> are met, the ERET instruction copies SPSR_ELx.SS to PSTATE.SS, and the processor
> advances to the active-not-pending state
>
>>>>       msr     spsr_el1, x22
>>>>       .if     \el == 0
>>>>       msr     sp_el0, x23
>>>> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>>>> index a3a7712..d5e5884 100644
>>>> --- a/arch/arm64/kernel/kgdb.c
>>>> +++ b/arch/arm64/kernel/kgdb.c
>>>> @@ -164,9 +164,31 @@ int kgdb_arch_handle_exception(int exception_vector, int signo, int err_code,
>>>>                       linux_regs->pc += 4;
>>>>
>>>>               compiled_break = 0;
>>>> +
>>>> +             /* Disable single step if enabled */
>>>> +             if (kernel_active_single_step())
>>>> +                     kernel_disable_single_step();
>>>> +
>>>>               err = 0;
>>>>               break;
>>>> +     case 's':
>>>> +             /*
>>>> +              * Update ESR value with step address passed
>>>> +              */
>>>
>>> Well, the comment is wrong, but I don't think you should be doing this anyway :)
>>>
>  I will correct it
>
>
>>> Will
