From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 19:26:44 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
Message-ID: <20100713182644.GC30142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 01:00:51PM +0200, Linus Walleij wrote:
> In the U300 (maybe the U8500 as well, I don't know OTOH) the
> APB pclk and e.g. SSPCLK is simply just wired together and
> connected to the same clock terminal. This means that currently
> the PCLK is toggled on/off in unison with the SSPCLK all the time
> already, and it's working.

That means you want to alias the device specific apb_pclk to the same
struct clk as (eg) the device's sspclk - which means that when the
driver wants either PCLK or SSPCLK to be on, the bit to enable them
will be turned on.

> Since that works, it means that we can likely insert
> amba_bus_clk_[disable|enable] at the same sites that we have
> this in the current code for the external clocks at the same time,
> atleast for pl011, pl022 and pl180.

Almost - but there's a few corner cases.  Basically, what I think you'll
need for pl011 is:
1. add an amba_bus_clk_disable() at the end of the successful probe
   function
2. add amba_bus_clk_enable() at the beginning of the remove function.
3. add amba_bus_clk_enable()/amba_bus_clk_disable() around each of the
   suspend(), resume(), pl011_console_write(), and
   pl011_console_get_options() functions.
4. amba_bus_clk_enable() at the start of the startup method.
5. amba_bus_clk_disable() at the end of the shutdown method.

Most of these do tie up with existing clk_enable()s, but there are some
additional places you'd need to enable the pclk because of register
accesses.
