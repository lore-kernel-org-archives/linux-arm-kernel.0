From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 4 Oct 2018 21:33:59 +0530
Subject: [PATCH 12/12] arm64: dts: allwinner: bananapi-m64: Bananapi
 S070WV20-CT16 DSI panel
In-Reply-To: <20180927171747.wqdt5eiwktyyoefz@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-13-jagan@amarulasolutions.com>
 <20180927171747.wqdt5eiwktyyoefz@flea>
Message-ID: <CAMty3ZBb25EBF85oGYZFMGkW1F8DwojfwWp=UKhoTrJZmQkjZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 10:47 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Sep 27, 2018 at 05:18:50PM +0530, Jagan Teki wrote:
> > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > BPI-M64 board.
> >
> > DSI panel connected via board DSI port with,
> > - DC1SW as AVDD supply
> > - DCDC1 as DVDD supply
> > - PD6 gpio for reset pin
> > - PD5 gpio for backlight enable pin
> > - PD7 gpio for backlight vdd supply
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > index ef1c90401bb2..c0be949be68d 100644
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
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "bl-3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
> > +             enable-active-high;
> > +     };
> > +
> > +     backlight_dsi: backlight-dsi {
> > +             compatible = "pwm-backlight";
> > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +             brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
>
> The brightness levels should be increasing linearly from a user point
> of view. Usually, with a PWM backlight, a quadratic rule works much
> better.

Does that mean, 0 40 80 ...
