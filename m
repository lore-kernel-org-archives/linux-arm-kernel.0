From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 15 Jan 2016 15:26:24 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: Add basic support for orion-r68
In-Reply-To: <CABxcv=nkry9PUg5pp+6jKjYb_G=iEfMa7+evZOrUkifDS8h5BA@mail.gmail.com>
References: <1452863192-29231-1-git-send-email-matthias.bgg@gmail.com>
 <2174023.jkjdoEECkq@phil>
 <CABxcv=nkry9PUg5pp+6jKjYb_G=iEfMa7+evZOrUkifDS8h5BA@mail.gmail.com>
Message-ID: <1804889.MQWMfNjko2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Januar 2016, 11:22:52 schrieb Javier Martinez Canillas:
> Hello Heiko,
> 
> On Fri, Jan 15, 2016 at 11:03 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Hi Javier,
> > 
> > Am Freitag, 15. Januar 2016, 10:28:44 schrieb Javier Martinez Canillas:
> >> This is not a complete review but I just wanted to comment on two
> > 
> >> things that I noticed:
> > same for me for now :-)
> > 
> >> On Fri, Jan 15, 2016 at 10:06 AM, Matthias Brugger
> >> <matthias.bgg@gmail.com> wrote:
> >> 
> >> [snip]
> >> 
> >> > +       };
> >> > +
> >> > +       vcc_18: vcc18-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vcc_18";
> >> > +               regulator-min-microvolt = <1800000>;
> >> > +               regulator-max-microvolt = <1800000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_sys>;
> >> > +       };
> >> > +
> >> > +       /* supplies both host and otg */
> >> > +       vcc_host: vcc-host-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               gpio = <&gpio0 4 GPIO_ACTIVE_LOW>;
> >> > +               pinctrl-names = "default";
> >> > +               pinctrl-0 = <&host_vbus_drv>;
> >> > +               regulator-name = "vcc_host";
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_sys>;
> >> > +       };
> >> > +
> >> > +       vccio_sd: vcc-io-sd-regulator {
> >> > +               regulator-name= "vccio_sd";
> >> > +               gpio = <&gpio0 9 GPIO_ACTIVE_LOW>;
> >> > +               regulator-min-microvolt = <3300000>;
> >> > +               regulator-max-microvolt = <3300000>;

that seems to be missing essential regulator properties
like a compatible.

> >> > +       };
> >> > +
> >> > +       vcc_sd: vcc-sd-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vcc_sd";
> >> > +               gpio = <&gpio3 11 GPIO_ACTIVE_LOW>;
> >> > +               regulator-min-microvolt = <3300000>;
> >> > +               regulator-max-microvolt = <3300000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_io>;
> >> > +       };
> >> > +
> >> > +       vcc_io: vcc-io-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vcc_io";
> >> > +               regulator-min-microvolt = <3300000>;
> >> > +               regulator-max-microvolt = <3300000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_sys>;
> >> > +       };
> >> > +
> >> > +       vcc_lan: vcc-lan-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vcc_lan";
> >> > +               regulator-min-microvolt = <3300000>;
> >> > +               regulator-max-microvolt = <3300000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_io>;
> >> > +       };
> >> > +
> >> > +       vcc_sys: vcc-sys-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vcc_sys";
> >> > +               regulator-min-microvolt = <5000000>;
> >> > +               regulator-max-microvolt = <5000000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +       };
> >> > +
> >> > +       vccio_wl: vccio-wl-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vccio_wl";
> >> > +               regulator-min-microvolt = <3300000>;
> >> > +               regulator-max-microvolt = <3300000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_io>;
> >> > +       };
> >> > +
> >> > +       vdd_10: vdd-10-regulator {
> >> > +               compatible = "regulator-fixed";
> >> > +               regulator-name = "vdd_10";
> >> > +               regulator-min-microvolt = <1000000>;
> >> > +               regulator-max-microvolt = <1000000>;
> >> > +               regulator-always-on;
> >> > +               regulator-boot-on;
> >> > +               vin-supply = <&vcc_sys>;
> >> > +       };
> >> > +};
> >> 
> >> There is only one regulator that is not marked as always-on. This will
> >> prevent the regulator subsystem to disable unused regulators. Do you
> >> really need all of them to be always-on?
> > 
> > I do believe the regulators should be more or less correct. Sadly there
> > are no real schematics for that specific device available, but the
> > reference design for rk3368-based tv-boxes uses a hirarchy of
> > hard-wired individual regulators without any ability to control for
> > most of them [aka always on].
> > 
> > And due to the r68 not sporting any different real pmic, I'd believe the
> > Orion will most likely also follow that scheme.
> 
> I see, thanks a lot for the clarification. But then in that case I
> wonder what's the point of defining the gpio property in the fixed
> regulator device nodes?

the ones with gpio properties actually can be turned off - here they are the 
different supplies for usb and sd-card only, so leaf-regulators without 
further children.


Heiko
