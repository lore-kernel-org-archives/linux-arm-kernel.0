From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 7 Aug 2018 14:14:28 +0200
Subject: [PATCH v8 1/3] dmaengine: fsl-edma: extract common fsl-edma code
 (no changes in behavior intended)
In-Reply-To: <326d1fd7010c34488af6a874011d5280@agner.ch>
References: <20180803193244.12084-1-angelo@sysam.it>
 <326d1fd7010c34488af6a874011d5280@agner.ch>
Message-ID: <CAJKOXPchX3H9JVf1VyA+m9waLz74DnWRb2xLBg4yp=YbrEGu0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2018 at 10:08, Stefan Agner <stefan@agner.ch> wrote:
> On 03.08.2018 21:32, Angelo Dureghello wrote:
>> This patch adds a new fsl-edma-common module to allow new
>> mcf-edma module code to use most of the fsl-edma code.
>>
>> Signed-off-by: Angelo Dureghello <angelo@sysam.it>
>> ---
>> Changes for v2:
>> - patch splitted into 4
>> - add mcf-edma as minimal different parts from fsl-edma
>>
>> Changes for v3:
>> none
>>
>> Changes for v4:
>> - patch simplified from 4/4 into 2/2
>> - collecting all the mcf-edma-related changes
>>
>> Changes for v5:
>> none
>>
>> Changes for v6:
>> - adjusted comment header
>> - fixed bit shift with BIT()
>> - we need to free the interrupts at remove(), so removed all devm_
>>   interrupt related calls
>>
>> Changes for v7:
>> none
>>
>> Changes for v8:
>> - patch rewritten from scratch, splitted into 3, common code isolated,
>>   minimal changes from the original Freescale code have been done.
>>   The patch has been tested with both Iris + Colibri Vybrid VF50 and
>>   stmark2/mcf54415 Coldfire boards.
>> ---
>>  drivers/dma/Makefile          |   2 +-
>>  drivers/dma/fsl-edma-common.c | 576 ++++++++++++++++++++++++++++
>>  drivers/dma/fsl-edma-common.h | 196 ++++++++++
>>  drivers/dma/fsl-edma.c        | 697 +---------------------------------
>>  4 files changed, 774 insertions(+), 697 deletions(-)
>>  create mode 100644 drivers/dma/fsl-edma-common.c
>>  create mode 100644 drivers/dma/fsl-edma-common.h
>>
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 203a99d68315..66022f59fca4 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -31,7 +31,7 @@ obj-$(CONFIG_DW_AXI_DMAC) += dw-axi-dmac/
>>  obj-$(CONFIG_DW_DMAC_CORE) += dw/
>>  obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>>  obj-$(CONFIG_FSL_DMA) += fsldma.o
>> -obj-$(CONFIG_FSL_EDMA) += fsl-edma.o
>> +obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
>>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
>>  obj-$(CONFIG_HSU_DMA) += hsu/
>>  obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> new file mode 100644
>> index 000000000000..0ae7094f477a
>> --- /dev/null
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -0,0 +1,576 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (c) 2013-2014 Freescale Semiconductor, Inc
>> +// Copyright (c) 2017 Sysam, Angelo Dureghello  <angelo@sysam.it>
>> +
>> +#include <linux/dmapool.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +
>> +#include "fsl-edma-common.h"
>> +
>> +/*
>> + * R/W functions for big- or little-endian registers:
>> + * The eDMA controller's endian is independent of the CPU core's endian.
>> + * For the big-endian IP module, the offset for 8-bit or 16-bit registers
>> + * should also be swapped opposite to that in little-endian IP.
>> + */
>> +u32 edma_readl(struct fsl_edma_engine *edma, void __iomem *addr)
>> +{
>> +     if (edma->big_endian)
>> +             return ioread32be(addr);
>> +     else
>> +             return ioread32(addr);
>> +}
>> +EXPORT_SYMBOL_GPL(edma_readl);
>
> In 3/3 you link the common object into the two modules individually:
>
> obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
> obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
>
> Therefor you do not access those functions from another module (they are
> within the module). No exporting should be necessary. Drop all those
> exports.

The fsl-edma-common will be its own module so the exports are
necessary for proper linking/modpost.

Best regards,
Krzysztof

> If possible I would prefer if you start with cleanup/conversions, then
> split-up and finally add functionality.
>
> So ideally:
> 1. Use macros for preprocessor defines (where you move to BIT/GENMASK)
> 2. Split
> 3. Add EDMA macros etc.
> 4. Add ColdFire mcf5441x edma support
>
