From: sza@esh.hu (=?utf-8?B?U3plbXrFkSBBbmRyw6Fz?=)
Date: Thu, 19 Jan 2017 16:23:03 +0100
Subject: [RFC PATCH v5 0/7] ARM: Fix dma_alloc_coherent() and friends for
 NOMMU
In-Reply-To: <1484738003-29892-1-git-send-email-vladimir.murzin@arm.com>
References: <1484738003-29892-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <8BBDE689-7AA0-4074-A322-66C3DBBEA351@esh.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 
> On 2017. Jan 18., at 12:13, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
> 
> Hi,
> 
> It seem that addition of cache support for M-class CPUs uncovered
> latent bug in DMA usage. NOMMU memory model has been treated as being
> always consistent; however, for R/M CPU classes memory can be covered
> by MPU which in turn might configure RAM as Normal i.e. bufferable and
> cacheable. It breaks dma_alloc_coherent() and friends, since data can
> stuck in caches now or be buffered.
> 
> This patch set is trying to address the issue by providing region of
> memory suitable for consistent DMA operations. It is supposed that
> such region is marked by MPU as non-cacheable. Robin suggested to
> advertise such memory as reserved shared-dma-pool, rather then using
> homebrew command line option, and extend dma-coherent to provide
> default DMA area in the similar way as it is done for CMA (PATCH
> 4/7). It allows us to offload all bookkeeping on generic coherent DMA
> framework, and it seems that it might be reused by other architectures
> like c6x and blackfin.
> 

I have tested the v5 on my ATMEL armv7m board. Caches enabled,
DMA on MMC, USART and Ethernet. 
Everything works as expected, so you can add my tested-by.

Booting Linux on physical CPU 0x0
Linux version 4.9.0 (root at debian) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29) ) #1 Wed Jan 18 22:10:39 CET 2017
CPU: ARMv7-M [410fc271] revision 1 (ARMv7M), cr=00000000
CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
OF: fdt:Machine model: SAME70-sampione board
Reserved memory: created DMA memory pool at 0x73e00000, size 2 MiB
OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
...
DMA: default coherent area is set
?

Thanks for the patches!

Regards,
Andras
