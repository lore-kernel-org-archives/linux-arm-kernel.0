From: stefan@agner.ch (Stefan Agner)
Date: Fri, 22 May 2015 17:36:44 +0200
Subject: [PATCH soc] ARM: use =?UTF-8?Q?ARM=5FSINGLE=5FARMV=37M=20for?=
 =?UTF-8?Q?=20ARMv=37-M=20platforms?=
In-Reply-To: <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
 <15864413.ed8EFg1NLl@wuerfel>
 <CALszF6D-3pXHtyVMwhO0JkT-dCSSB98UNDHNN7-LD04Wdgd2cA@mail.gmail.com>
Message-ID: <26b8dda924076b7587c42ecd5f7d854a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-22 17:29, Maxime Coquelin wrote:
> 2015-05-22 16:50 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> [one small request as I have four armv7-m folks on Cc already:
>>  could one of you try to fix the warning that I get with every
>>  single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
>> messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
>> Use of r13 as a source register is deprecated when r15 is the
>> destination register."]
> 
> Moving r13 to r12 and returning r12 seems to do the job (see below).
> But I don't know if there is a more elegant way, and if it is also
> valid for other architectures than armv7-m.
> I can propose a patch if someone can confirm it is valid.

> 
> -------------------------------------------------------------------------------------------------------------
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index aebfbf7..e84bdad 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -164,7 +164,8 @@ __after_proc_init:
>  #endif
>         mcr     p15, 0, r0, c1, c0, 0           @ write control reg
>  #endif /* CONFIG_CPU_CP15 */
> -       ret     r13
> +       mov     r12, r13
> +       ret     r12
>  ENDPROC(__after_proc_init)
>         .ltorg

That is actually a patch I have here too, altough I used r11 back
then... :-)

However, I don't think this is a nice solution. We should avoid using
r13 for that address in the first place, e.g. using a different register
to get the value when calling __mmap_switched. However, for that one
need to know what registers are guaranteed to be not used within
PROCINFO_INITFUNC...

--
Stefan
