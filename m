From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 22 Nov 2010 18:39:29 +0000
Subject: [PATCH v2 7/9] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <alpine.LFD.2.00.1011221312500.9313@xanadu.home>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-8-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1011221312500.9313@xanadu.home>
Message-ID: <AANLkTik8Ha31Abzgvqp3AiZoKg_L9iqNG-HcoM+L3foR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 22, 2010 at 6:28 PM, Nicolas Pitre <nico@fluxnic.net> wrote:

[...]

>> Applies on v2.6.37-rc3.
>
> Ideally you should keep that line above outside of the actual commit log
> text, as no one will care on what version it applies to once it is
> merged. ?It is best to put that below the --- line, or omit it entirely
> if using 'git send-email'.

OK, I'll leave it out in the future...

>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> Looking at it again there is a problem with the patch as is...
>
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -125,16 +125,21 @@ wait: ? ? ? ? ? mrc ? ? p14, 0, pc, c0, c1, 0
>> ? * sort out different calling conventions
>> ? */
>> ? ? ? ? ? ? ? .align
>> + ? ? ? ? ? ? .arm ? ? ? ? ? ? ? ? ? ? ? ? ? ?@ Always enter in ARM state
>> ?start:
>> ? ? ? ? ? ? ? .type ? start,#function
>> - ? ? ? ? ? ? .rept ? 8
>> + THUMB( ? ? ? ? ? ? ?adr ? ? r12, BSYM(1f) ? )
>> + THUMB( ? ? ? ? ? ? ?bx ? ? ?r12 ? ? ? ? ? ? )
>> + THUMB( ? ? ? ? ? ? ?.rept ? 6 ? ? ? ? ? ? ? )
>> + ARM( ? ? ? ? ? ? ? ?.rept ? 8 ? ? ? ? ? ? ? )
>> ? ? ? ? ? ? ? mov ? ? r0, r0
>> ? ? ? ? ? ? ? .endr
>>
>> - ? ? ? ? ? ? b ? ? ? 1f
>> + ? ? ? ? ? ? nop ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ Pad magic number to 0x24
>
> Why is this branch removed? ?With an ARM mode kernel this means we'll
> attempt to execute the magic number that follows.

Hmmm, I think I got confused during a branch merge...

I will retest and repost this patch as appropriate.

Cheers
---Dave
