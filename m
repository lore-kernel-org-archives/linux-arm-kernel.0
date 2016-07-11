From: vw@iommu.org (Wan Zongshun)
Date: Mon, 11 Jul 2016 10:19:03 +0800
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <CAP=VYLoAQ-0bNAHZFU0Bu9+1to6QFojyEY8YFoHxyP9QZgE5LQ@mail.gmail.com>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-3-git-send-email-vw@iommu.org>
 <CAP=VYLoAQ-0bNAHZFU0Bu9+1to6QFojyEY8YFoHxyP9QZgE5LQ@mail.gmail.com>
Message-ID: <57830217.3030800@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?07?11? 05:51, Paul Gortmaker wrote:
> On Sun, Jul 10, 2016 at 3:27 AM, Wan Zongshun <vw@iommu.org> wrote:
>> This patch is to add irqchip driver support for nuc900 plat,
>> current this driver only supports nuc970 SoC.
>>
>> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>   arch/arm/mach-w90x900/include/mach/irqs.h |   5 +
>>   drivers/irqchip/Makefile                  |   1 +
>>   drivers/irqchip/irq-nuc900.c              | 150 ++++++++++++++++++++++++++++++
>>   3 files changed, 156 insertions(+)
>>   create mode 100644 drivers/irqchip/irq-nuc900.c
>>
>> diff --git a/arch/arm/mach-w90x900/include/mach/irqs.h b/arch/arm/mach-w90x900/include/mach/irqs.h
>> index 9d5cba3..3b035c6 100644
>> --- a/arch/arm/mach-w90x900/include/mach/irqs.h
>> +++ b/arch/arm/mach-w90x900/include/mach/irqs.h
>> @@ -59,7 +59,12 @@
>>   #define IRQ_KPI                W90X900_IRQ(29)
>>   #define IRQ_P2SGROUP   W90X900_IRQ(30)
>>   #define IRQ_ADC                W90X900_IRQ(31)
>> +
>> +#if !defined(CONFIG_SOC_NUC900)
>>   #define NR_IRQS                (IRQ_ADC+1)
>> +#else
>> +#define NR_IRQS                62
>> +#endif
>>
>>   /*for irq group*/
>>
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 38853a1..9ccd5af8a 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)              += irq-pic32-evic.o
>>   obj-$(CONFIG_MVEBU_ODMI)               += irq-mvebu-odmi.o
>>   obj-$(CONFIG_LS_SCFG_MSI)              += irq-ls-scfg-msi.o
>>   obj-$(CONFIG_EZNPS_GIC)                        += irq-eznps.o
>> +obj-$(CONFIG_SOC_NUC970)               += irq-nuc900.o
>> diff --git a/drivers/irqchip/irq-nuc900.c b/drivers/irqchip/irq-nuc900.c
>> new file mode 100644
>> index 0000000..c4b2e39
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-nuc900.c
>> @@ -0,0 +1,150 @@
>> +/*
>> + * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/module.h>
>
> Why do you include module.h when I don't see anything modular in
> this driver?

Okay, I can delete it.

>
> Paul.
> --
>
>> +#include <linux/init.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +
>> +#include <asm/exception.h>
>> +#include <asm/hardirq.h>
>> +
>
> [...]
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
