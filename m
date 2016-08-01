From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 01 Aug 2016 19:31:20 +0900
Subject: [PATCH v4 5/7] PM / devfreq: event: support rockchip dfi
 controller
In-Reply-To: <579F07D9.1050106@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
 <CGME20160729075807epcas1p23ff4e931fe4f4cef2bcf59540394bf28@epcas1p2.samsung.com>
 <1469779021-10426-6-git-send-email-hl@rock-chips.com>
 <579EFD28.5070404@samsung.com> <579F0387.5070303@samsung.com>
 <579F07D9.1050106@rock-chips.com>
Message-ID: <579F24F8.8060002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

On 2016? 08? 01? 17:27, hl wrote:
> Hi Chanwoo Choi,
> 
> On 2016?08?01? 16:08, Chanwoo Choi wrote:
>> Hi Lin,
>>
>> I add the one minor comment for full name of 'DRI'.
>>
>> On 2016? 08? 01? 16:41, Chanwoo Choi wrote:
>>> Hi Lin,
>>>
>>> Because you remove the 'RFC' prefix on patch title,
>>> I think that you better to make the documentation as following:
>>> - Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
>>>
>>> Regards,
>>> Chanwoo Choi
>>>
>>> On 2016? 07? 29? 16:56, Lin Huang wrote:
>>>> on rk3399 platform, there is dfi conroller can monitor
>>>> ddr load, base on this result, we can do ddr freqency
>>>> scaling.
>>>>
>>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>> Changes in v4:
>>>> - None
>>>>
>>>> Changes in v3:
>>>> - None
>>>>
>>>> Changes in v2:
>>>> - use clk_disable_unprepare and clk_enable_prepare
>>>> - remove clk_enable_prepare in probe
>>>> - remove rockchip_dfi_remove function
>>>>
>>>> Changes in v1:
>>>> - None
>>>>
>>>>   drivers/devfreq/event/Kconfig        |   7 +
>>>>   drivers/devfreq/event/Makefile       |   1 +
>>>>   drivers/devfreq/event/rockchip-dfi.c | 253 +++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 261 insertions(+)
>>>>   create mode 100644 drivers/devfreq/event/rockchip-dfi.c
>>>>
>>>> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconfig
>>>> index a11720a..ff9279f 100644
>>>> --- a/drivers/devfreq/event/Kconfig
>>>> +++ b/drivers/devfreq/event/Kconfig
>>>> @@ -22,4 +22,11 @@ config DEVFREQ_EVENT_EXYNOS_PPMU
>>>>         (Platform Performance Monitoring Unit) counters to estimate the
>>>>         utilization of each module.
>>>>   +config DEVFREQ_EVENT_ROCKCHIP_DFI
>>>> +    tristate "ROCKCHIP DFI DEVFREQ event Driver"
>>>> +    depends on ARCH_ROCKCHIP
>>>> +    help
>>>> +      This add the devfreq-event driver for Rockchip SoC. It provides DFI
>>>> +      (DDR Monitor Module) driver to count ddr load.
>> The DFI is "DDR Monitor Module" full name? I need the correct abbreviation
>> and full name.
> We just call this module DFI in datasheet, and this module function is ddr monitor module,
> yes, it is do not fit the full name, but i think it is better follow the datasheet name.

Are there any full name of DFI? If the people who don't know the detailed history about
this workd (DFI), it causes the confusion and they don't understand it.

I think that if you want to use the DFI work, you need to add the more detailed description
why DFI word is used.

>>
>>>> +
>>>>   endif # PM_DEVFREQ_EVENT
>>>> diff --git a/drivers/devfreq/event/Makefile b/drivers/devfreq/event/Makefile
>>>> index be146ea..e3f88fc 100644
>>>> --- a/drivers/devfreq/event/Makefile
>>>> +++ b/drivers/devfreq/event/Makefile
>>>> @@ -1,2 +1,3 @@
>>>>   # Exynos DEVFREQ Event Drivers
>>>>   obj-$(CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU) += exynos-ppmu.o
>>>> +obj-$(CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI) += rockchip-dfi.o
>>>> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
>>>> new file mode 100644
>>>> index 0000000..96a0307
>>>> --- /dev/null
>>>> +++ b/drivers/devfreq/event/rockchip-dfi.c
>>>> @@ -0,0 +1,253 @@
>>>> +/*
>>>> + * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>>> + * Author: Lin Huang <hl@rock-chips.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify it
>>>> + * under the terms and conditions of the GNU General Public License,
>>>> + * version 2, as published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>>> + * more details.
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/devfreq-event.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/of.h>
>>>> +
>>>> +#define RK3399_DMC_NUM_CH    2
>>>> +
>>>> +/* DDRMON_CTRL */
>>>> +#define DDRMON_CTRL    0x04
>>>> +#define CLR_DDRMON_CTRL    (0x1f0000 << 0)
>>>> +#define LPDDR4_EN    (0x10001 << 4)
>>>> +#define HARDWARE_EN    (0x10001 << 3)
>>>> +#define LPDDR3_EN    (0x10001 << 2)
>>>> +#define SOFTWARE_EN    (0x10001 << 1)
>>>> +#define TIME_CNT_EN    (0x10001 << 0)

[snip]

>>>> +};
>>>> +module_platform_driver(rockchip_dfi_driver);
>>>> +
>>>> +MODULE_LICENSE("GPL v2");
>>>> +MODULE_AUTHOR("Lin Huang <hl@rock-chips.com>");
>>>> +MODULE_DESCRIPTION("Rockchip dfi driver");
>> s/dfi -> DFI

You should use the capital letter.

Regards,
Chanwoo Choi
