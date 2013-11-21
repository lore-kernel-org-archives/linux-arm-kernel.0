From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 21 Nov 2013 11:01:11 +0200
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <528CE3AB.60806@wwwdotorg.org>
References: <528BD6A7.3030908@wwwdotorg.org>
 <20131120.051708.396722414386125310.hdoyu@nvidia.com>
 <20131120131447.GA8279@ulmo.nvidia.com>
 <20131120.160359.1043627108929095327.hdoyu@nvidia.com>
 <528CE3AB.60806@wwwdotorg.org>
Message-ID: <20131121110111.2a5c3ed92fa0e12efd5dcf44@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Nov 2013 17:30:35 +0100
Stephen Warren <swarren@wwwdotorg.org> wrote:
...
> >>> Does the above mean the following?
> >>>
> >>> int of_iommu_attach(struct device *dev)
> >>> {
> >>> 	int i;
> >>> 	struct of_phandle_args args;
> >>>
> >>> 	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> >>> 					       "#iommu-cells", i, &args)
> >>> 		if (!args->np->dev->driver)
> >>> 			return -EPROBE_DEFER;
> >>> 	return 0;
> >>> }
> >>
> >> Not quite. The above would only check that a driver was bound to the
> >> device. But if that device isn't an IOMMU then this doesn't help you.
> > 
> > I thought that, as long as a device is a normal one, it's ok to let it
> > go to be populated.
> 
> I don't understand what that means.
> 
> > We only care about that, IOMMU devices comes
> > first, and clients should come later than IOMMUs, for population. In
> > the above if all IOMMUs are not populated, client devices are always
> > deferred. "args->np->dev" always points an IOMMU device in a
> > loop. Otherwise(no "iommus=") it goes out from the loop immediately.
> 
> I'm not sure what that means. Perhaps you're sauying the dev->driver
> isn't set until the driver is probe()d for the device, so if
> dev->driver!=NULL, then we know the driver probed() successfully for it?

Yes

> That does go most of the way, but as Thierry pointed out, it doesn't
> guarantee that the dev->driver is an IOMMU driver, just that it's *some*
> driver. Perhaps this won't actually make any difference in practice, but
> AFAIK, all other subsystems do perform the strict check, so I don't see
> why the IOMMU subsystem shouldn't.

Ok, now I got the one Thierry pointed out. Will implement that.
