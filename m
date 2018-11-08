From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 8 Nov 2018 15:10:32 +0100
Subject: [PATCH 0/7] Ensure stack is aligned for kernel entries
In-Reply-To: <8382cafd-9fb7-7121-0de2-5091ba079d31@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu-jVTWyy61Q--HE_Hw+RZVxYcTypZmF+YUhmX1p_QkLKQ@mail.gmail.com>
 <8382cafd-9fb7-7121-0de2-5091ba079d31@arm.com>
Message-ID: <CAKv+Gu_K9p5FvQGtvgzKmveiQvHQp1H1PxAzxqcFnJfDQt4huw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Ramana)

On 8 November 2018 at 14:27, Julien Thierry <julien.thierry@arm.com> wrote:
>
>
> On 08/11/18 13:04, Ard Biesheuvel wrote:
>>
>> On 26 September 2018 at 15:56, Julien Thierry <julien.thierry@arm.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> Having SCTLR_ELx.SA enabled requires the SP to be 16-bytes aligned before
>>> using it to access memory. When taking an exception, it is possible that
>>> the context during which the exception occured had SP mis-aligned.
>>
>>
>> How is this possible? GCC clearly only manipulates the stack pointer
>> in 16 byte multiples, and so if we do the same in our asm code (which
>> I think we already do, given the lack of reports about this issue), is
>> this handling really necessary?
>>
>
> Is there anything that actually gives us that guarantee from GCC? I agree
> that currently it looks like aarch64-<...>-gcc only manipulates SP aligned
> to 16 bytes, but I don't know whether that is certain.
>

I think we should get that clarified then. I don't think it makes
sense for GCC to have to reason about whether SP currently has a value
that permits dereferencing.

> The series can be dropped if there is enough confidence that this won't
> happen.
>
> Thanks,
>
>
>>
>>> The
>>> entry code needs to make sure that the stack is aligned before using it
>>> to
>>> save the context.
>>>
>>> This is only a concern when taking exception from an EL using the same
>>> SP_ELx as the handler. In other cases it can be assumed that the SP being
>>> picked up on exception entry is aligned under the condition that SP is
>>> always aligned when doing eret to an EL using a different SP.
>>>
>>> On Juno I see a runtime difference <1% for hackbench. If I do not include
>>> the fast path at EL1 (patch 4) I see a diff of 1-2%.
>>>
>>> For EL2 entries, a bit of clean up of stuff getting patched in the vector
>>> has been needed.
>>>
>>> Cheers,
>>>
>>> Julien
>>>
>>> -->
>>>
>>> Julien Thierry (7):
>>>    arm64: Add static check for pt_regs alignment
>>>    arm64: sdei: Always use sdei stack for sdei events
>>>    arm64: Align stack when taking exception from EL1
>>>    arm64: Add fast-path for stack alignment
>>>    arm64: Do not apply BP hardening for hyp entries from EL2
>>>    arm64: Do not apply vector harderning for hyp entries from EL2
>>>    arm64: kvm: Align stack for exception coming from EL2
>>>
>>>   arch/arm64/include/asm/assembler.h |  9 +++++
>>>   arch/arm64/include/asm/ptrace.h    |  2 +
>>>   arch/arm64/include/asm/sdei.h      |  2 -
>>>   arch/arm64/kernel/cpu_errata.c     | 10 ++++-
>>>   arch/arm64/kernel/entry.S          | 43 +++++++++++++++++++--
>>>   arch/arm64/kernel/sdei.c           | 23 ++++-------
>>>   arch/arm64/kvm/hyp/hyp-entry.S     | 78
>>> +++++++++++++++++++++++++++++++-------
>>>   drivers/firmware/Kconfig           |  1 +
>>>   8 files changed, 132 insertions(+), 36 deletions(-)
>>>
>>> --
>>> 1.9.1
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> --
> Julien Thierry
