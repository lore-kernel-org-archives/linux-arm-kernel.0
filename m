From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Oct 2018 21:36:20 +0100
Subject: [PATCH v2 15/15] arm64: dts: allwinner: bananapi-m64: Bananapi
 S070WV20-CT16 DSI panel
In-Reply-To: <20181024181159.35lm7ihqestbetvb@flea>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-16-jagan@amarulasolutions.com>
 <20181024181159.35lm7ihqestbetvb@flea>
Message-ID: <CAGb2v66MwbY1yHN8TLpChRfJPCd7-3qmH3O1R2Ku4wRzJfOu=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 7:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Oct 23, 2018 at 09:20:35PM +0530, Jagan Teki wrote:
> > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > BPI-M64 board.
> >
> > DSI panel connected via board DSI port with,
> > - DC1SW as AVDD supply
> > - DCDC1 as DVDD supply
> > - PD6 gpio for reset pin
> > - PD5 gpio for backlight enable pin
> > - PD7 gpio for backlight vdd supply

This is for a removable module, which is best handled using an overlay.
This patch should be marked [DO NOT MERGE].

> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - Use quadratic rule on pwm brightness
> >
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > index ef1c90401bb2..e0c6d1870a94 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > @@ -45,6 +45,7 @@
> >  #include "sun50i-a64.dtsi"
> >
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pwm/pwm.h>
> >
> >  / {
> >       model = "BananaPi-M64";
> > @@ -56,6 +57,24 @@
> >               serial1 = &uart1;
> >       };
> >
> > +     vdd_bl: regulator at 0 {
>
> You shouldn't have a unit address if you don't have a reg
> property. This will trigger a DTC warning.
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "bl-3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
> > +             enable-active-high;
> > +     };
> > +
> > +     backlight_dsi: backlight-dsi {

This should be just "backlight". There's nothing DSI specific
about a backlight.

> > +             compatible = "pwm-backlight";
> > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +             brightness-levels = <1 2 4 8 16 32 64 128 512>;
> > +             default-brightness-level = <2>;
> > +             enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* PD5 */
> > +             power-supply = <&vdd_bl>;
> > +     };
>
> These nodes should be ordered by alphabetical order.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
