From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 22 Jul 2016 10:38:56 +0100
Subject: [RFC 6/6] bus: Add support for Tegra NOR controller
In-Reply-To: <CALw8SCVy4ud5_+gS3C8WeyTCV0m_4R2xjdEY4vCKEq_3-aFanw@mail.gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-7-git-send-email-mirza.krak@gmail.com>
 <f6df33eb-53ae-699b-9e1f-69eb7fed7da0@nvidia.com>
 <CALw8SCVy4ud5_+gS3C8WeyTCV0m_4R2xjdEY4vCKEq_3-aFanw@mail.gmail.com>
Message-ID: <dbbb5c9f-8c67-9d9f-171b-64cd18353411@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/07/16 21:42, Mirza Krak wrote:
> 2016-07-21 12:15 GMT+02:00 Jon Hunter <jonathanh@nvidia.com>:
>>
>> On 19/07/16 14:36, Mirza Krak wrote:
>>> From: Mirza Krak <mirza.krak@gmail.com>
>>> +config TEGRA_NOR
>>> +     tristate "Nvidia Tegra NOR flash bus driver a.k.a GMI/SNOR"
>>> +             depends on ARCH_TEGRA_2x_SOC || ARCH_TEGRA_3x_SOC
>>> +             depends on OF
>>> +             help
>>> +                     Driver for NOR flash bus found on Tegra30/20 SOC`s.
>>
>> It is actually present on all Tegra's and so I would drop the 30/20.
> 
> ACK.
> 
>>> +++ b/drivers/bus/tegra-nor.c
>>> @@ -0,0 +1,118 @@
>>> +/*
>>> + * Driver for Nvidia NOR Flash bus a.k.a SNOR/GMI.
>>> + *
>>> + * Copyright (C) 2016 Host Mobility AB. All rights reserved.
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public
>>> + * License version 2. This program is licensed "as is" without any
>>> + * warranty of any kind, whether express or implied.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/mfd/syscon.h>
>>
>> Is this needed?
> 
> It is not. ACK.
> 
>>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/regmap.h>
>>
>> Or this?
> 
> It is not. ACK.
> 
>>
>>> +
>>> +#define TEGRA_NOR_TIMING_REG_COUNT   2
>>> +
>>> +#define TEGRA_NOR_CONFIG                     0x00
>>> +#define TEGRA_NOR_STATUS                     0x04
>>> +#define TEGRA_NOR_ADDR_PTR                   0x08
>>> +#define TEGRA_NOR_AHB_ADDR_PTR               0x0c
>>> +#define TEGRA_NOR_TIMING0                    0x10
>>> +#define TEGRA_NOR_TIMING1                    0x14
>>> +#define TEGRA_NOR_MIO_CONFIG         0x18
>>> +#define TEGRA_NOR_MIO_TIMING         0x1c
>>> +#define TEGRA_NOR_DMA_CONFIG         0x20
>>> +#define TEGRA_NOR_CS_MUX_CONFIG              0x24
>>
>> Not all of these are used. It is good to define them and I wonder if we
>> should add support for MIO while are at it :-)
> 
> We can come back to this once I have all SNOR stuff in order.
> 
>>
>>> +
>>> +#define TEGRA_NOR_CONFIG_GO                          BIT(31)
>>> +
>>> +static const struct of_device_id nor_id_table[] = {
>>> +     /* Tegra30 */
>>
>> I don't think this comment is needed.
> 
> ACK.
> 
>>
>>> +     { .compatible = "nvidia,tegra30-nor", .data = NULL, },
>>
>> You don't need to set data to NULL.
> 
> ACK.
> 
>>
>>> +     /* Tegra20 */
>>> +     { .compatible = "nvidia,tegra20-nor", .data = NULL, },
>>
>> Same here.
> 
> ACK
> 
>>> +static int __init nor_probe(struct platform_device *pdev)
>>> +{
>>
>> I would drop the __init.
> 
> ACK.
> 
>>> +static struct platform_driver nor_driver = {
>>> +     .driver = {
>>> +             .name           = "tegra-nor",
>>> +             .of_match_table = nor_id_table,
>>> +     },
>>> +};
>>
>> The driver should have a remove function given that we can build as a
>> module.
> 
> At the moment I do not know what we would do in a remove function and
> hence me not adding one.

Should just be the inverse of the probe (although there is no inverse
for the parsing DT bit). If you don't wish to add a remove, that is
fine, but make the driver a 'bool' and not 'tristate' in the Kconfig so
it cannot be configured as a module.

>>
>>> +module_platform_driver_probe(nor_driver, nor_probe);
>>
>> I would use "tegra_nor" namespace for all the structs, functions, etc.
>> However, we may prefer to go with GMI and in which case tegra_gmi_probe,
>> etc.
> 
> ACK. Who gets the last call on what we should call the driver? It
> seems that we both think GMI is a better name, do we need a third? :).

The patches would have to go via Thierry and so ultimately, Thierry.
However, I can't imagine he would object to GMI ;-)

Jon

-- 
nvpublic
