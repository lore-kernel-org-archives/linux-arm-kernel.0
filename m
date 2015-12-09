From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 10:10:51 +0100
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <1449651460.3118.22.camel@pengutronix.de>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <20151209085021.GF941@shlinux2> <1449651460.3118.22.camel@pengutronix.de>
Message-ID: <13697561.KqG59a0ceW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 09:57:40 Lucas Stach wrote:
> Am Mittwoch, den 09.12.2015, 16:50 +0800 schrieb Peter Chen:
> > On Tue, Dec 08, 2015 at 08:36:00AM -0700, Mathieu Poirier wrote:
> > > On 7 December 2015 at 18:37, Peter Chen <peter.chen@freescale.com> wrote:
> > > > +
> > > > +       if (dev->of_node) {
> > > > +               struct device_node *node = dev->of_node;
> > > > +
> > > > +               hub_data->clk = devm_clk_get(dev, "external_clk");
> > > > +               if (IS_ERR(hub_data->clk)) {
> > > > +                       dev_dbg(dev, "Can't get external clock: %ld\n",
> > > > +                                       PTR_ERR(hub_data->clk));
> > > > +               }
> > > 
> > > Is the intended behaviour to keep going here event when there is an
> > > error?  Can the "hub_data" really work without a clock?
> > 
> > Yes, some HUB may work with fixed 24M OSC at the board, but they need to
> > reset through external IO, so the clock is not need at this case, but
> > reset pin is mandatory.
> > 
> If the hub always requires a clock it must not be optional. If you have
> a fixed 24MHz clock on board add this to the DT as a fixed-clock and use
> it as an input to the hub.

I think it's fine to make the clock optional in the sense that you only
need to list non-fixed clocks that have to be enabled and or controlled.

Which reminds me, should the driver call clk_set_rate()? It currently
doesn't, but other machines might need that.

	Arnd
