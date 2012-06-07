From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 7 Jun 2012 18:15:18 +0530
Subject: [CFT 01/11] dmaengine: add OMAP DMA engine driver
In-Reply-To: <CANfBPZ_q97M4k8c8+7rBOpuBv99gfzNA1Q-SLesGP8c0AayBpw@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaXw-0003tR-U8@rmk-PC.arm.linux.org.uk>
 <CANfBPZ_q97M4k8c8+7rBOpuBv99gfzNA1Q-SLesGP8c0AayBpw@mail.gmail.com>
Message-ID: <CANfBPZ-7ideEWFmzSh1HujcLoA+x7GHORx+wBVAMm71Ctt4idg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 6:10 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Thu, Jun 7, 2012 at 4:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> ?drivers/dma/Kconfig ? ? ?| ? ?6 +
>> ?drivers/dma/Makefile ? ? | ? ?1 +
>> ?drivers/dma/omap-dma.c ? | ?522 ++++++++++++++++++++++++++++++++++++++++++++++
>> ?include/linux/omap-dma.h | ? 24 ++
>> ?4 files changed, 553 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/dma/omap-dma.c
>> ?create mode 100644 include/linux/omap-dma.h
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index eb2b60e..8be3bf6 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -261,6 +261,12 @@ config DMA_SA11X0
>> ? ? ? ? ?SA-1110 SoCs. ?This DMA engine can only be used with on-chip
>> ? ? ? ? ?devices.
>>
>> +config DMA_OMAP
>> + ? ? ? tristate "OMAP DMA support"
>> + ? ? ? depends on ARCH_OMAP
>> + ? ? ? select DMA_ENGINE
>> + ? ? ? select DMA_VIRTUAL_CHANNELS
>> +
>> ?config DMA_ENGINE
>> ? ? ? ?bool
>>
>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index fc05f7d..ddc291a 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCH_DMA) += pch_dma.o
>> ?obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
>> ?obj-$(CONFIG_EP93XX_DMA) += ep93xx_dma.o
>> ?obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
>> +obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
>> new file mode 100644
>> index 0000000..500bc71
>> --- /dev/null
>> +++ b/drivers/dma/omap-dma.c
>> @@ -0,0 +1,522 @@
>> +/*
>> + * OMAP DMAengine support
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/omap-dma.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include "virt-dma.h"
> Russell,
> ?I applied your entire series on 3.5-rc1 and build fails as it can't
> find virt-dma.h
> Perhaps a missed "git add" ?
>
Ok I reread your messages again and these 11 are based on the generic
dma-engine series.

>> +#include <plat/dma.h>
>> +
