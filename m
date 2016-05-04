From: chunkeey@googlemail.com (Christian Lamparter)
Date: Wed, 04 May 2016 06:53:50 +0200
Subject: [RFC v6 1/3] gpio: dt-bindings: add wd,mbl-gpio bindings
In-Reply-To: <20160504022210.GA9913@rob-hp-laptop>
References: <cover.1462104492.git.chunkeey@googlemail.com>
 <103bf8fceb426a9c3b09641ea989955e3ec1c7d4.1462104492.git.chunkeey@googlemail.com>
 <20160504022210.GA9913@rob-hp-laptop>
Message-ID: <4330813.s9mxBLCsXA@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 03, 2016 09:22:10 PM Rob Herring wrote:
> On Sun, May 01, 2016 at 02:18:37PM +0200, Christian Lamparter wrote:
> > This patch adds the device tree bindings for the Western Digital's
> > MyBook Live memory-mapped GPIO controllers.
> > 
> > The gpios will be supported by gpio-mmio code of the
> > GPIO generic library.
> > 
> > +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> > @@ -0,0 +1,38 @@
> > +Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.
> 
> Are these really product level GPIOs rather than some SOC's GPIOs 
> (APM?)?
> 
Ah, that's a good point. 

In a nutshell: The APM82181 SoC has two proper/normal GPIO controllers
which have a dt-binding and a kernel driver ready to go.
However Western Digital went with their own GPIO controller for
the MyBook Live [7].

Long version:
I know this SoC does have proper GPIO controllers [0].
For reference: I've helped making a OpenWRT port for the Cisco Meraki MR24
which uses it/them [1], [2]. Here's the GPIO extract from the MR24 DTS [3]:

--- MR24 DTS ---
	GPIO0: gpio at ef600b00 {
   		compatible = "ibm,ppc4xx-gpio";
       reg = <0xef600b00 0x00000048>; 
       #gpio-cells = <2>;
       gpio-controller;
    };
--- snap ---

The driver for the "ibm,ppc4xx-gpio" is located under: 
arch/powerpc/sysdev/ppc4xx_gpio.c [4].
I can't find a dt binding text for it, if you want I can write one >later<.
The "ppc4xx" moniker is a strong indication that these GPIO controllers 
were carried over from the ppc46x/44x/40x series. 
The address (but not the range): 0x00000004 ef600b00 does match with the
System Memory Map of the PPC460EX (See GPIO0 Controller on page 8 [5]).

Now for the MyBook Live: The GPIO situation is completely different.
Unlike the MR24, there are two GPIOs. The first one is on address
0x4e0000000. It drives the 3-color LED, Ethernet PHY Reset, USB-Core Power,
SATA Port0 and Port1 Power, NOR Flash Switch and the reset button driver.

The second GPIO only has one input connected. It BIT2 represents the state
of the reset button. It is located at 0x4e0100000. (The 0x4e0xxxxx address
puts the GPIO devices on the EBC (aka External Peripheral Bus Controller).
The EBC is normally used for "direct attachment of memory devices such as
ROM, SRAM, ...")

Western Digital did release their version of the GPIO driver: apollo3g-gpio.c
as part of their GPL sources [6]. (I found a mostly untouched version of the
apollo3g-gpio.c driver on github [7] (AFAICT he added the "porting to kernel 
3.2.64 by night_ghost@..."  string, other than that it should be pretty much
identical to what's inside the GPL.tar.gz).

So, I think the MyBook Live's GPIO controller is definitively something WD
cooked up by themselves in their labs. But I have no idea why they didn't
use the SoC's GPIO like Cisco... But sadly they really didn't...

Note:
If someone wants to look and play with this curiosity. I have a small
stack of DIY "MyBook Live kits", so I can sent one or two away easily.
For assembling a kit: one need a working 3.5" SATA HDD and a 12v 1.25A
PSU with a standard 5.5mm x 2.1mm power jack. I made a Debian image for 
development (download). So, if someone is interested: PM me.

Regards,
Christian

[0] <https://c1170156.ssl.cf3.rackcdn.com/UK_AMC_APM82181-SKE1000T_DS.pdf>
[1] <https://wikidevi.com/wiki/Cisco_Meraki_MR24>
[2] <https://forum.openwrt.org/viewtopic.php?pid=316793#p316793>
[3] <https://github.com/riptidewave93/Openwrt-MR24/blob/master/overlay/target/linux/apm821xx/dts/MR24.dts#L251>
[4] <https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/sysdev/ppc4xx_gpio.c>
[5] <http://datasheet.octopart.com/PPC460EX-NUB800T-AMCC-datasheet-11553412.pdf>
[6] <http://support.wdc.com/downloads.aspx?p=132&lang=en>
[7] <https://github.com/MyBookLive/kernel-4.0.x/blob/master/03_enable_leds.patch>

> +The Western Digital MyBook Live has two memory-mapped GPIO controllers.
> +Both GPIO controller only have a single 8-bit data register, where GPIO
> +state can be read and/or written.
> +
> +Required properties:
> +     - compatible: should be "wd,mbl-gpio"
> +     - reg-names: must contain
> +             "dat" - data register
> +     - reg: address + size pairs describing the GPIO register sets;
> +             order must correspond with the order of entries in reg-names
> +     - #gpio-cells: must be set to 2. The first cell is the pin number and
> +                     the second cell is used to specify the gpio polarity:
> +                     0 = active high
> +                     1 = active low
> +     - gpio-controller: Marks the device node as a gpio controller.
> +
> +Optional properties:
> +     - no-output: GPIOs are read-only.
> +
> +Examples:
> +     gpio0: gpio0 at e0000000 {
> +             compatible = "wd,mbl-gpio";
> +             reg-names = "dat";
> +             reg = <0xe0000000 0x1>;
> +             #gpio-cells = <2>;
> +             gpio-controller;
> +     };
> +
> +     gpio1: gpio1 at e0100000 {
> +             compatible = "wd,mbl-gpio";
> +             reg-names = "dat";
> +             reg = <0xe0100000 0x1>;
> +             #gpio-cells = <2>;
> +             gpio-controller;
> +             no-output;
> +     };
> -- 
> 2.8.1
> 
