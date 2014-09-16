From: karlp@tweak.net.au (Karl Palsson)
Date: Tue, 16 Sep 2014 09:49:45 +0000
Subject: [PATCH v2 5/7] clk: rockchip: add new clock-type for the cpuclk
In-Reply-To: <CAD=FV=XiPd7AFj1YCb4WdR5FU2YQ4tDbZ2FYMz3MFDu8wyKawQ@mail.gmail.com>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-6-git-send-email-heiko@sntech.de>
 <CAD=FV=XJEL1QDRHUGL=g5BKEhLWve0uUko7ZH=dM7btWkU4+1w@mail.gmail.com>
 <CAD=FV=XiPd7AFj1YCb4WdR5FU2YQ4tDbZ2FYMz3MFDu8wyKawQ@mail.gmail.com>
Message-ID: <20140916094945.GA5165@palmtree.beeroclock.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:49:01PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 15, 2014 at 4:58 PM, Doug Anderson <dianders@chromium.org> wrote:
> > Heiko,
> >
> > On Fri, Sep 12, 2014 at 3:30 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> >> When changing the armclk on Rockchip SoCs it is supposed to be reparented
> >> to an alternate parent before changing the underlying pll and back after
> >> the change. Additionally there exist clocks that are very tightly bound to
> >> the armclk whose divider values are set according to the armclk rate.
> >>
> >> Add a special clock-type to handle all that. The rate table and divider
> >> values will be supplied from the soc-specific clock controllers.
> >>
> >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >> ---
> >>  drivers/clk/rockchip/Makefile  |   1 +
> >>  drivers/clk/rockchip/clk-cpu.c | 316 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/clk/rockchip/clk.c     |  20 +++
> >>  drivers/clk/rockchip/clk.h     |  36 +++++
> >>  4 files changed, 373 insertions(+)
> >>  create mode 100644 drivers/clk/rockchip/clk-cpu.c
> >>
> >> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> >> index ee6b077..bd8514d 100644
> >> --- a/drivers/clk/rockchip/Makefile
> >> +++ b/drivers/clk/rockchip/Makefile
> >> @@ -5,6 +5,7 @@
> >>  obj-y  += clk-rockchip.o
> >>  obj-y  += clk.o
> >>  obj-y  += clk-pll.o
> >> +obj-y  += clk-cpu.o
> >>  obj-$(CONFIG_RESET_CONTROLLER) += softrst.o
> >>
> >>  obj-y  += clk-rk3188.o
> >> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
> >> new file mode 100644
> >> index 0000000..b8382b1
> >> --- /dev/null
> >> +++ b/drivers/clk/rockchip/clk-cpu.c
> >> @@ -0,0 +1,316 @@
> >> +/*
> >> + * Copyright (c) 2014 MundoReader S.L.
> >> + * Author: Heiko Stuebner <heiko@sntech.de>
> >> + *
> >> + * based on clk/samsung/clk-cpu.c
> >> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> >> + * Author: Thomas Abraham <thomas.ab@samsung.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This file contains the utility function to register CPU clock for Samsung
> >> + * Exynos platforms. A CPU clock is defined as a clock supplied to a CPU or a

It might be based on the clk/samsung/clk-cpu.c, as you mentioned above, but
_this_  file doesn't contain samsung exynos code...

Cheers,
Karl P
