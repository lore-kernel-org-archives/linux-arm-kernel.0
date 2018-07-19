From: hari.vyas@broadcom.com (Hari Vyas)
Date: Thu, 19 Jul 2018 15:47:46 +0530
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <20180719100140.GA424@jagdpanzerIV>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
 <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
 <20180719100140.GA424@jagdpanzerIV>
Message-ID: <CAM5rFu_N-=26LddRy1mO010h9yLcGuKqK6=y+h=h3-HbfEP+FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 3:31 PM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (07/19/18 15:18), Hari Vyas wrote:
> [..]
>
> Not so sure about the patch, sorry.
>
Mentioned concern in cover letter and commit message. Console loglevel
remains maximum after process die which
needs to be restored.
>> @@ -211,6 +211,8 @@ void die(const char *str, struct pt_regs *regs, int err)
>>
>>       bust_spinlocks(0);
>>       add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>> +
>> +     restore_console_loglevel();
>>       oops_exit();
>
> This is *probably* the only place where you can roll-back the
> loglevel, but you restore console loglevel too early - a trap
> can panic() the system, we need to preserve the console verbose
> mode which we set at the start of the trap.
>
console loglevel is indirectly sets to verbose in oops_enter() so
better to restore before oops_exit().
More from ARM maintainers.
>> @@ -624,6 +626,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
>>       die("Oops - bad mode", regs, 0);
>>       local_daif_mask();
>>       panic("bad mode");
>> +     restore_console_loglevel();
>
> panic()
>
>> @@ -680,6 +683,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
>>        * to get a better stack trace.
>>        */
>>       nmi_panic(NULL, "kernel stack overflow");
>> +     restore_console_loglevel();
>
> panic()
>
>> @@ -694,7 +698,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
>>               __show_regs(regs);
>>
>>       nmi_panic(regs, "Asynchronous SError Interrupt");
>> -
>> +     restore_console_loglevel();
>
> panic()
>
> What's the point of restore_console_loglevel() after panic()?
>
>         -ss
Except die(), other places restore call can be avoided but just added
for code completeness.
Same mentioned in cover letter.
More from ARM maintainers
