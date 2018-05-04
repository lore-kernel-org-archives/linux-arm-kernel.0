From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 10:06:52 +0200
Subject: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
In-Reply-To: <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
 <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
Message-ID: <20180504080652.dniwaqqhbeuknp7y@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 02, 2018 at 06:41:34PM +0200, Giulio Benetti wrote:
> > > You don't have to handcode the fragments anymore with the new syntax,
> > > and U-Boot makes it really trivial to use if you use the FIT image
> > > format to have multiple overlays bundled in the same image. You can
> > > choose to apply them dynamically, for example based on an EEPROM or
> > > some other metric to see which combination you have.
> > 
> > Ah, this is interesting. I'm going to experiment with that.
> > 
> 
> I'm struggling against this, I don't really know how to proceed,
> except keeping monolithic dts files including other dtsi files.
> 
> About dt-overlays I've tried to look around lot of time,
> but the only thing I've found is this:
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm/boot/dts?h=topic/renesas-overlays
> 
> where they use .dtso tagging them as "/plugin/;"
> and compile all .dtso found in dts folder.
> Then they obtain .dtbo files that should be the dt-overlays we have spoken
> about right?

Yes. You don't have to do that though, you can just rely on dtc to
compile them, outside of the linux build system.

> What I can't understand is if there's a real standard at this time to
> follow, because on renesas-driver they use their way to handle all .dtso
> files, but on mainline there seems to be nothing about that.

I'm not sure what you mean here. It's just fragments of device tree,
that have to be compiled using dtc, that's it. You can use the Linux
build system infrastructure to do that, or you can build your own
simpler one. That's really up to you. See for example
https://github.com/NextThingCo/CHIP-dt-overlays/blob/master/Makefile

(even though the overlays themselves use the legacy syntax and
shouldn't really be used an examples)

> So at the moment I'm trying to compile dts tagged as /plugin/;
> but dtc gives me a lot of warnings.
> 
> dts:
> "
> /dts-v1/;
> /plugin/;
> 
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/interrupt-controller/irq.h>
> 
> &i2c2 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&i2c2_pins_a>;
> 	status = "okay";
> 
> 	ft5x {
> 		compatible = "edt,edt-ft5306";
> 		reg = <0x38>;
> 		interrupt-parent = <&pio>;
> 		interrupts = <7 2 IRQ_TYPE_EDGE_FALLING>; /* PH2 */
> 		reset-gpios = <&pio 7 3 GPIO_ACTIVE_LOW>; /* PH3 */
> 		touchscreen-size-x = <480>;
> 		touchscreen-size-y = <272>;
> 	};
> };
> "
> 
> Build output issuing make ARCH=arm CROSS_COMPILE=arm-linux- aaa.dtb (I use
> aaa.dts as source):
> "
> arch/arm/boot/dts/aaa.dtb: Warning (reg_format):
> /fragment at 0/__overlay__/ft5x:reg: property has invalid length (4 bytes)
> (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/aaa.dtb: Warning (pci_device_bus_num): Failed prerequisite
> 'reg_format'
> arch/arm/boot/dts/aaa.dtb: Warning (simple_bus_reg): Failed prerequisite
> 'reg_format'
> arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size):
> /fragment at 0/__overlay__/ft5x: Relying on default #address-cells value
> arch/arm/boot/dts/aaa.dtb: Warning (avoid_default_addr_size):
> /fragment at 0/__overlay__/ft5x: Relying on default #size-cells value
> "

Yeah, your i2c node doesn't have the right address-cells and
size-cells properties value, like dtc is telling you.

> Then in uboot I'm trying to do as follows:
> # fdt addr 0x43000000 (where dtb is)
> # fdt resize 8192
> # fdt apply 0x430c0000 (where dtbo is)
> But it gives me "libfdt fdt_check_header(): FDT_ERR_BADMAGIC"
> (I was expecting some error)

It looks like your overlay hasn't been properly loaded.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/149226f9/attachment.sig>
