From: ddaney@caviumnetworks.com (David Daney)
Date: Fri, 18 Sep 2015 10:54:02 -0700
Subject: [PATCH 2/2] irqchip/gicv3-its:  Handle OF device tree "msi-map"
 properties.
In-Reply-To: <20150918095109.144c22ed@arm.com>
References: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
 <1442512859-31633-3-git-send-email-ddaney.cavm@gmail.com>
 <20150918095109.144c22ed@arm.com>
Message-ID: <55FC4FBA.1010306@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2015 01:51 AM, Marc Zyngier wrote:
> On Thu, 17 Sep 2015 11:00:59 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
>
> Hi David,
>
>> From: David Daney <david.daney@cavium.com>
>>
>> Search up the device hierarchy to find devices with a "msi-map"
>> property, if found apply the mapping to the GIC device id.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its-pci-msi.c | 73 ++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> index cf351c6..aa61cef 100644
>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> @@ -73,6 +73,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>>   	struct pci_dev *pdev;
>>   	struct its_pci_alias dev_alias;
>>   	struct msi_domain_info *msi_info;
>> +	struct device *parent_dev;
>> +	struct device_node *msi_controller_node = NULL;
>>
>>   	if (!dev_is_pci(dev))
>>   		return -EINVAL;
>> @@ -84,6 +86,77 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>>   	dev_alias.count = nvec;
>>
>>   	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
>> +	/*
>> +	 * Walk up the device parent links looking for one with a
>> +	 * "msi-map" property.
>> +	 */
>
> My first objection is the location of this parsing. It shouldn't be
> driver specific, but instead be part of the generic OF handling
> (nothing in these properties is GICv3 specific, even if the ITS is the
> only user so far).

OK, I agree that this should eventually end up in generic OF handling 
code.  I just wanted to get something out to initiate discussion.

The next patch revision will move this to a more generic home.

>
>> +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
>
> Is there a limit how far we should go up the parent chain to find a
> msi-map? My hunch is that you should stop at the first device that does
> have an of_node, as it is the one that should contain the msi-map
> property.

I think there is the possibility of finding something like a bridge that 
has an of_node, but does not have the "msi-map" property.  I currently 
have exactly this configuration, as some of the on-SoC devices sit 
behind a bridge, but need an of_node to obtain unprobable properties and 
children (the MDIO bus devices are like this).

So if we want to abort the walk early, we should at least go up until we 
find "msi-map" in the of_node.

>
>> +		u32 msi_mask, masked_devid;
>> +		u32 rid_base, msi_base, rid_len, phandle;
>> +		int msi_map_len;
>> +		const __be32 *msi_map;
>> +		bool matched;
>> +
>> +		if (!parent_dev->of_node)
>> +			continue;
>> +
>> +		msi_map = of_get_property(parent_dev->of_node,
>> +					  "msi-map", &msi_map_len);
>> +		if (!msi_map)
>> +			continue;
>
> At this point, you know you do have a msi-map, and anything below this
> point won't result in another iteration - they can be taken out of the
> loop, avoiding most of your break statements.


OK.  I will make this simplification.

>
>> +
>> +		/* The default is to select all bits. */
>> +		msi_mask = 0xffffffff;
>> +
>> +		/*
>> +		 * Can be overridden by "msi-mask" property.  If
>> +		 * of_property_read_u32() fails, the default is
>> +		 * used.
>> +		 */
>> +		of_property_read_u32(parent_dev->of_node,
>> +				     "msi-mask", &msi_mask);
>
> This should be "msi-map-mask", if I read Mark's binding correctly.

Good catch.  It was a typo on my part.  I am using the default, so my 
device tree doesn't have this property.

>
>> +
>> +		masked_devid = msi_mask & dev_alias.dev_id;
>> +		matched = false;
>> +		while (msi_map_len >= 4 * sizeof(__be32)) {
>> +			rid_base = be32_to_cpup(msi_map + 0);
>> +			phandle = be32_to_cpup(msi_map + 1);
>> +			msi_base = be32_to_cpup(msi_map + 2);
>> +			rid_len = be32_to_cpup(msi_map + 3);
>
> Ouch. I wonder if that kind of thing should deserve a generic helper.
> of_property_read_u32_array_from_index()? Rob, what do you think?

I think it is possible to add too many wrapper functions.  IMO, this is 
not too unreadable.

>
> Also, worth checking that msi_map_len is multiple of 4 (and shout if
> it isn't).

I initially had that, but thought that the fact that any trailing short 
entry would result in a non-functional device, so that would be enough. 
  But I will add it back in.


>
>> +
>> +			if (masked_devid < rid_base ||
>> +			    masked_devid >= rid_base + rid_len) {
>> +				msi_map_len -= 4 * sizeof(__be32);
>> +				msi_map += 4;
>> +				continue;
>> +			}
>> +			matched = true;
>> +			break;
>> +		}
>> +		if (!matched) {
>> +			dev_err(dev,
>> +				"No match in \"msi-map\" of %s for dev_id: %x\n",
>> +				dev_name(parent_dev), dev_alias.dev_id);
>
> It would probably be useful to also print the node containing the
> msi-map property, as this is likely to be the source of the problem.

Hmm, I will see what I can add...

>
>> +			break;
>> +		}
>> +
>> +		msi_controller_node = of_find_node_by_phandle(phandle);
>> +		if (domain->of_node != msi_controller_node) {
>> +			dev_err(dev,
>> +				"ERROR: msi-map mismatch \"%s\" vs. \"%s\"\n",
>> +				domain->of_node->full_name,
>> +				msi_controller_node ? NULL : msi_controller_node->full_name);
>
> Why is that an error? a RC can be configured to master multiple
> MSI-controllers,

Something has already associated the PCI device with this 
MSI-controller.  Therefore I think the reference in the map must refer 
to this ITS MSI-controller instance.


> and the kernel picks one of them for a given device.
> This is illustrated by "Example (5)" in the binding, where a device can
> master two MSI controllers.

The PCI host may have many MSI controllers, but I think a given PCI 
device will have only one (based on bus:devfn) that is looked up in the map.

>
>> +			break;
>> +		}
>> +		dev_dbg(dev,
>> +			"msi-map at: %s, len: %d, using mask %08x, rid: %08x, msi: %08x, rid_len: %08x, dev_id: %08x\n",
>> +			dev_name(parent_dev), msi_map_len, msi_mask, rid_base,
>> +			msi_base, rid_len, dev_alias.dev_id);
>> +		dev_alias.dev_id = masked_devid + msi_base;
>> +		dev_dbg(dev, "New dev_id: %08x\n", dev_alias.dev_id);
>> +		break;
>> +	}
>> +	of_node_put(msi_controller_node);
>>
>>   	/* ITS specific DeviceID, as the core ITS ignores dev. */
>>   	info->scratchpad[0].ul = dev_alias.dev_id;
>
>
> Thanks,
>
> 	M.
>
