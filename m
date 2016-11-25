From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 Nov 2016 12:48:57 +0000
Subject: [PATCH v3 2/3] powerpc/reloc64: add support for 32-bit CRC
 pseudo-symbols
In-Reply-To: <87oa13ssqq.fsf@concordia.ellerman.id.au>
References: <1477585631-18574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1477585631-18574-3-git-send-email-ard.biesheuvel@linaro.org>
 <87oa13ssqq.fsf@concordia.ellerman.id.au>
Message-ID: <CAKv+Gu8g=qgOg0Q5J7tFu0uBUFTUXdVQ+84N45oZseG3vTm0Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2016 at 11:29, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
>> index ec2d5c835170..2f510fbc87da 100755
>> --- a/arch/powerpc/relocs_check.sh
>> +++ b/arch/powerpc/relocs_check.sh
>> @@ -43,7 +43,8 @@ R_PPC_ADDR16_HA
>>  R_PPC_RELATIVE
>>  R_PPC_NONE' |
>>       grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_' |
>> -     grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_'
>> +     grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_' |
>> +     grep -E -v '\<R_PPC64_ADDR32[[:space:]]+\*ABS\*'
>
> I'm still getting:
>
> WARNING: 24 bad relocations
> c000000000d307c4 R_PPC64_ADDR32    __crc___arch_hweight16
> c000000000d307c8 R_PPC64_ADDR32    __crc___arch_hweight32
> c000000000d307cc R_PPC64_ADDR32    __crc___arch_hweight64
> c000000000d307d0 R_PPC64_ADDR32    __crc___arch_hweight8
> c000000000d30848 R_PPC64_ADDR32    __crc___bswapdi2
> c000000000d30854 R_PPC64_ADDR32    __crc___clear_user
> c000000000d30868 R_PPC64_ADDR32    __crc___copy_tofrom_user
> c000000000d30d4c R_PPC64_ADDR32    __crc__mcount
> c000000000d31344 R_PPC64_ADDR32    __crc_copy_page
> c000000000d3141c R_PPC64_ADDR32    __crc_current_stack_pointer
> c000000000d31840 R_PPC64_ADDR32    __crc_empty_zero_page
> c000000000d31a7c R_PPC64_ADDR32    __crc_flush_dcache_range
> c000000000d31a84 R_PPC64_ADDR32    __crc_flush_icache_range
> c000000000d32608 R_PPC64_ADDR32    __crc_load_fp_state
> c000000000d32614 R_PPC64_ADDR32    __crc_load_vr_state
> c000000000d32828 R_PPC64_ADDR32    __crc_memchr
> c000000000d32830 R_PPC64_ADDR32    __crc_memcmp
> c000000000d32834 R_PPC64_ADDR32    __crc_memcpy
> c000000000d32840 R_PPC64_ADDR32    __crc_memmove
> c000000000d32888 R_PPC64_ADDR32    __crc_memset
> c000000000d33c9c R_PPC64_ADDR32    __crc_store_fp_state
> c000000000d33ca0 R_PPC64_ADDR32    __crc_store_vr_state
> c000000000d33cf0 R_PPC64_ADDR32    __crc_strncmp
> c000000000d33cf4 R_PPC64_ADDR32    __crc_strncpy
>

Ah right, my bad. The regex above should switch to ADDR32 as well for
__crc_ symbols.

>
> If I just add those to the whitelist it builds, but then things aren't
> happy at boot:
>
>
> [    7.607687] kvm: disagrees about version of symbol module_layout
> [    7.846799] virtio: disagrees about version of symbol module_layout
> [   22.012615] crc32c_vpmsum: disagrees about version of symbol module_layout
> [   22.012959] libcrc32c: disagrees about version of symbol module_layout
>

Sigh. I suppose your modversions fixes are queued for v4.10? It's
probably best to revisit this after the v4.10 merge window closes
then, just to make sure I'm not aiming for a moving target.

Thanks,
Ard.
