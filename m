From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 17:28:36 +0100
Subject: [PATCH 1/2] arm64: mm: Enable CONT_SIZE aligned sections for 64k
 page kernels.
In-Reply-To: <56BE0698.10506@arm.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-2-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu_ViEAVN1GEDMWpJ5OYjg6BVSLTEtdus6vCCXchQ1BOjw@mail.gmail.com>
 <56BE0698.10506@arm.com>
Message-ID: <CAKv+Gu--05Wn6oWEiy=43nzujNgG0=DpOB9b1zs9_jfddYXWwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 17:21, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 02/12/2016 10:11 AM, Ard Biesheuvel wrote:
>>
>> On 12 February 2016 at 17:06, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> (trimming)
>>>
>>>   #if defined(CONFIG_DEBUG_ALIGN_RODATA)
>>> -#define ALIGN_DEBUG_RO                 . = ALIGN(1<<SECTION_SHIFT);
>>> -#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>>> +#if defined(CONFIG_ARM64_64K_PAGES)
>>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(CONT_SIZE);
>>> +#else
>>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(SECTION_SIZE);
>>
>>
>> Doesn't this align to 32 MB on 16k pages kernels?
>
>
> Yes, I considered whether it was more appropriate to use CONT_SIZE for 16k
> as well.
>
> Opinions?
>

Looking at vmlinux.lds.S, I see that that would put _stext and
__init_begin at 32 MB aligned boundaries. making the size of the
kernel at least 64 MB. If I take your .rodata patch into account,
which adds a third instance of ALIGN_DEBUG_RO_MIN, the Image footprint
will rise to ~100 MB. Or am I missing something?



>
>>
>>> +#endif
>>>   #elif defined(CONFIG_DEBUG_RODATA)
>>> -#define ALIGN_DEBUG_RO                 . = ALIGN(1<<PAGE_SHIFT);
>>> -#define ALIGN_DEBUG_RO_MIN(min)                ALIGN_DEBUG_RO
>>> +#define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(PAGE_SIZE);
>>>   #else
>>> -#define ALIGN_DEBUG_RO
>>>   #define ALIGN_DEBUG_RO_MIN(min)                . = ALIGN(min);
>>>   #endif
>>>
>>> --
>>> 2.4.3
>>>
>>
>
