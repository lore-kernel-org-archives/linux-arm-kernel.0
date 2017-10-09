From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 9 Oct 2017 10:20:19 +0100
Subject: [PATCH v3 0/8] ARM: NOMMU: MPU updates
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <68a6eb4d-4d8e-7c6a-0875-3165bde8de89@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, do you have concerns on this series?

Thanks
Vladimir

On 25/09/17 10:05, Vladimir Murzin wrote:
> Hi,
> 
> This is an update of the existent MPU code which consist set of
> clean-ups and enhancements. The most significant changes are in the
> way how MPU settings sync-up for secondaries (PATCH 3/8), more
> flexible layout for memory (PATCH 7/8) and support for XIP (PATCH
> 8/8). Since there is no in-tree user of MPU, support for M-class has
> been added (PATCH 6/8).
> 
> There is also practical benefit of patch set:
> 
> "These MPU patches introduce a nice feature that it simplifies the
> bootloader: do not need to setup the MPU, for example for coherent DMA
> region, which is described in device-tree too." Andr?s Szemz?
> 
> Changelog:
>            v2 -> v3
>               - fixed support for XIP (PATCH 8/8)
> 	      - rebased on 4.14-rc2
> 
>            v1 -> v2
>               - support for XIP (PATCH 8/8)
> 	      - rebased on 4.13-rc1
> 
>         RFC v2 -> v1
>                - dropped RFC tag
> 	       - Tested-by from Andr?s
> 	       - rebased on 4.12-rc5
> 
>            RFC -> RFC v2
> 	       - fixed MPU enable for v7m (PATCH 6/7)
> 
> Thanks!
> 
> Vladimir Murzin (8):
>   ARM: NOMMU: Move out MPU setup in separate module
>   ARM: NOMMU: Update MPU accessors to use cp15 helpers
>   ARM: NOMMU: Rework MPU to be mostly done in C
>   ARM: NOMMU: Disallow MPU for XIP
>   ARM: Kconfig: Kill CONFIG_VECTORS_BASE
>   ARM: V7M: Add support for MPU to M-class
>   ARM: NOMMU: Use more MPU regions to cover memory
>   ARM: NOMMU: Support MPU in XIP configuration
> 
>  arch/arm/Kconfig                  |   9 -
>  arch/arm/Kconfig-nommu            |   4 +-
>  arch/arm/include/asm/cputype.h    |  10 +
>  arch/arm/include/asm/mpu.h        |  26 +-
>  arch/arm/include/asm/smp.h        |   2 +-
>  arch/arm/include/asm/v7m.h        |  10 +
>  arch/arm/kernel/asm-offsets.c     |  11 +
>  arch/arm/kernel/head-nommu.S      | 148 +++++++++---
>  arch/arm/kernel/smp.c             |   2 +-
>  arch/arm/kernel/vmlinux-xip.lds.S |  23 ++
>  arch/arm/mm/Makefile              |   1 +
>  arch/arm/mm/nommu.c               | 254 +-------------------
>  arch/arm/mm/pmsa-v7.c             | 484 ++++++++++++++++++++++++++++++++++++++
>  13 files changed, 682 insertions(+), 302 deletions(-)
>  create mode 100644 arch/arm/mm/pmsa-v7.c
> 
