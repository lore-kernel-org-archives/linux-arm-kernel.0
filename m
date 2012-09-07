From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 7 Sep 2012 13:02:51 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
Message-ID: <20120907110251.GA7968@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 09:10:50AM +0000, AnilKumar, Chimata wrote:
> Hi Domenico,

Hi,

> On Fri, Sep 07, 2012 at 14:18:39, Domenico Andreoli wrote:
> > On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:
> > > Adopt pinctrl support to leds-gpio driver based on leds-gpio
> > > device pointer, pinctrl driver configure SoC pins to GPIO
> > > mode according to definitions provided in .dts file.
> > 
> > Shouldn't be the interaction with the pinctrl layer left to gpiolib?
> > 
> 
> No, these gpio's are configured specifically for user leds.

So there are some special pad configs to make the leds work which are not
only muxing and direction setting? Because I expect these to be managed
privately between gpiolib and pinctrl but now I'm not sure any more,
I'll look the code.

> So, leds-gpio driver should have this call, because these gpio
> pins are used by leds-gpio driver.
> 
> +       am33xx_pinmux: pinmux at 44e10800 {
> +               userled_pins: pinmux_userled_pins {
> +                       pinctrl-single,pins = <
> +                               0x54 0x7       
> +                               0x58 0x17       
> +                               0x5c 0x7        
> +                               0x60 0x17       
> +                       >;
> +               };
> +       };
> +
> 
> [...]
> 
> +               leds {
> +                       compatible = "gpio-leds";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&userled_pins>;
>                                       ^^^^^^^^^^^^

I'm surprised to not see any gpio controller (ala irq) involved.

> Lets take gpio-keypad driver, in that case we have to configure
> pins as INPUT mode (generic gpio driver might not know what
> the end usecase is) and this leds case we configure as OUTPUT
> mode.

gpio direction is modeled by gpiolib so, if no other out-of-gpiolib
capabilities are required for that led gpio, there is no need to directly
use pinctrl.

maybe I've just got it wrong. sorry.

thanks,
Domenico
