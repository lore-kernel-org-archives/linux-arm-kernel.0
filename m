From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Mon, 09 Jan 2017 08:33:11 +0100
Subject: [PATCH v2] ARM: dts: sun7i: Add wifi dt node on Banana Pro
In-Reply-To: <20170109071050.d533vekwrfwslxdw@lukather>
References: <20170105173753.14024-1-joerg.krause@embedded.rocks>
 <20170105181151.i3ttsu5ylrw45br7@lukather>
 <1483642871.27207.1.camel@embedded.rocks>
 <20170109071050.d533vekwrfwslxdw@lukather>
Message-ID: <1483947191.4334.1.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, 2017-01-09 at 08:10 +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Jan 05, 2017 at 08:01:11PM +0100, J?rg Krause wrote:
> > Hi Maxim,
> > 
> > On Thu, 2017-01-05 at 19:11 +0100, Maxime Ripard wrote:
> > > Hi J?rg,
> > > 
> > > On Thu, Jan 05, 2017 at 06:37:53PM +0100, J?rg Krause wrote:
> > > > The Banana Pro has an AMPAK AP6181 WiFi+Bluetooth module. The
> > > > WiFi
> > > > part
> > > > is a BCM43362 IC connected to MMC3 of the A20 SoC via SDIO. The
> > > > IC
> > > > also
> > > > takes a power enable signal via GPIO.
> > > > 
> > > > This commit adds a device-tree node to power it up, so the mmc
> > > > subsys
> > > > can scan it, and enables the mmc controller which is connected
> > > > to
> > > > it.
> > > > 
> > > > As the wifi enable pin of the AP6181 module is not really a
> > > > regulator,
> > > > switch the mmc3 node to the mmc-pwrseq framework for
> > > > controlling
> > > > it.
> > > > This more accurately reflectes how the hardware actually works.
> > > > 
> > > > Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
> > > > ---
> > > > Changes v2 (suggested by Maxime Ripard):
> > > > ? - rename pwrseq node to clarify the function rather what it's
> > > > ????connected to
> > > > ? - use dash instead of underscore for the pwrseq node name
> > > > ? - remove setting pull-ups for mmc3 (default since commit
> > > > 37bc56128d92)
> > > > 
> > > > ---
> > > > ?arch/arm/boot/dts/sun7i-a20-bananapro.dts | 30
> > > > ++++++++++++++++++-
> > > > -----------
> > > > ?1 file changed, 18 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> > > > b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> > > > index 19d63d4049de..77f8fb76c157 100644
> > > > --- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> > > > +++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> > > > @@ -76,6 +76,13 @@
> > > > ?		};
> > > > ?	};
> > > > ?
> > > > +	wifi_pwrseq: wifi-pwrseq {
> > > > +		compatible = "mmc-pwrseq-simple";
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&vmmc3_pin_bananapro>;
> > > > +		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>;
> > > > +	};
> > > > +
> > > > ?	reg_gmac_3v3: gmac-3v3 {
> > > > ?		compatible = "regulator-fixed";
> > > > ?		pinctrl-names = "default";
> > > > @@ -87,17 +94,6 @@
> > > > ?		enable-active-high;
> > > > ?		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
> > > > ?	};
> > > > -
> > > > -	reg_vmmc3: vmmc3 {
> > > > -		compatible = "regulator-fixed";
> > > > -		pinctrl-names = "default";
> > > > -		pinctrl-0 = <&vmmc3_pin_bananapro>;
> > > > -		regulator-name = "vmmc3";
> > > > -		regulator-min-microvolt = <3300000>;
> > > > -		regulator-max-microvolt = <3300000>;
> > > > -		enable-active-high;
> > > > -		gpio = <&pio 7 22 GPIO_ACTIVE_HIGH>;
> > > > -	};
> > > > ?};
> > > > ?
> > > > ?&ahci {
> > > > @@ -166,10 +162,20 @@
> > > > ?&mmc3 {
> > > > ?	pinctrl-names = "default";
> > > > ?	pinctrl-0 = <&mmc3_pins_a>;
> > > > -	vmmc-supply = <&reg_vmmc3>;
> > > > +	vmmc-supply = <&reg_vcc3v3>;
> > > > +	mmc-pwrseq = <&wifi_pwrseq>;
> > > > ?	bus-width = <4>;
> > > > ?	non-removable;
> > > > +	wakeup-source;
> > > 
> > > Sorry for not spotting that earlier, but this is suspicious. The
> > > PIO
> > > is not able to be wake up the CPU, since it's connected to the
> > > GIC
> > > that is shut down during CPU suspend. Our only wake up source is
> > > the
> > > NMI controller. So either it is not able to wake up the system,
> > > or
> > > the
> > > interrupt line in not the right one.
> > 
> > Sorry, but I'm not sure I understand...
> > 
> > The "WIFI-HOST-WAKE" line connects "WL_HOST_WAKE" of the AP6210 to
> > pin
> > EINT15 of the A20 as shown in the schematic of the board [1].
> > 
> > Note, that this is the same hardware configuration as done on the
> > Banana Pi M1+ [2]. The device tree node for mmc3 of the M1+ has
> > "wakeup-source" enabled, too, so I inherited it. However, I did not
> > tested the wake-up feature.
> 
> This is exactly the wakeup-source property that is suspicious, and
> probably doesn't work on the BPi either. Either way, we don't have
> suspend support at all on both of these boards, so you can just
> remove
> it and we will figure it out later.

I see! I'll remove this property and send an updated version. Many
thanks for the review!

J?rg
