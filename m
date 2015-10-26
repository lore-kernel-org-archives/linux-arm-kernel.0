From: laura@labbott.name (Laura Abbott)
Date: Mon, 26 Oct 2015 14:09:58 -0700
Subject: [PATCH v2] arm64: Align .text section to PAGE_SIZE
In-Reply-To: <20151026202608.GJ12277@leverpostej>
References: <1445882989-10618-1-git-send-email-jeremy.linton@arm.com>
 <20151026201611.GI12277@leverpostej> <20151026202608.GJ12277@leverpostej>
Message-ID: <562E96A6.9090602@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/15 1:26 PM, Mark Rutland wrote:
>> Perhaps it would be better to have something like the following (with
>> PAGE_SHIFT sorted out to be includable in a linker script), so any
>> ALIGN_DEBUG_RO* correctly aligns things to whatever boundary is
>> required, and we don't need to over-align things in the !DEBUG_RO_DATA
>> case.
>
> Ignore the bit about PAGE_SHIFT and linker script. I'd got confused as I
> had a local typo breaking the build.
>
> With the below diff applied I can boot a defconfig +CONFIG_DEBUG_RODATA
> +CONFIG_ARM64_64K_PAGES v4.3-rc7 kernel on Juno
>

Most of the alignment was found by trial and error so I suspect it was
just getting lucky before. I think this should be covering all the
cases. Hopefully the protections will make it more restrictive instead
of less to catch any more corner cases. For whoever ends up submitting
the patch,

Reviewed-by: Laura Abbott <laura@labbott.name>

> Thanks,
> Mark.
>
>> ---->8----
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 9807333..4d77757 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -60,9 +60,12 @@ PECOFF_FILE_ALIGNMENT = 0x200;
>>   #define PECOFF_EDATA_PADDING
>>   #endif
>>
>> -#ifdef CONFIG_DEBUG_ALIGN_RODATA
>> +#if defined(CONFIG_DEBUG_ALIGN_RODATA)
>>   #define ALIGN_DEBUG_RO                 . = ALIGN(1<<SECTION_SHIFT);
>>   #define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>> +#elif defined(CONFIG_DEBUG_RODATA)
>> +#define ALIGN_DEBUG_RO                 . = ALIGN(1<<PAGE_SHIFT);
>> +#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>>   #else
>>   #define ALIGN_DEBUG_RO
>>   #define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(min);
