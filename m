From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 13:00:54 +0100
Subject: [PATCH] arm64: mm: use correct mapping granularity under
 DEBUG_RODATA
In-Reply-To: <20151116115740.GD20696@leverpostej>
References: <1447669094-31076-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151116115740.GD20696@leverpostej>
Message-ID: <CAKv+Gu9ZoRx8i8ppNxiuS9FfRONzLK5TVPe33W-dirfO702zOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2015 at 12:57, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Mon, Nov 16, 2015 at 11:18:14AM +0100, Ard Biesheuvel wrote:
>> When booting a 64k pages kernel that is built with CONFIG_DEBUG_RODATA
>> and resides at an offset that is not a multiple of 512 MB, the rounding
>> that occurs in __map_memblock() and fixup_executable() results in
>> incorrect regions being mapped.
>>
>> The following snippet from /sys/kernel/debug/kernel_page_tables shows
>> how, when the kernel is loaded 2 MB above the base of DRAM at 0x40000000,
>> the first 2 MB of memory (which may be inaccessible from non-secure EL1
>> or just reserved by the firmware) is inadvertently mapped into the end of
>> the module region.
>
> I assume for the above that you mean the kernel is loaded TEXT_OFFSET
> above these addresses. It's only a nit, but it might make things harder
> for otehrs to reason about in future.
>
> Perhaps re-word in terms of PHYS_OFFSET/memstart_addr? e.g. "when
> PHYS_OFFSET is not a multiple of SECTION_SIZE ...".
>

The clearer the better, so yes, let's reword it.

>>   ---[ Modules start ]---
>>   0xfffffdffffe00000-0xfffffe0000000000     2M RW NX ... UXN MEM/NORMAL
>>   ---[ Modules end ]---
>>   ---[ Kernel Mapping ]---
>>   0xfffffe0000000000-0xfffffe0000090000   576K RW NX ... UXN MEM/NORMAL
>>   0xfffffe0000090000-0xfffffe0000200000  1472K ro x  ... UXN MEM/NORMAL
>>   0xfffffe0000200000-0xfffffe0000800000     6M ro x  ... UXN MEM/NORMAL
>>   0xfffffe0000800000-0xfffffe0000810000    64K ro x  ... UXN MEM/NORMAL
>>   0xfffffe0000810000-0xfffffe0000a00000  1984K RW NX ... UXN MEM/NORMAL
>>   0xfffffe0000a00000-0xfffffe00ffe00000  4084M RW NX ... UXN MEM/NORMAL
>>
>> The same issue is likely to occur on 16k pages kernels whose load
>> address is not a multiple of 32 MB (i.e., SECTION_SIZE). So round to
>> SWAPPER_BLOCK_SIZE instead of SECTION_SIZE.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> This looks good to me. With or without the rewording above:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Does this need to be backported to stable?
>

It should be fixed in stable, I think, but SWAPPER_BLOCK_SIZE is new
in v4.4 so we'd need another patch anyway.

-- 
Ard.
