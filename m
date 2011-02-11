From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 11 Feb 2011 12:42:14 -0800
Subject: [PATCH 2/3] msm: iommu: Generalize platform data for multiple
	targets
In-Reply-To: <1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
Message-ID: <1297456934.4852.11.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-11 at 12:28 -0800, Stepan Moskovchenko wrote:
> Make the IOMMU platform data target-independent in
> preparation for adding MSM8960 IOMMU support. The IOMMU
> configuration on MSM8x60 and MSM8960 is identical and the
> same platform data can be used for both.
> 
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> ---
>  arch/arm/mach-msm/Makefile                         |    4 +-
>  .../{devices-msm8x60-iommu.c => devices-iommu.c}   |   54 +++++++++----------
>  arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |   36 -------------
>  3 files changed, 28 insertions(+), 66 deletions(-)
>  rename arch/arm/mach-msm/{devices-msm8x60-iommu.c => devices-iommu.c} (93%)
> 
> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
> index 81f4811..2099c97 100644
> --- a/arch/arm/mach-msm/Makefile
> +++ b/arch/arm/mach-msm/Makefile
> @@ -4,12 +4,12 @@ obj-$(CONFIG_DEBUG_FS) += clock-debug.o
>  endif
> 
>  obj-$(CONFIG_MSM_VIC) += irq-vic.o
> -obj-$(CONFIG_MSM_IOMMU) += iommu.o iommu_dev.o
> +obj-$(CONFIG_MSM_IOMMU) += iommu.o iommu_dev.o devices-iommu.o
> 
>  obj-$(CONFIG_ARCH_MSM7X00A) += dma.o irq.o acpuclock-arm11.o
>  obj-$(CONFIG_ARCH_MSM7X30) += dma.o
>  obj-$(CONFIG_ARCH_QSD8X50) += dma.o sirc.o
> -obj-$(CONFIG_ARCH_MSM8X60) += clock-dummy.o devices-msm8x60-iommu.o
> +obj-$(CONFIG_ARCH_MSM8X60) += clock-dummy.o
>  obj-$(CONFIG_ARCH_MSM8960) += clock-dummy.o
> 
>  obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
> diff --git a/arch/arm/mach-msm/devices-msm8x60-iommu.c b/arch/arm/mach-msm/devices-iommu.c
> similarity index 93%
> rename from arch/arm/mach-msm/devices-msm8x60-iommu.c
> rename to arch/arm/mach-msm/devices-iommu.c
> index f9e7bd3..c0206b7 100644
> --- a/arch/arm/mach-msm/devices-msm8x60-iommu.c
> +++ b/arch/arm/mach-msm/devices-iommu.c
> @@ -1,4 +1,4 @@
> -/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> +/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 and
> @@ -18,15 +18,13 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/bootmem.h>
> -
> -#include <mach/msm_iomap-8x60.h>
> -#include <mach/irqs-8x60.h>
> +#include <mach/irqs.h>
>  #include <mach/iommu.h>
> 
>  static struct resource msm_iommu_jpegd_resources[] = {
>  	{
> -		.start = MSM_IOMMU_JPEGD_PHYS,
> -		.end   = MSM_IOMMU_JPEGD_PHYS + MSM_IOMMU_JPEGD_SIZE - 1,
> +		.start = 0x07300000,
> +		.end   = 0x07300000 + SZ_1M - 1,

Looks worse .. Just put the macros into a static header file for both.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
