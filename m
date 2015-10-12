From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Oct 2015 18:18:41 +0200
Subject: [PATCH v6 10/17] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <561BCB97.3030201@ti.com>
References: <1444491357-26095-1-git-send-email-ykk@rock-chips.com>
 <1444492559-27181-1-git-send-email-ykk@rock-chips.com>
 <561BCB97.3030201@ti.com>
Message-ID: <3399683.FyIv57FCEM@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. Oktober 2015, 20:32:47 schrieb Kishon Vijay Abraham I:
> Hi,
> 
> On Saturday 10 October 2015 09:25 PM, Yakir Yang wrote:
> > This phy driver would control the Rockchip DisplayPort module
> > phy clock and phy power, it is relate to analogix_dp-rockchip
> > dp driver. If you want DP works rightly on rockchip platform,
> > then you should select both of them.
> 
> Add phy driver for the Rockchip DisplayPort PHY module. This is required
> to get DisplayPort working in Rockchip SoCs.
> 
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > ---
> > Changes in v6: None
> > Changes in v5:
> > - Remove "reg" DT property, cause driver could poweron/poweroff phy via
> > 
> >   the exist "grf" syscon already. And rename the example DT node from
> >   "edp_phy: phy at ff770274" to "edp_phy: edp-phy" directly. (Heiko)
> > 
> > - Add deivce_node at the front of driver, update phy_ops type from "static
> > 
> >   struct" to "static const struct". And correct the input paramters of
> >   devm_phy_create() interfaces. (Heiko)
> > 
> > Changes in v4:
> > - Add commit message, and remove the redundant rockchip_dp_phy_init()
> > 
> >   function, move those code to probe() method. And remove driver .owner
> >   number. (Kishon)
> > 
> > Changes in v3:
> > - Suggest, add rockchip dp phy driver, collect the phy clocks and
> > 
> >   power control. (Heiko)
> > 
> > Changes in v2: None
> > 
> >  drivers/phy/Kconfig           |   7 ++
> >  drivers/phy/Makefile          |   1 +
> >  drivers/phy/phy-rockchip-dp.c | 151
> >  ++++++++++++++++++++++++++++++++++++++++++ 3 files changed, 159
> >  insertions(+)
> >  create mode 100644 drivers/phy/phy-rockchip-dp.c
> > 
> > diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> > index 47da573..8f2bc4f 100644
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -310,6 +310,13 @@ config PHY_ROCKCHIP_USB
> > 
> >  	help
> >  	
> >  	  Enable this to support the Rockchip USB 2.0 PHY.
> > 
> > +config PHY_ROCKCHIP_DP
> > +	tristate "Rockchip Display Port PHY Driver"
> > +	depends on ARCH_ROCKCHIP && OF
> > +	select GENERIC_PHY
> > +	help
> > +	  Enable this to support the Rockchip Display Port PHY.
> > +
> > 
> >  config PHY_ST_SPEAR1310_MIPHY
> >  
> >  	tristate "ST SPEAR1310-MIPHY driver"
> >  	select GENERIC_PHY
> > 
> > diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> > index a5b18c1..e281f35 100644
> > --- a/drivers/phy/Makefile
> > +++ b/drivers/phy/Makefile
> > @@ -34,6 +34,7 @@ phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)	+=
> > phy-s5pv210-usb2.o> 
> >  obj-$(CONFIG_PHY_EXYNOS5_USBDRD)	+= phy-exynos5-usbdrd.o
> >  obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
> > 
> > +obj-$(CONFIG_PHY_ROCKCHIP_DP)		+= phy-rockchip-dp.o
> > 
> >  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
> >  obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
> >  obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
> > 
> > diff --git a/drivers/phy/phy-rockchip-dp.c b/drivers/phy/phy-rockchip-dp.c
> > new file mode 100644
> > index 0000000..3a2ac120
> > --- /dev/null
> > +++ b/drivers/phy/phy-rockchip-dp.c
> > @@ -0,0 +1,151 @@
> > +/*
> > + * Rockchip DP PHY driver
> > + *
> > + * Copyright (C) 2015 FuZhou Rockchip Co., Ltd.
> > + * Author: Yakir Yang <ykk@@rock-chips.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/clk.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define GRF_SOC_CON12                   0x0274
> > +#define GRF_EDP_REF_CLK_SEL_INTER	BIT(4)
> > +#define GRF_EDP_PHY_SIDDQ_WRITE_EN      BIT(21)
> > +#define GRF_EDP_PHY_SIDDQ_ON            0
> > +#define GRF_EDP_PHY_SIDDQ_OFF           BIT(5)
> > +
> > +struct rockchip_dp_phy {
> > +	struct device  *dev;
> > +	struct regmap  *grf;
> > +	struct clk     *phy_24m;
> > +};
> > +
> > +static int rockchip_set_phy_state(struct phy *phy, bool enable)
> > +{
> > +	struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
> > +	int ret;
> > +
> > +	if (enable) {
> > +		ret = clk_prepare_enable(dp->phy_24m);
> > +		if (ret < 0) {
> > +			dev_err(dp->dev, "Can't enable clock 24m %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		ret = regmap_write(dp->grf, GRF_SOC_CON12,
> > +				   GRF_EDP_PHY_SIDDQ_WRITE_EN |
> > +				   GRF_EDP_PHY_SIDDQ_ON);
> > +	} else {
> > +		clk_disable_unprepare(dp->phy_24m);
> 
> should clk_disable come after regmap_write? It'll be symmetric to enable?
> 
> > +		ret = regmap_write(dp->grf, GRF_SOC_CON12,
> > +				   GRF_EDP_PHY_SIDDQ_WRITE_EN |
> > +				   GRF_EDP_PHY_SIDDQ_OFF);
> 
> Is this syscon register used only by Display Port PHY? Better to use
> regmap_update API?

Rockchip's GRF syscon registers use what gets called "Hiword-mask", so when 
writing you actually need to set the write-enable bit (x+16, like 
GRF_EDP_PHY_SIDDQ_WRITE_EN here) if you want to set bit x. No other bits get 
affected by this.


Heiko
