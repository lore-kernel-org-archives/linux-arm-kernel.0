From: orca.chen@gmail.com (Min-Hua Chen)
Date: Wed, 24 Dec 2014 00:41:20 +0800
Subject: [PATCH] arm64: setup return path for el1_undef
In-Reply-To: <20141223155714.GC21816@e104818-lin.cambridge.arm.com>
References: <CAHkaATRdNgcZnAvgKFRmiMEhLOPxFEPpjTu+XNkDk9DxG+4Fpg@mail.gmail.com>
 <20141223155714.GC21816@e104818-lin.cambridge.arm.com>
Message-ID: <CAHkaATSC9OZB=XcOhOR-259RUpoFX9HOkGrU6PR7ae7WBmOc_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 11:57 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Dec 23, 2014 at 03:15:10PM +0000, Min-Hua Chen wrote:
>> Setup return path for el1_undef since el1_undef may
>> be handled by handlers.
>
> Did you find a real issue or it was just code inspection.

Thanks for your reply. It was just a code inspection.

Min-Hua

>
>> asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>> {
>>     siginfo_t info;
>>     void __user *pc = (void __user *)instruction_pointer(regs);
>>
>>     /* check for AArch32 breakpoint instructions */
>>     if (!aarch32_break_handler(regs))
>>         return;
>>
>>     if (call_undef_hook(regs) == 0)
>>         return;
>>
>>     ...
>> }
>> Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
>> ---
>>  arch/arm64/kernel/entry.S |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index fd4fa37..86ebec5 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -313,7 +313,8 @@ el1_undef:
>>       */
>>      enable_dbg
>>      mov    x0, sp
>> -    b    do_undefinstr
>> +    bl    do_undefinstr
>> +    kernel_exit 1
>>  el1_dbg:
>>      /*
>>       * Debug exception handling
>
> I don't think this is needed. The code is pretty convoluted but for an
> EL1 undefined exception we should never return from do_undefinstr(). The
> call_undef_hook() function returns 1 if !user_mode(regs) and this should
> cause a kernel panic. Basically we do not allow any kind of undefined
> instructions in the arm64 kernel.
>
> --
> Catalin
