From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Feb 2015 16:56:32 +0000
Subject: [RFC PATCH 3/3] arm64: KVM: use ID map with increased VA range if
 required
In-Reply-To: <20150226161146.GA17949@e104818-lin.cambridge.arm.com>
References: <1424964547-2118-1-git-send-email-ard.biesheuvel@linaro.org>
 <1424964547-2118-4-git-send-email-ard.biesheuvel@linaro.org>
 <20150226161146.GA17949@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu8bK-OFXp1FkYtZ7k8N8gg3hGpGAA7SO3KN16A3-FkcMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2015 at 16:11, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Feb 26, 2015 at 03:29:07PM +0000, Ard Biesheuvel wrote:
>> +     /*
>> +      * If we are running with VA_BITS < 48, we may be running with an extra
>> +      * level of translation in the ID map. This is only the case if system
>> +      * RAM is out of range for the currently configured page size and number
>> +      * of translation levels, in which case we will also need the extra
>> +      * level for the HYP ID map, or we won't be able to enable the EL2 MMU.
>> +      *
>> +      * However, at EL2, there is only one TTBR register, and we can't switch
>> +      * between translation tables *and* update TCR_EL2.T0SZ at the same
>> +      * time. Bottom line: we need the extra level in *both* our translation
>> +      * tables.
>
> It doesn't sound too nice but I'm not sure we can do much about it.
>

I don't think there is.

>> +      *
>> +      * Fortunately, there is an easy way out: the existing ID map, with the
>> +      * extra level, can be reused for both. The kernel image is already
>> +      * identity mapped at a high virtual offset, which leaves VA_BITS of
>> +      * address space at the low end to put our runtime HYP mappings.
>> +      */
>
> Another aspect here is that the Hyp VA starts at HYP_PAGE_OFFSET which
> is 1 << (VA_BITS - 1). On some platforms we may get an overlap with the
> physical memory (and the original idmap). Could we switch to the
> dedicated hyp TTBR at this point, with the extra level? Functions like
> __create_hyp_mapping() don't need to know about this extra level as
> hyp_pgd only knows about 4 levels but TTBR0_EL2 would point to the extra
> level.
>

The original id map only covers the kernel image, not all of system
ram (and it doesn't have to). The only way the hyp VA range could
overlap with the existing ID mapping while we are running with the
additional level is if KERNEL_START < (1<<VA_BITS) and KERNEL_END >=
(1<<VA_BITS). I don't think the pgtable code in head.S can deal with
that anyway atm. Otherwise, I don't see how they would ever overlap.

If we are not running with the additional level, then we keep the
separate translation tables. We could decide to reuse the existing ID
map in that case as well, but this is fairly trivial to implement so I
left it out for now.
