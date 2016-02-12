From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 21:37:02 +0100
Subject: [PATCH v5sub1 0/8] arm64: split linear and kernel mappings
In-Reply-To: <56BE3C35.7070608@gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <56BE3645.3030403@gmail.com>
 <CAKv+Gu9Qw=DSe1fZT=Dv=iKaKqzsf5ARK9dzwCWPk_0uRECm1w@mail.gmail.com>
 <56BE3C35.7070608@gmail.com>
Message-ID: <CAKv+Gu_oRxvw_543M21Z_5qcUd8euWnn8T-qzrneQMw_z5SQkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 21:10, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
> On 12/02/16 20:47, Ard Biesheuvel wrote:
>>
>> On 12 February 2016 at 20:45, Matthias Brugger <matthias.bgg@gmail.com>
>> wrote:
>>>
>>> Hi Ard,
>>>
>>>
>>> On 01/02/16 11:54, Ard Biesheuvel wrote:
>>>>
>>>>
>>>> At the request of Catalin, this series has been split off from my series
>>>> 'arm64: implement support for KASLR v4' [1]. This sub-series deals with
>>>> moving the kernel out of the linear mapping into the vmalloc area. This
>>>> is a prerequisite for independent physical and virtual randomization of
>>>> the kernel image. On top of that, considering that these changes allow
>>>> the linear mapping to start at an arbitrary offset above PAGE_OFFSET, it
>>>> should be an improvement in itself due to the fact that we can now
>>>> choose
>>>> PAGE_OFFSET such that RAM can be mapped using large block sizes.
>>>>
>>>> For instance, on my Seattle A0 box, the kernel is loaded 16 MB into the
>>>> lowest GB of RAM, which means __pa(PAGE_OFFSET) is not 1 GB aligned, and
>>>> the entire 16 GB of RAM will be mapping using 2 MB blocks. (Similarly,
>>>> for 64 KB granule kernels, the entire 16 GB of RAM will be mapped using
>>>> pages since __pa(PAGE_OFFSET) is not 512 MB aligned). With these changes
>>>>    __pa(PAGE_OFFSET) will always be chosen such that it is aligned to a
>>>> quantity that allows efficient mapping.
>>>>
>>>> Note that of the entire KASLR series, this sub-series is the most likely
>>>> to
>>>> cause problems, and hence requires the most careful review and testing.
>>>> This
>>>> is due to the fact that, with these changes, the invariant __va(__pa(x))
>>>> == x
>>>> no longer holds, and any code that is based on that assumption needs to
>>>> be
>>>> updated.
>>>>
>>>> Changes since v4:
>>>> - added Marc's ack to patch #6
>>>> - round the kasan zero shadow region around the kernel image to swapper
>>>> block
>>>>     size (#7)
>>>> - ensure that we don't clip the kernel image when clipping RAM to the
>>>> linear
>>>>     region size (#8)
>>>>
>>>> Patch #1 allows the low mark of memblocks discovered from the FDT to be
>>>> overridden by the architecture.
>>>>
>>>> Patch #2 enables the huge-vmap generic feature for arm64. This should be
>>>> an
>>>> improvement in itself, but the significance for this series is that it
>>>> allows
>>>> unmap_kernel_range() to be called on the [__init_begin, __init_end)
>>>> region,
>>>> which may be partially mapped using block mappings.
>>>>
>>>> Patch #3 introduces KIMAGE_VADDR as a separate, preparatory step towards
>>>> decoupling the kernel placement from PAGE_OFFSET
>>>>
>>>> Patch #4 implements some translation table accessors that operate on
>>>> statically
>>>> allocate translation tables before the linear mapping is up.
>>>>
>>>> Patch #5 decouples the fixmap initialization from the linear mapping, by
>>>> using
>>>> the accessors implemented by patch #4
>>>>
>>>> Patch #6 removes assumptions made my KVM regarding the placement of the
>>>> kernel
>>>> image inside the linear mapping.
>>>>
>>>> Patch #7 moves the kernel image from the base of the linear mapping to
>>>> the
>>>> base
>>>> of the vmalloc area. The modules area, which sits right below the kernel
>>>> image,
>>>> is moved along and is put right before the start of the vmalloc area.
>>>>
>>>> Patch #8 decouples PHYS_OFFSET from PAGE_OFFSET, which allows the linear
>>>> mapping
>>>> to cover all discovered memory, regardless of where the kernel image is
>>>> located
>>>> in it. This effectively allows the kernel to be loaded at any physical
>>>> address
>>>> (provided that the correct alignment is used)
>>>>
>>>> [1] http://thread.gmane.org/gmane.linux.kernel/2135931
>>>>
>>>> Ard Biesheuvel (8):
>>>>     of/fdt: make memblock minimum physical address arch configurable
>>>>     arm64: add support for ioremap() block mappings
>>>>     arm64: introduce KIMAGE_VADDR as the virtual base of the kernel
>>>> region
>>>>     arm64: pgtable: implement static [pte|pmd|pud]_offset variants
>>>>     arm64: decouple early fixmap init from linear mapping
>>>>     arm64: kvm: deal with kernel symbols outside of linear mapping
>>>>     arm64: move kernel image to base of vmalloc area
>>>>     arm64: allow kernel Image to be loaded anywhere in physical memory
>>>>
>>>
>>> I bisected linux-next (20160212) with the following error on booting with
>>> an
>>> initramfs:
>>>   Failed to execute /init (error -8)
>>>   request_module: runaway loop modprobe binfmt-464c
>>>   Starting init: /sbin/init exists but couldn't execute it (error -8)
>>>   request_module: runaway loop modprobe binfmt-464c
>>>   Starting init: /bin/sh exists but couldn't execute it (error -8)
>>>   Kernel panic - not syncing: No working init found.  Try passing init=
>>> option to kernel. See Linux Documentation/init..
>>>
>>> I tracked down the error to patch 7 of this series. But I realized that
>>> patch 7 does not compile, but from patch 8 onwards I observe the error.
>>>
>>> I use defconfig with an initramfs.cpio created with buildroot.
>>> I tested this on my mt8173 eval board, but I suppose this can be
>>> reproduced
>>> easily on other machines as well.
>>>
>>
>> Thanks for the report. Does this help at all?
>>
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/477645
>>
>
> I applied them on top of linux-next and this fixed the problem.
>

Great! Thanks for testing

>>> Regards,
>>> Matthias
>>>
>>>
>>>>    Documentation/arm64/booting.txt                      |  20 ++-
>>>>    Documentation/features/vm/huge-vmap/arch-support.txt |   2 +-
>>>>    arch/arm/include/asm/kvm_asm.h                       |   2 +
>>>>    arch/arm/kvm/arm.c                                   |   8 +-
>>>>    arch/arm64/Kconfig                                   |   1 +
>>>>    arch/arm64/include/asm/boot.h                        |   6 +
>>>>    arch/arm64/include/asm/kasan.h                       |   2 +-
>>>>    arch/arm64/include/asm/kernel-pgtable.h              |  12 ++
>>>>    arch/arm64/include/asm/kvm_asm.h                     |   2 +
>>>>    arch/arm64/include/asm/kvm_host.h                    |   8 +-
>>>>    arch/arm64/include/asm/memory.h                      |  44 ++++--
>>>>    arch/arm64/include/asm/pgtable.h                     |  23 ++-
>>>>    arch/arm64/kernel/head.S                             |   8 +-
>>>>    arch/arm64/kernel/image.h                            |  13 +-
>>>>    arch/arm64/kernel/vmlinux.lds.S                      |   4 +-
>>>>    arch/arm64/kvm/hyp.S                                 |   6 +-
>>>>    arch/arm64/mm/dump.c                                 |  12 +-
>>>>    arch/arm64/mm/init.c                                 | 123
>>>> ++++++++++++++--
>>>>    arch/arm64/mm/kasan_init.c                           |  31 +++-
>>>>    arch/arm64/mm/mmu.c                                  | 155
>>>> +++++++++++++++-----
>>>>    drivers/of/fdt.c                                     |   5 +-
>>>>    21 files changed, 378 insertions(+), 109 deletions(-)
>>>>
>>>
>
