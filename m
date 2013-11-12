From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 12 Nov 2013 09:26:02 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131112091608.161f1347@skate>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com> <20131106190308.01f7a4a9@skate>
 <20131106182457.GA25879@obsidianresearch.com>
 <20131111155050.96290C41ABB@trevor.secretlab.ca>
 <20131112080512.3992b2e4@skate>	<5281E2B5.3080701@keymile.com>
 <20131112091608.161f1347@skate>
Message-ID: <5281E61A.2070809@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 11/12/2013 09:16 AM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,
>
> On Tue, 12 Nov 2013 09:11:33 +0100, Gerlando Falauto wrote:
>
>>> Hum, right, but unless I'm wrong the of_busses[] array of struct of_bus
>>> is fixed in drivers/of/address.c, and as it is, there is no way for a
>>> specific bus driver to provide its own struct of_bus.
>>
>> That was exactly my understanding as well, and that's where I was
>> expecting some trickery to happen.
>>
>>> So that would need to be extended, right?
>>
>> The other approach I was foreseeing was to implement a way of
>> dynamically updating the DT when the PCI subsystem enumerates the
>> devices and assigns memory areas (namely, I would expect the ranges
>> property to reflect that). But this would imply a standard way of
>> defining the ranges property (I would expect something like <bar#
>> start_addr length>, with an arguable number of cells). And I could
>> not find any such definition in the PCI bus binding document, so I'm
>> probably completely off-track here. Aren't I?
>>
>> After all, we should expect a driver to behave (and expect) the same of
>> the DT, regardless of whether enumeration was performed by firmware or
>> by the OS itself. Or am I wrong on this too?
>
> Well, in the context of the mvebu platforms (including Kirkwood), the
> problem is not so much the ranges in the pcie-controller node, but the
> ranges in the main soc { ... } node which encloses the description of
> the MBus. It is those ranges that need to be updated when a new window
> is created, or a window is removed. So the problem is not PCI related,
> but MBus related in this case, no?

I was actually referring to ranges within the PCI *device* (~leaf node).
So not thinking about mvebu, but rather about general PCI devices.

I see drivers/of/address.c implements some:

extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
			       u64 *size, unsigned int *flags);
extern int of_pci_address_to_resource(struct device_node *dev, int bar,
				      struct resource *r);

Which are not hooked to any ranges (of_bus) mechanisms nor any DT-aware 
PCI device driver and that's where I got completely lost.
But I'm probably looking at it from a wrong perspective.

Thanks,
Gerlando
