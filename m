From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 27 Jul 2018 09:41:40 -0700
Subject: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
In-Reply-To: <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
 <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
 <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
Message-ID: <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Yixun Lan (2018-07-27 07:52:23)
> HI Stephen:
> 
> On 07/26/2018 11:20 PM, Stephen Boyd wrote:
> > Quoting Yixun Lan (2018-07-12 14:12:44)
> >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> >> new file mode 100644
> >> index 000000000000..36c4c7cd69a6
> >> --- /dev/null
> >> +++ b/drivers/clk/meson/mmc-clkc.c
> >> @@ -0,0 +1,367 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Amlogic Meson MMC Sub Clock Controller Driver
> >> + *
> >> + * Copyright (c) 2017 Baylibre SAS.
> >> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> >> + *
> >> + * Copyright (c) 2018 Amlogic, inc.
> >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> > 
> > Is this include used?
> > 
> this is needed by clk_get_rate()
> see drivers/clk/meson/mmc-clkc.c:204

Hmm ok. That's unfortunate.

> 
> > 
> >> +       init.num_parents = 1;
> >> +
> >> +       clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> >> +       if (IS_ERR(clk))
> >> +               dev_err(dev, "Core %s clock registration failed\n", suffix);
> >> +
> >> +       kfree(parent);
> >> +       return clk;
> >> +}
> >> +
> >> +static int mmc_clkc_probe(struct platform_device *pdev)
> >> +{
> >> +       struct clk_hw_onecell_data *onecell_data;
> >> +       struct device *dev = &pdev->dev;
> >> +       struct mmc_clkc_data *data;
> >> +       struct regmap *map;
> >> +       struct clk_regmap *mux, *div, *core, *rx, *tx;
> >> +
> >> +       data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> > 
> > This cast is unnecessary. Pleas remove.
> > 
> Ok, I will try to fix in next version
> 
> 
> this was trying to silence the ?const? cast warning [1]
> I could make a 'const struct mmc_clkc_data *data' declare, but need to
> fix further cast warning issue..
> 
> 
> [1] drivers/clk/meson/mmc-clkc.c: In function ?mmc_clkc_probe?:
> drivers/clk/meson/mmc-clkc.c:302:7: warning: assignment discards ?const?
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>   data = of_device_get_match_data(dev);
>        ^

Yes. Casting away const is a bad idea.
