From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 17:42:26 +0200
Subject: [PATCH 00/11] MSM DT based multi-platform support
In-Reply-To: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201306191742.26491.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Stephen Boyd wrote:
> This patchset allows me to compile and run the DT based MSM
> platforms in the multi-platform ARM kernel. This is built on
> top of a couple patches I've sent out already (specifically
> the debug_ll patch series and the clocksource_of conversion)
> as well a patch from Rohit that didn't seem to make it into 
> MSM's for-next branch.

Very nice!

> There is one problem though, the last two patches cause compile
> failures if you turn on MSM's sdcc or USB_OTG driver. It seems
> that the sdcc driver depends on the clk_reset() API and the custom
> DMA interface provided by mach layers. And the USB_OTG driver depends
> on clk_reset.
> 
> The simplest solution is to make these two drivers depend on the
> non-dt based MSM support so that they can't be compiled in the
> multi-platform config. Otherwise, we'll need to replace the clk_reset()
> calls with the new reset controller API, but doing that would
> require us to convert all MSM platforms over to devicetree or
> we'll need to add support to the reset controller API for non-DT based
> controllers. Even with that, the sdcc driver uses custom DMA things
> so we may need to put that all behind some #ifdef.

The msm_serial_hs driver also seems to require the custom DMA
interface.

I think for the DMA stuff, the solution is clearly to move that
driver to use the dmaengine API, wich I assume you are already
planning to do anyway. Do you have a time line for that?

For the clk_reset interface, maybe you can move those calls int
platform_data callbacks for the non-DT machines to get them out
of the way?

You could have something like

	if (pdata && pdata->reset)
		pdata->reset(dev, clk);
	else
		reset_device(dev);

That wouldn't be too ugly. For the time being, disabling the
drivers on multiplatform sounds reasonable. I don't think you
actually have to have the drivers conflict with DT support:
you should be able to allow the DT based boards with non-multiplatform
to enable the two or three drivers anyway.

	Arnd
