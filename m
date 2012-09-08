From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 9 Sep 2012 01:44:35 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CADjby3UyhW=Ok8Zy57MVUz65gd-=4z2PhE6uqd7F8xtaDXcWfQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA29819@DBDE01.ent.ti.com>
 <20120907110251.GA7968@glitch>
 <331ABD5ECB02734CA317220B2BBEABC13EA29BF3@DBDE01.ent.ti.com>
 <20120907160025.GB14330@glitch>
 <CACRpkdbz7CQtaj9e-1kcRVszpCSoqKz=19YT68sTMF9SOyWa8w@mail.gmail.com>
Message-ID: <20120908234435.GA13519@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 11:57:59PM +0200, Linus Walleij wrote:
> On Fri, Sep 7, 2012 at 6:00 PM, Domenico Andreoli <cavokz@gmail.com> wrote:
> > On Fri, Sep 07, 2012 at 02:30:59PM +0000, AnilKumar, Chimata wrote:
> 
> >> How can gpio driver knows that leds-gpio driver require
> >> these 4 pins?
> >
> > because leds-gpio requests each gpio (specified in the DT against a specific
> > gpio controller) before assuming it is available?  gpiolib then asks to
> > pinctrl if those pins are available for gpio and possibly reserve them
> > (configuring the mux, if necessary) for the device.
> 
> So this is not an either-or situation but a both-and case.
>
...
> 
> If all you need to to is to multiplex the pins into GPIO mode,
> then the gpio_get() call on this driver *can* call through to
> pinctrl_request_gpio() which will in turn fall through to the
> above pinmux driver calls (.gpio_request_enable, etc).

So if the GPIO driver doesn't coordinate with the pinctrl driver, it's
all left to the GPIO user to configure the pin before using it, right?

I can understand the concerns of Tony, whether a pin must be requested
or not before the gpio then depends on the GPIO driver implementation,
which may or may not call through the pinctrl layer, isn't it?.

> But that's as far as it goes! The GPIO abstraction cannot
> call through to e.g. set some specific biasing on the pins
> (pull up etc). Doing that would require us to reimplement
> every interface that pinctrl already has again in the
> GPIO layer, which is not a good idea.

Yes, clear. Never meant that, I thought that the pinctrl was anyway
available for stuff not modeled by the GPIO layer, as you say below.

> So the pinctrl handle can be used for such config, and it
> can also be used for multiplexing if that is desired - if not
> done by the fall through functions pinctrl_gpio_*().
> 
> You can use a combination of both too, Stephen patched
> pinctrl some time back so that a pin can be muxed for a
> certain function and used as GPIO at the same time, so
> these two are now orthogonal, it's a bit relaxed and gives some
> feeling of loss of control but was necessary for certain
> usecases. (For example we can snoop on a I2C pin using
> its corresponding GPIO registers in the U300...)
>
> There is some flexibility here, I hope it's not too confusing :-/

Thank you for clarifying :)

Regards,
Domenico
