From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jul 2018 15:57:48 +0100
Subject: [PATCH v5 7/7] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180706133637.GZ17271@n2100.armlinux.org.uk>
References: <20180523093122.27859-1-peda@axentia.se>
 <20180523093122.27859-8-peda@axentia.se>
 <20180706133637.GZ17271@n2100.armlinux.org.uk>
Message-ID: <20180706145748.GA17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 02:36:37PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 23, 2018 at 11:31:22AM +0200, Peter Rosin wrote:
> > This makes this driver work with all(?) drivers that are not
> > componentized and instead expect to connect to a panel/bridge. That
> > said, the only one tested is atmel-hlcdc.
> > 
> > This hooks the relevant work function previously called by the encoder
> > and the component also to the bridge, since the encoder goes away when
> > connecting to the bridge interface of the driver and the equivalent of
> > bind/unbind of the component is handled by bridge attach/detach.
> > 
> > The lifetime requirements of a bridge and a component are slightly
> > different, which is the reason for struct tda998x_bridge.
> 
> Why not do this conversion similarly to other "bridge" drivers that have
> this same problem (eg, dw-hdmi, dw-mipi-dsi) and always create the
> bridge device, but optionally create the encoder and bind the bridge
> to the encoder?
> 
> That way we don't end up with the veneer functions for bridge-only vs
> encoder-only, and we have just one control path to care about - that
> being the bridge interface.

So what I'm proposing is something along the lines of the following
(untested) patch series - I haven't gone to the extent of creating
just the bridge device, but as you will see, it's not that far away.

With the addition of the component helper into drm_bridge code, we
could probably push both armada and tilcdc to use bridges and create
their own encoders for the bridges rather trivially and make tda998x
encoderless, without sacrificing the existing ability to be able to
safely unload these components.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
