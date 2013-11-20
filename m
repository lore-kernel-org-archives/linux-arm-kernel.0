From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 20 Nov 2013 15:03:59 +0100
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <20131120131447.GA8279@ulmo.nvidia.com>
References: <528BD6A7.3030908@wwwdotorg.org><20131120.051708.396722414386125310.hdoyu@nvidia.com><20131120131447.GA8279@ulmo.nvidia.com>
Message-ID: <20131120.160359.1043627108929095327.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 20 Nov 2013 14:14:48 +0100:
....
> > Does the above mean the following?
> > 
> > int of_iommu_attach(struct device *dev)
> > {
> > 	int i;
> > 	struct of_phandle_args args;
> > 
> > 	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> > 					       "#iommu-cells", i, &args)
> > 		if (!args->np->dev->driver)
> > 			return -EPROBE_DEFER;
> > 	return 0;
> > }
> 
> Not quite. The above would only check that a driver was bound to the
> device. But if that device isn't an IOMMU then this doesn't help you.

I thought that, as long as a device is a normal one, it's ok to let it
go to be populated. We only care about that, IOMMU devices comes
first, and clients should come later than IOMMUs, for population. In
the above if all IOMMUs are not populated, client devices are always
deferred. "args->np->dev" always points an IOMMU device in a
loop. Otherwise(no "iommus=") it goes out from the loop immediately.

+#define of_property_for_each_phandle_with_args(np, list, cells, i, args) \
+	 for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)

> The standard way to solve this issue is to add the IOMMU to a global
> list upon registration. Typically subsystems have some way to do that
> already,

Your implementation has some possibiity that we could construct any
hierarchy of IOMMUs.

> already, but it seems like IOMMU doesn't. It looks like that's one of
> the side-effects of the assumption that there will always only be a
> single IOMMU (per bus).

There's the following case at least we have already had.

"memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
                                      |
                                      |
                                      +--"device_b"

"smmu_b" isn't related to a bus at all.

> There's also no base object that IOMMU drivers implement, which is the
> way it's usually done in other subsystems. The absence of that makes it
> more difficult. I suspect the easiest way to do that would be to add a
> new type, something like this:
....

> With that you can use of_find_iommu_by_node() in the loop to check
> whether an IOMMU has really been registered.

Do you think if it's acceptable to see if a device is populated or not
via "dev->driver"[1]? Grant Likely proposed to use flag[2] instead of
struct device[2], though.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2013-July/006023.html
[2] http://lists.linuxfoundation.org/pipermail/iommu/2013-October/006763.html
