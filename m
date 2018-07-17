From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 17 Jul 2018 20:27:57 +0900
Subject: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
In-Reply-To: <52b96200-2234-9017-a317-f929eac9b266@ti.com>
References: <20180711210514.BB32.4A936039@socionext.com>
 <52b96200-2234-9017-a317-f929eac9b266@ti.com>
Message-ID: <20180717202757.858B.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Fri, 13 Jul 2018 12:45:06 +0530 <kishon@ti.com> wrote:

> Hi,
> 
> On Wednesday 11 July 2018 05:35 PM, Kunihiko Hayashi wrote:
> > On Mon, 9 Jul 2018 20:23:19 +0900 <hayashi.kunihiko@socionext.com> wrote:
> > 
> >> Hi Kishon,
> >> Thank you for your comments.
> >>
> >> On Mon, 9 Jul 2018 10:49:50 +0530 <kishon@ti.com> wrote:
> >>
> >>> Hi,
> >>>
> >>> On Friday 29 June 2018 02:08 PM, Kunihiko Hayashi wrote:
> >>>> Add a driver for PHY interface built into USB3 controller
> >>>> implemented in UniPhier SoCs.
> >>>> This driver supports High-Speed PHY and Super-Speed PHY.
> >>>>
> >>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> >>>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> >>>> ---
> >>>>  drivers/phy/Kconfig                         |   1 +
> >>>>  drivers/phy/Makefile                        |   1 +
> >>>>  drivers/phy/socionext/Kconfig               |  12 +
> >>>>  drivers/phy/socionext/Makefile              |   6 +
> >>>>  drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
> >>>>  drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
> >>>>  6 files changed, 811 insertions(+)
> >>>>  create mode 100644 drivers/phy/socionext/Kconfig
> >>>>  create mode 100644 drivers/phy/socionext/Makefile
> >>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
> >>>>  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
> >>
> >> (snip...)
> >>
> >>>> --- /dev/null
> >>>> +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> >>>> @@ -0,0 +1,422 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> >>>> + * Copyright 2015-2018 Socionext Inc.
> >>>> + * Author:
> >>>> + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>>> + * Contributors:
> >>>> + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> >>>> + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> >>>> + */
> >>>> +
> >>>> +#include <linux/bitfield.h>
> >>>> +#include <linux/bitops.h>
> >>>> +#include <linux/clk.h>
> >>>> +#include <linux/io.h>
> >>>> +#include <linux/mfd/syscon.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/nvmem-consumer.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/of_platform.h>
> >>>> +#include <linux/phy/phy.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/reset.h>
> >>>> +#include <linux/slab.h>
> >>>> +
> >>>> +#define HSPHY_CFG0		0x0
> >>>> +#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
> >>>> +#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
> >>>> +#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
> >>>> +#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
> >>>> +#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
> >>>> +#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
> >>>> +				 | HSPHY_CFG0_SEL_T_MASK \
> >>>> +				 | HSPHY_CFG0_RTERM_MASK)
> >>>> +
> >>>> +#define HSPHY_CFG1		0x4
> >>>> +#define HSPHY_CFG1_DAT_EN	BIT(29)
> >>>> +#define HSPHY_CFG1_ADR_EN	BIT(28)
> >>>> +#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
> >>>> +#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
> >>>> +
> >>>> +#define MAX_CLKS	3
> >>>> +#define MAX_RSTS	2
> >>>> +#define MAX_PHY_PARAMS	1
> >>>> +
> >>>> +struct uniphier_u3hsphy_param {
> >>>> +	u32 addr;
> >>>> +	u32 mask;
> >>>> +	u32 val;
> >>>> +};
> >>>
> >>> I'd like to avoid configure the PHY this way, since it's impossible to know
> >>> which register is being configured.
> >>
> > 
> > This way might be misunderstood.
> > These HS-PHY and SS-PHY have "internal" registers, which are not memory-mapped.
> > 
> > And to access these internal registers, we need to specify the number
> > corresponding to the register.
> > 
> > The "addr" in "uniphier_u3hsphy_param" is just the number of the register.
> > The "mask" shows a bitfield of the register, that means one of PHY parameters.
> > The "value" shows a parameter value to set to the bitfield.
> 
> What does each of these bitfields represent? Which PHY parameter does it
> configure. Are they really PHY parameters or they also configure clocks/mux
> etc? I would like the configurations to be more descriptive so that we get to
> know at least what's getting configured here.

These bitfields represent phy parameters only, not include clocks/mux etc.
We can express the register (bitfield) name with macros.

However, only recommended values are noted for the bitfields in the specsheet,
because there are the trimmed values that aren't set as power-on values,
and we should use the values for stable operation.

This driver includes only minimal parameter set, so I think it's difficult
to express them more configurable.

Thank you,

---
Best Regards,
Kunihiko Hayashi
