From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 10 Aug 2018 11:30:08 +0900
Subject: [PATCH v2 2/4] phy: socionext: add USB3 PHY driver for UniPhier
 SoC
In-Reply-To: <312d10ae-7909-bede-ea0a-5d92a497f639@ti.com>
References: <1533290045-18969-3-git-send-email-hayashi.kunihiko@socionext.com>
 <312d10ae-7909-bede-ea0a-5d92a497f639@ti.com>
Message-ID: <20180810113007.0746.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Thu, 9 Aug 2018 16:00:19 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Hi,
> 
> On Friday 03 August 2018 03:24 PM, Kunihiko Hayashi wrote:
> > Add a driver for PHY interface built into USB3 controller
> > implemented in UniPhier SoCs.
> > This driver supports High-Speed PHY and Super-Speed PHY.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > ---
> >  drivers/phy/Kconfig                         |   1 +
> >  drivers/phy/Makefile                        |   1 +
> >  drivers/phy/socionext/Kconfig               |  12 +
> >  drivers/phy/socionext/Makefile              |   6 +
> >  drivers/phy/socionext/phy-uniphier-usb3hs.c | 423 ++++++++++++++++++++++++++++
> >  drivers/phy/socionext/phy-uniphier-usb3ss.c | 350 +++++++++++++++++++++++
> >  6 files changed, 793 insertions(+)
> >  create mode 100644 drivers/phy/socionext/Kconfig
> >  create mode 100644 drivers/phy/socionext/Makefile
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
> >  create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

[snip]

> > --- /dev/null
> > +++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
> > +// Copyright 2015-2018 Socionext Inc.
> > +// Author:
> > +//      Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > +// Contributors:
> > +//      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> > +//      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> > +
> 
> I'm not sure if there is a standard format for adding SPDX identifiers. But
> other PHY drivers seems to have used single line comment style only for the
> first line. (see drivers/phy/amlogic/phy-meson-gxl-usb3.c)

Okay, I understand that the format differs depending on each sub-system so far.
I'll rewrite it according to other PHY drivers.

Same as phy-uniphier-usb3ss.c.

> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>

[snip]

> > +	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3hsphy_ops);
> > +	if (IS_ERR(phy))
> > +		return PTR_ERR(phy);
> > +
> > +	phy_set_drvdata(phy, priv);
> > +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider))
> > +		return PTR_ERR(phy_provider);
> 
> return PTR_ERR_OR_ZERO()?

Indeed. I'll replace it as follows.

	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
	return PTR_ERR_OR_ZERO(phy_provider);

Same as phy-uniphier-usb3ss.c.

Thank you,

---
Best Regards,
Kunihiko Hayashi
