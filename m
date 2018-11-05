From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Nov 2018 20:35:18 +0100
Subject: [PATCH 1/6] ARM: compressed: move sharpsl startup code into
 subroutine
In-Reply-To: <nycvar.YSQ.7.76.1811051413250.1498@knanqh.ubzr>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105184438.19494-2-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1811051413250.1498@knanqh.ubzr>
Message-ID: <CAKv+Gu-dZZ7T4gzAghoBeDk4NcW98rUhuHUEA5yu_R4QwEE5Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2018 at 20:25, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 5 Nov 2018, Ard Biesheuvel wrote:
>
>> Instead of relying on unspecified linker behavior, move the
>> SharpSL startup code into a subroutine and call it from the
>> location we expect the linker to put the code.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
> [...]
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -213,6 +213,9 @@ not_angel:
>>                */
>>
>>               .text
>> +#ifdef CONFIG_PXA_SHARPSL_DETECT_MACH_ID
>> +             bl      __SharpSL_start
>> +#endif
>
> Independently from Russell's points, I don't like the above. that will
> turn into an ugly list of #ifdefs and machine specific calls. I think
> you should use:
>
>                 bl      __early_arch_specific_start
>
> and somewhere else in head.S:
>
> WEAK(__early_arch_specific_start)
>                 mov     pc, lr
> ENDPROC(__early_arch_specific_start)
>
> That would make this change more palatable.
>

Yeah.

In any case, I will try a different approach that leaves the .start
and .text sections alone, given that the issue that I thought I was
addressing on the side does not turn out to exist in practice.

Thanks
