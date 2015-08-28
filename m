From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Fri, 28 Aug 2015 16:31:44 +0300
Subject: [PATCH 6/6] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <20150828123805.GN29389@lukather>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-7-git-send-email-wens@csie.org>
 <20150828123805.GN29389@lukather>
Message-ID: <20150828163144.239e9bd5@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Aug 2015 14:38:05 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, Aug 28, 2015 at 05:54:39PM +0800, Chen-Yu Tsai wrote:
> > From: Karsten Merker <merker@debian.org>
> > 
> > The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
> > 768x1024 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
> > rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
> > and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
> > (both volume buttons are also connected to the UBOOT_SEL pin). The

Actually this part about both volume buttons turned out to be not
perfectly accurate. We have discussed it with Chen-Yu Tsai on IRC
several days ago and also corrected this information in the wiki:

    http://linux-sunxi.org/index.php?title=MSI_Primo81&diff=14802&oldid=14767

That's just a minor nitpick. And I'm sorry for providing this originally
wrong information in the first revision of the patch in the first place.

> > external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
> > OTG and 3.5mm headphone jack. More details are available at
> > 
> >     http://linux-sunxi.org/MSI_Primo81
> 
> Again, not a huge fan of the commit logs URL...

But you are not strongly objecting to it either, right?

AFAIK many people are in favour of having links to the device pages in
the linux-sunxi wiki listed somewhere in the commit logs or along with
the board maintainer contact information (in U-Boot). Because these
pages contain the most relevant and up to date information about the
device, various pictures, tips and tricks, etc.

If you are worried about linux-sunxi.org suddenly going down and not
coming back, there is also webarchive:

    http://web.archive.org/web/*/http://linux-sunxi.org/MSI_Primo81

> This commit log is already fine without it.

This commit log is a nice example of why having a link to the wiki page
is a good idea. The errors and omissions in the wiki page can be
corrected. The old commit logs can't.

> > 
> > USB OTG is enabled in host only mode. AXP221 USB power supply and
> > GPIO support are required for full USB OTG support.
> > 
> > Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> > Signed-off-by: Karsten Merker <merker@debian.org>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > 
> > Changes since v4:
> > 
> >   - Use axp221.dtsi and add all active regulators.
> >   - Enable i2c controllers for capacitive touch panel and accelerometer.
> >   - Mark i2c controller for camera sensors as failed for now.
> >   - Enable USB OTG in host only mode.
> >   - Drop uart0 as this is not tested.
> >   - s/library/file/ in GPL header.
> > 
> > ---
> >  arch/arm/boot/dts/Makefile               |   1 +
> >  arch/arm/boot/dts/sun6i-a31s-primo81.dts | 255 +++++++++++++++++++++++++++++++
> >  2 files changed, 256 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index ada5156fdd49..c87513ed4eb4 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -579,6 +579,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
> >  	sun6i-a31-m9.dtb \
> >  	sun6i-a31-mele-a1000g-quad.dtb \
> >  	sun6i-a31s-cs908.dtb \
> > +	sun6i-a31s-primo81.dtb \
> >  	sun6i-a31s-sina31s.dtb
> >  dtb-$(CONFIG_MACH_SUN7I) += \
> >  	sun7i-a20-bananapi.dtb \
> > diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > new file mode 100644
> > index 000000000000..d22befaf363b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> > @@ -0,0 +1,255 @@
> > +/*
> > + * Copyright 2014 Siarhei Siamashka <siarhei.siamashka@gmail.com>
> > + * Copyright 2015 Karsten Merker <merker@debian.org>
> > + * Copyright 2015 Chen-Yu Tsai <wens@csie.org>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun6i-a31s.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pinctrl/sun4i-a10.h>
> > +
> > +/ {
> > +	model = "MSI Primo81 tablet";
> > +	compatible = "msi,primo81", "allwinner,sun6i-a31s";
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&reg_dcdc2>;
> > +};
> > +
> > +&ehci0 {
> > +	/* rtl8188etv wifi is connected here */
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins_a>;
> > +	/* pull-ups and device VDDIO require AXP221 DLDO3 */
> 
> Now that we have AXP221, that can probably be solved, right?
> 
> > +	status = "failed";
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins_a>;
> > +	status = "okay";
> > +
> > +	ctp at 5d {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&gt911_int_primo81>;
> > +		compatible = "goodix,gt911";
> > +		reg = <0x5d>;
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
> > +		/*
> > +		 * The default 0,0 coordinate is at the corner closest to
> > +		 * the headphone jack. X goes along the long side, while
> > +		 * Y goes along the short side.
> > +		 */
> 
> I'm not exactly sure what that comment is supposed to be for...

It's probably a human readable comment intended to be read by humans.

Yeah, this information might actually better belong to the wiki page.
But then again, this brings us to the question whether we should have
a link to the linux-sunxi wiki page somewhere in the dts.

-- 
Best regards,
Siarhei Siamashka
