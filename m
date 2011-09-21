From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Sep 2011 09:02:01 +0200
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	<20110920203037.GE31404@pengutronix.de>
	<CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
Message-ID: <20110921070201.GB14191@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 01:04:09PM +0800, Richard Zhu wrote:
> Hi Sascha:
> Thanks for your comments.
> 
> Best Regard
> Richard Zhu
> 
> On 21 September 2011 04:30, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Aug 31, 2011 at 11:50:31AM +0800, Richard Zhu wrote:
> >> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> >> Tested-By: Hector Oron Martinez <hector.oron@gmail.com>
> >> ---
> >> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ? ? | ? 19 ++++
> >> ?arch/arm/mach-mx5/devices-imx53.h ? ? ? ? ? ? ? | ? ?4 +
> >> ?arch/arm/plat-mxc/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> >> ?arch/arm/plat-mxc/ahci_sata.c ? ? ? ? ? ? ? ? ? | ?104 +++++++++++++++++++++++
> >> ?arch/arm/plat-mxc/devices/Kconfig ? ? ? ? ? ? ? | ? ?4 +
> >> ?arch/arm/plat-mxc/devices/Makefile ? ? ? ? ? ? ?| ? ?1 +
> >> ?arch/arm/plat-mxc/devices/platform-ahci-imx.c ? | ? 66 ++++++++++++++
> >> ?arch/arm/plat-mxc/include/mach/ahci_sata.h ? ? ?| ? 33 +++++++
> >> ?arch/arm/plat-mxc/include/mach/devices-common.h | ? 10 ++
> >> ?9 files changed, 242 insertions(+), 0 deletions(-)
> >> ?create mode 100644 arch/arm/plat-mxc/ahci_sata.c
> >> ?create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
> >> ?create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h
> >>
> >> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> index 7f20308..e1fadaf 100644
> >> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> >> @@ -1397,6 +1397,22 @@ static struct clk esdhc4_mx53_clk = {
> >> ? ? ? .secondary = &esdhc4_ipg_clk,
> >> ?};
> >>
> >> diff --git a/arch/arm/plat-mxc/ahci_sata.c b/arch/arm/plat-mxc/ahci_sata.c
> >> new file mode 100644
> >> index 0000000..4f54816
> >> --- /dev/null
> >> +++ b/arch/arm/plat-mxc/ahci_sata.c
> >> @@ -0,0 +1,104 @@
> >> +/*
> >> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> >> + */
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> +
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> >> + * GNU General Public License for more details.
> >> +
> >> + * You should have received a copy of the GNU General Public License along
> >> + * with this program; if not, write to the Free Software Foundation, Inc.,
> >> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#include <linux/io.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/err.h>
> >> +#include <linux/device.h>
> >> +#include <mach/ahci_sata.h>
> >> +
> >> +static struct clk *sata_clk, *sata_ref_clk;
> >
> > These variables make the driver single instance only.
> [Richard Zhu] In order to handle the clock enable/disable stuff, these
> two variables are mandatory required.
> Otherwise, new two struct clk members had to be added into
> ahci_platform_data struct. Then the clks can
> be transferred by the platform data.
> The current is preferred, refer to the second choice.
> >
> >> +
> >> +/* AHCI module Initialization, if return 0, initialization is successful. */
> >> +int sata_init(struct device *dev, void __iomem *addr)
> >
> > A global function with such a generic name is not a good idea.
> > Also I wonder how we want to convert this to devicetree when we
> > implement this as a platform specific hook. It should be done in the
> > driver.
> >
> [Richard Zhu] The name of these two func can be changed.
> But I don't have a good idea to move out these two platform specific
> hooks (->init, ->exit).
> 
> Refer to you comments, do you means that the ->init and ->exit should
> be done in ahci_platform.c driver?
> Different platform may have the different ->init and ->exit funcs to
> handle it's own initialization and exit.
> It would be a problem that handle all kinds of init in one driver
> without the hooks.

Maybe Shawn can comment on the device tree topic. I just think that if
we merge this without devicetree support it should at least be
devicetree friendly. For example each platform could provide it's own
platform driver glue code like it's done for the sdhci driver.

> >> diff --git a/arch/arm/plat-mxc/devices/platform-ahci-imx.c b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> >> new file mode 100644
> >> index 0000000..9e1b460
> >> --- /dev/null
> >> +++ b/arch/arm/plat-mxc/devices/platform-ahci-imx.c
> >> @@ -0,0 +1,66 @@
> >> +/*
> >> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> >> + */
> >> +
> >> +/*
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> +
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> >> + * GNU General Public License for more details.
> >> +
> >> + * You should have received a copy of the GNU General Public License along
> >> + * with this program; if not, write to the Free Software Foundation, Inc.,
> >> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#include <linux/dma-mapping.h>
> >> +#include <asm/sizes.h>
> >> +#include <mach/hardware.h>
> >> +#include <mach/devices-common.h>
> >> +#include <mach/ahci_sata.h>
> >> +
> >> +#define imx_ahci_imx_data_entry_single(soc, _devid) ? ? ? ? ?\
> >> + ? ? { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? .devid = _devid, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> >> + ? ? ? ? ? ? .iobase = soc ## _SATA_BASE_ADDR, ? ? ? ? ? ? ? ? ? ? ? \
> >> + ? ? ? ? ? ? .irq = soc ## _INT_SATA, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
> >> + ? ? }
> >> +
> >> +#ifdef CONFIG_SOC_IMX53
> >> +const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
> >> + ? ? imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
> >> +#endif
> >> +
> >> +static struct ahci_platform_data default_sata_pdata = {
> >> + ? ? .init = sata_init,
> >> + ? ? .exit = sata_exit,
> >> +};

If we continue going the way you started, please add the
sata_init/sata_exit functions as static functions to this file, ...

> >> +
> >> +struct platform_device *__init imx_add_ahci_imx(
> >> + ? ? ? ? ? ? const struct imx_ahci_imx_data *data,
> >> + ? ? ? ? ? ? const struct ahci_platform_data *pdata)
> >> +{
> >> + ? ? struct resource res[] = {
> >> + ? ? ? ? ? ? {
> >> + ? ? ? ? ? ? ? ? ? ? .start = data->iobase,
> >> + ? ? ? ? ? ? ? ? ? ? .end = data->iobase + SZ_4K - 1,
> >> + ? ? ? ? ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> >> + ? ? ? ? ? ? }, {
> >> + ? ? ? ? ? ? ? ? ? ? .start = data->irq,
> >> + ? ? ? ? ? ? ? ? ? ? .end = data->irq,
> >> + ? ? ? ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ,
> >> + ? ? ? ? ? ? },
> >> + ? ? };
> >> +
> >> + ? ? if (pdata == NULL)
> >> + ? ? ? ? ? ? pdata = &default_sata_pdata;

...remove these two lines, and instead introduce a function like this:

struct platform_device *__init imx53_add_ahci_imx(void)
{
	struct ahci_platform_data pdata = {
		.init = imx53_sata_init,
		.exit = imx53_sata_exit,
	};

	return imx_add_ahci_imx(&imx53_ahci_imx_data, &pdata);
}


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
