From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 May 2013 19:35:48 +0300
Subject: MUSB multiplatform work?
In-Reply-To: <201305271702.09203.arnd@arndb.de>
References: <201305271702.09203.arnd@arndb.de>
Message-ID: <20130528163548.GC28253@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 27, 2013 at 05:02:09PM +0200, Arnd Bergmann wrote:
> Hi Felipe,
> 
> We've gone through remaining work items for getting the ARM kernel
> to full multiplatform support again, and MUSB came up. I'm sure you
> have your own thoughts on this, but I'd like to know if there is
> already a plan in place.
> 
> From what I can see, the driver in PIO mode should almost work
> on multiple platforms, but there are a couple of compile-time
> dependencies in it that need to be turned into run-time conditionals.
> In particular the TUSB version seem sufficiently different that
> it needs some extra work to be a true run-time option.

yeah, TUSB layer is quite messy, all the others should be doable though.

> The DMA support as far as I can tell has never been intended to
> be usable in a multiplatform setup, but that also seems doable.

we're looking into dmaengine for that but will take a lot of work to
have something usable.

> Looking just at the #ifdef statements in the driver, I found
> that the following things need to be addressed:
> 
> * abstract musb_write_fifo and musb_read_fifo into callbacks
> * move fifo_mode setting into glue driver for runtime selection

for the fifo mode, I'd rather detect the size of the internal fifo and
configure it dynamically based on that plus number of endpoints
configured in the IP.

> * turn TUSB compile-time switches into run-time conditionals
> * turn musb_ep_select into run-time switch
> * make is_dma_capable/is_cppi_enabled/tusb_dma_omap run-time conditionals

those can be remove, actually. Back at Nokia we did a huge cleanup on
the DMA programming part, it can be very simple with no ifdefs at all,
just needs someone to put the work and test on all platforms.

> * abtract dma_controller_create/destroy interface
> 
> Aside from this, a recent discussion with Maxime has brought up
> that the Allwinner A1x platform (mach-sunxi) contains an MUSB variant
> that is currently used with an independently implemented device driver,
> see https://github.com/linux-sunxi/linux-sunxi/tree/sunxi-3.0/drivers/usb/sun5i_usb
> I wonder if you have any insight on how that can be integrated into
> musb, or whether it is likely to be a compatible version to start with.

just write a glue layer, should be as easy as that :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/7c6e6c26/attachment-0001.sig>
