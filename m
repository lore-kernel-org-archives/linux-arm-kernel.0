From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 22 Feb 2017 23:11:49 +0100
Subject: [linux-sunxi] Re: [PATCH 2/8] clk: sunxi-ng: add support for DE2
 CCU
In-Reply-To: <20170222231754.Hm6O1qAk@smtp3j.mail.yandex.net>
References: <20170222231754.Hm6O1qAk@smtp3j.mail.yandex.net>
Message-ID: <2861790.WmLcjTgm5a@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne sreda, 22. februar 2017 ob 21:17:29 CET je Icenowy Zheng napisal(a):
> 2017?2?23? 03:09? Maxime Ripard <maxime.ripard@free-electrons.com>???
> 
> > Hi,
> > 
> > On Wed, Feb 22, 2017 at 11:18:48PM +0800, Icenowy Zheng wrote:
> > > +config SUNXI_DE2_CCU
> > > + bool "Support for the Allwinner SoCs DE2 CCU"
> > > + select SUNXI_CCU_DIV
> > > + select SUNXI_CCU_GATE
> > > + default n
> > 
> > This is already the default.
> 
> P.S. I in fact want it default DRM_SUN4I_DE2.
> 
> > > +
> > >
> > >  endif
> > >
> > > diff --git a/drivers/clk/sunxi-ng/Makefile
> > > b/drivers/clk/sunxi-ng/Makefile
> > > index 6feaac0c5600..1d36c40384a6 100644
> > > --- a/drivers/clk/sunxi-ng/Makefile
> > > +++ b/drivers/clk/sunxi-ng/Makefile
> > > @@ -28,3 +28,4 @@ obj-$(CONFIG_SUN8I_V3S_CCU) += ccu-sun8i-v3s.o
> > >
> > >  obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80.o
> > >  obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-de.o
> > >  obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-usb.o
> > >
> > > +obj-$(CONFIG_SUNXI_DE2_CCU) += ccu-sunxi-de2.o
> > 
> > sun8i-de2 please
> 
> It also exists in sun50is.

Usual approach is to name it after the family where the IP block first 
appeared.

Regards,
Jernej

> 
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-de2.c
> > > b/drivers/clk/sunxi-ng/ccu-sunxi-de2.c new file mode 100644
> > > index 000000000000..4259c145d5da
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi-ng/ccu-sunxi-de2.c
> > > @@ -0,0 +1,204 @@
> > > +/*
> > > + * Copyright (c) 2016 Chen-Yu Tsai. All rights reserved.
> > 
> > Wrong author?
> 
> Oh I copied ccu-sun9i-a80-de.c...
> 
> > > + *
> > > + * This software is licensed under the terms of the GNU General Public
> > > + * License version 2, as published by the Free Software Foundation, and
> > > + * may be copied, distributed, and modified under those terms.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > > +
> > > +#include "ccu_common.h"
> > > +#include "ccu_div.h"
> > > +#include "ccu_gate.h"
> > > +#include "ccu_reset.h"
> > > +
> > > +#include "ccu-sunxi-de2.h"
> > > +
> > > +static SUNXI_CCU_GATE(bus_mixer0_clk, "bus-mixer0", "bus-de",
> > > +       0x04, BIT(0), 0);
> > > +static SUNXI_CCU_GATE(bus_mixer1_clk, "bus-mixer1", "bus-de",
> > > +       0x04, BIT(1), 0);
> > > +static SUNXI_CCU_GATE(bus_wb_clk, "bus-wb", "bus-de",
> > > +       0x04, BIT(2), 0);
> > > +
> > > +static SUNXI_CCU_GATE(mixer0_clk, "mixer0", "mixer0-div",
> > > +       0x00, BIT(0), CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_GATE(mixer1_clk, "mixer1", "mixer1-div",
> > > +       0x00, BIT(1), CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_GATE(wb_clk, "wb", "wb-div",
> > > +       0x00, BIT(2), CLK_SET_RATE_PARENT);
> > > +
> > > +static SUNXI_CCU_M(mixer0_div_clk, "mixer0-div", "de", 0x0c, 0, 4,
> > > +    CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_M(mixer1_div_clk, "mixer1-div", "de", 0x0c, 4, 4,
> > > +    CLK_SET_RATE_PARENT);
> > > +static SUNXI_CCU_M(wb_div_clk, "wb-div", "de", 0x0c, 8, 4,
> > > +    CLK_SET_RATE_PARENT);
> > > +
> > > +static struct ccu_common *sunxi_de2_clks[] = {
> > > + &mixer0_clk.common,
> > > + &mixer1_clk.common,
> > > + &wb_clk.common,
> > > +
> > > + &bus_mixer0_clk.common,
> > > + &bus_mixer1_clk.common,
> > > + &bus_wb_clk.common,
> > > +
> > > + &mixer0_div_clk.common,
> > > + &mixer1_div_clk.common,
> > > + &wb_div_clk.common,
> > > +};
> > > +
> > > +static struct clk_hw_onecell_data sunxi_de2_hw_clks = {
> > > + .hws = {
> > > + [CLK_MIXER0] = &mixer0_clk.common.hw,
> > > + [CLK_MIXER1] = &mixer1_clk.common.hw,
> > > + [CLK_WB] = &wb_clk.common.hw,
> > > +
> > > + [CLK_BUS_MIXER0] = &bus_mixer0_clk.common.hw,
> > > + [CLK_BUS_MIXER1] = &bus_mixer1_clk.common.hw,
> > > + [CLK_BUS_WB] = &bus_wb_clk.common.hw,
> > > +
> > > + [CLK_MIXER0_DIV] = &mixer1_div_clk.common.hw,
> > > + [CLK_MIXER1_DIV] = &mixer0_div_clk.common.hw,
> > > + [CLK_WB_DIV] = &wb_div_clk.common.hw,
> > > + },
> > > + .num = CLK_NUMBER,
> > > +};
> > > +
> > > +static struct ccu_reset_map sun8i_a83t_de2_resets[] = {
> > > + [RST_MIXER0] = { 0x08, BIT(0) },
> > > + /*
> > > + * For A83T, H3 and R40, mixer1 reset line is shared with wb, so
> > > + * only RST_WB is exported here.
> > > + */
> > > + [RST_WB] = { 0x08, BIT(2) },
> > > +};
> > > +
> > > +static struct ccu_reset_map sun50i_a64_de2_resets[] = {
> > > + [RST_MIXER0] = { 0x08, BIT(0) },
> > > + [RST_MIXER1] = { 0x08, BIT(1) },
> > > + [RST_WB] = { 0x08, BIT(2) },
> > > +};
> > > +
> > > +static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
> > > + .ccu_clks = sunxi_de2_clks,
> > > + .num_ccu_clks = ARRAY_SIZE(sunxi_de2_clks),
> > > +
> > > + .hw_clks = &sunxi_de2_hw_clks,
> > > +
> > > + .resets = sun8i_a83t_de2_resets,
> > > + .num_resets = ARRAY_SIZE(sun8i_a83t_de2_resets),
> > > +};
> > > +
> > > +static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
> > > + .ccu_clks = sunxi_de2_clks,
> > > + .num_ccu_clks = ARRAY_SIZE(sunxi_de2_clks),
> > > +
> > > + .hw_clks = &sunxi_de2_hw_clks,
> > > +
> > > + .resets = sun50i_a64_de2_resets,
> > > + .num_resets = ARRAY_SIZE(sun50i_a64_de2_resets),
> > > +};
> > > +
> > > +static int sunxi_de2_clk_probe(struct platform_device *pdev)
> > > +{
> > > + struct resource *res;
> > > + struct clk *bus_clk;
> > > + struct reset_control *rstc;
> > > + void __iomem *reg;
> > > + const struct sunxi_ccu_desc *ccu_desc;
> > > + int ret;
> > > +
> > > + ccu_desc = of_device_get_match_data(&pdev->dev);
> > > + if (!ccu_desc)
> > > + return -EINVAL;
> > > +
> > > + res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > + reg = devm_ioremap_resource(&pdev->dev, res);
> > > + if (IS_ERR(reg))
> > > + return PTR_ERR(reg);
> > > +
> > > + bus_clk = devm_clk_get(&pdev->dev, "bus");
> > > + if (IS_ERR(bus_clk)) {
> > > + ret = PTR_ERR(bus_clk);
> > > + if (ret != -EPROBE_DEFER)
> > > + dev_err(&pdev->dev, "Couldn't get bus clk: %d\n", ret);
> > > + return ret;
> > > + }
> > > +
> > > + rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > > + if (IS_ERR(rstc)) {
> > > + ret = PTR_ERR(bus_clk);
> > > + if (ret != -EPROBE_DEFER)
> > > + dev_err(&pdev->dev,
> > > + "Couldn't get reset control: %d\n", ret);
> > > + return ret;
> > > + }
> > > +
> > > + /* The bus clock needs to be enabled for us to access the registers */
> > > + ret = clk_prepare_enable(bus_clk);
> > > + if (ret) {
> > > + dev_err(&pdev->dev, "Couldn't enable bus clk: %d\n", ret);
> > > + return ret;
> > > + }
> > 
> > That looks inefficient if none of the clocks are enabled. Maybe you
> > can use CLK_OPS_PARENT_ENABLE?
> 
> Don't know about it... it's a simplified version of this func of A80 de ccu.
> > Thanks,
> > Maxime
> > 
> > --
> > Maxime Ripard, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe at googlegroups.com. For more options, visit
> > https://groups.google.com/d/optout.
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
