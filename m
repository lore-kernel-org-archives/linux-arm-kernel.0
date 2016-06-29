From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jun 2016 18:50:30 +0200
Subject: [PATCH 3/5] arm64: efi: avoid block mappings for unaligned UEFI
 memory regions
In-Reply-To: <20160629164525.GE2522@e104818-lin.cambridge.arm.com>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
 <1467204690-10790-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160629164525.GE2522@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_OUw+WJSNmC8mdAgAK8Nm=UGqtwgt8TBCwhTiBY9+2tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 June 2016 at 18:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jun 29, 2016 at 02:51:28PM +0200, Ard Biesheuvel wrote:
>> +     if (!PAGE_ALIGNED(md->phys_addr) ||
>> +         !PAGE_ALIGNED(md->num_pages << EFI_PAGE_SHIFT)) {
>> +             /*
>> +              * If the end address of this region is not aligned to page
>> +              * size, the mapping is rounded up, and may end up sharing a
>> +              * page frame with the next UEFI memory region. If we create
>> +              * a block entry now, we may need to split it again when mapping
>> +              * the next region, and support for that is going to be removed
>> +              * from the MMU routines. So avoid block mappings altogether in
>> +              * that case.
>> +              */
>> +             allow_block_mappings = false;
>> +     }
>
> How common is it for large areas to have unaligned start/end? I wonder
> whether it's worth implementing my approach to look ahead and explicitly
> check the overlap with the next section instead of disabling block
> mappings altogether for this region.
>

Very uncommon. Typically, only MMIO regions that represent NOR flash
are larger than a couple of pages. Taken from QEMU:
