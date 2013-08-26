From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 26 Aug 2013 11:27:06 +0200
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130809140140.GA14990@ulmo>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com> <20130809140140.GA14990@ulmo>
Message-ID: <521B1F6A.1090304@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys [particularly Jason and Thierry],

sorry for the prolonged silence, here I am back again...

On 08/09/2013 04:01 PM, Thierry Reding wrote:
> On Wed, Jul 31, 2013 at 02:50:34PM -0600, Jason Gunthorpe wrote:
>> On Wed, Jul 31, 2013 at 11:00:45AM +0200, Thomas Petazzoni wrote:
>>
>>>> Actually, the main reason for trying to use this driver was because I
>>>> wanted to model a PCIe *device* within the device tree, so to expose its
>>>> GPIOs and IRQs to be referenced (through phandles) from other device
>>>> tree nodes. The way I understand it, turns out this is not the way to
>>>> go, as PCI/PCIe are essentially enumerated busses, so you're not
>>>> supposed to -and it's not a trivial task to- put any information about
>>>> real devices within the device tree.
>>>> Do you have any suggestion about that?
>>>
>>> Indeed, PCI/PCIe devices are enumerated dynamically, so they are not
>>> listed in the Device Tree, so there's no way to "attach" more
>>> information to them.
>>>
>>> Device Tree people, any suggestion about the above question?
>>
>> No, that isn't true.
>>
>> Device tree can include the discovered PCI devices, you have to use
>> the special reg encoding and all that weirdness, but it does work. The
>> of_node will be attached to the struct pci device automatically.

So you mean that, assuming I knew the topology, I could populate the 
device tree in advance (e.g. statically), so that it already includes 
*devices* which will be further discovered during probing?
Or else you mean the {firmware,u-boot} can do that prior to starting the OS?
If either of the above is true, could you please suggest some example 
(or some way to get one)?
I assume the "reg" property (and the after-"@" node name) will need to 
encode (at least) the device number, is that right?

I tried reading the "PCI Bus Binding to Open Firmware" but I could not 
make complete sense out of it...

>> On server/etc DT platforms the firmware will do PCI discovery and
>> resource assignment then dump all those results into DT for the OS to
>> reference.
>>
>> This is a major reason why we wanted to see the standard PCI DT be
>> used for Marvell/etc, the existing infrastructure for this is
>> valuable.
>>
>> AFAIK, Thierry has tested this on tegra, and I am doing it on Kirkwood
>> (though not yet with the new driver).

Could you please give a pointer to some example of this? I'm not quite 
sure I understand what you guys are talking about.

>>
>> It is useful for exactly the reason stated - you can describe GPIOs,
>> I2C busses, etc, etc in DT and then upon load of the PCI driver engage
>> the DT code to populate and connect all that downstream
>> infrastructure.

I'm not 100% sure I made myself clear though.
What I would like to do is to have *other* parts of the device tree be 
able to reference (i.e., connect to, through phandles) a PCI device 
(because it provides a GPIO, for instance).
Is that also what you mean?

> Obviously this doesn't work in general purpose systems because the PCI
> hierarchy needs to be hardcoded in the DT. If you start adding and
> removing PCI devices that will likely change the hierarchy and break
> this matching of PCI device to DT node.

Yes, I guess in that case (if ever) we would need some other way that 
the device number (is that the same as the physical slot?) to specify a 
particular "hotplug" device (i.e. maybe a serial number or so)?
But that's definitely out of scope here.

>
> It's quite unlikely to have a need to hook up GPIOs or IRQs via DT in a
> general purpose system, though, so I don't really see that being a big
> problem.

Agreed.

>
> Thierry

Thanks again for your patience...

Gerlando
