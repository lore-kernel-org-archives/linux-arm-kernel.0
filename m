From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 3 Nov 2016 13:50:56 +0000
Subject: [PATCH V3 6/6] bus: Add support for Tegra Generic Memory Interface
In-Reply-To: <CALw8SCVu+-h_yhOa7uDuyFBPVvhwjD64S+-MDeYN8EZsGHpXyw@mail.gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
 <1477576872-2665-7-git-send-email-mirza.krak@gmail.com>
 <3cdf7281-840f-1aa0-5a57-fe58501165f4@nvidia.com>
 <CALw8SCVu+-h_yhOa7uDuyFBPVvhwjD64S+-MDeYN8EZsGHpXyw@mail.gmail.com>
Message-ID: <1a68a2fa-d4b7-7c94-6777-4fb58bed747f@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/11/16 13:08, Mirza Krak wrote:
> 2016-11-03 11:51 GMT+01:00 Jon Hunter <jonathanh@nvidia.com>:
>>
>> On 27/10/16 15:01, Mirza Krak wrote:
>>>
>>> From: Mirza Krak <mirza.krak@gmail.com>
>>>
>>> The Generic Memory Interface bus can be used to connect high-speed
>>> devices such as NOR flash, FPGAs, DSPs...
>>>
>>> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
>>> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board
>>> ---
>>>
>>> Changes in v2:
>>>  - Fixed some checkpatch errors
>>>  - Re-ordered probe to get rid of local variables
>>>  - Moved of_platform_default_populate call to the end of probe
>>>  - Use the timing and configuration properties from the child device
>>>  - Added warning if more then 1 child device exist
>>>
>>> Changes in v3:
>>>  - added helper function to disable the controller which is used in remove
>>> and
>>>  on error.
>>>  - Added logic to parse CS# from "ranges" property with fallback to "reg"
>>>  property
>>>
>>>  drivers/bus/Kconfig     |   8 ++
>>>  drivers/bus/Makefile    |   1 +
>>>  drivers/bus/tegra-gmi.c | 267
>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 276 insertions(+)
>>>  create mode 100644 drivers/bus/tegra-gmi.c
>>>
>>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>>> index 4ed7d26..2e75a7f 100644
>>> --- a/drivers/bus/Kconfig
>>> +++ b/drivers/bus/Kconfig
>>> @@ -141,6 +141,14 @@ config TEGRA_ACONNECT
>>>           Driver for the Tegra ACONNECT bus which is used to interface
>>> with
>>>           the devices inside the Audio Processing Engine (APE) for
>>> Tegra210.
>>>
>>> +config TEGRA_GMI
>>> +       tristate "Tegra Generic Memory Interface bus driver"
>>> +       depends on ARCH_TEGRA
>>> +       help
>>> +         Driver for the Tegra Generic Memory Interface bus which can be
>>> used
>>> +         to attach devices such as NOR, UART, FPGA and more.
>>> +
>>> +
>>
>>
>> Nit-pick ... only one additional line above is needed to be consistent with
>> the rest of the file.
>
> Will fix that.
>
>>
>>
>>>  config UNIPHIER_SYSTEM_BUS
>>>         tristate "UniPhier System Bus driver"
>>>         depends on ARCH_UNIPHIER && OF
>>> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
>>> index ac84cc4..34e2bab 100644
>>> --- a/drivers/bus/Makefile
>>> +++ b/drivers/bus/Makefile
>>> @@ -18,5 +18,6 @@ obj-$(CONFIG_OMAP_OCP2SCP)    += omap-ocp2scp.o
>>>  obj-$(CONFIG_SUNXI_RSB)                += sunxi-rsb.o
>>>  obj-$(CONFIG_SIMPLE_PM_BUS)    += simple-pm-bus.o
>>>  obj-$(CONFIG_TEGRA_ACONNECT)   += tegra-aconnect.o
>>> +obj-$(CONFIG_TEGRA_GMI)                += tegra-gmi.o
>>>  obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)      += uniphier-system-bus.o
>>>  obj-$(CONFIG_VEXPRESS_CONFIG)  += vexpress-config.o
>>> diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
>>> new file mode 100644
>>> index 0000000..dd9623e
>>> --- /dev/null
>>> +++ b/drivers/bus/tegra-gmi.c
>>> @@ -0,0 +1,267 @@
>>> +/*
>>> + * Driver for NVIDIA Generic Memory Interface
>>> + *
>>> + * Copyright (C) 2016 Host Mobility AB. All rights reserved.
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public
>>> + * License version 2. This program is licensed "as is" without any
>>> + * warranty of any kind, whether express or implied.
>>> + */
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/reset.h>
>>> +
>>> +#define TEGRA_GMI_CONFIG               0x00
>>> +#define TEGRA_GMI_CONFIG_GO            BIT(31)
>>> +#define TEGRA_GMI_BUS_WIDTH_32BIT      BIT(30)
>>> +#define TEGRA_GMI_MUX_MODE             BIT(28)
>>> +#define TEGRA_GMI_RDY_BEFORE_DATA      BIT(24)
>>> +#define TEGRA_GMI_RDY_ACTIVE_HIGH      BIT(23)
>>> +#define TEGRA_GMI_ADV_ACTIVE_HIGH      BIT(22)
>>> +#define TEGRA_GMI_OE_ACTIVE_HIGH       BIT(21)
>>> +#define TEGRA_GMI_CS_ACTIVE_HIGH       BIT(20)
>>> +#define TEGRA_GMI_CS_SELECT(x)         ((x & 0x7) << 4)
>>> +
>>> +#define TEGRA_GMI_TIMING0              0x10
>>> +#define TEGRA_GMI_MUXED_WIDTH(x)       ((x & 0xf) << 12)
>>> +#define TEGRA_GMI_HOLD_WIDTH(x)                ((x & 0xf) << 8)
>>> +#define TEGRA_GMI_ADV_WIDTH(x)         ((x & 0xf) << 4)
>>> +#define TEGRA_GMI_CE_WIDTH(x)          (x & 0xf)
>>> +
>>> +#define TEGRA_GMI_TIMING1              0x14
>>> +#define TEGRA_GMI_WE_WIDTH(x)          ((x & 0xff) << 16)
>>> +#define TEGRA_GMI_OE_WIDTH(x)          ((x & 0xff) << 8)
>>> +#define TEGRA_GMI_WAIT_WIDTH(x)                (x & 0xff)
>>> +
>>> +struct tegra_gmi_priv {
>>> +       void __iomem *base;
>>> +       struct reset_control *rst;
>>> +       struct clk *clk;
>>> +
>>> +       u32 snor_config;
>>> +       u32 snor_timing0;
>>> +       u32 snor_timing1;
>>> +};
>>> +
>>> +static void tegra_gmi_disable(struct tegra_gmi_priv *priv)
>>> +{
>>> +       u32 config;
>>> +
>>> +       /* stop GMI operation */
>>> +       config = readl(priv->base + TEGRA_GMI_CONFIG);
>>> +       config &= ~TEGRA_GMI_CONFIG_GO;
>>> +       writel(config, priv->base + TEGRA_GMI_CONFIG);
>>> +
>>> +       reset_control_assert(priv->rst);
>>> +       clk_disable_unprepare(priv->clk);
>>> +}
>>> +
>>> +static void tegra_gmi_init(struct device *dev, struct tegra_gmi_priv
>>> *priv)
>>> +{
>>> +       writel(priv->snor_timing0, priv->base + TEGRA_GMI_TIMING0);
>>> +       writel(priv->snor_timing1, priv->base + TEGRA_GMI_TIMING1);
>>> +
>>> +       priv->snor_config |= TEGRA_GMI_CONFIG_GO;
>>> +       writel(priv->snor_config, priv->base + TEGRA_GMI_CONFIG);
>>> +}
>>> +
>>> +static int tegra_gmi_parse_dt(struct device *dev, struct tegra_gmi_priv
>>> *priv)
>>> +{
>>> +       struct device_node *child =
>>> of_get_next_available_child(dev->of_node,
>>> +               NULL);
>>> +       u32 property, ranges[4];
>>> +       int ret;
>>> +
>>> +       if (!child) {
>>> +               dev_warn(dev, "no child nodes found\n");
>>> +               return 0;
>>
>>
>> Don't we want to return an error here? Otherwise, we will call
>> tegra_gmi_init() with an invalid configuration.
>
> True, we probably want that. My thought was that we might accept a
> tegra-gmi node without any child nodes and just print a warning. But
> since it is the child node that holds the bus configuration it makes
> sense to fail probe due to no child nodes.

I was wondering that too, but given that we then program and enable the 
GMI I think it is best to just fail for now.

>>
>>
>>> +       }
>>> +
>>> +       /*
>>> +        * We currently only support one child device due to lack of
>>> +        * chip-select address decoding. Which means that we only have one
>>> +        * chip-select line from the GMI controller.
>>> +        */
>>> +       if (of_get_child_count(dev->of_node) > 1)
>>> +               dev_warn(dev, "only one child device is supported.");
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-data-width-32bit"))
>>> +               priv->snor_config |= TEGRA_GMI_BUS_WIDTH_32BIT;
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-mux-mode"))
>>> +               priv->snor_config |= TEGRA_GMI_MUX_MODE;
>>> +
>>> +       if (of_property_read_bool(child,
>>> "nvidia,snor-rdy-active-before-data"))
>>> +               priv->snor_config |= TEGRA_GMI_RDY_BEFORE_DATA;
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-rdy-inv"))
>>> +               priv->snor_config |= TEGRA_GMI_RDY_ACTIVE_HIGH;
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-adv-inv"))
>>> +               priv->snor_config |= TEGRA_GMI_ADV_ACTIVE_HIGH;
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-oe-inv"))
>>> +               priv->snor_config |= TEGRA_GMI_OE_ACTIVE_HIGH;
>>> +
>>> +       if (of_property_read_bool(child, "nvidia,snor-cs-inv"))
>>> +               priv->snor_config |= TEGRA_GMI_CS_ACTIVE_HIGH;
>>> +
>>> +       /* Decode the CS# */
>>> +       ret = of_property_read_u32_array(child, "ranges", ranges, 4);
>>> +       if (ret < 0) {
>>> +               /* Invalid binding */
>>> +               if (ret == -EOVERFLOW) {
>>> +                       dev_err(dev, "invalid ranges length\n");
>>> +                       goto error_cs_decode;
>>> +               }
>>> +
>>> +               /*
>>> +                * If we reach here it means that the child node has an
>>> empty
>>> +                * ranges or it does not exist at all. Attempt to decode
>>> the
>>> +                * CS# from the reg property instead.
>>> +                */
>>> +               ret = of_property_read_u32(child, "reg", &property);
>>> +               if (ret < 0) {
>>> +                       dev_err(dev, "no reg property found\n");
>>> +                       goto error_cs_decode;
>>> +               }
>>> +       } else {
>>> +               property = ranges[1];
>>> +       }
>>> +
>>> +       priv->snor_config |= TEGRA_GMI_CS_SELECT(property);
>>
>>
>> Should we make sure the CS is a valid value before setting?
>
> The TEGRA_GMI_CS_SELECT(x) macro will truncate any erroneous CS value.
> But yeah we could do a sanity check instead and return an error if it
> is invalid.
>
>>
>>
>>> +
>>> +       /* The default values that are provided below are reset values */
>>> +       if (!of_property_read_u32(child, "nvidia,snor-muxed-width",
>>> &property))
>>> +               priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing0 |= TEGRA_GMI_MUXED_WIDTH(1);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-hold-width",
>>> &property))
>>> +               priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing0 |= TEGRA_GMI_HOLD_WIDTH(1);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-adv-width",
>>> &property))
>>> +               priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing0 |= TEGRA_GMI_ADV_WIDTH(1);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-ce-width",
>>> &property))
>>> +               priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing0 |= TEGRA_GMI_CE_WIDTH(4);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-we-width",
>>> &property))
>>> +               priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing1 |= TEGRA_GMI_WE_WIDTH(1);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-oe-width",
>>> &property))
>>> +               priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing1 |= TEGRA_GMI_OE_WIDTH(1);
>>> +
>>> +       if (!of_property_read_u32(child, "nvidia,snor-wait-width",
>>> &property))
>>> +               priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(property);
>>> +       else
>>> +               priv->snor_timing1 |= TEGRA_GMI_WAIT_WIDTH(3);
>>> +
>>> +error_cs_decode:
>>> +       if (ret < 0)
>>> +               dev_err(dev, "failed to decode chip-select number\n");
>>
>>
>> Nit do we need another error message here? Can we add the "failed to decode
>> CS" part the earlier message?
>
> Does it make sense to drop the two earlier messages instead and keep this one?

I think it is nice to have specific errors so we know where it failed. 
You could just drop the above and when you add the test for making sure 
the CS is valid add another error message for that. Not a big deal 
either way. So I will leave to you to decide.

Cheers
Jon

-- 
nvpublic
