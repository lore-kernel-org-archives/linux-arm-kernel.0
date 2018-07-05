From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Jul 2018 13:22:23 +0100
Subject: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
In-Reply-To: <92a851a9-a12c-e773-5f43-007f4d08b7e3@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell>
 <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
 <20180703071103.GE20176@dell>
 <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
 <20180704164540.GH496@dell>
 <92a851a9-a12c-e773-5f43-007f4d08b7e3@suse.com>
Message-ID: <20180705122223.GO496@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 05 Jul 2018, Matthias Brugger wrote:
> On 04/07/18 18:45, Lee Jones wrote:
> > On Wed, 04 Jul 2018, Matthias Brugger wrote:
> >> On 03/07/18 09:11, Lee Jones wrote:
> >>> On Mon, 25 Jun 2018, Matthias Brugger wrote:
> >>>> On 30/04/18 12:18, Lee Jones wrote:
> >>>>> On Fri, 27 Apr 2018, matthias.bgg at kernel.org wrote:
> >>>>>
> >>>>>> From: Matthias Brugger <mbrugger@suse.com>
> >>>>>>
> >>>>>> The MMSYS subsystem includes clocks and drm components.
> >>>>>> This patch adds a MFD device to probe both drivers from the same
> >>>>>> device tree compatible.
> >>>>>>
> >>>>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >>>>>> ---
> >>>>>>  drivers/mfd/Kconfig     |  9 ++++++
> >>>>>>  drivers/mfd/Makefile    |  2 ++
> >>>>>>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>  3 files changed, 90 insertions(+)
> >>>>>>  create mode 100644 drivers/mfd/mtk-mmsys.c
> >>>>>>
> >>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >>>>>> index b860eb5aa194..d23a3b9a2c58 100644
> >>>>>> --- a/drivers/mfd/Kconfig
> >>>>>> +++ b/drivers/mfd/Kconfig
> >>>>>> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
> >>>>>>  	help
> >>>>>>  	  Select this if your MC13xxx is connected via an I2C bus.
> >>>>>>  
> >>>>>> +config MFD_MEDIATEK_MMSYS
> >>>>>> +	tristate "Mediatek MMSYS interface"
> >>>>>> +	select MFD_CORE
> >>>>>> +	select REGMAP_MMIO
> >>>>>> +	help
> >>>>>> +	  Select this if you have a MMSYS subsystem in your SoC. The
> >>>>>> +	  MMSYS subsystem has at least a clock driver part and some
> >>>>>> +	  DRM components.
> >>>>>> +
> >>>>>>  config MFD_MXS_LRADC
> >>>>>>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> >>>>>>  	depends on ARCH_MXS || COMPILE_TEST
> >>>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >>>>>> index d9d2cf0d32ef..b96118bd68d9 100644
> >>>>>> --- a/drivers/mfd/Makefile
> >>>>>> +++ b/drivers/mfd/Makefile
> >>>>>> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
> >>>>>>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
> >>>>>>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> >>>>>>  
> >>>>>> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
> >>>>>> +
> >>>>>>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> >>>>>>  
> >>>>>>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> >>>>>> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..c802343fb1c6
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/mfd/mtk-mmsys.c
> >>>>>> @@ -0,0 +1,79 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0+
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
> >>>>>> + *
> >>>>>> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
> >>>>>> + *
> >>>>>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include <linux/module.h>
> >>>>>> +#include <linux/init.h>
> >>>>>> +#include <linux/mfd/core.h>
> >>>>>> +#include <linux/of.h>
> >>>>>> +#include <linux/of_address.h>
> >>>>>> +#include <linux/of_device.h>
> >>>>>> +#include <linux/platform_device.h>
> >>>>>> +#include <linux/regmap.h>
> >>>>>> +
> >>>>>> +enum {
> >>>>>> +	MMSYS_MT2701 = 1,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct mfd_cell mmsys_mt2701_devs[] = {
> >>>>>> +	{ .name = "clk-mt2701-mm", },
> >>>>>> +	{ .name = "drm-mt2701-mm", },
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int mmsys_probe(struct platform_device *pdev)
> >>>>>> +{
> >>>>>> +	const struct mfd_cell *mmsys_cells;
> >>>>>> +	int nr_cells;
> >>>>>> +	long id;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	id = (long) of_device_get_match_data(&pdev->dev);
> >>>>>> +	if (!id) {
> >>>>>> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
> >>>>>> +		return -EINVAL;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	switch (id) {
> >>>>>> +	case MMSYS_MT2701:
> >>>>>> +		mmsys_cells = mmsys_mt2701_devs;
> >>>>>> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
> >>>>>> +		break;
> >>>>>> +	default:
> >>>>>> +		return -ENODEV;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
> >>>>>> +					NULL, 0, NULL);
> >>>>>> +	if (ret) {
> >>>>>> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
> >>>>>> +		return ret;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	return 0;
> >>>>>> +};
> >>>>>
> >>>>> This driver is pretty pointless.  It doesn't actually do anything.
> >>>>>
> >>>>> I think you just want to use "simple-mfd" instead.
> >>>>>
> >>>>
> >>>> I think the problem is, that right now we have two drivers which use the same
> >>>> devicetree binding, which are clk and drm driver. With a simple-mfd we would
> >>>> need two compatibles, and this would break backwards compatibility.
> >>>
> >>> So what functionality does this driver provide you with that you do
> >>> not have currently?
> >>>
> >>
> >> I'm not sure if I get your question. Point is, that the MMSYS implementation for
> >> mt8173 is broken, as it assumes that we can probe two drivers with the
> >> mediatek,mt8173-mmsys compatible. Somehow it used to work, but from what I
> >> understand it was a bug. So older devicetrees use just on mt8173-mmsys
> >> compatible in ther DTB.
> > 
> > Okay, that is what I was getting at.  Thanks for the explanation.
> > 
> > Do you have a datasheet I can look at?
> > 
> 
> Unfortunately there is no datasheet you can get without a NDA. The only public
> available information I'm aware of is for the (not upstream supported) 96board
> [1]. And it's only the register description. You can find some more explanation
> about the MMSYS in older threads which tried to solve the very same problem [2]
> 
> [1]
> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_2.pdf
> [2] http://lists.infradead.org/pipermail/linux-mediatek/2017-October/010979.html

And now we have some history.  Thanks for providing those.

So my initial reaction is the one I have just confirmed for myself.
MFD is being used as a work-around in this odd use-case and really
isn't the right place for it.

If you're adamant that you do not wish to change the Device Tree, my
suggestion is to either move the clk functionality into the DRM
driver, or register the clk driver from DRM using standard
platform_device_register() API.

> >> I would like to keep backwards compatibility for the device tree, that's why I
> >> was searching for a solution where we can probe two drivers and came up with
> >> this mfd solution.
> >>
> >> So no new functionality, the clk driver provides the clock the drm components need.
> > 

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
