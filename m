From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Jul 2018 08:11:03 +0100
Subject: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
In-Reply-To: <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell>
 <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
Message-ID: <20180703071103.GE20176@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jun 2018, Matthias Brugger wrote:
> On 30/04/18 12:18, Lee Jones wrote:
> > On Fri, 27 Apr 2018, matthias.bgg at kernel.org wrote:
> > 
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> The MMSYS subsystem includes clocks and drm components.
> >> This patch adds a MFD device to probe both drivers from the same
> >> device tree compatible.
> >>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  drivers/mfd/Kconfig     |  9 ++++++
> >>  drivers/mfd/Makefile    |  2 ++
> >>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 90 insertions(+)
> >>  create mode 100644 drivers/mfd/mtk-mmsys.c
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index b860eb5aa194..d23a3b9a2c58 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
> >>  	help
> >>  	  Select this if your MC13xxx is connected via an I2C bus.
> >>  
> >> +config MFD_MEDIATEK_MMSYS
> >> +	tristate "Mediatek MMSYS interface"
> >> +	select MFD_CORE
> >> +	select REGMAP_MMIO
> >> +	help
> >> +	  Select this if you have a MMSYS subsystem in your SoC. The
> >> +	  MMSYS subsystem has at least a clock driver part and some
> >> +	  DRM components.
> >> +
> >>  config MFD_MXS_LRADC
> >>  	tristate "Freescale i.MX23/i.MX28 LRADC"
> >>  	depends on ARCH_MXS || COMPILE_TEST
> >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >> index d9d2cf0d32ef..b96118bd68d9 100644
> >> --- a/drivers/mfd/Makefile
> >> +++ b/drivers/mfd/Makefile
> >> @@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
> >>  obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
> >>  obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> >>  
> >> +obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
> >> +
> >>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> >>  
> >>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> >> diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
> >> new file mode 100644
> >> index 000000000000..c802343fb1c6
> >> --- /dev/null
> >> +++ b/drivers/mfd/mtk-mmsys.c
> >> @@ -0,0 +1,79 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +/*
> >> + * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
> >> + *
> >> + * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
> >> + *
> >> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/init.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +enum {
> >> +	MMSYS_MT2701 = 1,
> >> +};
> >> +
> >> +static const struct mfd_cell mmsys_mt2701_devs[] = {
> >> +	{ .name = "clk-mt2701-mm", },
> >> +	{ .name = "drm-mt2701-mm", },
> >> +};
> >> +
> >> +static int mmsys_probe(struct platform_device *pdev)
> >> +{
> >> +	const struct mfd_cell *mmsys_cells;
> >> +	int nr_cells;
> >> +	long id;
> >> +	int ret;
> >> +
> >> +	id = (long) of_device_get_match_data(&pdev->dev);
> >> +	if (!id) {
> >> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	switch (id) {
> >> +	case MMSYS_MT2701:
> >> +		mmsys_cells = mmsys_mt2701_devs;
> >> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
> >> +		break;
> >> +	default:
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
> >> +					NULL, 0, NULL);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +};
> > 
> > This driver is pretty pointless.  It doesn't actually do anything.
> > 
> > I think you just want to use "simple-mfd" instead.
> > 
> 
> I think the problem is, that right now we have two drivers which use the same
> devicetree binding, which are clk and drm driver. With a simple-mfd we would
> need two compatibles, and this would break backwards compatibility.

So what functionality does this driver provide you with that you do
not have currently?

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
