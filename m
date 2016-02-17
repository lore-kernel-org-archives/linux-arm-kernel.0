From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 17 Feb 2016 10:54:06 -0600
Subject: [PATCH v2 1/2] arm64: mm: Mark .rodata as RO
In-Reply-To: <CAKv+Gu82_sXwRjZpqsLDMc_MVwZ3bRLodS4TEQRoRSKQCNQu3A@mail.gmail.com>
References: <1455727274-16328-1-git-send-email-jeremy.linton@arm.com>
 <1455727274-16328-2-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu82_sXwRjZpqsLDMc_MVwZ3bRLodS4TEQRoRSKQCNQu3A@mail.gmail.com>
Message-ID: <56C4A5AE.1090602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2016 10:46 AM, Ard Biesheuvel wrote:
> On 17 February 2016 at 17:41, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> Currently the .rodata section is actually still executable when DEBUG_RODATA
>> is enabled. This changes that so the .rodata is actually read only, no execute.
>>
(trimming)
>>
>> -       map_kernel_chunk(pgd, _stext, _etext, PAGE_KERNEL_EXEC);
>> +       map_kernel_chunk(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC);
>> +       map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL_EXEC);
>
> Couldn't we map this non-exec from the start?

Probably, Mark suggested that, but Kees seemed to have reasons not to. 
Either way, my opinion is that for that change to make sense we also 
need to always enable the functionality turned on by DEBUG_RODATA.

>
>>          map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC);
>>          map_kernel_chunk(pgd, _data, _end, PAGE_KERNEL);
>>
>> --
>> 2.4.3
>>
>
