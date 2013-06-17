From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 17 Jun 2013 09:06:41 +0800
Subject: [PATCH v4 6/7] ARM: hi3xxx: add board support with device tree
In-Reply-To: <20130612195455.GB5162@quad.lixom.net>
References: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
 <1370702843-27172-7-git-send-email-haojian.zhuang@linaro.org>
 <20130612195455.GB5162@quad.lixom.net>
Message-ID: <CAD6h2NRLr9OXT_j=bjxXCqs2xV+iCvy4nKVOY04+_qjgJX4eOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 June 2013 03:54, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Jun 08, 2013 at 10:47:22PM +0800, Haojian Zhuang wrote:
>> Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.
>>
>> Changelog:
>> v3:
>> 1. Remove .map_io() in DT machine descriptor. Since debug_ll_io_init()
>> is called by default.
>> 2. Remove .init_machine() in DT machine descriptor. Since
>> of_platform_populate() is called by default in DT mode.
>>
>> v2:
>> 1. Remove .init_irq() in DT machine descriptor. Since irqchip_init()
>> is called by default in DT mode.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  .../bindings/arm/hisilicon/hisilicon.txt           | 10 ++++++
>>  arch/arm/Kconfig                                   |  2 ++
>>  arch/arm/Makefile                                  |  1 +
>>  arch/arm/mach-hi3xxx/Kconfig                       | 13 ++++++++
>>  arch/arm/mach-hi3xxx/Makefile                      |  5 +++
>>  arch/arm/mach-hi3xxx/hi3xxx.c                      | 37 ++++++++++++++++++++++
>>  6 files changed, 68 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>  create mode 100644 arch/arm/mach-hi3xxx/Kconfig
>>  create mode 100644 arch/arm/mach-hi3xxx/Makefile
>>  create mode 100644 arch/arm/mach-hi3xxx/hi3xxx.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> new file mode 100644
>> index 0000000..3be60c8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -0,0 +1,10 @@
>> +Hisilicon Platforms Device Tree Bindings
>> +----------------------------------------------------
>> +
>> +Hi3716 Development Board
>> +Required root node properties:
>> +     - compatible = "hisilicon,hi3716-dkb";
>> +
>> +Hi4511 Board
>> +Required root node properties:
>> +     - compatible = "hisilicon,hi3620-hi4511";
>
> Having the same namespace for boards and for SoCs is _extremely_ confusing.
> I know it's not something you made up, but if you have a chance to influence
> future naming, please do so. Or maybe consider using a different naming
> scheme than just "hixxxx" for boards in the sources.

Maybe. But it's still their choice.

>
>> diff --git a/arch/arm/mach-hi3xxx/hi3xxx.c b/arch/arm/mach-hi3xxx/hi3xxx.c
>> new file mode 100644
>> index 0000000..064b303
>> --- /dev/null
>> +++ b/arch/arm/mach-hi3xxx/hi3xxx.c
>> @@ -0,0 +1,37 @@
>> +/*
>> + * (Hisilicon's Hi36xx/Hi37xx SoC based) flattened device tree enabled machine
>> + *
>> + * Copyright (c) 2012-2013 Hisilicon Ltd.
>> + * Copyright (c) 2012-2013 Linaro Ltd.
>> + *
>> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/of_platform.h>
>> +
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/map.h>
>> +
>> +static void __init hi3xxx_timer_init(void)
>> +{
>> +     of_clk_init(NULL);
>> +     clocksource_of_init();
>> +}
>> +
>> +static const char *hs_compat[] __initdata = {
>> +     "hisilicon,hi3620-hi4511",
>> +     NULL,
>
> Should you list the hisilicon,hi3716-dkb board here too, since you add the
> bindings doc for it?
>
>
> -Olof

If all of these patches are merged, I can submit hi3716-dkb continuously.

The more things what I add only cause me pending more time.

Regards
Haojian
