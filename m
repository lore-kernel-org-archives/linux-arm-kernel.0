From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 06 Nov 2013 13:50:52 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106122317.GA8806@ulmo.nvidia.com>
References: <527A1983.6020603@keymile.com>
 <20131106122317.GA8806@ulmo.nvidia.com>
Message-ID: <527A3B2C.6070209@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

thanks again for your patience!

On 11/06/2013 01:23 PM, Thierry Reding wrote:
> On Wed, Nov 06, 2013 at 11:27:15AM +0100, Gerlando Falauto wrote:
>> Hi everyone,
>>
>> I am currently trying to describe an external device within a device
>> tree in a Kirkwood design.
>> Such device is accessed through a local (parallel) bus. Since
>> Kirkwood does not provide such an interface, we added a custom FPGA
>> (PCIe device) which implements a PCIe-to-localbus bridge.
>> So essentially BAR0 provides the configuration space for such a
>> bridge, and BAR1 provides a remapped area where accesses to the
>> localbus can be performed. BAR2 and BAR3 provide other functions.
>>
>> So with the appropriate reg encoding of the PCI device, the PCI
>> driver for the FPGA will automatically get an of_node.
>>
>> My question is: is there any way I can describe this external device
>> (I believe as a child node of the PCI device), so that a call to
>> of_address_to_resource() (or equivalent) from its driver will
>> automatically translate a localbus address (e.g. 0x0000abcd) to
>> whatever address was assigned to BAR1 (in my case 0xe0000000 ->
>> 0xe000abcd)?
>
> Perhaps I don't understand properly, but what good is the local bus
> address to any driver? I mean you'll have to have a PCI driver to bind
> to the PCI device, right?

Correct, and that's the PCI driver for the FPGA, which is (among other 
things) a PCI-to-localbus bridge.

 > And that PCI driver will only need to obtain
> the register addresses from BAR1,

Correct.

> then access that region.

That's not 100% right. The PCI driver will only _provide_ the region for 
BAR1 (as it is a bridge), not _access_ it.

> Why would you need to have it translated via DT?

Because it would be a *separate* driver, the one handling the /external/ 
"slave" device, to use that region.

In principle, if I wanted to reuse that same external device on a 
completely different architecture (which *does* natively provide a 
localbus) I should be able to move that same device node together with 
its driver. Provided the node is under the right bus, and translation is 
configured properly in the device tree, it should then work out of the 
box. Or am I completely mistaken?

What I did now (and it works) was to put the device node for the 
external device right under the main bus,

/ {
...
	ocp at f1000000 {
		slave at 0,0 {
...
			compatible = "keymile,slave";
			reg = <0xe0000000 0x200>;
		};
	};
};

where "0xe0000000" is hardcoded, being the result of the dynamic assignment:

pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]

I'd like to avoid that, saying "slave at 0,0 is accessible through the 
memory area 0x0-0x200 within BAR1 of device 0 on bus 1".

Thanks again,
Gerlando
