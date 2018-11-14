From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Nov 2018 17:22:33 +0800
Subject: [PATCH v4 25/26] [DO NOT MERGE] arm64: dts: allwinner:
 bananapi-m64: Bananapi S070WV20-CT16 DSI panel
In-Reply-To: <CAGb2v669dkf2qaUDaosJEKSRKpPRVKWszb6BLL2NrAjWwp3t2Q@mail.gmail.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-26-jagan@amarulasolutions.com>
 <20181113122204.337db8b1@donnerap.cambridge.arm.com>
 <CAMty3ZBQXcnU=490KREa=F-qctMtRep9-rrhrPd1UZStnV=hqw@mail.gmail.com>
 <CAGb2v669dkf2qaUDaosJEKSRKpPRVKWszb6BLL2NrAjWwp3t2Q@mail.gmail.com>
Message-ID: <CAGb2v64YOV48UwHc8-=jDt2Bp_4mNb3iuyEzj0d+GOQE_oT-Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 2:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Wed, Nov 14, 2018 at 2:31 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Nov 13, 2018 at 5:52 PM Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Tue, 13 Nov 2018 16:46:32 +0530
> > > Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > Hi,
> > >
> > > > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > > > BPI-M64 board.
> > > >
> > > > DSI panel connected via board DSI port with,
> > > > - DC1SW as AVDD supply
> > >
> > > Are you sure of that? I don't see anything in the schematic to support
> > > this. The only power lines that go to the DSI connector are DCDC1 and
> > > PS. DC1SW is only connected to PortD on the SoC and to the Ethernet PHY.
> > > Is there anything I miss?
> >
> > Thanks for the comment, yes dc1sw is connected in ephy. I have reused
> > dc1, BSP is attached lcd_power1 to axp81x_dc1sw [1]. I just looking
> > for someone to comment, may be we can skip this regulator attachment.
>
> That seems sketchy. The schematics show the connector has feeds from both
> the unregulated output IPSOUT (PS) and DCDC1. For designs with RGB LCD
> panels, we only see the PS feed. Since the LCD panel can be used in either
> RGB or MIPI DSI mode, I highly suspect the DCDC1 supply feeds the bridge
> IC.
>
> As for DC1SW, this is likely referenced because it provides power to the
> GPIO lines that are used to control the LCD panel. If you don't provide
> power, you can't pull them up.
>
> While many of us dislike FEX and the new FEX-derived device tree, they
> do provide some information, such as regulator usage. Note that each
> regulator output has multiple names, which likely denote specific
> usages.
>
> I've asked BPI for schematics on the bridge board. Hopefully we'll
> have something in more detail. In the meantime, I suggest leaving
> this panel out of your next submission, and focus on getting the bulk
> of the dsi driver and dts changes in first.

I got the schematics, but unfortunately I can't share them publicly.

It looks like VCC-MIPI on the connector is not connected to anything.
All power is provided from IPSOUT, first through a current limiter IC
turned on and off by LCD_PWR_EN, and then through some voltage regulators
to provide the voltages for various parts of the panel, including LCD,
capacitive touch, and the MIPI-DSI bridge. There's even an onboard EEPROM,
though I'm not sure what that's for.

> >
> > >
> > > > - DCDC1 as DVDD supply
> > >
> > > That seems right, but doesn't match with what you write below.
> >
> > Commit need to fix s/DCDC1/DLDO1
> >
> > >
> > > > - PD6 gpio for reset pin

This toggles reset for both the panel itself and for the MIPI-DSI bridge.

> > > > - PD5 gpio for backlight enable pin

This enables the backlight's regulator.

> > > > - PD7 gpio for backlight vdd supply

This enables power to the whole panel module.

Then you also have the two GPIOs for the capacitive touch controller.
And also the I2C bus for the controller, and the EEPROM.


ChenYu

> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42
> > > > +++++++++++++++++++ 1 file changed, 42 insertions(+)
> > > >
> > > > diff --git
> > > > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts index
> > > > ef1c90401bb2..6cb010e3bbd9 100644 ---
> > > > a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts +++
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts @@ -45,6
> > > > +45,7 @@ #include "sun50i-a64.dtsi"
> > > >  #include <dt-bindings/gpio/gpio.h>
> > > > +#include <dt-bindings/pwm/pwm.h>
> > > >
> > > >  / {
> > > >       model = "BananaPi-M64";
> > > > @@ -56,6 +57,15 @@
> > > >               serial1 = &uart1;
> > > >       };
> > > >
> > > > +     backlight: backlight {
> > > > +             compatible = "pwm-backlight";
> > > > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > > +             brightness-levels = <1 2 4 8 16 32 64 128 512>;
> > > > +             default-brightness-level = <2>;
> > > > +             enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /*
> > > > LCD-BL-EN: PD5 */
> > > > +             power-supply = <&reg_vdd_backlight>;
> > > > +     };
> > > > +
> > > >       chosen {
> > > >               stdout-path = "serial0:115200n8";
> > > >       };
> > > > @@ -91,6 +101,15 @@
> > > >               };
> > > >       };
> > > >
> > > > +     reg_vdd_backlight: vdd-backlight {
> > > > +             compatible = "regulator-fixed";
> > > > +             regulator-name = "vdd-backlight";
> > > > +             regulator-min-microvolt = <3300000>;
> > > > +             regulator-max-microvolt = <3300000>;
> > > > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN:
> > > > PD7 */
> > > > +             enable-active-high;
> > > > +     };
> > > > +
> > > >       wifi_pwrseq: wifi_pwrseq {
> > > >               compatible = "mmc-pwrseq-simple";
> > > >               reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> > > > @@ -101,6 +120,23 @@
> > > >       status = "okay";
> > > >  };
> > > >
> > > > +&dphy {
> > > > +     status = "okay";
> > > > +};
> > > > +
> > > > +&dsi {
> > > > +     status = "okay";
> > > > +
> > > > +     panel at 0 {
> > > > +             compatible = "bananapi,s070wv20-ct16-icn6211";
> > > > +             reg = <0>;
> > > > +             avdd-supply = <&reg_dc1sw>;
> > >
> > > As mentioned above, I don't see this on the DSI connector.
> > >
> > > > +             dvdd-supply = <&reg_dldo1>;
> > >
> > > Mmh, this line is connected to the *SoC*, to drive the DSI data lines
> > > or the DPHY, presumably. So I wouldn't expect it in the panel node, but
> > > rather in the DPHY or DSI node. Although I can't find a power-supply
> > > property in those bindings.
> >
> > Got it, this has to attach via vcc-dsi-supply.
> >
> > [1] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/bootloader/blobs/bpi-m64-lcd7.dts#L2266
