From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Jul 2015 12:17:23 +0200
Subject: [PATCH 7/7] clk: sunxi: Add a simple gates driver
In-Reply-To: <CAGb2v6517qCXmNkYihnfBmc5fL7bqTDOQwedNYjq+p2Mg45+gQ@mail.gmail.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
 <1437945270-32014-8-git-send-email-maxime.ripard@free-electrons.com>
 <20150727202648.GB14521@codeaurora.org>
 <CAGb2v6517qCXmNkYihnfBmc5fL7bqTDOQwedNYjq+p2Mg45+gQ@mail.gmail.com>
Message-ID: <20150730101723.GL2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 03:55:17PM +0800, Chen-Yu Tsai wrote:
> On Tue, Jul 28, 2015 at 4:26 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 07/26, Maxime Ripard wrote:
> >> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
> >> new file mode 100644
> >> index 000000000000..1a3963a8a686
> >> --- /dev/null
> >> +++ b/drivers/clk/sunxi/clk-simple-gates.c
> >> @@ -0,0 +1,159 @@
> >> +/*
> >> + * Copyright 2015 Maxime Ripard
> >> + *
> >> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> >> +
> 
> I'm guessing the following were copied from clk-sunxi.c.
> 
> >> +#include <linux/clk-provider.h>
> >> +#include <linux/clkdev.h>
> >
> > Is this used?
> 
> clk_register_clkdev() is not used in this file, so not needed.
> 
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/reset-controller.h>
> >
> > Is this used?
> 
> A remnant of the USB clocks, which has been moved to clk-usb.c.
> 
> Not needed here nor in clk-sunxi.c.
> 
> >> +#include <linux/spinlock.h>
> >> +#include <linux/log2.h>
> >
> > Is this used?
> 
> This is only used for clock factor calculation. Not applicable in
> clk-simple-gates.c, so no.

You're right, we don't need any of these...

> >> +static DEFINE_SPINLOCK(gates_lock);
> >> +
> > [...]
> >> +
> >> +static const int sun4i_a10_ahb_critical_clocks[] __initdata = {
> >
> > Shouldn't it be __initconst ?
> 
> Not sure why our critical clocks lists are __initdata...

Why shouldn't it be?

CLK_OF_DECLARE callbacks only run at of_clk_init time, which is way
before the init memory is discarded.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/f0ffccd0/attachment-0001.sig>
