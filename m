From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Nov 2015 01:54:16 +0900
Subject: [PATCH 1/4] bus: uniphier-system-bus: add UniPhier System Bus
 Controller driver
In-Reply-To: <20151124115053.GB4108@leverpostej>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
 <1448357962-12259-2-git-send-email-yamada.masahiro@socionext.com>
 <20151124115053.GB4108@leverpostej>
Message-ID: <CAK7LNAR_6qwVK9fNEAX-L_v1Z5cdGMU33bP75Rdtu5bdmid-3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


2015-11-24 20:50 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
> On Tue, Nov 24, 2015 at 06:39:19PM +0900, Masahiro Yamada wrote:
>> The UniPhier System Bus is an external bus where on-board devices are
>> connected to the UniPhier SoC.  This driver parses the "ranges"
>> property of the System Bus and set up the registers of the System Bus
>> Controller for the correct bus routing.
>
> Could you elaborate on why you need to do that?

In order to have access to the System Bus (external bus),
the System Bus Controller must be set up.


> What needs to be configured specifically?

The base address and the size of each bank (each chip select)
must be set to the registers of the controller.



> [...]
>
>> +The UniPhier System Bus is an external bus where on-board devices are connected
>> +to the UniPhier SoC.  It it a simple parallel bus with address, data, and some
>> +control signals.  It supports up to 8 banks (chip selects).
>> +
>> +Required properties for System Bus:
>> +- compatible: should be "socionext,uniphier-system-bus", "simple-bus".
>
> If the kernel has to perform setup of the bus, then it is not a
> "simple-bus".
>
> Configure the bus, then probe children. Don't use simple-bus jsut to get
> probing.

OK, I will fix in v2.



>> +- #address-cells: should be equal to or grater than 2.  The first cell is the
>
> s/grater/greater/

OK, thanks.


>> +  bank number (chip select).  The rest is the base address within the bank that
>> +  should be mapped onto the parent bus (usually AMBA).
>> +
>> +Optional properties for System Bus:
>> +- #size-cells: should be the same as that of the parent bus, if exists.  The
>> +  value of the parent bus is assumed, if not specified.
>
> This should be just as required as #address-cells, for consistency.

Will fix.


>> +
>> +
>> +UniPhier System Bus Controller
>> +------------------------------
>> +
>> +The UniPhier System Bus Controller is a hardware block with registers that
>> +controls the System Bus accessing; how each bank is mapped onto the parent bus,
>> +various timing parameters of the bus access, etc.
>> +
>> +Required properties for System Bus Controller:
>> +- compatible: should be "socionext,uniphier-system-bus-controller".
>> +- reg: offsets and lengths of the register sets for the device.  It should
>> +  contain 2 regions: base & control register, misc register, in this order.
>
> The example also has a system-bus phandle.

Actually, I was wondering which is better to describe the relation between
the bus and the controller,  phandle or compatible string..



> Is the "misc register" part of the bus controller, or is it a shared
> system controller?

It is a part of the bus controller, but used for another purpose.
(i.e. partly this is syscon.  I know this is strange, but it is
what the hardware developers designed.)



>> +Example
>> +-------
>> +     system_bus: system-bus {
>> +             compatible = "socionext,uniphier-system-bus", "simple-bus";
>> +             #address-cells = <2>;
>> +             #size-cells = <1>;
>> +             ranges = <1 0x00000000 0x42000000 0x02000000
>> +                       5 0x00000000 0x48000000 0x01000000>;
>> +
>> +             eth: ethernet at 1,01f00000 {
>> +                     compatible = "smsc,lan9115";
>> +                     reg = <1 0x01f00000 0x1000>;
>> +                     phy-mode = "mii";
>> +                     reg-io-width = <4>;
>> +             };
>> +
>> +             serial: uart at 5,00200000 {
>> +                     compatible = "ns16550a";
>> +                     reg = <5 0x00200000 0x20>;
>> +                     clock-frequency = <12288000>;
>> +                     reg-shift = <1>;
>> +             };
>> +     };
>> +
>> +     system-bus-controller at 58c00000 {
>> +             compatible = "socionext,uniphier-system-bus-controller";
>> +             reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
>> +             system-bus = <&system_bus>;
>> +     };
>
> Assuming that the controller and bus are 1-1 related, make this a single
> node. e.g.
>
> system-bus {
>         compatible = "socionext,uniphier-system-bus";
>         reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <1 0x00000000 0x42000000 0x02000000>,
>                  <5 0x00000000 0x48000000 0x01000000>;
>
>         ...
>         child nodes here
>         ...
>
> };

Hmm, make sense.  But, I prefer to reflect the hardware structure.

The range of System Bus is <0x40000000 0x10000000>.

The register of the System Bus Controller is
<0x58c00000 0x400>  (and <0x59800000 0x2000>)


The bus and its controller is different.


> [...]
>
>> +static int uniphier_sbc_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct uniphier_sbc_priv *priv;
>> +     struct resource *regs;
>> +     struct device_node *bus_np;
>> +     int child_addrc, addrc, sizec, bank;
>> +     u64 child_addr, addr, size;
>> +     const __be32 *ranges;
>> +     int rlen, rone, ret;
>> +
>> +     bus_np = of_find_compatible_node(NULL, NULL,
>> +                                      "socionext,uniphier-system-bus");
>
> This is broken if you ever have multiple instances.
>
> Either use a single node, or if there is a more complex relationship
> between busses and their controllers, describe that explicitly with
> phandles.


Probably, I will stick to phandle in v2.


Thanks,

-- 
Best Regards
Masahiro Yamada
