From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 28 Jul 2015 07:05:57 -0700
Subject: [RFCv2 3/3] reset: reset-zynq: Adding support for Xilinx Zynq
 reset controller.
In-Reply-To: <1438072680.3193.24.camel@pengutronix.de>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-4-git-send-email-moritz.fischer@ettus.com>
 <1438072680.3193.24.camel@pengutronix.de>
Message-ID: <CAAtXAHfgCnH1KPyPBBPHq-amr=npMmyYjs+D9jnB3F9qpD6dbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philip,

thanks for your review :)

On Tue, Jul 28, 2015 at 1:38 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Moritz,
>
> Am Freitag, den 24.07.2015, 17:21 -0700 schrieb Moritz Fischer:
>> This adds a reset controller driver to control the Xilinx Zynq
>> SoC's various resets.
>>
>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>> ---
>>  drivers/reset/Makefile     |   1 +
>>  drivers/reset/reset-zynq.c | 142 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 143 insertions(+)
>>  create mode 100644 drivers/reset/reset-zynq.c
>>
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 157d421..3fe50e7 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -3,3 +3,4 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>>  obj-$(CONFIG_ARCH_STI) += sti/
>> +obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>> diff --git a/drivers/reset/reset-zynq.c b/drivers/reset/reset-zynq.c
>> new file mode 100644
>> index 0000000..05e37f8
>> --- /dev/null
>> +++ b/drivers/reset/reset-zynq.c
>> @@ -0,0 +1,142 @@
>> +/*
>> + * Copyright (c) 2015, National Instruments Corp.
>> + *
>> + * Xilinx Zynq Reset controller driver
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
>> +
>> +/* Offsets into SLCR regmap */
>> +#define SLCR_RST_CTRL_OFFSET 0x200 /* FPGA Software Reset Control */
>
> Maybe get this value from the reg property? I'm not sure if this is ever
> expected to change.
I don't think it's going to change. Is there a reason to only expose
part of the resets?
>
>> +#define NBANKS       18
>
> reg = <0x200 0x50> says there are two more registers, are those not used?

Should be 0x48, you're right. Michal had suggested 0x50, but the last
two regs are not really resets.
>
>> +struct zynq_reset_data {
>> +     struct regmap *slcr;
>> +     struct reset_controller_dev rcdev;
>> +};
>> +
>> +#define to_zynq_reset_data(p)                \
>> +     container_of((p), struct zynq_reset_data, rcdev)
>> +
>> +static int zynq_reset_assert(struct reset_controller_dev *rcdev,
>> +                          unsigned long id)
>> +{
>> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
>> +
>> +     int bank = id / BITS_PER_LONG;
>> +     int offset = id % BITS_PER_LONG;
>> +
>> +     regmap_update_bits(priv->slcr,
>> +                        SLCR_RST_CTRL_OFFSET + (bank * 4),
>> +                        BIT(offset),
>> +                        BIT(offset));
>> +
>> +     return 0;
>> +}
>
> Just "return regmap_update_bits(...)" here ...
Yup, good point.
>
>> +static int zynq_reset_deassert(struct reset_controller_dev *rcdev,
>> +                            unsigned long id)
>> +{
>> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
>> +
>> +     int bank = id / BITS_PER_LONG;
>> +     int offset = id % BITS_PER_LONG;
>> +
>> +     regmap_update_bits(priv->slcr,
>> +                        SLCR_RST_CTRL_OFFSET + (bank * 4),
>> +                        BIT(offset),
>> +                        ~BIT(offset));
>> +
>> +     return 0;
>> +}
>
> ... and here.
>
>> +static int zynq_reset_status(struct reset_controller_dev *rcdev,
>> +                          unsigned long id)
>> +{
>> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
>> +
>> +     int bank = id / BITS_PER_LONG;
>> +     int offset = id % BITS_PER_LONG;
>> +     u32 reg;
>> +
>> +     regmap_read(priv->slcr, SLCR_RST_CTRL_OFFSET + (bank * 4), &reg);
>> +
>> +     return !(reg & BIT(offset));
>> +}

Will change to:
        ret = regmap_read(priv->slcr, SLCR_RST_CTRL_OFFSET + (bank * 4), &reg);
        if (ret)
                return ret;
        else
                return !!(reg & BIT(offset));

the single '!' was a typo ...

>
> Do I understand this correctly, you write 1 to assert the reset, but the
> register reads 0 while the reset is asserted and 1 otherwise?
> Also note that reset_status may return negative ERRNO, so for offset ==
> 31 you should not return (1<<31).
>
>> +static const struct reset_control_ops zynq_reset_ops = {
>> +     .assert         = zynq_reset_assert,
>> +     .deassert       = zynq_reset_deassert,
>> +     .status         = zynq_reset_status,
>> +};
>> +
>> +static int zynq_reset_probe(struct platform_device *pdev)
>> +{
>> +     struct zynq_reset_data *priv;
>> +
>> +     priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +     platform_set_drvdata(pdev, priv);
>> +
>> +     priv->slcr = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +             "syscon");
>
> I'd just use syscon_node_to_regmap(pdev->dev.of_node->parent) here,
> which removes the need for the syscon phandle binding.

See binding doc discussion. I don't have a strong preference either way,
just tried to be consistent with the pinctrl node.
We just need a decision one way or the other :)
>
>> +     if (IS_ERR(priv->slcr)) {
>> +             dev_err(&pdev->dev, "unable to get zynq-slcr regmap");
>> +             return PTR_ERR(priv->slcr);
>> +     }
>> +
>> +     priv->rcdev.owner = THIS_MODULE;
>> +     priv->rcdev.nr_resets = NBANKS * BITS_PER_LONG;
>> +     priv->rcdev.ops = &zynq_reset_ops;
>> +     priv->rcdev.of_node = pdev->dev.of_node;
>> +     reset_controller_register(&priv->rcdev);
>> +
>> +     return 0;
>> +}
>> +
>> +static int zynq_reset_remove(struct platform_device *pdev)
>> +{
>> +     struct zynq_reset_data *priv = platform_get_drvdata(pdev);
>> +
>> +     reset_controller_unregister(&priv->rcdev);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id zynq_reset_dt_ids[] = {
>> +     { .compatible = "xlnx,zynq-reset", },
>> +     { /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver zynq_reset_driver = {
>> +     .probe  = zynq_reset_probe,
>> +     .remove = zynq_reset_remove,
>> +     .driver = {
>> +             .name           = "zynq-pl-reset",
>
> Is -pl- a leftover?
Yes ... will fix that.
>
>> +             .of_match_table = zynq_reset_dt_ids,
>> +     },
>> +};
>> +module_platform_driver(zynq_reset_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
>> +MODULE_DESCRIPTION("Zynq Reset Controller Driver");
>
> regards
> Philipp
>
Thanks,

Moritz
