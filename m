From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 25 Nov 2017 10:50:04 +0100 (CET)
Subject: [PATCH] ARM: dts: add minimal device tree for compute model 3
In-Reply-To: <84679F1A-7EF2-44FD-B8CC-F2D01C313E17@martin.sperl.org>
References: <20171124121813.11318-1-kernel@martin.sperl.org>
 <787908872.337073.1511557057220@email.1und1.de>
 <84679F1A-7EF2-44FD-B8CC-F2D01C313E17@martin.sperl.org>
Message-ID: <905313235.319254.1511603404501@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

> kernel at martin.sperl.org hat am 25. November 2017 um 08:32 geschrieben:
> 
> 
> 
> > On 24.11.2017, at 21:57, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Since we need always 2 boards (SoM + carrier), i like to see two separate DT files. A DTSI file for the SoM (describe RAM, eMMC) and a DTS file for the carrier board (please look at arm/boot/dts/imx6ul-tx6ul.dtsi and arm/boot/dts/imx6ul-tx6ul-mainboard.dts as an example).
> > 
> > Suggested include hierarchy:
> > 
> >  bcm2837.dtsi
> >    bcm2837-rpi-cm3.dtsi
> >      bcm2837-rpi-cm3-io3.dts
> > 
> 
> I shall give it a try.
> 
> But it would require possibly 2 versions of the cm-module:
> * the one including emmc
> * the one exposing the sd-card ports/pins (CM3-Lite)

I don't have those modules. In case it's possible to create a DTSI which applies for both of them then i prefer this. In theory there are two extremes:

1) Create a DTS for all Compute Modules (like the Raspberry Pi foundation)
2) Create DTS/DTSI files for all possible combinations

I think none of them are practical. In case 1 3rd party vendors would start to copy the DTS file and case 2 is hard to maintain. So we need to try something in the middle by starting with a DTSI file which applies to all CM3 (including the Lite) and a DTS which applies to all Raspberry Pi IO Boards and include the CM3 DTSI.

> 
> But then I could go as far as including the ?classic? CM V1 as well...

Yeah, that's the idea.

> 
> >> 	bcm2835-rpi-zero.dtb \
> >> 	bcm2835-rpi-zero-w.dtb
> >> dtb-$(CONFIG_ARCH_BCM_5301X) += \
> >> diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3.dts
> >> new file mode 100644
> >> index 000000000000..f387bd8bd707
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dts
> >> @@ -0,0 +1,38 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/dts-v1/;
> >> +#include "bcm2837.dtsi"
> >> +#include "bcm2835-rpi.dtsi"
> >> +#include "bcm283x-rpi-usb-host.dtsi"
> >> +
> >> +/ {
> >> +	compatible = "raspberrypi,3-compute-model", "brcm,bcm2837";
> > 
> > s/compute-model/compute-module/

Btw i forgot to mention this needs to be documented here [1] in a separate patch.

> > 
> >> +	model = "Raspberry Pi Compute Module 3";
> > 
> > Raspberry Pi Compute Module 3 on a IO board V3
> > 
> 
> That is not necessarily true - I am running the CM3 on a IO-board v1 so that one is compatible?

AFAIK this combination is not recommend, because the old IO board doesn't provide enough power for all use cases. But that's not the point about my comment. We need to describe the combination.

How about "Raspberry Pi Compute Module 3 on a IO board" and "bcm2837-rpi-cm3-io.dts" ?

> 
> >> 
> >> +/* SDHOST is used to drive the SD card */
> > 
> > Since this is an eMMC please drop this misleading comment.
> > 
> 
> for a CM3-Lite it is exposing sd card pins
> 
> >> +&sdhost {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&sdhost_gpio48>;
> >> +	status = "okay";
> >> +	bus-width = <4>;
> > 
> > non-removable;
> 
> See comment about Lite...

Okay, i'm fine without it but then we need a comment that the upcoming DTSI should apply to CM3 and CM3-Lite. Also the commit log should mention the CM3-Lite so everybody understand it.

Please wait a little bit before sending your second version to give the others some time for comments.

Thanks
Stefan

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt

> 
> Martin
>
