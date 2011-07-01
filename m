From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 11:25:51 +0200
Subject: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for imx23/imx28
In-Reply-To: <4E0D7CE9.2030209@freescale.com>
References: <1309406028-2924-1-git-send-email-b32955@freescale.com>
	<20110701060356.GA27039@pengutronix.de>
	<4E0D7CE9.2030209@freescale.com>
Message-ID: <201107011125.51581.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011 09:53:13 Huang Shijie wrote:
> >> If you really want to call out obsceneties, how about the fact that this
> >> driver comes with an 805 line patch to add a HAL for a single chip!
> >>
> >> Such abstractions should not be introduced as long as there is only
> >> a single instance of the hardware.
> > If I understood correctly, most if not all upcoming i.MX will have the GPMI
> > (mx50, mx6). Huang, do you already have a draft for the mx50-hal?
> >
> I have finished the code for mx50's GPMI.
> And I am coding for the MX6's GPMI recently.

Ok.

> I need a separate mx50-hal (or mx60-hal) to make the code tidy.
> The MX50 and mx60 support ONFI NAND and TOGGLE nand(which mx23/mx28 do 
> not support),
> they need a long code to initialize the TIMING register. What's more, 
> the READ/WRITE functions
> are different from the mx23/mx28.
> 
> Frankly speaking, I can merge the mxs-hal.c file to the gpmi-nfc.c, but 
> don't you think it too
> messy?

If you already have the code for the other SoCs, it's fine to have an
abstraction. From reading your patches that were specifically targetted
at mxs, that was not clear.

After a very brief look at the driver, my impression is that your layering
is upside-down though:

You have a "main" driver that registers to all devices and then pulls
in hardware specific bits. What you should have instead is a "library"
driver for the common code that provides all the common functionality
as exported functions, and individual drivers for each SoC type that
each register a platform_driver for one device id and use the functions
from the common module.

I don't know how hard it would be to retrofit that model, and I'm not
asking you to do it, unless other people feel strongly about it.
However, I think it would make your life easier when maintaining the
driver in the future. There are multiple advantages to that:

* You would not need a HAL. For your information, that term causes strong
  negative associations with many Linux developers. To us, the kernel
  drivers themselves are the hardware abstraction, you don't need another
  one.

* It's more easy to extend to multiple levels of libraries. E.g. you could
  have one module for stuff that is common between i.MX5 and i.MX6 but
  not i.MX3, and make the later drivers use both libraries.

* It gets rid of the need for #ifdef in the common driver module.

* It becomes very easy to override one function just for a specific
  instance of the hardware, while everything else uses a common version
  from the library.

	Arnd
