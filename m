From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Wed, 6 Jul 2016 09:44:29 +0200
Subject: [PATCH 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <1467725309.2978.63.camel@pengutronix.de>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-3-git-send-email-gabriel.fernandez@st.com>
 <1467725309.2978.63.camel@pengutronix.de>
Message-ID: <577CB6DD.5040502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 07/05/2016 03:28 PM, Philipp Zabel wrote:
> Am Montag, den 04.07.2016, 15:47 +0200 schrieb gabriel.fernandez at st.com:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> The STM32 MCUs family IPs can be reset by accessing some registers
>> from the RCC block.
>>
>> The list of available reset lines is documented in the DT bindings.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   drivers/reset/Makefile      |   1 +
>>   drivers/reset/reset-stm32.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>   create mode 100644 drivers/reset/reset-stm32.c
>>
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 03dc1bb..3776b7b 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>>   obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>>   obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
>>   obj-$(CONFIG_ARCH_MESON) += reset-meson.o
>> +obj-$(CONFIG_ARCH_STM32) += reset-stm32.o
>>   obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>>   obj-$(CONFIG_ARCH_STI) += sti/
>>   obj-$(CONFIG_ARCH_HISI) += hisilicon/
>> diff --git a/drivers/reset/reset-stm32.c b/drivers/reset/reset-stm32.c
>> new file mode 100644
>> index 0000000..be42bff
>> --- /dev/null
>> +++ b/drivers/reset/reset-stm32.c
>> @@ -0,0 +1,113 @@
>> +/*
>> + * Copyright (C) Maxime Coquelin 2015
>> + * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> + * License terms:  GNU General Public License (GPL), version 2
>> + *
>> + * Heavily based on sunxi driver from Maxime Ripard.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +struct stm32_reset_data {
>> +	spinlock_t			lock;
>> +	void __iomem			*membase;
>> +	struct reset_controller_dev	rcdev;
>> +};
>> +
>> +static int stm32_reset_assert(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	struct stm32_reset_data *data = container_of(rcdev,
>> +						     struct stm32_reset_data,
>> +						     rcdev);
>> +	int bank = id / BITS_PER_LONG;
>> +	int offset = id % BITS_PER_LONG;
>> +	unsigned long flags;
>> +	u32 reg;
>> +
>> +	spin_lock_irqsave(&data->lock, flags);
>> +
>> +	reg = readl_relaxed(data->membase + (bank * 4));
>> +	writel_relaxed(reg | BIT(offset), data->membase + (bank * 4));
> Please also switch to the non-relaxed variants. It shouldn't make a
> difference here, and as Arnd points out, reduces the risk of new
> developers using readl/writel_relaxed without thinking about the
> consequences.
> Further, this will make the stm32, sunxi, and socfpga accessors look the
> same. I'd like to try and combine them after this is merged.
>
> regards
> Philipp
>
ok no problem, i will fix it.

Thanks

Gabriel
