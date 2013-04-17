From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Apr 2013 12:41:26 +0800
Subject: iMX28 DTS GPIO IRQ Definition
In-Reply-To: <CAGUvELcukT8Ei13HnrE2rxxkaV3+TW7W+ovP0sd=kGcBOtKgvQ@mail.gmail.com>
References: <CAGUvELcRFK9vjx3t69ccEfjLanPSnpZmSo83fxQN0yWvbjTX7w@mail.gmail.com>
 <20130417031512.GA3338@S2101-09.ap.freescale.net>
 <CAGUvELcukT8Ei13HnrE2rxxkaV3+TW7W+ovP0sd=kGcBOtKgvQ@mail.gmail.com>
Message-ID: <20130417044124.GI11245@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 10:41:40PM -0500, Ryan Bryngelson wrote:
> pca9555: pca9555 at 20 {
>     compatible = "nxp,pca9555";
>     interrupt-parent = <&gpio2>;
>     interrupts = <19 0x2>;
>     gpio-controller;
>     #gpio-cells = <2>;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>     reg = <0x20>;
> };
> 
> I'm learning about the device tree.  Is it correct to say "interrupts"
> corresponds to "#interrupt-cells" and "gpios" corresponds to
> "gpio-cells"?  If so, why is "gpios" missing from this definition?

#interrupt-cells and #gpio-cells are properties of interrupt controller
and gpio controller.  The reason you are seeing them in pca9555 is
because that the device acts as both a interrupt controller and a gpio
controller.  And that's why the node has properties "gpio-controller"
and interrupt-controller.  This is the same case as gpio device.  But
meanwhile pca9555 is also a interrupt client device of gpio2.  And
properties "interrupts" and "interrupt-parent" are used to tell that.

I should probably give you a simpler example firstly.  You may want to
look at "lan9220 at f4000000" node in arch/arm/boot/dts/imx53-ard.dts.
That's a pure interrupt client device.

> I
> see that GPIO2_19 is configured to have it's internal pull up enabled
> in the hog_pins_cfa10049_pullup node.  What are "hog_pins"?

We put the pins that do not have a clear owner device and should only be
configured for once on given board in "hog_pins".  And pinctrl core will
set up these pins during initialization.

Shawn
