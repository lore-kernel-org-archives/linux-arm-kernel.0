From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 4 Jun 2018 10:51:11 +0200
Subject: [PATCH 1/3] arm64: allwinner: a64: add R_I2C controller
In-Reply-To: <CA+E=qVfH3wWsSdzGn353q0Jf-PQ8cjU-i5osLOV1c4qWVGrR5A@mail.gmail.com>
References: <20180601062901.8052-1-anarsoul@gmail.com>
 <20180601062901.8052-2-anarsoul@gmail.com>
 <20180601091631.wqctilk55fcmggwv@flea>
 <CA+E=qVfH3wWsSdzGn353q0Jf-PQ8cjU-i5osLOV1c4qWVGrR5A@mail.gmail.com>
Message-ID: <20180604085111.s23qamdethe6sr6d@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 10:30:00AM -0700, Vasily Khoruzhick wrote:
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index 1b2ef28c42bd..b5e903ccf0ec 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -46,6 +46,7 @@
> >>  #include <dt-bindings/clock/sun8i-r-ccu.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
> >> +#include <dt-bindings/reset/sun8i-r-ccu.h>
> >>
> >>  / {
> >>       interrupt-parent = <&gic>;
> >> @@ -655,6 +656,17 @@
> >>                       #reset-cells = <1>;
> >>               };
> >>
> >> +             r_i2c: i2c at 1f02400 {
> >> +                     compatible = "allwinner,sun6i-a31-i2c";
> >
> > You should add an a64 compatible here
> 
> We don't have it for regular i2c, why should I add it here?

We miss some of them. Adding for i2c would make sense too.

> >> +                     reg = <0x01f02400 0x400>;
> >> +                     interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> >> +                     clocks = <&r_ccu CLK_APB0_I2C>;
> >> +                     resets = <&r_ccu RST_APB0_I2C>;
> >> +                     status = "disabled";
> >> +                     #address-cells = <1>;
> >> +                     #size-cells = <0>;
> >> +             };
> >> +
> >>               r_pio: pinctrl at 1f02c00 {
> >>                       compatible = "allwinner,sun50i-a64-r-pinctrl";
> >>                       reg = <0x01f02c00 0x400>;
> >> @@ -670,6 +682,11 @@
> >>                               pins = "PL0", "PL1";
> >>                               function = "s_rsb";
> >>                       };
> >> +
> >> +                     r_i2c_pins_a: i2c-a {
> >> +                             pins = "PL8", "PL9";
> >> +                             function = "s_i2c";
> >> +                     };
> >
> > This should be ordered by alphabetical order
> 
> OK
> 
> > If this is the only muxing option, you can also add it to the i2c DT
> > node.
> 
> It's not the only option, but other option conflicts with rsb. Should
> I still add it to i2c DT node?

I guess you can put it there, the muxing will only be enforced if the
device is enabled, and there should be only one of RSB or I2C that
would be.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/51e52d58/attachment.sig>
