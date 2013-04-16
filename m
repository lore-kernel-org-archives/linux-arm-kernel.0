From: rabryn@c2development.com (Ryan Bryngelson)
Date: Tue, 16 Apr 2013 11:47:57 -0500
Subject: iMX28 DTS GPIO IRQ Definition
Message-ID: <CAGUvELcRFK9vjx3t69ccEfjLanPSnpZmSo83fxQN0yWvbjTX7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm having trouble defining a node in imx28-evk.dts that will
configure a GPIO pin to be an IRQ (high-to-low edge triggered
interrupt).  I'm using mainline kernel version 3.8.3.  I've read the
documentation located in 'Documentation/devicetree/bindings/gpio, I
see the following in gpio-mxs.txt' where it says the following...



As the GPIO controller is embedded in the PIN controller and all the
GPIO ports share the same IO space with PIN controller, the GPIO node
will be represented as sub-nodes of MXS pinctrl node.

Required properties for GPIO node:
- compatible : Should be "fsl,<soc>-gpio".  The supported SoCs include
  imx23 and imx28.
- interrupts : Should be the port interrupt shared by all 32 pins.
- gpio-controller : Marks the device node as a gpio controller.
- #gpio-cells : Should be two.  The first cell is the pin number and
  the second cell is used to specify the gpio polarity:
      0 = active high
      1 = active low
- interrupt-controller: Marks the device node as an interrupt controller.
- #interrupt-cells : Should be 2.  The first cell is the GPIO number.
  The second cell bits[3:0] is used to specify trigger type and level flags:
      1 = low-to-high edge triggered.
      2 = high-to-low edge triggered.
      4 = active high level-sensitive.
      8 = active low level-sensitive.

Note: Each GPIO port should have an alias correctly numbered in "aliases"
node.



How would I define this?  I assume the "pin number" in the gpio-cells
definition is the bit in the port.  So if I wanted to configure port
0, bit 4 to be an interrupt, it would be '4'.  In the interrupt-cells
definition what is "GPIO number"?  I see in the imx28.dtsi the
definitions of the aliases and GPIO ports, for example...



                gpio0: gpio at 0 {
                    compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
                    interrupts = <127>;
                    gpio-controller;
                    #gpio-cells = <2>;
                    interrupt-controller;
                    #interrupt-cells = <2>;
                };



I don't see how I should define a node in the imx28-evk.dts that
defines a GPIO that is an IRQ.  The "interrupts" in the dtsi file, 127
in the example above, refer to the IRQ source in the ICOLL.  Where are
the definitions of the interrupt-cells and gpio-cells at that are
described in the gpio-mxs.txt documentation?

I'm new to the device tree and any help would be appreciated.  I've
already tried to take this up with Freescale support and they sent me
here.

Thanks,
Ryan
