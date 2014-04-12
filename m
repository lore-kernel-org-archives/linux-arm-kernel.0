From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 23:29:11 -0400 (EDT)
Subject: [PATCH v2 0/2] change ARM linux memory layout to support 32 CPUs
In-Reply-To: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
References: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <alpine.LFD.2.11.1404112326580.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Liu Hua wrote:

> Hi Nicolas or Russell,
> 
> This patch series change fixmap mapping region to suppport 32 CPUs.
> Because the "top_pmd" covers 0xfffe0000 - 0xffffffff(2M). And part 
> is used by vector table. So I move this region down to 0xffc00000
>  - 0xffdffff. 
> 
> 
> I have tested the patches on arma9(2 CPUs) and arma15(16 CPUs) platforms
> 
> BTW, As we know we can configure NR_CPUS up to 32. So we need 2048K 
> at most. But for ARM systems with less cpus, there is a waste 
> of virtual address. So should we change its size according to
> NR_CPUS, as what MIPS linux does ?

It is probably not worth the bother.  We lived with this area reserved 
for static DMA mapping while there was no longer any DMA mapped there 
for quite a while.



> 
> Changes from v1:
> ---------------
> - changed documentation for ARM linux memory layout.
> - moved fixmap mapping region, not just extended.
> 
> Liu Hua (2):
>   ARM : DMA : remove useless information about DMA
>   ARM : extend fixmap mapping region to support 32 CPUs
> 
>  Documentation/arm/memory.txt   |  8 ++------
>  arch/arm/include/asm/fixmap.h  |  4 ++--
>  arch/arm/include/asm/highmem.h |  1 +
>  arch/arm/include/asm/memory.h  |  2 --
>  arch/arm/mm/highmem.c          | 10 +++++-----
>  arch/arm/mm/mm.h               |  7 +++++++
>  arch/arm/mm/mmu.c              |  4 ++++
>  mm/highmem.c                   |  1 +
>  8 files changed, 22 insertions(+), 15 deletions(-)
> 
> -- 
> 1.9.0
> 
