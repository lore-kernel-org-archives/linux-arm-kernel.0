From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 21 Sep 2015 09:35:51 -0700
Subject: [PATCH 2/2] irqchip/gicv3-its:  Handle OF device tree "msi-map"
 properties.
In-Reply-To: <20150921165814.01967eaf@arm.com>
References: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
 <1442512859-31633-3-git-send-email-ddaney.cavm@gmail.com>
 <20150918095109.144c22ed@arm.com> <55FC4FBA.1010306@caviumnetworks.com>
 <20150921165814.01967eaf@arm.com>
Message-ID: <560031E7.1060307@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2015 08:58 AM, Marc Zyngier wrote:
> On Fri, 18 Sep 2015 10:54:02 -0700
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> On 09/18/2015 01:51 AM, Marc Zyngier wrote:
>>> On Thu, 17 Sep 2015 11:00:59 -0700
>>> David Daney <ddaney.cavm@gmail.com> wrote:
>>>
>>> Hi David,
>>>
>>>> From: David Daney <david.daney@cavium.com>
>>>>
>>>> Search up the device hierarchy to find devices with a "msi-map"
>>>> property, if found apply the mapping to the GIC device id.
>>>>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> ---
>>>>    drivers/irqchip/irq-gic-v3-its-pci-msi.c | 73 ++++++++++++++++++++++++++++++++
>>>>    1 file changed, 73 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>>>> index cf351c6..aa61cef 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>>>> @@ -73,6 +73,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>>>>    	struct pci_dev *pdev;
>>>>    	struct its_pci_alias dev_alias;
>>>>    	struct msi_domain_info *msi_info;
>>>> +	struct device *parent_dev;
>>>> +	struct device_node *msi_controller_node = NULL;
>>>>
>>>>    	if (!dev_is_pci(dev))
>>>>    		return -EINVAL;
>>>> @@ -84,6 +86,77 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>>>>    	dev_alias.count = nvec;
>>>>
>>>>    	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
>>>> +	/*
>>>> +	 * Walk up the device parent links looking for one with a
>>>> +	 * "msi-map" property.
>>>> +	 */
>>>
>>> My first objection is the location of this parsing. It shouldn't be
>>> driver specific, but instead be part of the generic OF handling
>>> (nothing in these properties is GICv3 specific, even if the ITS is the
>>> only user so far).
>>
>> OK, I agree that this should eventually end up in generic OF handling
>> code.  I just wanted to get something out to initiate discussion.
>>
>> The next patch revision will move this to a more generic home.
>>
>>>
>>>> +	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
>>>
>>> Is there a limit how far we should go up the parent chain to find a
>>> msi-map? My hunch is that you should stop at the first device that does
>>> have an of_node, as it is the one that should contain the msi-map
>>> property.
>>
>> I think there is the possibility of finding something like a bridge that
>> has an of_node, but does not have the "msi-map" property.  I currently
>> have exactly this configuration, as some of the on-SoC devices sit
>> behind a bridge, but need an of_node to obtain unprobable properties and
>> children (the MDIO bus devices are like this).
>>
>> So if we want to abort the walk early, we should at least go up until we
>> find "msi-map" in the of_node.
>
> I don't really see a case where we would traverse a series of nodes
> where the msi-map property wouldn't be in the first node. Could you
> please give me an example?
>

OK, how about this:

	pcie0: pcie0 at 8480,00000000 {
		compatible = "pci-host-ecam-generic";
		device_type = "pci";
		msi-parent = <&its>;
		msi-map = <0 &its 0x80000 0x10000>;
		bus-range = <0 255>;
		#size-cells = <2>;
		#address-cells = <3>;
		#stream-id-cells = <1>;
		reg = <0x8480 0x00000000 0 0x10000000>;	 /* Configuration space */
		ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000 0x070 
0x00000000>, /* mem ranges */
			 <0x03000000 0x87e0 0x00000000 0x87e0 0x00000000 0x020 0x00000000>;

		/* Other devices that use MSI, like USB xHCI, are here
		on the same bus as the bridge.  They have no firmware
		node as sufficient information can be probed as part
		of normal PCI probing. */

		mrml-bridge0 at 1,0 {
			compatible = "cavium,thunder-8890-mrml-bridge";
			#size-cells = <2>;
			#address-cells = <3>;
			ranges = <0x03000000 0x87e0 0x00000000 0x03000000 0x87e0 0x00000000 
0x10 0x00000000>;
			reg = <0x0800 0 0 0 0>; /* DEVFN = 0x08 (1:0) */

			mdio-nexus at 1,3 {
				compatible = "cavium,thunder-8890-mdio-nexus";
				#address-cells = <2>;
				#size-cells = <2>;
				reg = <0x0b00 0 0 0 0>; /* DEVFN = 0x0b (1:3) */
				assigned-addresses = <0x03000000 0x87e0 0x05000000 0x0 0x800000>;
				ranges = <0x87e0 0x05000000 0x03000000 0x87e0 0x05000000 0x0 0x800000>;

				mdio0 at 87e0,05003800 {
					compatible = "cavium,thunder-8890-mdio";
					#address-cells = <1>;
					#size-cells = <0>;
					reg = <0x87e0 0x05003800 0x0 0x30>;

					sgmii00: sgmii00 {
						reg = <0> ;
						compatible = "marvell,88e1240", "ethernet-phy-ieee802.3-c22";
					};
				};
			};
			bgx0 {
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <0x8000 0 0 0 0>; /* DEVFN = 0x80 (16:0) */
				sgmii00 {
					reg = <0>;
					phy-handle = <&sgmii00>;
				};

			};

		};


The "msi-map" is specified in the PICe host controller node, but there
is a bridge between the device generating interrupts "bgx0" and the
host controller.


> [...]
>
>>>> +		msi_controller_node = of_find_node_by_phandle(phandle);
>>>> +		if (domain->of_node != msi_controller_node) {
>>>> +			dev_err(dev,
>>>> +				"ERROR: msi-map mismatch \"%s\" vs. \"%s\"\n",
>>>> +				domain->of_node->full_name,
>>>> +				msi_controller_node ? NULL : msi_controller_node->full_name);
>>>
>>> Why is that an error? a RC can be configured to master multiple
>>> MSI-controllers,
>>
>> Something has already associated the PCI device with this
>> MSI-controller.  Therefore I think the reference in the map must refer
>> to this ITS MSI-controller instance.
>>
>>
>>> and the kernel picks one of them for a given device.
>>> This is illustrated by "Example (5)" in the binding, where a device can
>>> master two MSI controllers.
>>
>> The PCI host may have many MSI controllers, but I think a given PCI
>> device will have only one (based on bus:devfn) that is looked up in the map.
>
> A PCI device will only be configured to talk to a single MSI
> controller, but here you stop parsing the msi-map on the first match,
> and assume that you must have found the right MSI controller:
>
> I think this should read:
>
> +			if (masked_devid < rid_base ||
> +			    masked_devid >= rid_base + rid_len ||
> 			    domain->of_node != of_find_node_by_phandle(phandle)) {
> +				msi_map_len -= 4 * sizeof(__be32);
> +				msi_map += 4;
> +				continue;
> +			}
> +			matched = true;
> +			break;
>

Good, I will incorporate that too.

In practice, I don't know if we would ever find a system with multiple 
"msi-map" on a path from the device to the root, but we should probably 
attempt to handle it "just in case".


> Thanks,
>
> 	M.
>
