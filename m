From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Feb 2016 17:55:57 +0100
Subject: [PATCH v2 1/2] arm64: mm: Mark .rodata as RO
In-Reply-To: <56C4A5AE.1090602@arm.com>
References: <1455727274-16328-1-git-send-email-jeremy.linton@arm.com>
 <1455727274-16328-2-git-send-email-jeremy.linton@arm.com>
 <CAKv+Gu82_sXwRjZpqsLDMc_MVwZ3bRLodS4TEQRoRSKQCNQu3A@mail.gmail.com>
 <56C4A5AE.1090602@arm.com>
Message-ID: <CAKv+Gu-TgwNHEeqe3+H1ork5N-pVROTrJ4FPzUBvUGo-Z9RehA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2016 at 17:54, Jeremy Linton <jeremy.linton@arm.com> wrote:
> On 02/17/2016 10:46 AM, Ard Biesheuvel wrote:
>>
>> On 17 February 2016 at 17:41, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>
>>> Currently the .rodata section is actually still executable when
>>> DEBUG_RODATA
>>> is enabled. This changes that so the .rodata is actually read only, no
>>> execute.
>>>
> (trimming)
>>>
>>>
>>> -       map_kernel_chunk(pgd, _stext, _etext, PAGE_KERNEL_EXEC);
>>> +       map_kernel_chunk(pgd, _stext, __start_rodata, PAGE_KERNEL_EXEC);
>>> +       map_kernel_chunk(pgd, __start_rodata, _etext, PAGE_KERNEL_EXEC);
>>
>>
>> Couldn't we map this non-exec from the start?
>
>
> Probably, Mark suggested that, but Kees seemed to have reasons not to.
> Either way, my opinion is that for that change to make sense we also need to
> always enable the functionality turned on by DEBUG_RODATA.
>

Actually, I think that was about mapping read-only, not non-exec. For
text patching and Kees's __ro_after_init stuff, the region would need
to be writable early on. But I don't think there is a reason to make
it executable.
