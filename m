From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 15 Apr 2014 10:00:07 +0200
Subject: [PATCH] tty/serial: atmel_serial: Fix device tree documentation
In-Reply-To: <534CE24F.9020703@gmail.com>
References: <1397487482-3816-1-git-send-email-richard.genoud@gmail.com>
 <20140414152212.GC2255@ldesroches-Latitude-E6320>
 <534CE24F.9020703@gmail.com>
Message-ID: <20140415080006.GE2255@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:39:59AM +0200, Richard Genoud wrote:
> On 14/04/2014 17:22, Ludovic Desroches wrote:
> > Hi Richard,
> > 
> > On Mon, Apr 14, 2014 at 04:58:02PM +0200, Richard Genoud wrote:
> >> RTS pin is an active low pin.
> >> For now, this doesn't change anything as the ACTIVE_LOW flag is not
> >> handled in atmel_serial, but it will be in 3.16.
> >>
> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> >> ---
> >>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> >> index 17c1042b2df8..2f7aad71b3c9 100644
> >> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> >> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> >> @@ -35,7 +35,7 @@ Example:
> >>  		clock-names = "usart";
> >>  		atmel,use-dma-rx;
> >>  		atmel,use-dma-tx;
> >> -		rts-gpios = <&pioD 15 0>;
> >> +		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
> > 
> > I was told we should not use macros here. If it is still the truth:
> > 
> > rts-gpios = <&pioD 15 1>;
> 
> But I'd really like to know if macros are forbidden in DT documentation and why...
> Because, IMHO, <&pioD 15 1> talks less that <&pioD 15 GPIO_ACTIVE_LOW>.
> Which is a shame in a documentation.

I don't remember who told me that but the reason was that device tree
should not depend on Linux and macros are relative to Linux.

> 
> Rob, any idea on that ?
> 
> (actually, I missed some uses of GPIO_ACTIVE_ macros in Documentation :)
> git grep GPIO_ACTIVE Documentation/devicetree/bindings/
> Documentation/devicetree/bindings/gpio/gpio-davinci.txt:                gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/gpio/gpio-davinci.txt:                gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/gpio/gpio-lp3943.txt:         gpios = <&gpioex 9 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/gpio/gpio-lp3943.txt:         gpios = <&gpioex 10 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt:    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt:      GPIO_ACTIVE_HIGH
> Documentation/devicetree/bindings/gpio/gpio-tz1090-pdc.txt:      GPIO_ACTIVE_LOW
> Documentation/devicetree/bindings/gpio/gpio-tz1090.txt:        GPIO_ACTIVE_HIGH
> Documentation/devicetree/bindings/gpio/gpio-tz1090.txt:        GPIO_ACTIVE_LOW
> Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt:    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> Documentation/devicetree/bindings/input/gpio-beeper.txt:                gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/mmc/mmc.txt:also be specified using the OF_GPIO_ACTIVE_LOW flag. This creates an ambiguity
> Documentation/devicetree/bindings/mmc/mmc.txt:OF_GPIO_ACTIVE_LOW flag clear and specifying the respective *-inverted
> Documentation/devicetree/bindings/net/nfc/trf7970a.txt:         ti,enable-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>,
> Documentation/devicetree/bindings/net/nfc/trf7970a.txt:                           <&gpio2 5 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt:           ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
> Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt:    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt:                      gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/power/isp1704.txt:    nxp,enable-gpio = <&gpio3 3 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/sound/max98090.txt:   interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/sound/rt5640.txt:     interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/sound/rt5640.txt:             <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/sound/tpa6130a2.txt:  power-gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt:                reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt:           gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/video/panel-dsi-cm.txt:       reset-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
> Documentation/devicetree/bindings/video/sony,acx565akm.txt:     reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
> Documentation/devicetree/bindings/video/ti,omap-dss.txt:                gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;     /* 0, power-down */
> Documentation/devicetree/bindings/video/ti,omap-dss.txt:                gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,   /* 60, CT CP HPD */
> Documentation/devicetree/bindings/video/ti,omap-dss.txt:                        <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
> Documentation/devicetree/bindings/video/ti,omap-dss.txt:                        <&gpio2 31 GPIO_ACTIVE_HIGH>;   /* 63, HPD */
> Documentation/devicetree/bindings/video/ti,tfp410.txt:  powerdown-gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
> Documentation/devicetree/bindings/video/ti,tpd12s015.txt:       gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,   /* 60, CT CP HPD */
> Documentation/devicetree/bindings/video/ti,tpd12s015.txt:               <&gpio2 9 GPIO_ACTIVE_HIGH>,    /* 41, LS OE */
> Documentation/devicetree/bindings/video/ti,tpd12s015.txt:               <&gpio2 31 GPIO_ACTIVE_HIGH>;   /* 63, HPD */
> Documentation/devicetree/bindings/watchdog/gpio-wdt.txt:                gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
> 
> Richard.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
