From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 09:30:35 -0700
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <20131120.160359.1043627108929095327.hdoyu@nvidia.com>
References: <528BD6A7.3030908@wwwdotorg.org><20131120.051708.396722414386125310.hdoyu@nvidia.com><20131120131447.GA8279@ulmo.nvidia.com>
 <20131120.160359.1043627108929095327.hdoyu@nvidia.com>
Message-ID: <528CE3AB.60806@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 07:03 AM, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 20 Nov 2013 14:14:48 +0100:

(Yes, what Thierry said)

> ....
>>> Does the above mean the following?
>>>
>>> int of_iommu_attach(struct device *dev)
>>> {
>>> 	int i;
>>> 	struct of_phandle_args args;
>>>
>>> 	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
>>> 					       "#iommu-cells", i, &args)
>>> 		if (!args->np->dev->driver)
>>> 			return -EPROBE_DEFER;
>>> 	return 0;
>>> }
>>
>> Not quite. The above would only check that a driver was bound to the
>> device. But if that device isn't an IOMMU then this doesn't help you.
> 
> I thought that, as long as a device is a normal one, it's ok to let it
> go to be populated.

I don't understand what that means.

> We only care about that, IOMMU devices comes
> first, and clients should come later than IOMMUs, for population. In
> the above if all IOMMUs are not populated, client devices are always
> deferred. "args->np->dev" always points an IOMMU device in a
> loop. Otherwise(no "iommus=") it goes out from the loop immediately.

I'm not sure what that means. Perhaps you're sauying the dev->driver
isn't set until the driver is probe()d for the device, so if
dev->driver!=NULL, then we know the driver probed() successfully for it?
That does go most of the way, but as Thierry pointed out, it doesn't
guarantee that the dev->driver is an IOMMU driver, just that it's *some*
driver. Perhaps this won't actually make any difference in practice, but
AFAIK, all other subsystems do perform the strict check, so I don't see
why the IOMMU subsystem shouldn't.

...
> There's the following case at least we have already had.
> 
> "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
>                                       |
>                                       |
>                                       +--"device_b"
> 
> "smmu_b" isn't related to a bus at all.

Yes, smmu_b is related to a bus.

Admittedly perhaps not a bus that the CPU can master transactions onto,
but there's still a (perhaps point-point) bus that device_a masters, and
smmu_b acts as a slave.

Note that not all buses in the diagram above are represented as bus
objects in the Linux kernel (or even in DT), since those tend to
concentrate only on representing buses that the CPU masters, rather than
additionally representing buses that only HW devices master.
