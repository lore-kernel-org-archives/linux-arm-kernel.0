From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 11 Nov 2013 22:51:59 -0800
Subject: [PATCH] ARM: signal: fix armv7-m build issue in sigreturn_codes.S
In-Reply-To: <20131111105141.GB28302@mudshark.cambridge.arm.com>
References: <1384157427-31613-1-git-send-email-victor.kamensky@linaro.org>
 <1384157427-31613-2-git-send-email-victor.kamensky@linaro.org>
 <20131111105141.GB28302@mudshark.cambridge.arm.com>
Message-ID: <CAA3XUr0-iGBXkcJDKa-mSaj=Ok3SRV7vFyCGFYmVQWdfyVe0qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 November 2013 02:51, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Nov 11, 2013 at 08:10:27AM +0000, Victor Kamensky wrote:
>> In case of armv7-m architecture arm instructions are not allowed.
>> For this architecture CONFIG_CPU_THUMBONLY is set. Use this macro
>> to emit conditionally arm instructions or nops in thumb mode.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm/kernel/sigreturn_codes.S | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
>> index 3c5d0f2..899fb86 100644
>> --- a/arch/arm/kernel/sigreturn_codes.S
>> +++ b/arch/arm/kernel/sigreturn_codes.S
>> @@ -41,17 +41,29 @@
>>       .arch armv4t
>>  #endif
>>
>> +/*
>> + * In CPU_THUMBONLY kernel case arm opcodes are not allowed
>> + */
>> +#ifndef CONFIG_CPU_THUMBONLY
>
> Is this THUMBONLY stuff actually destined for mainline?
>
>> +#define ARM_INSTR(code...) .arm ; \
>> +                        code
>> +#else
>> +#define ARM_INSTR(code...) .thumb ; \
>> +                        nop ;    \
>> +                        nop ;
>> +#endif
>
> Why can't you solve this with the ARM(...) and THUMB(...) macros, like we do
> in places like head.S?

If we pursue this route (otherwise see Dave's suggestion on [1]),
sigreturn_codes is array of instructions snipets. It
is indexed by signal.c. Layout is very important here.
I don't see how ARM and THUMB can help us to achieve this.
The conditionally include instruction or empty. If I use them, it
will not help because it will change layout of sigreturn_codes.
Local macro I introduced uses .arm instruction
if not THUMBONLY and put two thumb instructions
to fill the space so sigreturn_codes keeps the same
layout.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210631.html

> Will
