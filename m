From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 09 Dec 2015 09:57:40 +0100
Subject: [PATCH 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <20151209085021.GF941@shlinux2>
References: <1449538670-7954-1-git-send-email-peter.chen@freescale.com>
 <1449538670-7954-2-git-send-email-peter.chen@freescale.com>
 <CANLsYkwfLSQKEw1a-Y_dguu-yutnTeQv73cMxPFooMjzTv4n1A@mail.gmail.com>
 <20151209085021.GF941@shlinux2>
Message-ID: <1449651460.3118.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 09.12.2015, 16:50 +0800 schrieb Peter Chen:
> On Tue, Dec 08, 2015 at 08:36:00AM -0700, Mathieu Poirier wrote:
> > On 7 December 2015 at 18:37, Peter Chen <peter.chen@freescale.com> wrote:
> > > +
> > > +       if (dev->of_node) {
> > > +               struct device_node *node = dev->of_node;
> > > +
> > > +               hub_data->clk = devm_clk_get(dev, "external_clk");
> > > +               if (IS_ERR(hub_data->clk)) {
> > > +                       dev_dbg(dev, "Can't get external clock: %ld\n",
> > > +                                       PTR_ERR(hub_data->clk));
> > > +               }
> > 
> > Is the intended behaviour to keep going here event when there is an
> > error?  Can the "hub_data" really work without a clock?
> 
> Yes, some HUB may work with fixed 24M OSC at the board, but they need to
> reset through external IO, so the clock is not need at this case, but
> reset pin is mandatory.
> 
If the hub always requires a clock it must not be optional. If you have
a fixed 24MHz clock on board add this to the DT as a fixed-clock and use
it as an input to the hub.

> > > +       }
> > > +
> > > +       if (gpiod_reset) {
> > > +               /* Sanity check */
> > > +               if (duration_us > 1000000)
> > > +                       duration_us = 50;
> > > +               usleep_range(duration_us, duration_us + 100);
> > > +               gpiod_set_value(gpiod_reset, reset_pol ? 0 : 1);
> > 
> > What are these hard-coded values?  Shouldn't this be taken from the
> > DT?  If not then some comments explaining the values would be
> > appreciated.
> 
> Yes, I did it wrongly, thanks.
> 
> > > diff --git a/include/linux/usb/generic_onboard_hub.h b/include/linux/usb/generic_onboard_hub.h
> > > new file mode 100644
> > > index 0000000..1b70ccc
> > > --- /dev/null
> > > +++ b/include/linux/usb/generic_onboard_hub.h
> > > @@ -0,0 +1,11 @@
> > > +#ifndef __LINUX_USB_GENERIC_HUB_H
> > > +#define __LINUX_USB_GENERIC_HUB_H
> > > +
> > > +struct usb_hub_generic_platform_data {
> > > +       int gpio_reset;
> > > +       int gpio_reset_polarity;
> > > +       int gpio_reset_duration_us;
> > > +       struct clk *ext_clk;
> > > +};
> > 
> > Please document this structure in accordance with kernel documentation
> > standards.
> > 
> 
> Thanks, it should be.
> 

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
