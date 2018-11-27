From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 11:31:06 +0100
Subject: [PATCH 5/5] DO NOT MERGE: ARM: dts: bananapi: Add Camera support
In-Reply-To: <CAMty3ZBO6B=vgduv5u28zC8P1DOm1TYGFAVjDtJOpU8dozrk=A@mail.gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <12093630fdd7d8b43ebcb0340691e0f2200e26c6.1542097288.git-series.maxime.ripard@bootlin.com>
 <CAMty3ZBO6B=vgduv5u28zC8P1DOm1TYGFAVjDtJOpU8dozrk=A@mail.gmail.com>
Message-ID: <20181127103106.vykudp36vkyy5vme@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 12:26:09PM +0530, Jagan Teki wrote:
> On Tue, Nov 13, 2018 at 1:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 98 +++++++++++++++++++++++++-
> >  1 file changed, 98 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > index 70dfc4ac0bb5..18dbff9f1ce9 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> > @@ -54,6 +54,9 @@
> >         compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
> >
> >         aliases {
> > +               i2c0 = &i2c0;
> > +               i2c1 = &i2c1;
> > +               i2c2 = &i2c2;
> >                 serial0 = &uart0;
> >                 serial1 = &uart3;
> >                 serial2 = &uart7;
> > @@ -63,6 +66,41 @@
> >                 stdout-path = "serial0:115200n8";
> >         };
> >
> > +       reg_cam: cam {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "cam";
> > +               regulator-min-microvolt = <5000000>;
> > +               regulator-max-microvolt = <5000000>;
> > +               vin-supply = <&reg_vcc5v0>;
> > +               gpio = <&pio 7 16 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               regulator-always-on;
> > +       };
> > +
> > +        reg_cam_avdd: cam-avdd {
> > +                compatible = "regulator-fixed";
> > +                regulator-name = "cam500b-avdd";
> > +                regulator-min-microvolt = <2800000>;
> > +                regulator-max-microvolt = <2800000>;
> > +                vin-supply = <&reg_cam>;
> > +        };
> > +
> > +        reg_cam_dovdd: cam-dovdd {
> > +                compatible = "regulator-fixed";
> > +                regulator-name = "cam500b-dovdd";
> > +                regulator-min-microvolt = <1800000>;
> > +                regulator-max-microvolt = <1800000>;
> > +                vin-supply = <&reg_cam>;
> > +        };
> > +
> > +        reg_cam_dvdd: cam-dvdd {
> > +                compatible = "regulator-fixed";
> > +                regulator-name = "cam500b-dvdd";
> > +                regulator-min-microvolt = <1500000>;
> > +                regulator-max-microvolt = <1500000>;
> > +                vin-supply = <&reg_cam>;
> > +        };
> > +
> >         hdmi-connector {
> >                 compatible = "hdmi-connector";
> >                 type = "a";
> > @@ -120,6 +158,27 @@
> >                 >;
> >  };
> >
> > +&csi0 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&csi0_pins_a>;
> > +       status = "okay";
> > +
> > +       port {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               csi_from_ov5640: endpoint {
> > +                        remote-endpoint = <&ov5640_to_csi>;
> > +                        bus-width = <8>;
> > +                        data-shift = <2>;
> > +                        hsync-active = <1>; /* Active high */
> > +                        vsync-active = <0>; /* Active low */
> > +                        data-active = <1>;  /* Active high */
> > +                        pclk-sample = <1>;  /* Rising */
> > +                };
> > +       };
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> > @@ -167,6 +226,39 @@
> >         };
> >  };
> >
> > +&i2c1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&i2c1_pins_a>;
> > +       status = "okay";
> > +
> > +       camera: camera at 21 {
> > +               compatible = "ovti,ov5640";
> > +               reg = <0x21>;
> > +                clocks = <&ccu CLK_CSI0>;
> > +                clock-names = "xclk";
> > +               assigned-clocks = <&ccu CLK_CSI0>;
> > +               assigned-clock-rates = <24000000>;
> > +
> > +                reset-gpios = <&pio 7 14 GPIO_ACTIVE_LOW>;
> > +                powerdown-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>;
> > +                AVDD-supply = <&reg_cam_avdd>;
> > +                DOVDD-supply = <&reg_cam_dovdd>;
> > +                DVDD-supply = <&reg_cam_dvdd>;
> > +
> > +                port {
> > +                        ov5640_to_csi: endpoint {
> > +                                remote-endpoint = <&csi_from_ov5640>;
> > +                                bus-width = <8>;
> > +                                data-shift = <2>;
> > +                                hsync-active = <1>; /* Active high */
> > +                                vsync-active = <0>; /* Active low */
> > +                                data-active = <1>;  /* Active high */
> > +                                pclk-sample = <1>;  /* Rising */
> > +                        };
> > +                };
> > +       };
> 
> Does ov5640 need any further patches, wrt linux-next? I'm trying to
> test this on top of linux-next but the slave id seems not detecting.
> 
> [    2.304711] ov5640 1-0021: Linked as a consumer to regulator.5
> [    2.310639] ov5640 1-0021: Linked as a consumer to regulator.6
> [    2.316592] ov5640 1-0021: Linked as a consumer to regulator.4
> [    2.351540] ov5640 1-0021: ov5640_init_slave_id: failed with -6
> [    2.357543] ov5640 1-0021: Dropping the link to regulator.5
> [    2.363224] ov5640 1-0021: Dropping the link to regulator.6
> [    2.368829] ov5640 1-0021: Dropping the link to regulator.4
> 
> Here is the full log [1], please let me know if I miss anything, I
> even tried to remove MCLK pin

You seem to have made local modifications to your tree, what are they?
This indicates that the communication over i2c doesn't work, what is
your setup?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/7a6ac65e/attachment-0001.sig>
