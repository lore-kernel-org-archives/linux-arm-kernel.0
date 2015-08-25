From: keescook@chromium.org (Kees Cook)
Date: Mon, 24 Aug 2015 22:20:03 -0700
Subject: [BUG] arm: kgdb: patch_text() in kgdb_arch_set_breakpoint() may
 sleep
In-Reply-To: <CAD=FV=Xkye3_e-ZvpUfXyQJ7VFz2s6bTPSuty4-x7Fpa72UW2g@mail.gmail.com>
References: <55C230C7.2000909@nvidia.com>
 <CAD=FV=V_E+YMQuW5kvn+52Ugc_5hZsyXKKQ9Ywo_emoqK-N+Qw@mail.gmail.com>
 <CAGXu5j+P=LtTAVQbkn4w6Y9pTVouvRgAhwfS+rAmKfqTXC8pyg@mail.gmail.com>
 <CAD=FV=Xkye3_e-ZvpUfXyQJ7VFz2s6bTPSuty4-x7Fpa72UW2g@mail.gmail.com>
Message-ID: <CAGXu5jKduNfz0-zhM+LvA=jHFs51kxoBegdHOFaE5YdJZ3xkrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 4:56 PM, Doug Anderson <dianders@chromium.org> wrote:
> Kees,
>
> On Mon, Aug 24, 2015 at 10:46 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Sun, Aug 23, 2015 at 7:45 PM, Doug Anderson <dianders@chromium.org> wrote:
>>> On Wed, Aug 5, 2015 at 8:50 AM, Aapo Vienamo <avienamo@nvidia.com> wrote:
>>>> Hi,
>>>>
>>>> The breakpoint setting code in arch/arm/kernel/kgdb.c calls
>>>> patch_text(), which ends up trying to sleep while in interrupt context.
>>>> The bug was introduced by commit: 23a4e40 arm: kgdb: Handle read-only
>>>> text / modules. The resulting behavior is "BUG: scheduling while
>>>> atomic..." when setting a breakpoint in kgdb. This was tested on an
>>>> Nvidia Jetson TK1 board with 4.2.0-rc5-next-20150805 kernel.
>>>>
>>>> Regards,
>>>> Aapo Vienamo
>>>
>>> Aapo,
>>>
>>> Including the stack trace with this would have been helpful, though
>>> it's not too hard to reproduce.  Here it is:
>>>
>>> [  416.510559] BUG: scheduling while atomic: swapper/0/0/0x00010007
>>> [  416.516554] Modules linked in:
>>> [  416.519614] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
>>> 4.2.0-rc7-00133-geb63b34 #1073
>>> [  416.527341] Hardware name: Rockchip (Device Tree)
>>> [  416.532042] [<c0017a4c>] (unwind_backtrace) from [<c00133d4>]
>>> (show_stack+0x20/0x24)
>>> [  416.539772] [<c00133d4>] (show_stack) from [<c05400e8>]
>>> (dump_stack+0x84/0xb8)
>>> [  416.546983] [<c05400e8>] (dump_stack) from [<c004913c>]
>>> (__schedule_bug+0x54/0x6c)
>>> [  416.554540] [<c004913c>] (__schedule_bug) from [<c054065c>]
>>> (__schedule+0x80/0x668)
>>> [  416.562183] [<c054065c>] (__schedule) from [<c0540cfc>] (schedule+0xb8/0xd4)
>>> [  416.569219] [<c0540cfc>] (schedule) from [<c0543a3c>]
>>> (schedule_timeout+0x2c/0x234)
>>> [  416.576861] [<c0543a3c>] (schedule_timeout) from [<c05417c0>]
>>> (wait_for_common+0xf4/0x188)
>>> [  416.585109] [<c05417c0>] (wait_for_common) from [<c0541874>]
>>> (wait_for_completion+0x20/0x24)
>>> [  416.593531] [<c0541874>] (wait_for_completion) from [<c00a0104>]
>>> (__stop_cpus+0x58/0x70)
>>> [  416.601608] [<c00a0104>] (__stop_cpus) from [<c00a0580>]
>>> (stop_cpus+0x3c/0x54)
>>> [  416.608817] [<c00a0580>] (stop_cpus) from [<c00a06c4>]
>>> (__stop_machine+0xcc/0xe8)
>>> [  416.616286] [<c00a06c4>] (__stop_machine) from [<c00a0714>]
>>> (stop_machine+0x34/0x44)
>>> [  416.624016] [<c00a0714>] (stop_machine) from [<c00173e8>]
>>> (patch_text+0x28/0x34)
>>> [  416.631399] [<c00173e8>] (patch_text) from [<c001733c>]
>>> (kgdb_arch_set_breakpoint+0x40/0x4c)
>>> [  416.639823] [<c001733c>] (kgdb_arch_set_breakpoint) from
>>> [<c00a0d68>] (kgdb_validate_break_address+0x2c/0x60)
>>> [  416.649719] [<c00a0d68>] (kgdb_validate_break_address) from
>>> [<c00a0e90>] (dbg_set_sw_break+0x1c/0xdc)
>>> [  416.658922] [<c00a0e90>] (dbg_set_sw_break) from [<c00a2e88>]
>>> (gdb_serial_stub+0x9c4/0xba4)
>>> [  416.667259] [<c00a2e88>] (gdb_serial_stub) from [<c00a11cc>]
>>> (kgdb_cpu_enter+0x1f8/0x60c)
>>> [  416.675423] [<c00a11cc>] (kgdb_cpu_enter) from [<c00a18cc>]
>>> (kgdb_handle_exception+0x19c/0x1d0)
>>> [  416.684106] [<c00a18cc>] (kgdb_handle_exception) from [<c0016f7c>]
>>> (kgdb_compiled_brk_fn+0x30/0x3c)
>>> [  416.693135] [<c0016f7c>] (kgdb_compiled_brk_fn) from [<c00091a4>]
>>> (do_undefinstr+0x1a4/0x20c)
>>> [  416.701643] [<c00091a4>] (do_undefinstr) from [<c001400c>]
>>> (__und_svc_finish+0x0/0x34)
>>> [  416.709543] Exception stack(0xc07c1ce8 to 0xc07c1d30)
>>> [  416.714584] 1ce0:                   00000000 c07c6504 c086e290
>>> c086e294 c086e294 c086e290
>>> [  416.722745] 1d00: c07c6504 00000067 00000001 c07c2100 00000027
>>> c07c1d4c c07c1d50 c07c1d30
>>> [  416.730905] 1d20: c00a0990 c00a08d0 60000193 ffffffff
>>> [  416.735947] [<c001400c>] (__und_svc_finish) from [<c00a08d0>]
>>> (kgdb_breakpoint+0x58/0x94)
>>> [  416.744110] [<c00a08d0>] (kgdb_breakpoint) from [<c00a0990>]
>>> (sysrq_handle_dbg+0x58/0x6c)
>>> [  416.752273] [<c00a0990>] (sysrq_handle_dbg) from [<c02c230c>]
>>> (__handle_sysrq+0xac/0x15c)
>>> [  416.760437] [<c02c230c>] (__handle_sysrq) from [<c02c23ec>]
>>> (handle_sysrq+0x30/0x34)
>>>
>>>
>>> Kees: I think you've dealt with a lot more of these types of issues
>>> than I have.  Any quick thoughts?  If not I can put it on my long-term
>>> list of things to do, but until then we could always just post a
>>> Revert...
>>
>> I don't think a revert is in order here. CONFIG_DEBUG_RODATA could be
>> turned off for builds where you need kgdb while this bug gets found.
>
> I don't think that's right.  In my testing I don't have
> CONFIG_DEBUG_RODATA.  I think I did the right grep:
>
> $ grep ARM_KERNMEM_PERMS .config
> # CONFIG_ARM_KERNMEM_PERMS is not set
>
> Basically no matter what we'll call:
> - kgdb_arch_set_breakpoint
> -- patch_text
> --- stop_machine
>
> ...no dependencies on RODATA.

I said DEBUG_RODATA since that's the stricter of the options (it
requires KERNMEM_PERMS). But yes, I see now that patch.c doesn't test
for this feature at all (which probably makes sense).

>> I
>> don't actually see where we've gone wrong, though. Looks like
>> scheduling happened while waiting for CPUs to stop? Where did we enter
>> atomic?
>
> We're in kdb.  That's a stop mode debugger.  No sleeping allowed while
> in the debugger.
>
>
>> Perhaps we need to test if we're already atomic in patch_text, and
>> only call stop_machine if we need to?
>>
>> Untested (and likely mangled by gmail):
>>
>> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
>> index 69bda1a5707e..855696bfe072 100644
>> --- a/arch/arm/kernel/patch.c
>> +++ b/arch/arm/kernel/patch.c
>> @@ -124,5 +124,8 @@ void __kprobes patch_text(void *addr, unsigned int insn)
>>                 .insn = insn,
>>         };
>>
>> -       stop_machine(patch_text_stop_machine, &patch, NULL);
>> +       if (unlikely(in_atomic_preempt_off()))
>> +               patch_text_stop_machine(&patch);
>> +       else
>> +               stop_machine(patch_text_stop_machine, &patch, NULL);
>
> Ah, right.  We're already stopped, so just not stopping again seems
> reasonable.  I think I'd rather just use in_dbg_master() as the test
> since that's a case where I _know_ all the CPUs are stopped.  Doesn't
> in_atomic_preempt_off() just check if preemption is off for this
> single CPU?
>
> Anyway, I'll throw a patch up now.  It fixes it for me.  :)

The in_atomic_preempt_off is what the schedule is using for this test,
so it seemed the best generic fix (in the case that some other caller
in the future tries to call patch_text also, not just kgdb).

Thanks for testing! Feel free to add my S-o-b or Acked-by, as appropriate. :)

-Kees

-- 
Kees Cook
Chrome OS Security
