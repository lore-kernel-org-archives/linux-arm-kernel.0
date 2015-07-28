From: monstr@monstr.eu (Michal Simek)
Date: Tue, 28 Jul 2015 07:43:09 +0200
Subject: [RFCv2 3/3] reset: reset-zynq: Adding support for Xilinx Zynq
 reset controller.
In-Reply-To: <CAAtXAHcN3YS+k9HH4WaPusg+sidU_a=-RWZ+D43bWe1pH60G0w@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-4-git-send-email-moritz.fischer@ettus.com>
 <55B5D9C2.60509@monstr.eu>
 <CAAtXAHcN3YS+k9HH4WaPusg+sidU_a=-RWZ+D43bWe1pH60G0w@mail.gmail.com>
Message-ID: <55B7166D.4040503@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2015 06:59 AM, Moritz Fischer wrote:
> Hi Michal,
> 
> On Mon, Jul 27, 2015 at 12:12 AM, Michal Simek <monstr@monstr.eu> wrote:
>> On 07/25/2015 02:21 AM, Moritz Fischer wrote:
>>> This adds a reset controller driver to control the Xilinx Zynq
>>> SoC's various resets.
>>>
>>> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
>>> ---
>>>  drivers/reset/Makefile     |   1 +
>>>  drivers/reset/reset-zynq.c | 142 +++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 143 insertions(+)
>>>  create mode 100644 drivers/reset/reset-zynq.c
>>>
>>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>>> index 157d421..3fe50e7 100644
>>> --- a/drivers/reset/Makefile
>>> +++ b/drivers/reset/Makefile
>>> @@ -3,3 +3,4 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>>>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>>>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>>>  obj-$(CONFIG_ARCH_STI) += sti/
>>> +obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>>> diff --git a/drivers/reset/reset-zynq.c b/drivers/reset/reset-zynq.c
>>> new file mode 100644
>>> index 0000000..05e37f8
>>> --- /dev/null
>>> +++ b/drivers/reset/reset-zynq.c
>>> @@ -0,0 +1,142 @@
>>> +/*
>>> + * Copyright (c) 2015, National Instruments Corp.
>>> + *
>>> + * Xilinx Zynq Reset controller driver
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; version 2 of the License.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset-controller.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/types.h>
>>> +
>>> +/* Offsets into SLCR regmap */
>>> +#define SLCR_RST_CTRL_OFFSET 0x200 /* FPGA Software Reset Control */
>>> +
>>> +#define NBANKS       18
>>> +
>>> +struct zynq_reset_data {
>>> +     struct regmap *slcr;
>>> +     struct reset_controller_dev rcdev;
>>> +};
>>> +
>>> +#define to_zynq_reset_data(p)                \
>>> +     container_of((p), struct zynq_reset_data, rcdev)
>>> +
>>> +static int zynq_reset_assert(struct reset_controller_dev *rcdev,
>>> +                          unsigned long id)
>>> +{
>>> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
>>> +
>>> +     int bank = id / BITS_PER_LONG;
>>> +     int offset = id % BITS_PER_LONG;
>>> +
>>
>> Personally me I would also add debug message here to be simply enabled
>> for easier tracking.
> See below
>>
>>> +     regmap_update_bits(priv->slcr,
>>> +                        SLCR_RST_CTRL_OFFSET + (bank * 4),
>>> +                        BIT(offset),
>>> +                        BIT(offset));
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int zynq_reset_deassert(struct reset_controller_dev *rcdev,
>>> +                            unsigned long id)
>>> +{
>>> +     struct zynq_reset_data *priv = to_zynq_reset_data(rcdev);
>>> +
>>> +     int bank = id / BITS_PER_LONG;
>>> +     int offset = id % BITS_PER_LONG;
>>> +
>>
>> debug message here too.
> is:
> pr_debug("%s: bank: %u offset %u\n", __func__, bank, offset);
> accetable? Otherwise I'd have to carry around a struct dev* to use dev_dbg()

It is fine for me.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/f14cd43d/attachment-0001.sig>
