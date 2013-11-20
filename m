From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Nov 2013 14:14:48 +0100
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <20131120.051708.396722414386125310.hdoyu@nvidia.com>
References: <20131119102506.GG31504@ulmo.nvidia.com>
 <20131119.140351.1342214267287135109.hdoyu@nvidia.com>
 <528BD6A7.3030908@wwwdotorg.org>
 <20131120.051708.396722414386125310.hdoyu@nvidia.com>
Message-ID: <20131120131447.GA8279@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 04:17:08AM +0100, Hiroshi Doyu wrote:
> Stephen Warren <swarren@wwwdotorg.org> wrote @ Tue, 19 Nov 2013 22:22:47 +0100:
> 
> > On 11/19/2013 05:03 AM, Hiroshi Doyu wrote:
> > > Hi Thierry,
> > > 
> > > Thierry Reding <thierry.reding@gmail.com> wrote @ Tue, 19 Nov 2013 11:25:07 +0100:
> > > 
> > >> From earlier discussions I thought the goal was to actually defer this
> > >> until all nodes referred to by the iommus property were actually
> > >> registered. The above only checks that the phandles can be resolved to
> > >> valid struct device_node:s. That doesn't mean that an actual IOMMU has
> > >> been registered for it, only that the devices have been created.
> > > 
> > > Currently "bus->iommu_ops" is set at the end of tegra_smmu_probe(). So
> > > if "bus->iommu_ops" is set, it means that an iommu instance is
> > > populated at that time.
> > 
> > Yes, but that's the register bus, upon which the device is a client, not
> > the bus upon which the device is a bus master. They aren't necessarily
> > the same.
> > 
> > There's no getting around the fact that, as Thierry said, you need to
> > search for a registered IOMMU device for each phandle, and defer probe
> > if any aren't registered yet.
> > 
> > If we do that, then you shouldn't need to look at the value of
> > dev->bus->iommu_ops at all; if all IOMMUs in the list were registered,
> > then iommu_ops must have been set when (one of them) was registered, and
> > if not, then it possibly wasn't, so defer probe.
> > 
> > That way, this code won't have to change if the core IOMMU code gets
> > extended to support multiple IOMMUs, devices mastering transactions onto
> > buses other than their register bus, etc.
> 
> Does the above mean the following?
> 
> int of_iommu_attach(struct device *dev)
> {
> 	int i;
> 	struct of_phandle_args args;
> 
> 	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> 					       "#iommu-cells", i, &args)
> 		if (!args->np->dev->driver)
> 			return -EPROBE_DEFER;
> 	return 0;
> }

Not quite. The above would only check that a driver was bound to the
device. But if that device isn't an IOMMU then this doesn't help you.

The standard way to solve this issue is to add the IOMMU to a global
list upon registration. Typically subsystems have some way to do that
already, but it seems like IOMMU doesn't. It looks like that's one of
the side-effects of the assumption that there will always only be a
single IOMMU (per bus).

There's also no base object that IOMMU drivers implement, which is the
way it's usually done in other subsystems. The absence of that makes it
more difficult. I suspect the easiest way to do that would be to add a
new type, something like this:

	struct iommu {
		struct list_head list;
		struct device *dev;
	};

Then modify the driver to do something like this (tegra-smmu.c):

	struct smmu_device {
		struct iommu iommu;

		...
	};

	...

	static int tegra_smmu_probe(struct platform_device *pdev)
	{
		struct smmu_device *smmu;

		...

		smmu->iommu.dev = &pdev->dev;

		iommu_add(&smmu->iommu);

		...
	}

	static int tegra_smmu_remove(struct platform_device *pdev)
	{
		struct smmu_device *smmu;

		...

		iommu_del(&smmu->iommu);
	}

The implementation of iommu_add() and iommu_del() could be as simple as:

	static DEFINE_MUTEX(iommus_lock);
	static LIST_HEAD(iommus_list);

	void iommu_add(struct iommu *iommu)
	{
		INIT_LIST_HEAD(&iommu->list);
		mutex_lock(&iommus_lock);
		list_add_tail(&iommu->list, &iommus_list);
		mutex_unlock(&iommus_lock);
	}

	void iommu_del(struct iommu *iommu)
	{
		INIT_LIST_HEAD(&iommu->list);
		mutex_lock(&iommus_lock);
		list_del(&iommu->list);
		mutex_unlock(&iommus_lock);
	}

And then you can implement a lookup function to match an IOMMU to the
phandle, like so:

	struct iommu *of_find_iommu_by_node(struct device_node *np)
	{
		struct iommu *iommu;

		mutex_lock(&iommus_lock);

		list_for_each_entry(iommu, &iommus_list, list) {
			if (iommu->dev->of_node == np) {
				mutex_unlock(&iommus_lock);
				return iommu;
			}
		}

		mutex_unlock(&iommus_lock);
		return NULL;
	}

With that you can use of_find_iommu_by_node() in the loop to check
whether an IOMMU has really been registered.

Of course that all is somewhat intrusive and Joerg might have some
objections.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/d6017976/attachment.sig>
