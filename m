From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 15 Feb 2016 08:49:37 -0800
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160215162753.GI12289@pengutronix.de>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de> <56C1CE95.6020206@arm.com>
 <20160215144344.GF10826@n2100.arm.linux.org.uk>
 <20160215162753.GI12289@pengutronix.de>
Message-ID: <20160215164937.GC25556@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:27:53PM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Mon, Feb 15, 2016 at 02:43:44PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Feb 15, 2016 at 01:11:49PM +0000, Robin Murphy wrote:
> > > FWIW the PL180 on my Juno still works fine with this patch picked on top of
> > > -rc3, so the issue would seem to be something else - From a quick comparison
> > > between the DTs I see a slight difference in compatible strings for the
> > > clocks, but the more likely-looking suspect is that the VExpress DT
> > > references some GPIOs where the Juno DT doesn't.
> > 
> > Maybe it would be a good idea that Uwe creates a patch which initially
> > warns when a DT platform device falls back to matching via the platform
> > strings?
> > 
> > It's likely that the "basic subsystem" platform drivers are silent when
> > they probe, so having notification of a fallback would at least put
> > something into the kernel log when that happens - and then later change
> > that to be a hard failure (as Uwe is trying to do with his patch.)
> > 
> > However, I have to bring up another point: is what Uwe is trying to do
> > actually the right thing?  The DT platform device code has the ability
> > to create standard platform devices from DT, with an of_node, but with
> > standard names, and platform data.  It's there for compatibility with
> > older systems, and is there to allow systems to be transitioned over.
> > 
> > This patch breaks all that: despite the DT code changing the platform
> > device bus_id from the address.nodename format to the standard format
> > (thus allowing unconverted platform drivers to match), this patch
> > means that because the platform device has a of_node attached, this
> > will now fail.
> > 
> > Therefore, I think Uwe's patch is just wrong - or, if it's something we
> > want, the auxdata table support code needs to _also_ be ripped out of
> > the drivers/of/platform.c code, but that then means anyone who wants to
> > go through the conversion has a big flag-day change to go through.
> 
> That's a valid concern I wasn't aware of when I created the patch.
> 
> So maybe just emitting a warning as you suggested is a good idea. And
> additionally only emit it when the driver is dt aware, too.
> 
> Greg, can you drop this patch, or do you need a proper changelog for a
> revert? On top of that I'd then create a new patch which is more
> conservative.

A hint as to what the git commit id was would be helpful, I can just
revert it based on that.

thanks,

greg k-h
