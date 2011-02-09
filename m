From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 9 Feb 2011 17:00:48 +0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <alpine.LFD.2.00.1102091133050.14920@xanadu.home>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1102091133050.14920@xanadu.home>
Message-ID: <AANLkTi=U=EhzFT1+VPG-sYsTj8yrnaRNfvA=qsmwgvr9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 9, 2011 at 4:38 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 8 Feb 2011, Dave Martin wrote:
>
>> The content for ALT_SMP() in the definition of WFE() expands to 6
>> bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
>> code, leading to lockups when the affected code gets run.
>>
>> This patch works around the problem by explicitly using an
>> IT + WFEcc.N pair.
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> ---
>> ?arch/arm/include/asm/spinlock.h | ? ?7 ++++++-
>> ?1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
>> index da1af52..7cba79c 100644
>> --- a/arch/arm/include/asm/spinlock.h
>> +++ b/arch/arm/include/asm/spinlock.h
>> @@ -18,7 +18,12 @@
>>
>> ?#ifdef CONFIG_THUMB2_KERNEL
>> ?#define SEV ? ? ? ? ?ALT_SMP("sev.w", "nop.w")
>> -#define WFE(cond) ? ?ALT_SMP("wfe" cond ".w", "nop.w")
>> +#define WFE(cond) ? ?ALT_SMP( ? ? ? ? ? ? ? ?\
>> + ? ? "it " cond "\n\t" ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? "wfe" cond ".n", ? ? ? ? ? ? ? ? ? ? ? ?\
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> + ? ? "nop.w" ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> +)
>
> In addition to a comment inline for this as others have suggested
> already, I'd write it differently to save some realestate:
>
> #define WFE(cond) ? ? ? ALT_SMP("it " cond " ; wfe" cond ".n", "nop.w")

Because of the subtlety of this, I wanted it to be presented in as
clear a way as possible.

Russell, the patch is in your patch system--- if you prefer the
shortened form, fell free to reject the existing patch and I'll
repost.

Cheers
---Dave
