From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 May 2018 10:35:12 +0200
Subject: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
In-Reply-To: <CACRpkdYCdNZ=ASw1uz4zKXC4AMd1EGbvG_G5K5cwSpH5eGPgKA@mail.gmail.com>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1685755.J6GI985WX3@diego>
 <CACRpkdYCdNZ=ASw1uz4zKXC4AMd1EGbvG_G5K5cwSpH5eGPgKA@mail.gmail.com>
Message-ID: <2044895.BqI5yRtle6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Donnerstag, 24. Mai 2018, 10:28:44 CEST schrieb Linus Walleij:
> On Wed, May 23, 2018 at 5:12 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > So the gpio controller should definitly also be a subnode.
> > 
> > The gpio in question is called "mute", so I'd think the gpio-syscon driver
> > should just define a "rockchip,rk3328-gpio-mute" compatible and contain
> > all the register voodoo in the driver itself and not define it in the dt.
> > 
> > So it should probably look like
> > 
> > grf: syscon at ff100000 {
> > 
> >         compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> >         
> >         [all the other syscon sub-devices]
> >         
> >         gpio_mute: gpio-mute {
> >         
> >                 compatible = "rockchip,rk3328-gpio-mute";
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >         
> >         };
> 
> I'm sceptic.
> 
> That doesn't sound like "general purpose input output" at all.
> 
> It sounds like special purpose, for a mute button.
> 
> Does it use IRQ? I would recommend implementing
> drivers/input/keyboard/syscon-keys.c in the same vein
> as drivers/leds/leds-syscon.c so you can avoid indirection
> through GPIO for no good reason at all.

To quote Levin from the other mail:
--------
The "mute" pin is a output only GPIO, which is already supported by 
setting flags in the gpio-syscon
  driver. And yes, this pin has a defined function, but can also be used 
for general purpose operation.
--------

So to summarize, the documentation calls it "mute", but it is usable as
a general pin, which is the reason Levin is working on it - because on his
board this pin is used to switch between two voltages (aka a gpio-regulator)
for the sdmmc controller [3.3V + 1.8V].

Available pin settings are output-enable + of course the high/low setting
and I think I remember there is even a pull setting for it in the GRF 
somewhere - but my memory might be fuzzy here.


Heiko
