From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Aug 2012 10:30:19 +0000
Subject: [PATCH 2/5] clk: mmp: add clock definition for pxa168
In-Reply-To: <CADApbegvdRQ5swDrO-Y631K4AhsTigAG4=Mm82mT-smSA7XzJw@mail.gmail.com>
References: <1343716792-10399-1-git-send-email-xiechao.mail@gmail.com>
 <201207311154.42866.arnd@arndb.de>
 <CADApbegvdRQ5swDrO-Y631K4AhsTigAG4=Mm82mT-smSA7XzJw@mail.gmail.com>
Message-ID: <201208021030.19986.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 August 2012, Chao Xie wrote:
> > #define APBC_RTC       0x28
> >
> > apbc_clks[rtc_clk] = mmp_clk_register_apbc(rtc_clk, clk32k, APBC_RTC, 10, APBC_POWER_CTRL, mmp_clk_lock);
> > clk_register_clkdev(apbc_clks[rtc_clk], NULL, "sa1100-rtc");
> >
> >         Arnd
> >
> hi
> I would like to keep the mmp_clk_register_apbc to receive the "reg
> base" not "reg offset".
> It will be aligned with other kind of clock register APIs.
> To read out APBC base register from device tree can be added at the
> clock-pxa168.c, and it can map the registers and pass to the
> mmp_clk_register_apbc.

Right, my mistake.

The above should have been something like

#define APBC_RTC       0x28
apbc_clks[rtc_clk] = mmp_clk_register_apbc(rtc_clk, clk32k, clock_base + APBC_RTC, 10, APBC_POWER_CTRL, mmp_clk_lock);
clk_register_clkdev(apbc_clks[rtc_clk], NULL, "sa1100-rtc");

instead, with clock_base pointing to the __iomem token for the clock controller.

> Now, i have talked to Haojian who is doing device tree maintainer in
> pxa/mmp. This kind of support is not added.
> I suggest that after device tree support in clock can be added later
> after other functionality of the clock framework is fine.

You can do device tree support as a second step, but in this first step, you
should already start using ioremap to get the virtual address of the
clock controller, rather than hardcoding it.

	Arnd
