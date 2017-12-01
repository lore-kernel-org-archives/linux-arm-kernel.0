From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Dec 2017 08:39:03 -0800
Subject: [PATCH v3 2/3] clk: meson-axg: add clock controller drivers
In-Reply-To: <d2b58c06-93dc-4368-501e-4b8bdc9a4c34@amlogic.com>
References: <20171128125330.363-1-yixun.lan@amlogic.com>
 <20171128125330.363-3-yixun.lan@amlogic.com>
 <20171129193433.GA19419@codeaurora.org>
 <d2b58c06-93dc-4368-501e-4b8bdc9a4c34@amlogic.com>
Message-ID: <20171201163903.GF19419@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Yixun Lan wrote:
> Hi Stephen
> 
> On 11/30/17 03:34, Stephen Boyd wrote:
> > On 11/28, Yixun Lan wrote:
> >> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> >> new file mode 100644
> >> index 000000000000..51c5b4062715
> >> --- /dev/null
> >> +++ b/drivers/clk/meson/axg.c
> >> @@ -0,0 +1,948 @@
> >> +/*
> >> + * AmLogic Meson-AXG Clock Controller Driver
> >> + *
> >> + * Copyright (c) 2016 Baylibre SAS.
> >> + * Author: Michael Turquette <mturquette@baylibre.com>
> >> + *
> >> + * Copyright (c) 2017 Amlogic, inc.
> >> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0+
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/init.h>
> >> +
> >> +#include "clkc.h"
> >> +#include "axg.h"
> >> +
> >> +static DEFINE_SPINLOCK(clk_lock);
> > 
> > meson_axg_clk_lock?
> > 
> em... I'd leave it unchanged
> 
> because the spinlock will be used at macro MESON_GATE() [1] which
> defined at drivers/clk/meson/clkc.h, and it assume using the generic
> name 'clk_lock', change name will break the code..
> 
> and besides it's already defined as static, so I see no problem here

The problem is lockdep debugging and ctags/grep on the source
code. clk_lock is very generic when it should be more specific so
we can find this lock later on from a lockdep report with a
simple search of the code.

Maybe make another patch to rename it to meson_clk_lock so the
macro doesn't have to change too much, and we get it slightly
more unique. Looks like v4l2 also has a clk_lock.

> 
> >> +};
> >> +
> >> +static int axg_clkc_probe(struct platform_device *pdev)
> >> +{
> >> +	const struct clkc_data *clkc_data;
> >> +	void __iomem *clk_base;
> >> +	int ret, clkid, i;
> >> +	struct device *dev = &pdev->dev;
> >> +
> >> +	clkc_data = of_device_get_match_data(&pdev->dev);
> >> +	if (!clkc_data)
> >> +		return -EINVAL;
> >> +
> >> +	/*  Generic clocks and PLLs */
> >> +	clk_base = of_iomap(dev->of_node, 0);
> > 
> > Use platform device APIs for ioremapping?
> > 
> I assume you are referring to 'platform_get_resource +
> devm_ioremap_resource' ?
> 
> the idea sounds good to me.

Yes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
