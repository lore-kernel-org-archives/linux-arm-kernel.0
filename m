From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 May 2017 09:17:16 +0200
Subject: [PATCH v3 2/2] dt-bindings: pcie: Add documentation for Mediatek
 PCIe
In-Reply-To: <1494470650.20742.36.camel@mtkswgap22>
References: <1494382020-26790-1-git-send-email-ryder.lee@mediatek.com>
 <1494382020-26790-3-git-send-email-ryder.lee@mediatek.com>
 <CAK8P3a193RxchvFAMWeZiP0sc0bd+VGg=_aVvipSgcbDpHXojg@mail.gmail.com>
 <1494408707.31307.32.camel@mtkswgap22>
 <CAK8P3a1AUsUTNDnN+_9251sxC7R4vvkQRr37dvAke6ooCJ_oxg@mail.gmail.com>
 <1494470650.20742.36.camel@mtkswgap22>
Message-ID: <CAK8P3a1FVyoFufnbQFjGovoQpkxMj3kaAgjb5Q+v-DQnYKeA-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 4:44 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
> On Wed, 2017-05-10 at 12:01 +0200, Arnd Bergmann wrote:
>> On Wed, May 10, 2017 at 11:31 AM, Ryder Lee <ryder.lee@mediatek.com> wrote:
>> > On Wed, 2017-05-10 at 10:08 +0200, Arnd Bergmann wrote:

>> >> > +Required properties:
>> >> > +- device_type: Must be "pci"
>> >> > +- assigned-addresses: Address and size of the port configuration registers
>> >> > +- reg: Only the first four bytes are used to refer to the correct bus number
>> >> > +  and device number.
>> >> > +- #address-cells: Must be 3
>> >> > +- #size-cells: Must be 2
>> >> > +- #interrupt-cells: Must be 1
>> >> > +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>> >> > +  Please refer to the standard PCI bus binding document for a more detailed
>> >> > +  explanation.
>> >>
>> >> Child nodes do not normally have interrupt-map properties. Isn't this
>> >> already covered by the interrupt-map in the parent?
>> >>
>> >
>> > I have one Intel 4 port ethernet card(0000:00:01) and MTK WLAN card
>> > (0000:00:02), probe message looks good to me.
>> >
>> > pci 0000:00:01.0: fixup irq: got 224
>> > pci 0000:00:01.0: assigning IRQ 224
>> > pci 0000:00:02.0: fixup irq: got 225
>> > pci 0000:00:02.0: assigning IRQ 225
>> >
>> > pci 0000:01:00.0: fixup irq: got 224
>> > pci 0000:01:00.0: assigning IRQ 224
>> > pci 0000:01:00.1: fixup irq: got 224
>> > pci 0000:01:00.1: assigning IRQ 224
>> > pci 0000:01:00.2: fixup irq: got 224
>> > pci 0000:01:00.2: assigning IRQ 224
>> > pci 0000:01:00.3: fixup irq: got 224
>> > pci 0000:01:00.3: assigning IRQ 224
>> >
>> > pci 0000:02:00.0: fixup irq: got 225
>> > pci 0000:02:00.0: assigning IRQ 225
>> >
>> >
>> > But child nodes without interrupt-map properties:
>> > It seems incorrect.
>> >
>> > pci 0000:00:01.0: fixup irq: got 224
>> > pci 0000:00:01.0: assigning IRQ 224
>> > pci 0000:00:02.0: fixup irq: got 225
>> > pci 0000:00:02.0: assigning IRQ 225
>> >
>> > pci 0000:01:00.0: fixup irq: got 223
>> > pci 0000:01:00.0: assigning IRQ 223
>>
>> Not entirely sure what happens here, but I guess the problem
>> is that the 'reg' portion of the parent interrupt-map refers to
>> the port devices, not the devices attached the devices behind
>> them.
>
> I agree with you. That's why I need additional interrupt-map properties
> to resolve IRQ correctly for the devices behind root ports.
>
> Not sure whether other platforms have similar case like me here.

I think it's just a bug in this specific chip where the HW designers
wired the IRQs in a nonstandard way.

However, you really should not need the interrupt-map properties
in the child nodes, just change the address part in the parent
interrupt-map. Specifically, the 'bus' portion of the device address
in the interrupt-map would have to be nonzero to refer to
child devices.

>> On a related note, I see that you still list
>>
>> > +- interrupts: Three interrupt outputs of the controller. Must contain an
>> > +  entry for each entry in the interrupt-names property.
>> > +- interrupt-names: Must include the following names
>> > +  - "pcie-int0"
>> > +  - "pcie-int1"
>> > +  - "pcie-int2"
>>
>> This seems to be an artifact from the older version and should be
>> removed as the driver correctly ignores the properties now.
>
> Actually, everything works fine without these properties however when it
> loads we see a few weird error message:
>
> pcieport 0000:00:01.0: Signaling PME with IRQ 232
> pcieport 0000:00:02.0: enabling device (0140 -> 0142)
> pcieport 0000:00:02.0: enabling bus mastering
> irq 232: nobody cared (try booting with the "irqpoll" option)
> ...
> [<c03f6be4>] (pcie_pme_probe) from [<c03f47b8>] (pcie_port_probe_service
> +0x44/0x6c)
> (pcie_port_probe_service) from [<c0454cf8>] (driver_probe_device
> +0x280/0x470)
> ...
> (pcie_port_device_register) from [<c03f51a0>] (pcie_portdrv_probe
> +0x3c/0xb4)
> (pcie_portdrv_probe) from [<c03e7acc>] (pci_device_probe+0x98/0xfc)
> (pci_device_probe) from [<c0454cf8>] (driver_probe_device+0x280/0x470)
> handlers:
> [<c03f68b0>] pcie_pme_irq
> Disabling IRQ #233
>
> I haven't dig it out yet, but just keep them here to solve that.

Something is going very wrong if adding the properties helps. I can't
think of what that is, but we have to find out before the binding can
be merged.

      Arnd
