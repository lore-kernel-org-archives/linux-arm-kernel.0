From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 10:45:54 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <20151014172418.GI5041@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <20151014172418.GI5041@leverpostej>
Message-ID: <561F75D2.8010301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 18:24, Mark Rutland wrote:

>> - * other registers depend on the function called upon completion
>> + * Other registers depend on the function called upon completion.
>> + *
>> + * Checks if the selected granule size is supported by the CPU.
>> + * If it doesn't park the CPU
>
> Nit: "If it isn't, park the CPU."

OK

>
>>    */
>> +#if	defined(CONFIG_ARM64_64K_PAGES)
>> +
>> +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
>> +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
>> +
>> +#else
>> +
>> +#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
>> +#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON
>
> Any reason for not using upper-case names for the macros?

Nothing in particular. I had them in upper-case in the previous version,
changed it here ;) for absolutely no reason. I could switch it back.

> Given they're local you could just call them TGRAN_SHIFT and TRGRAN_ON
> to make the asm slightly nicer.

Given Jeremy's suggestion to add something to the EFI stub, I will retain
the original definition with all upper-case and define it somewhere in
a header so that we can reuse it.

>> +
>> +__no_granule_support:
>> +	wfe
>> +	b __no_granule_support
>> +ENDPROC(__no_granule_support)
>
> Other than the above, this loogs fine to me.
>
> In future it would be nice if we could somehow signal that these dead
> CPUs are trapped in the kernel -- we should have some kind of canary
> mechanism for that. That needn't block this patch, though.

Yes, we should.

Thanks for the review
Suzuki
