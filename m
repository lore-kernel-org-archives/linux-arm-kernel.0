From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 1 Dec 2015 13:30:25 +0900
Subject: [Question] DT-Bindings for run-time configurable bus?
Message-ID: <CAK7LNATGi4isAaG0XS13ZnfFQKCxzaxeJvusSg3RYn7z29BF9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello experts,

I am tackling on a new bus driver, but I am worndering
what the DT-binding specification should be.

Here is my hardware situation:

My SoC has an external bus (it is called UniPhier System Bus).
This is a simple parallel bus with address, data,
chip-selects, and some other control signals.
It supports up to 8 chip-selects.

Each CS address space can be mapped onto the CPU view,
and it must be configured run-time via the bus controller registers.

Let's assume this situation:

 - An ethernet device is connected at the offset address 0x01f00000 of CS1
 - A UART device is connected at the offset address 0x00200000 of CS5


A quick draft of device tree would be as follows:


amba {
     compatible = "simple-bus";
     #address-cells = <1>;
     #size-cells = <1>;
     ranges;

     extbus {
           compatible = "socionext,uniphier-system-bus";
           reg = <0x58c00000 0x400>; /* registers of bus controller */
           #address-cells = <2>;
           #size-cells = <1>;

           ethernet at 1,01f00000 {
                 compatible = "smsc,lan9115";
                 reg = <1 0x01f00000 0x1000>;
                 interrupts = <0 48 4>
                 phy-mode = "mii";
           };

           uart at 5,00200000 {
                 compatible = "ns16550a";
                 reg = <5 0x00200000 0x20>;
                 interrupts = <0 49 4>
                 clock-frequency = <12288000>;
           };
     };
};



Please note "ranges" property is missing from the extbus node.

As mentioned above, the address translation from the external bus
to the parent bus is run-time configurable.


It is possible to map
  CS1 of extbus  to  0x40000000-0x41ffffff of CPU view
  CS5 of extbus  to  0x42000000-0x43ffffff of CPU view

It is also possible to map
  CS1 of extbus  to  0x46000000-0x47ffffff of CPU view
  CS5 of extbus  to  0x44000000-0x45ffffff of CPU view

There is nothing preventing us from a particular
address mapping.
It is completely up to the software (driver)
to choose one mapping from another.


And I notice a conflict between the followings.

[1] Device Tree is a hardware description language.
It should not describe the software configuration.

So, ranges such as
   ranges = <1 0 0x40000000 0x02000000
             5 0 0x42000000 0x02000000>;

   or

   ranges = <1 0 0x46000000 0x02000000
             5 0 0x44000000 0x02000000>;

are configuration information, which should not be
included in the device tree.

Any address mapping is OK as long as no region overlap occurs.
No point to specify "ranges" from the device tree.


[2] of_translate_address() expects "ranges" in every bus node

When we need to translate the "reg" property into the CPU-viewed address,
we call of_translate_address().  It translates addresses,
parsing "ranges" property when crossing buses.
It potentially means, "ranges" properties are statically defined
in the device tree.


I have not been able to find a good way
to solve the conflict between [1] and [2].


To sum up, what I want is:

 - Let the driver to configure the address translation on run-time
 - Once the bus is configured, I want the sub nodes to be accessed
   from the CPU, like the other statically instantiated devices.


Any comment is welcome!


BTW, perhaps Marvell Mbus has a similar situation (run-time configurable)?
(Documentation/devicetree/bindings/bus/mvebu-mbus.txt)
I am not familiar with such SoCs, though.


-- 
Best Regards
Masahiro Yamada
