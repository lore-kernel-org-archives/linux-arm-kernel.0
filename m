From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 10 Jan 2014 02:38:55 +0200
Subject: [LNG] [PATCH] ARM: traps: fix opcode endianness when read from
 user memory
In-Reply-To: <CAA3XUr0A2jK0y-kfkpGE4mDNOCAhDi7AY0y9Fvmu5dgNygXXQQ@mail.gmail.com>
References: <1387816927-4313-1-git-send-email-taras.kondratiuk@linaro.org>
 <CAA3XUr0A2jK0y-kfkpGE4mDNOCAhDi7AY0y9Fvmu5dgNygXXQQ@mail.gmail.com>
Message-ID: <CAArO44uXBmnz3Cn9n5bBCfw_AHcX2B0OqPZpVzbOT9Nu5sEq2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just put it into tracker with your Reviewed-by.

On 10 January 2014 02:09, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> Taras, it looks good. Did you submit it into Russell's patch system? It
> would be good to have this fix in main line tree.
>
> Anyone, is there any concerns about this patch? It is quite simple
> change.
>
> Thanks,
> Victor
>
> On 23 December 2013 08:42, Taras Kondratiuk <taras.kondratiuk@linaro.org> wrote:
>> Currently code has an inverted logic: opcode from user memory
>> is swapped to a proper endianness only in case of read error.
>> While normally opcode should be swapped only if it was read
>> correctly from user memory.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>> ---
>>  arch/arm/kernel/traps.c |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 7940241..36a844e 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -425,9 +425,10 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>                         instr2 = __mem_to_opcode_thumb16(instr2);
>>                         instr = __opcode_thumb32_compose(instr, instr2);
>>                 }
>> -       } else if (get_user(instr, (u32 __user *)pc)) {
>> +       } else {
>> +               if (get_user(instr, (u32 __user *)pc))
>> +                       goto die_sig;
>>                 instr = __mem_to_opcode_arm(instr);
>> -               goto die_sig;
>>         }
>>
>>         if (call_undef_hook(regs, instr) == 0)
>> --
>> 1.7.9.5
>>
>> --
>> You received this message because you are subscribed to the Google Groups "Linaro Networking" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linaro-networking+unsubscribe at linaro.org.
>> To post to this group, send email to linaro-networking at linaro.org.
>
> --
> You received this message because you are subscribed to the Google Groups "Linaro Networking" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linaro-networking+unsubscribe at linaro.org.
> To post to this group, send email to linaro-networking at linaro.org.



-- 
Regards,
Taras Kondratiuk
