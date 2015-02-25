From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 24 Feb 2015 17:30:44 -0800
Subject: [PATCH v2] arm64: mm: increase VA range of identity map
In-Reply-To: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1424797703-2804-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <54ED25C4.2090900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/24/2015 9:08 AM, Ard Biesheuvel wrote:
> The page size and the number of translation levels, and hence the supported
> virtual address range, are build-time configurables on arm64 whose optimal
> values are use case dependent. However, in the current implementation, if
> the system's RAM is located at a very high offset, the virtual address range
> needs to reflect that merely because the identity mapping, which is only used
> to enable or disable the MMU, requires the extended virtual range to map the
> physical memory at an equal virtual offset.
>
> This patch relaxes that requirement, by increasing the number of translation
> levels for the identity mapping only, and only when actually needed, i.e.,
> when system RAM's offset is found to be out of reach at runtime.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2:
> - Dropped hunk regarding KVM, this will be addressed separately. Note that the
>    build is still broken on Seattle if you have KVM enabled and 4k pages with
>    3 levels of translation configured, but at least you have something to watch
>    on your console now
> - Fix ordering wrt TLB flushing
> - Set T0SZ based on actual leading zero count in __pa(KERNEL_END), the net
>    result is the same (one additional level of translation, if needed)
>
>   arch/arm64/include/asm/mmu_context.h   | 38 ++++++++++++++++++++++++++++++++++
>   arch/arm64/include/asm/page.h          |  6 ++++--
>   arch/arm64/include/asm/pgtable-hwdef.h |  7 ++++++-
>   arch/arm64/kernel/head.S               | 22 ++++++++++++++++++++
>   arch/arm64/kernel/smp.c                |  1 +
>   arch/arm64/mm/mmu.c                    |  7 ++++++-
>   arch/arm64/mm/proc-macros.S            | 11 ++++++++++
>   arch/arm64/mm/proc.S                   |  3 +++
>   8 files changed, 91 insertions(+), 4 deletions(-)
>

Tested-by: Laura Abbott <lauraa@codeaurora.org>

For both 4K and 64K pages.


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
