From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 10:21:44 -0600
Subject: [PATCH 1/2] arm64: mm: Enable CONT_SIZE aligned sections for 64k
 page kernels.
In-Reply-To: <CAKv+Gu_ViEAVN1GEDMWpJ5OYjg6BVSLTEtdus6vCCXchQ1BOjw@mail.gmail.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-2-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_ViEAVN1GEDMWpJ5OYjg6BVSLTEtdus6vCCXchQ1BOjw@mail.gmail.com>
Message-ID: <56BE0698.10506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 10:11 AM, Ard Biesheuvel wrote:
> On 12 February 2016 at 17:06, Jeremy Linton <jeremy.linton@arm.com> wrote:
(trimming)
>>   #if defined(CONFIG_DEBUG_ALIGN_RODATA)
>> -#define ALIGN_DEBUG_RO                 . = ALIGN(1<<SECTION_SHIFT);
>> -#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>> +#if defined(CONFIG_ARM64_64K_PAGES)
>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(CONT_SIZE);
>> +#else
>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(SECTION_SIZE);
>
> Doesn't this align to 32 MB on 16k pages kernels?

Yes, I considered whether it was more appropriate to use CONT_SIZE for 
16k as well.

Opinions?

>
>> +#endif
>>   #elif defined(CONFIG_DEBUG_RODATA)
>> -#define ALIGN_DEBUG_RO                 . = ALIGN(1<<PAGE_SHIFT);
>> -#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(PAGE_SIZE);
>>   #else
>> -#define ALIGN_DEBUG_RO
>>   #define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(min);
>>   #endif
>>
>> --
>> 2.4.3
>>
>
