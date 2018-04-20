From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Apr 2018 11:24:09 +0100
Subject: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <2556566.3fxMPoIyx0@avalon>
References: <20180419162751.25223-1-peda@axentia.se>
 <20180419162751.25223-8-peda@axentia.se>
 <2556566.3fxMPoIyx0@avalon>
Message-ID: <20180420102408.GW16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 01:06:49PM +0300, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patch.
> 
> On Thursday, 19 April 2018 19:27:51 EEST Peter Rosin wrote:
> > This makes this driver work with all(?) drivers that are not
> > componentized and instead expect to connect to a panel/bridge. That
> > said, the only one tested is atmel_hlcdc.
> > 
> > This hooks the relevant work function previously called by the encoder
> > and the component also to the bridge, since the encoder goes away when
> > connecting to the bridge interface of the driver and the equivalent of
> > bind/unbind of the component is handled by bridge attach/detach.
> > 
> > The lifetime requirements of a bridge and a component are slightly
> > different, which is the reason for struct tda998x_bridge.
> 
> Couldn't you move the allocation and initialization (tda998x_create) of the 
> tda998x_priv structure to probe time ? I think you wouldn't need a separate 
> structure in that case. Unless I'm mistaken there would be an added benefit of 
> separating component and bridge initialization, resulting in the encoder not 
> being initialized at all if the component isn't used. You wouldn't need to add 
> a local_encoder parameter to the tda998x_init() function.

No, I don't like that idea one bit, as I've stated in the past about the
component API.  The same (probably) goes for the bridge stuff too.

Consider the following:

Your DRM system is initialised.  You then remove a module, which results
in the DRM system being torn down.  You re-insert the module (eg, having
made a change to it).  The DRM system is then re-initialised.

At this point, what is the state of variables such as priv->is_on if
you allocate the structure at probe time?

What about all the other variables in the driver private structure - are
you sure that the driver can cope with random values from the previous
"usage" remaining there?

At the moment, this isn't a concern for the driver because we
dev_kzalloc() the structure in the bind callback.  Move that to the
probe function, and the structure is no longer re-initialised each
time, and so it retains the previous state.  The driver is not setup
to cope with that.

So, to work around that, you would need to reinitialise _everything_
in the structure that the driver requires, which IMHO is a very
open to bugs (eg, if a member is missed, or added without the
necessary re-initialisation), _especially_ when this is not a path
that will get regular testing.

If you want to do this for a subset of data, it would be much better
to separate them into independent structures (maybe one embedded into
the other) so that this problem can not occur.  That way, a subset
of the data can be memset() when bound to the rest of the DRM system
ensuring a consistent driver state and still achieve what you're
suggesting.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
