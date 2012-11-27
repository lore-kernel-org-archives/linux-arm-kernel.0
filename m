From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Nov 2012 10:37:53 +0530
Subject: [PATCH] ARM: Exynos: Remove unused non-dt support for dwmci
 controller
In-Reply-To: <CAH9JG2X_=Vr=52BY=vjZVtf9fzSox2KMjXGr0U4uAJu6MHjwQw@mail.gmail.com>
References: <1353914155-1716-1-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2X_=Vr=52BY=vjZVtf9fzSox2KMjXGr0U4uAJu6MHjwQw@mail.gmail.com>
Message-ID: <CAJuYYwQqgVbDYEDGwgu0FXe46j4CrxpiDPhWzdjNgfo+3rU1rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr. Park,

On 26 November 2012 16:57, Kyungmin Park <kmpark@infradead.org> wrote:
> On 11/26/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> With device tree support enabled for dwmci controller, the unused non-dt
>> support
>> for dwmci controller can be removed.
>
> Are there no problem to use legacy board? e.g., universal_c210.

The objective of this patch was to reduce the gap that mach-exynos has
to participate in multi-platform kernel builds. It is difficult to
reduce this gap if we continue to add further non-dt support to
existing not-dt (legacy) board files. Exynos5 is fully dt-enabled now
and all further additions to mach-exynos will be/should be dt-only
code.

So what is currently holding us back in letting mach-exynos
participate in multi-platform kernel builds is the mainly the four
legacy board files (origen, smdkv310, nuri and universal) and
hopefully there will be some efforts towards getting them dt-enabled.
I understand that there is lot of work here to do but we have to start
somewhere.

Thanks,
Thomas.

>
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>  arch/arm/mach-exynos/Makefile             |    1 -
>>  arch/arm/mach-exynos/dev-dwmci.c          |   75
>> -----------------------------
>>  arch/arm/mach-exynos/include/mach/dwmci.h |   20 --------
>>  3 files changed, 0 insertions(+), 96 deletions(-)
>>  delete mode 100644 arch/arm/mach-exynos/dev-dwmci.c
>>  delete mode 100644 arch/arm/mach-exynos/include/mach/dwmci.h
>>
>> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
>> index c12ed6a..b189881 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -50,7 +50,6 @@ obj-$(CONFIG_MACH_EXYNOS5_DT)               += mach-exynos5-dt.o
>>  obj-y                                        += dev-uart.o
>>  obj-$(CONFIG_ARCH_EXYNOS4)           += dev-audio.o
>>  obj-$(CONFIG_EXYNOS4_DEV_AHCI)               += dev-ahci.o
>> -obj-$(CONFIG_EXYNOS4_DEV_DWMCI)              += dev-dwmci.o
>>  obj-$(CONFIG_EXYNOS_DEV_DMA)         += dma.o
>>  obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)   += dev-ohci.o
>>  obj-$(CONFIG_EXYNOS_DEV_SYSMMU)              += dev-sysmmu.o
>> diff --git a/arch/arm/mach-exynos/dev-dwmci.c
>> b/arch/arm/mach-exynos/dev-dwmci.c
>> deleted file mode 100644
>> index 7903501..0000000
>> --- a/arch/arm/mach-exynos/dev-dwmci.c
>> +++ /dev/null
>> @@ -1,75 +0,0 @@
>> -/*
>> - * linux/arch/arm/mach-exynos4/dev-dwmci.c
>> - *
>> - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> - *           http://www.samsung.com
>> - *
>> - * Platform device for Synopsys DesignWare Mobile Storage IP
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - */
>> -
>> -#include <linux/kernel.h>
>> -#include <linux/dma-mapping.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/interrupt.h>
>> -#include <linux/ioport.h>
>> -#include <linux/mmc/dw_mmc.h>
>> -
>> -#include <plat/devs.h>
>> -
>> -#include <mach/map.h>
>> -
>> -static int exynos4_dwmci_get_bus_wd(u32 slot_id)
>> -{
>> -     return 4;
>> -}
>> -
>> -static int exynos4_dwmci_init(u32 slot_id, irq_handler_t handler, void
>> *data)
>> -{
>> -     return 0;
>> -}
>> -
>> -static struct resource exynos4_dwmci_resource[] = {
>> -     [0] = DEFINE_RES_MEM(EXYNOS4_PA_DWMCI, SZ_4K),
>> -     [1] = DEFINE_RES_IRQ(EXYNOS4_IRQ_DWMCI),
>> -};
>> -
>> -static struct dw_mci_board exynos4_dwci_pdata = {
>> -     .num_slots                      = 1,
>> -     .quirks                         = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
>> -     .bus_hz                         = 80 * 1000 * 1000,
>> -     .detect_delay_ms        = 200,
>> -     .init                           = exynos4_dwmci_init,
>> -     .get_bus_wd                     = exynos4_dwmci_get_bus_wd,
>> -};
>> -
>> -static u64 exynos4_dwmci_dmamask = DMA_BIT_MASK(32);
>> -
>> -struct platform_device exynos4_device_dwmci = {
>> -     .name           = "dw_mmc",
>> -     .id             = -1,
>> -     .num_resources  = ARRAY_SIZE(exynos4_dwmci_resource),
>> -     .resource       = exynos4_dwmci_resource,
>> -     .dev            = {
>> -             .dma_mask               = &exynos4_dwmci_dmamask,
>> -             .coherent_dma_mask      = DMA_BIT_MASK(32),
>> -             .platform_data  = &exynos4_dwci_pdata,
>> -     },
>> -};
>> -
>> -void __init exynos4_dwmci_set_platdata(struct dw_mci_board *pd)
>> -{
>> -     struct dw_mci_board *npd;
>> -
>> -     npd = s3c_set_platdata(pd, sizeof(struct dw_mci_board),
>> -                     &exynos4_device_dwmci);
>> -
>> -     if (!npd->init)
>> -             npd->init = exynos4_dwmci_init;
>> -     if (!npd->get_bus_wd)
>> -             npd->get_bus_wd = exynos4_dwmci_get_bus_wd;
>> -}
>> diff --git a/arch/arm/mach-exynos/include/mach/dwmci.h
>> b/arch/arm/mach-exynos/include/mach/dwmci.h
>> deleted file mode 100644
>> index 7ce6574..0000000
>> --- a/arch/arm/mach-exynos/include/mach/dwmci.h
>> +++ /dev/null
>> @@ -1,20 +0,0 @@
>> -/* linux/arch/arm/mach-exynos4/include/mach/dwmci.h
>> - *
>> - * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> - *           http://www.samsung.com/
>> - *
>> - * Synopsys DesignWare Mobile Storage for EXYNOS4210
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License version 2 as
>> - * published by the Free Software Foundation.
>> - */
>> -
>> -#ifndef __ASM_ARM_ARCH_DWMCI_H
>> -#define __ASM_ARM_ARCH_DWMCI_H __FILE__
>> -
>> -#include <linux/mmc/dw_mmc.h>
>> -
>> -extern void exynos4_dwmci_set_platdata(struct dw_mci_board *pd);
>> -
>> -#endif /* __ASM_ARM_ARCH_DWMCI_H */
>> --
>> 1.7.5.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
