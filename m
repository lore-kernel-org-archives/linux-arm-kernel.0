From: keescook@chromium.org (Kees Cook)
Date: Tue, 25 Aug 2015 09:50:11 -0700
Subject: [PATCH] ARM: probes: Don't stop the machine if we're in the
 debugger
In-Reply-To: <55DBB48E.7040508@codeaurora.org>
References: <1440460739-19522-1-git-send-email-dianders@chromium.org>
 <55DBB48E.7040508@codeaurora.org>
Message-ID: <CAGXu5j+oExmQPR9UuJy8oVaL_DzZ70kSP6ftS+ZhyFSs7hyxsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 5:19 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/24/2015 04:58 PM, Douglas Anderson wrote:
>>
>> If we're in kgdb then the machine is already stopped.  Trying to stop
>> it again will cause us to try to sleep, which is not allowed while in
>> kgdb.  To avoid this problem, only stop the machine when we're not in
>> kgdb.
>>
>> Reported-by: Aapo Vienamo <avienamo@nvidia.com>
>> Suggested-by: Kees Cook <keescook@chromium.org>

I actually suggested using in_atomic_preempt_off() which is I think a
better catch-all. Could you use that instead, please?

-Kees

>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>
>
> Can you add the backtrace?
>
>>   arch/arm/kernel/patch.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
>> index 69bda1a..abf30ec 100644
>> --- a/arch/arm/kernel/patch.c
>> +++ b/arch/arm/kernel/patch.c
>> @@ -1,5 +1,6 @@
>>   #include <linux/kernel.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/kgdb.h>
>>   #include <linux/kprobes.h>
>>   #include <linux/mm.h>
>>   #include <linux/stop_machine.h>
>> @@ -124,6 +125,9 @@ void __kprobes patch_text(void *addr, unsigned int
>> insn)
>>                 .insn = insn,
>>         };
>>   -     stop_machine(patch_text_stop_machine, &patch, NULL);
>> +       /* Stop machine before patching; but not if in the debugger */
>> +       if (unlikely(in_dbg_master()))
>> +               patch_text_stop_machine(&patch);
>> +       else
>> +               stop_machine(patch_text_stop_machine, &patch, NULL);
>>   }
>
>
> Perhaps it would be better to add a different function for the kgdb call
> site? Then it's explicit what's going on without us having to figure out
> when in_dbg_master() is true.
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>



-- 
Kees Cook
Chrome OS Security
