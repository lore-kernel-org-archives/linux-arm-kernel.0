From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 07 Sep 2016 09:51:55 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20562703.Glp77l1PBf@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <4416687.vUjZzKWZG6@wuerfel> <87d1khmhdj.fsf@linux.intel.com>
 <20562703.Glp77l1PBf@wuerfel>
Message-ID: <87y434kxro.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday, September 6, 2016 1:50:48 PM CEST Felipe Balbi wrote:
>> Hi,
>> 
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > On Tuesday, September 6, 2016 9:40:19 AM CEST Felipe Balbi wrote:
>> >> 
>> >> this only solves the problem for DT devices. Legacy devices and
>> >> PCI-based systems will still suffer from the same problem. At least for
>> >> dwc3, I will only be taking patches that solve the problem for all
>> >> users, not a subset of them.
>> >
>> > I don't think legacy devices are a worry, because they wouldn't
>> > have this problem. For the PCI case, you are right that it cannot
>> > work, in particular for machines that have complex IOMMU setup.
>> >
>> > Some architectures (at least arm64 and sparc) check the bus_type of
>> > a device in order to find the correct set of dma_map_ops for that
>> > device, so there is no real way to handle this as long as you
>> > pass a platform_device into an API that expects a pci_device.
>> 
>> Then I guess we're left with adding a "struct device *dma_dev" to struct
>> dwc3 and trying to figure out if we should use parent or self. Does
>> anybody see any problems with that?
>
> I think we actually need the device pointer in the usb_hcd structure,
> so it can be passed in these API calls from the USB core

that's for host side. I'm concerned about peripheral side

> as these are all called on behalf of the host controller node.
> Looking for more instances of hcd->self.controller, I find this
> instance:
>
> drivers/usb/core/hcd.c:         struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
> drivers/usb/core/hcd.c:         struct phy *phy = phy_get(hcd->self.controller, "usb");
>
> I'm unsure which device pointer we want here, but I suspect this also
> needs to be the one that has the device node in order to make the lookup
> of the phy structure by device node work right. Can you clarify how
> this works today?

sounds correct to me.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/751dcd92/attachment.sig>
