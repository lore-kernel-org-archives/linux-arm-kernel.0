From: achandran@mvista.com (Arun Chandran)
Date: Sun, 24 Aug 2014 01:20:15 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140822131518.GW21734@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
 <20140820105408.GG21174@leverpostej>
 <CAFdej00s9ZYXnE4AfU0vUqTb4dmUg4U=fOhc3KS1_JK+0=+mdw@mail.gmail.com>
 <20140820141623.GF21734@leverpostej>
 <CAFdej023ABj=xstTS_vddr2PMoqE4Fe1qBN9Gr0P69hW+u=YBA@mail.gmail.com>
 <20140821143155.GN21734@leverpostej>
 <CAFdej00oR5r2=-r1dv3qG59SXT6+WbZeu+zOeS19nV5nRhw20w@mail.gmail.com>
 <20140822131518.GW21734@leverpostej>
Message-ID: <CAFdej02c9nVwxBQkkp7z5gKa4Jv+AT47H=3_0m6NV1Lfvq3x5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Aug 22, 2014 at 6:45 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
>
>> >> > Your spin-table implementation might be poking something that's not
>> >> > accessible at EL1, in which case you require the jump to EL2 for
>> >> > correctness. I can't say for certain either way.
>> >> >
>> >>
>> >> Yes you are right I needed a jump to EL2 for putting the
>> >> secondary CPUs at correct spinning loop.
>> >
>> > Ok. So we need to do what I have suggested elsewhere w.r.t. jumping back
>> > up to EL2. As you point out below we need to synchronise with the CPUs
>> > on their way out too we can add a spin-table cpu_kill with a slightly
>> > dodgy delay to ensure that, given we have no other mechanism for
>> > synchronising.
>> >
>> Ok
>>
>> >
>> > As far as I am aware an "isb; dsb" sequence never makes sense. It should
>> > be "dsb; isb". You want the I-side maintenance to complete (for which
>> > you have the DSB) _then_ you want to synchronise the execution context
>> > with the newly-visible instructions (for which you have the ISB).
>> >
>> Thanks for the nice explanation.
>>
>> Now I am able to kexec an SMP kernel with the below change.
>>
>> ##########
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index 607d4bb..8969922 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -343,6 +343,11 @@ CPU_LE(    movk    x0, #0x30d0, lsl #16    )
>>  // Clear EE and E0E on LE systems
>>                       PSR_MODE_EL1h)
>>         msr     spsr_el2, x0
>>         msr     elr_el2, lr
>> +       mov     x0, #0x33ff
>> +       movk    x0, #0x801f, lsl #16
>> +       msr     cptr_el2, x0                    // Enable traps to el2
>> when CPACR or CPACR_EL1 is accessed
>> +       mov     x0, #3 << 20
>> +       msr     cpacr_el1, x0                   // Enable FP/ASIMD
>>         mov     w20, #BOOT_CPU_MODE_EL2         // This CPU booted in EL2
>>         eret
>>  ENDPROC(el2_setup)
>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>> index a272f33..1fb4c38 100644
>> --- a/arch/arm64/kernel/hyp-stub.S
>> +++ b/arch/arm64/kernel/hyp-stub.S
>> @@ -56,12 +56,25 @@ el1_sync:
>>         mrs     x1, esr_el2
>>         lsr     x1, x1, #26
>>         cmp     x1, #0x16
>> -       b.ne    2f                              // Not an HVC trap
>> +       b.ne    3f                              // Not an HVC trap
>>         cbz     x0, 1f
>>         msr     vbar_el2, x0                    // Set vbar_el2
>>         b       2f
>>  1:     mrs     x0, vbar_el2                    // Return vbar_el2
>>  2:     eret
>> +3:     cmp     x1, #0x18       // Traps to EL2 for CPACR access have this code
>> +       b.ne    2b
>> +
>> +       mov     x1, #0x33ff
>> +       msr     cptr_el2, x1                    // Disable copro. traps to EL2
>> +
>> +       msr     cntp_ctl_el0, xzr
>> +       msr     cntfrq_el0, xzr
>> +       ic      ialluis
>> +       dsb     sy
>> +       isb
>> +
>> +       br  x0
>>  ENDPROC(el1_sync)
>>
>>  .macro invalid_vector  label
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 64733d4..77298c2 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -65,6 +65,14 @@ void soft_restart(unsigned long addr)
>>  //     smp_secondary_shutdown();
>>  #endif
>>
>> +       /* Delay primary cpu; allow enough time for
>> +        * secondaries to enter spin loop
>> +        */
>> +#if defined(CONFIG_SMP)
>> +       if (smp_processor_id() == 0)
>> +               mdelay(1000);
>> +#endif
>> +
>>         cpu_soft_restart(virt_to_phys(cpu_reset), addr);
>>
>>         /* Should never get here */
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 3cb6dec..f6ab468 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -76,6 +76,10 @@ ENTRY(cpu_reset)
>>  #if defined(CONFIG_SMP)
>>  /*     bl      secondary_shutdown */
>>  #endif
>> +
>> +       /* Trap to EL2 */
>> +       mov     x1, #3 << 20
>> +       msr     cpacr_el1, x1                   // Enable FP/ASIMD
>>         ret     x0
>>  ENDPROC(cpu_reset)
>>
>> @@ -200,8 +204,6 @@ ENTRY(__cpu_setup)
>>         tlbi    vmalle1is                       // invalidate I + D TLBs
>>         dsb     ish
>>
>> -       mov     x0, #3 << 20
>> -       msr     cpacr_el1, x0                   // Enable FP/ASIMD
>>         msr     mdscr_el1, xzr                  // Reset mdscr_el1
>>         /*
>>          * Memory region attributes for LPAE:
>> ##########
>>
>> The two lines
>> +       msr     cntp_ctl_el0, xzr
>> +       msr     cntfrq_el0, xzr
>
> The kernel should _NEVER_ write to CNTFRQ. It is not guaranteed to be
> accessible from the non-secure side. The firmware should have configured
> this appropriately.
>
> If the firmware does not configure CNTFRQ correctly then it is buggy and
> must be fixed.
>
> Overriding the CNTFRQ to zero is completely broken.
>
>> were added for
>> ##########
>> SANITY CHECK: Unexpected variation in cntfrq. Boot CPU:
>> 0x00000002faf080, CPU1: 0x00000000000000
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 0 at arch/arm64/kernel/cpuinfo.c:146
>> cpuinfo_store_cpu+0x2e8/0x14f4()
>> Unsupported CPU feature variation.
>> Modules linked in:
>> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.16.0-rc4+ #196
>> Call trace:
>> [<ffffffc000087fd0>] dump_backtrace+0x0/0x130
>> [<ffffffc000088110>] show_stack+0x10/0x1c
>> [<ffffffc0004c03e0>] dump_stack+0x74/0xb8
>> [<ffffffc00009dfac>] warn_slowpath_common+0x8c/0xb4
>> [<ffffffc00009e078>] warn_slowpath_fmt_taint+0x4c/0x58
>> [<ffffffc00008adf0>] cpuinfo_store_cpu+0x2e4/0x14f4
>> [<ffffffc00008f7e0>] secondary_start_kernel+0xd4/0x120
>> ---[ end trace 62c0cf48de286b1c ]---
>> CPU2: Booted secondary processor
>> Detected PIPT I-cache on CPU2
>> SANITY CHECK: Unexpected variation in cntfrq. Boot CPU:
>> 0x00000002faf080, CPU2: 0x00000000000000
>> CPU3: Booted secondary processor
>> ##########
>>
>> does this mean we also need to stop/handle timers before
>> jumping to new kernel??
>
> The value of CNTFRQ has nothing to do with whether the timers are
> enabled. If we don't already disabling the timers I guess we could as a
> courtesy to the next kernel, but interrupts should be masked and the
> next kernel should be able to handle it anyway. That would all live in
> the timer driver anyhow.
>
> Do you see the sanity check failure on a cold boot (with the same
> kernel)?
>

No I don't see the failure on cold boot.

>  - If so, your firmware is not configuring CNTFRQ appropriately as it
>    MUST do. Virtualization IS broken on your system. This is a bug in
>    the firmware.
>
>  - If not, then something in the spin-table's cpu return path is
>    resulting in CPUs being reconfigured, or reset and not configured as
>    with cold boot. This is a bug in the firmware.

I will report this to my hardware guys.
>
> The firmware MUST configure CNTFRQ. It must do so regardless of
> cold/warm boot. A clock-frequency property in the DT is insufficient;
> it's a half-baked workaround that's especially problematic if you boot
> at EL2.
>
>> > I really can't say. I know nothing of your platform or spin-table
>> > implementation, and this is nothing like what I'd expect the jump to EL2
>> > code to look like.
>>
>> Yes It was just for trying things out. Traping to EL2 and then jumping
>> to the kexec/SMP-spin code is not sane. And by the way
>> I did not find anyway to do mode change to el2 from el1 other than
>> trapping.
>>
>> Could you please elaborate more about the way you expect
>> it to be working/implemented??.
>
> Elsewhere in this thread I gave an outline of how I would expect this to
> be implemented with modifications to KVM and the hyp stub.
>
OK. I will give it a try.

> Obviously some trap will be taken to EL2, but that should be as a result
> of an explicit HVC rather than an access to the CPACR, and it should
> only occur when the kernel was booted at EL2.
>
Ok. Thanks for the nice explanation.

--Arun
