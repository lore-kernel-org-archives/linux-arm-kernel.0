From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 21 Jun 2014 01:25:26 +0400
Subject: [PATCH v4 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <4490558.0d3xbrzEgW@wuerfel>
References: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
 <4637423.jWRbL1GbCK@wuerfel> <53A4A0E5.50904@cogentembedded.com>
 <4490558.0d3xbrzEgW@wuerfel>
Message-ID: <53A4A6C6.9000703@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2014 01:10 AM, Arnd Bergmann wrote:

>>>> +       pci0: pci at ee090000 {
>>>> +               compatible = "renesas,pci-r8a7790";
>>>> +               clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
>>>> +               reg = <0x0 0xee090000 0x0 0xc00>,
>>>> +                     <0x0 0xee080000 0x0 0x1100>;
>>>> +               interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
>>>> +               status = "disabled";
>>>> +
>>>> +               bus-range = <0 0>;
>>>> +               #address-cells = >;
>>>> +               #size-cells = <2>;
>>>> +               #interrupt-cells = <1>;
>>>> +               interrupt-map-mask = <0xff00 0 0 0x7>;
>>>> +               interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>>>> +                                0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>>>> +                                0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
>>>> +       };

>>> Hmm, this device node is not actually compliant to the PCI binding,
>>> it needs a "ranges" property that can be used to look up the memory
>>> and I/O space windows.

>>      The PCI driver doesn't support I/O space.

> Well, whichever windows are registered by the driver should come
> from the ranges property.

    I know. Too bad the driver's original author managed to misunderstand that...

>>> It also needs a device_type property.

>>      Hm, are you sure about that? I thought only PCI devices should have it...

> Yes, pretty sure it's needed in both the host controller and the
> devices.

     I don't understand the case of the PCI devices, honestly. Shouldn't the 
"device_type" prop reflect the device's functionality rather than the bus 
where it's located?

>>> I realize that the driver doesn't currently use them, but you should
>>> adhere to the binding anyway, so we can fix the driver at some point.

>>      Sigh, agreed about the need to fix the driver. Too bad you've spoken up
>> only now though. And you've ACKed the DT bindings without those properties
>> documented or even present in an example...

> Yes, I realized that too late as well, sorry about it. For some reason
> I only looked at the interrupt-map being done right and forgot to
> check the ranges.

> We definitely need to move the code handling the ranges into a common
> location to avoid this mistake in the future.

    It is already in the common location, AFAIK; what's lacking there is the 
code that parses "dma-ranges" as well but that should be pretty easy to add...

> 	Arnd

WBR, Sergei
