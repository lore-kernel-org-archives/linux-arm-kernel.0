From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Aug 2015 15:06:02 -0700
Subject: [BUG] arm: kgdb: patch_text() in kgdb_arch_set_breakpoint() may
 sleep
In-Reply-To: <CAD=FV=Xkye3_e-ZvpUfXyQJ7VFz2s6bTPSuty4-x7Fpa72UW2g@mail.gmail.com>
References: <55C230C7.2000909@nvidia.com>
 <CAD=FV=V_E+YMQuW5kvn+52Ugc_5hZsyXKKQ9Ywo_emoqK-N+Qw@mail.gmail.com>
 <CAGXu5j+P=LtTAVQbkn4w6Y9pTVouvRgAhwfS+rAmKfqTXC8pyg@mail.gmail.com>
 <CAD=FV=Xkye3_e-ZvpUfXyQJ7VFz2s6bTPSuty4-x7Fpa72UW2g@mail.gmail.com>
Message-ID: <CAD=FV=Wbqx+m9GopFztvT+RE0P_NKDVLogqn8=JbhtoEt3apEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 24, 2015 at 4:56 PM, Doug Anderson <dianders@chromium.org> wrote:
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

In case anyone happens upon this thread, the patch I originally put up
is at <https://patchwork.kernel.org/patch/7067211/>.  ...I've since
spun it to <https://patchwork.kernel.org/patch/7073441/>

-Doug
