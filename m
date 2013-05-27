From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 May 2013 17:02:09 +0200
Subject: MUSB multiplatform work?
Message-ID: <201305271702.09203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

We've gone through remaining work items for getting the ARM kernel
to full multiplatform support again, and MUSB came up. I'm sure you
have your own thoughts on this, but I'd like to know if there is
already a plan in place.

>From what I can see, the driver in PIO mode should almost work
on multiple platforms, but there are a couple of compile-time
dependencies in it that need to be turned into run-time conditionals.
In particular the TUSB version seem sufficiently different that
it needs some extra work to be a true run-time option.

The DMA support as far as I can tell has never been intended to
be usable in a multiplatform setup, but that also seems doable.
Looking just at the #ifdef statements in the driver, I found
that the following things need to be addressed:

* abstract musb_write_fifo and musb_read_fifo into callbacks
* move fifo_mode setting into glue driver for runtime selection
* turn TUSB compile-time switches into run-time conditionals
* turn musb_ep_select into run-time switch
* make is_dma_capable/is_cppi_enabled/tusb_dma_omap run-time conditionals
* abtract dma_controller_create/destroy interface

Aside from this, a recent discussion with Maxime has brought up
that the Allwinner A1x platform (mach-sunxi) contains an MUSB variant
that is currently used with an independently implemented device driver,
see https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.0/drivers/usb/sun5i_usb
I wonder if you have any insight on how that can be integrated into
musb, or whether it is likely to be a compatible version to start with.

	Arnd
