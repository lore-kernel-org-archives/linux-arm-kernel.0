From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 7 May 2016 11:49:14 +0200
Subject: [RFC PATCH 05/12] ARM: dts: exynos: Configure Exynos5410 pinctrl
 for eMMC and SD card
In-Reply-To: <CAGOxZ52sH9vcN0MXxhX1ee7wr9Ao6Na=5X1bXxQo+6uvvWCbJA@mail.gmail.com>
References: <1462297949-13824-1-git-send-email-krzk@kernel.org>
 <1462297949-13824-6-git-send-email-krzk@kernel.org>
 <CAGOxZ52sH9vcN0MXxhX1ee7wr9Ao6Na=5X1bXxQo+6uvvWCbJA@mail.gmail.com>
Message-ID: <20160507094914.GA3731@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 07, 2016 at 10:23:52AM +0530, Alim Akhtar wrote:
> Hi Krzysztof,
> 
> On Tue, May 3, 2016 at 11:22 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Configure the pinctrl for MMC0 (eMMC) and MMC2 (microSD card).
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > ---
> >
> > I am not sure about sd0_rclk. Also I wonder whether this should go to
> > board DTS...
> > ---
> >  arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 87 +++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> > index f9aa6bb55464..dc12a79b8b32 100644
> > --- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
> > @@ -277,6 +277,93 @@
> >                 interrupt-controller;
> >                 #interrupt-cells = <2>;
> >         };
> > +
> > +       sd0_clk: sd0-clk {
> > +               samsung,pins = "gpc0-0";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <0>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_cmd: sd0-cmd {
> > +               samsung,pins = "gpc0-1";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <0>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_cd: sd0-cd {
> > +               samsung,pins = "gpc0-2";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <3>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus1: sd0-bus-width1 {
> > +               samsung,pins = "gpc0-3";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <3>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus4: sd0-bus-width4 {
> > +               samsung,pins = "gpc0-4", "gpc0-5", "gpc0-6";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <3>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       sd0_bus8: sd0-bus-width8 {
> > +               samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <3>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +
> > +       /* TODO: What's up with with rclk? On Odroid XU this is missing... */
> > +       /*
> > +       sd0_rclk: sd0-rclk {
> > +               samsung,pins = "gpc0-7";
> > +               samsung,pin-function = <2>;
> > +               samsung,pin-pud = <1>;
> > +               samsung,pin-drv = <3>;
> > +       };
> > +       */
> > +
> IF Odroid XU is populated with an eMMC5.0+ device && RCLK (Data
> Strobe) is connected from AP to emmc device, THEN you should configure
> this dedicated PIN.
> Otherwise you can remove this TODO and uncomment the node and put a
> comment saying that this feature (emmc5.0+) is not supported on this
> SoC.

I double checked and:
1. Schematics say this pin is not connected,
2. Hardkernel forum confirms that altough XU could support eMMC5.0 (SoC
   supports it) but it was not tested and the pin (RCLK) should be wired
   by consumer.

With your help it seems solved. I'll remove the TODO and add a comment
about not supported emmc5.


Best regards,
Krzysztof
