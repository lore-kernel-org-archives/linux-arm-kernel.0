From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 16:04:50 -0700
Subject: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL and
 DIV values
In-Reply-To: <20180509043205.GA57916@hak8or>
References: <20180429190111.14247-1-marcin@ziemianowicz.com>
 <20180430075847.29706679@bbrezillon> <20180509043205.GA57916@hak8or>
Message-ID: <152642549058.237094.805373991669238611@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Marcin Ziemianowicz (2018-05-08 21:32:05)
> On Mon, Apr 30, 2018 at 07:58:47AM +0200, Boris Brezillon wrote:
> > On Sun, 29 Apr 2018 15:01:11 -0400
> > Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:
> > 
> > > When a USB device is connected to the USB host port on the SAM9N12 then
> > > you get "-62" error which seems to indicate USB replies from the device
> > > are timing out. Based on a logic sniffer, I saw the USB bus was running
> > > at half speed.
> > > 
> > > The PLL code uses cached MUL and DIV values which get set in set_rate()
> > > and applied in prepare(), but the recalc_rate() function instead
> > > queries the hardware instead of using these cached values. Therefore,
> > > if recalc_rate() is called between a set_rate() and prepare(), the
> > > wrong frequency is calculated and later the USB clock divider for the
> > > SAM9N12 SOC will be configured for an incorrect clock.
> > > 
> > > In my case, the PLL hardware was set to 96 Mhz before the OHCI
> > > driver loads, and therefore the usb clock divider was being set
> > > to /2 even though the OHCI driver set the PLL to 48 Mhz.
> > > 
> > > As an alternative explanation, I noticed this was fixed in the past by
> > > 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> > > driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> > > at91: make use of syscon/regmap internally").
> > > 
> > > Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> > 
> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Apologies for being a bother, but since it's been a bit over a week,
> should I do something with this now that it has been ACK'd? I was thinking
> I would see it somewhere on the git group repo but am not seeing it there
> yet. Googling says that there is a "review cycle" for some maintainers, but
> I am not clear on if I need to initiate it manually or anything of the sort.
> 

I'll apply it to clk-next. Should appear in linux-next in day or so.
