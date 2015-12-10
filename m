From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Dec 2015 16:01:14 +0000
Subject: [RFC PATCH 06/20] arm64: mm: place empty_zero_page in bss
In-Reply-To: <20151210155110.GK495@leverpostej>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
 <1449665095-20774-7-git-send-email-mark.rutland@arm.com>
 <20151210141107.GF21134@arm.com> <20151210152957.GD495@leverpostej>
 <56699CD8.2010009@arm.com> <20151210155110.GK495@leverpostej>
Message-ID: <5669A1CA.2030400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 15:51, Mark Rutland wrote:
> On Thu, Dec 10, 2015 at 03:40:08PM +0000, Marc Zyngier wrote:
>> On 10/12/15 15:29, Mark Rutland wrote:
>>> On Thu, Dec 10, 2015 at 02:11:08PM +0000, Will Deacon wrote:
>>>> On Wed, Dec 09, 2015 at 12:44:41PM +0000, Mark Rutland wrote:
>>>>> Currently the zero page is set up in paging_init, and thus we cannot use
>>>>> the zero page earlier. We use the zero page as a reserved TTBR value
>>>>> from which no TLB entries may be allocated (e.g. when uninstalling the
>>>>> idmap). To enable such usage earlier (as may be required for invasive
>>>>> changes to the kernel page tables), and to minimise the time that the
>>>>> idmap is active, we need to be able to use the zero page before
>>>>> paging_init.
>>>>>
>>>>> This patch follows the example set by x86, by allocating the zero page
>>>>> at compile time, in .bss. This means that the zero page itself is
>>>>> available immediately upon entry to start_kernel (as we zero .bss before
>>>>> this), and also means that the zero page takes up no space in the raw
>>>>> Image binary. The associated struct page is allocated in bootmem_init,
>>>>> and remains unavailable until this time.
>>>>>
>>>>> Outside of arch code, the only users of empty_zero_page assume that the
>>>>> empty_zero_page symbol refers to the zeroed memory itself, and that
>>>>> ZERO_PAGE(x) must be used to acquire the associated struct page,
>>>>> following the example of x86. This patch also brings arm64 inline with
>>>>> these assumptions.
>>>>>
>>>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>>>>> Cc: Laura Abbott <labbott@fedoraproject.org>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/mmu_context.h | 2 +-
>>>>>  arch/arm64/include/asm/pgtable.h     | 4 ++--
>>>>>  arch/arm64/mm/mmu.c                  | 9 +--------
>>>>>  3 files changed, 4 insertions(+), 11 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>> index 304ff23..7559c22 100644
>>>>> --- a/arch/arm64/mm/mmu.c
>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>> @@ -48,7 +48,7 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>>>>>   * Empty_zero_page is a special page that is used for zero-initialized data
>>>>>   * and COW.
>>>>>   */
>>>>> -struct page *empty_zero_page;
>>>>> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>>>>>  EXPORT_SYMBOL(empty_zero_page);
>>>>
>>>> I've been looking at this, and it was making me feel uneasy because it's
>>>> full of junk before the bss is zeroed. Working that through, it's no
>>>> worse than what we currently have but I then realised that (a) we don't
>>>> have a dsb after zeroing the zero page (which we need to make sure the
>>>> zeroes are visible to the page table walker and (b) the zero page is
>>>> never explicitly cleaned to the PoC.
>>>
>>> Ouch; that's scary.
>>>
>>>> There may be cases where the zero-page is used to back read-only,
>>>> non-cacheable mappings (something to do with KVM?), so I'd sleep better
>>>> if we made sure that it was clean.
>>>
>>> From a grep around for uses of ZERO_PAGE, in most places the zero page
>>> is simply used as an empty buffer for I/O. In these cases it's either
>>> accessed coherently or goes via the usual machinery for non-coherent DMA
>>> kicks in.
>>>
>>> I don't believe that we usually give userspace the ability to create
>>> non-cacheable mappings, and I couldn't spot any paths it could do so via
>>> some driver-specific IOCTL applied to the zero page.
>>>
>>> Looking around, kvm_clear_guest_page seemed problematic, but isn't used
>>> on arm64. I can imagine the zero page being mapped into guests in other
>>> situations when mirroring the userspace mapping. 
>>>
>>> Marc, Christoffer, I thought we cleaned pages to the PoC before mapping
>>> them into a guest? Is that right? Or do we have potential issues there?
>>
>> I think we're OK. Looking at __coherent_cache_guest_page (which is
>> called when transitioning from an invalid to valid mapping), we do flush
>> things to PoC if the vcpu has its cache disabled (or if we know that the
>> IPA shouldn't be cached - the whole NOR flash emulation horror story).
> 
> So we asume the guest never disables the MMU, and always uses consistent
> attributes for a given IPA (e.g. it doesn't have a Device and Normal
> Cacheable mapping)?

Yup. If it starts using stupid attributes, it will get stupid results,
and there isn't much the architecture gives us to deal with this.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
