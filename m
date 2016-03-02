From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 2 Mar 2016 18:16:46 +0100
Subject: [PATCH 0/3] arm64: more granular KASLR
In-Reply-To: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456938712-11089-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu90DPQwMD7W9_jydBAFOaA3Mu0RgbOPODTdmuY01zLoKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 March 2016 at 18:11, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> It turns out we can squeeze out 5 to 7 bits of additional KASLR entropy in
> the new arm64 implementation. This is based on the observation that the
> minimal 2 MB alignment of the kernel image is only required for kernels
> that are non-relocatable, and since KASLR already implies a relocatable
> kernel anyway, we get this additional wiggle room almost [1] for free.
>
> The idea is that, since we need to fix up all absolute symbol references
> anyway, the hardcoded virtual start address of the kernel does not need to
> be 2 MB aligned (+ TEXT_OFFSET), and the only thing we need to ensure is
> that the physical misalignment and the virtual misalignment are equal modulo
> the swapper block size.
>
> Patch #1 removes the explicit mapping of the TEXT_OFFSET region below the
> kernel, and only maps it if the rounding to swapper block size of the kernel
> start address ends up covering it.
>
> Patch #2 updates the early boot code to treat the physical misalignment as
> the initial KASLR displacement. Note that this only affects code that is
> compiled conditionally if CONFIG_RANDOMIZE_BASE=y
>
> Patch #3 updates the stub allocation strategy to allow a more granular mapping.
> Note that the allocation itself is still rounded to 2 MB as before, to prevent
> the early mapping to cover adjacent regions inadvertently. As is the case for
> patch #2, this only affects the new code under CONFIG_RANDOMIZE_BASE=y
>
> Sample output from a 4k/4 levels kernel, where we have 33 bits of entropy
> in the kernel addresses:
>
> Virtual kernel memory layout:
>     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
>     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
>       .init : 0xffff0bbbe14a6000 - 0xffff0bbbe17d5000   (  3260 KB)
>       .text : 0xffff0bbbe0c24000 - 0xffff0bbbe120a000   (  6040 KB)
>     .rodata : 0xffff0bbbe120a000 - 0xffff0bbbe14a6000   (  2672 KB)
>       .data : 0xffff0bbbe17d5000 - 0xffff0bbbe1866e00   (   584 KB)
>       fixed : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
>     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
>     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
>               0xffff7e1333000000 - 0xffff7e1337000000   (    64 MB actual)
>      memory : 0xffff84ccc0000000 - 0xffff84cdc0000000   (  4096 MB)
>

[1] this does defeat the performance benefit resulting from the
increased alignment implemented by CONFIG_DEBUG_ALIGN_RODATA=y
