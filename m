From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Oct 2014 10:15:44 +0200
Subject: [PATCH] arm: dma-mapping: fix compilation error when CONFIG_MMU is
 not present
In-Reply-To: <5445A345.7010401@codeaurora.org>
References: <1413734340-53108-1-git-send-email-stefan.hengelein@fau.de>
 <5444BCFF.8030803@samsung.com>
 <CABv5NL_GdtZegpw8wxau9oD6xXWdX3GUySLqCaoaoa549Kg_GQ@mail.gmail.com>
 <5445A345.7010401@codeaurora.org>
Message-ID: <5448B930.7070800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-10-21 02:05, Laura Abbott wrote:
> On 10/20/2014 6:50 AM, Stefan Hengelein wrote:
>> Well,
>>
>> arch/arm/mm/dma-mapping.c: In function ?__atomic_get_pages?:
>> arch/arm/mm/dma-mapping.c:1265:31: error: ?atomic_pool? undeclared
>> (first use in this function)
>>
>> arch/arm/mm/dma-mapping.c: In function ?__iommu_get_pages?:
>> arch/arm/mm/dma-mapping.c:1275:2: error: implicit declaration of
>> function ?__in_atomic_pool? [-Werror=implicit-function-declaration]
>>
>>
>> others:
>> arch/arm/mm/dma-mapping.c: In function ?__iommu_alloc_remap?:
>> arch/arm/mm/dma-mapping.c:1200:4: error: ?VM_ARM_DMA_CONSISTENT?
>> undeclared (first use in this function)
>> arch/arm/mm/dma-mapping.c:1200:4: note: each undeclared identifier is
>> reported only once for each function it appears in
>>
>> arch/arm/mm/dma-mapping.c: In function ?__iommu_get_pages?:
>> arch/arm/mm/dma-mapping.c:1282:29: error: ?VM_ARM_DMA_CONSISTENT?
>> undeclared (first use in this function)
>> arch/arm/mm/dma-mapping.c: In function ?arm_iommu_free_attrs?:
>> arch/arm/mm/dma-mapping.c:1411:4: error: ?VM_ARM_DMA_CONSISTENT?
>> undeclared (first use in this function)
>>
>>
>> i've attached a configuration where it happens.
>> when you place the configuration in your tree and compile the file,
>> the errors should show up.
>>
>> However, within the configuration CONFIG_ARM_DMA_USE_IOMMU is defined
>> and CONFIG_MMU is not. AFAIUI, if both should be enabled together, it
>> should be mapped in Kconfig somewhere, right?
>
> There isn't a nice way to fixup the dma consistent flags so I would
> say this option should just depend on MMU.

The question is which option should depend on MMU? Making 
CONFIG_ARM_DMA_USE_IOMMU
to depend on MMU doesn't solve this case. It only gives following 
warning with the
mentioned .config:
warning: (VIDEO_OMAP3 && EXYNOS_IOMMU && SHMOBILE_IOMMU && IPMMU_VMSA && 
ARM_SMMU) selects ARM_DMA_USE_IOMMU which has unmet direct dependencies 
(MMU)

IMHO the best solution will be to either make the whole IOMMU subsystem 
to depend
on MMU or alternatively, add this dependency to all IOMMU drivers which 
can be
enabled by COMPILE_TEST option (here the issue is caused by 
SHMOBILE_IOMMU, which
otherwise cannot be enabled when no-mmu systems are selected).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
