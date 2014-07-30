From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Jul 2014 14:05:08 +0200
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <CAKv+Gu-891BPCMCB2xnhsaUHxz_BCMkwbbwQ76kmK=JsUdifHQ@mail.gmail.com>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140730113013.GL12239@arm.com>
 <CAKv+Gu-891BPCMCB2xnhsaUHxz_BCMkwbbwQ76kmK=JsUdifHQ@mail.gmail.com>
Message-ID: <CAKv+Gu8rg=Th0OggHggSFEpLq5buR3vsCwR74TeyO5g85pt2Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 July 2014 14:00, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 30 July 2014 13:30, Will Deacon <will.deacon@arm.com> wrote:
>> On Wed, Jul 30, 2014 at 11:59:02AM +0100, Ard Biesheuvel wrote:
>>> From: Mark Rutland <mark.rutland@arm.com>
>>>
>>> In certain cases the cpu-release-addr of a CPU may not fall in the
>>> linear mapping (e.g. when the kernel is loaded above this address due to
>>> the presence of other images in memory). This is problematic for the
>>> spin-table code as it assumes that it can trivially convert a
>>> cpu-release-addr to a valid VA in the linear map.
>>>
>>> This patch modifies the spin-table code to use a temporary cached
>>> mapping to write to a given cpu-release-addr, enabling us to support
>>> addresses regardless of whether they are covered by the linear mapping.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Tested-by: Mark Salter <msalter@redhat.com>
>>> [ardb: added (__force void *) cast]
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  arch/arm64/kernel/smp_spin_table.c | 22 +++++++++++++++++-----
>>>  1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> I'm nervous about this. What if the spin table sits in the same physical 64k
>> frame as a read-sensitive device and we're running with 64k pages?
>>
>
> I see what you mean. This is potentially hairy, as EFI already
> ioremap_cache()s everything known to it as normal DRAM, so using plain

Clarification: every Runtime Services region known to it as being
normal DRAM, which may cover this area

> ioremap() here if pfn_valid() returns false for cpu-release-addr's PFN
> may still result in mappings with different attributes for the same
> region. So how should we decide whether to call ioremap() or
> ioremap_cache() in this case?
>
> --
> Ard.
