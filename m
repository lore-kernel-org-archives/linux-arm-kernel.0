From: dsd@laptop.org (Daniel Drake)
Date: Thu, 8 Aug 2013 11:17:16 -0600
Subject: [PATCH RESEND 1/2] clk: mmp: use global clock lock
In-Reply-To: <CAN1soZw7_3X5pdvp2M-Wp69=7Cr9bp4DDD0qMps4XT6u1s_9mQ@mail.gmail.com>
References: <20130716181029.C08D8FAAF3@dev.laptop.org>
 <CAN1soZw7_3X5pdvp2M-Wp69=7Cr9bp4DDD0qMps4XT6u1s_9mQ@mail.gmail.com>
Message-ID: <CAMLZHHQNtJM40Po1pj7NSfFc01BDVpeeUOgQwhD25VJ=4tBc1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry for the late response.

On Thu, Jul 25, 2013 at 8:42 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Currently lock is defined in pxa910, pxa168 & mmp2 clock driver. Only
> one of these driver
> could be active in real system. So I can't see any benefit to use the
> shared clock lock among
> these three drivers.

As far as I can see, my patch does not attempt to share the clock
between those 3 platforms. Instead it only affects the mmp2 case.

The mmp2 case does *already* have a shared clock lock defined in
static bindings (drivers/clk/mmp/clk-mmp2.c):
static DEFINE_SPINLOCK(clk_lock);

This lock is shared between MMP apmu and apbc drivers.

My patch simply moves the location of where the shared clk_lock is
defined so that it can be additionally used by dynamic DT-driven
bindings. If you take a quick glance at the next patch, "clk: mmp: add
support for DT-defined clocks" the reasoning behind this change is
hopefully even clearer.

Thanks
Daniel
