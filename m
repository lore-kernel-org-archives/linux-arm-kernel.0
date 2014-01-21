From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 21 Jan 2014 08:11:34 +0100
Subject: More GPIO madness on iMX6 - and the crappy ARM port of Linux
In-Reply-To: <CAAVeFuJhYv_vKqgyyaw7LOzRvErjf4u=5jJCvpoEgA0ZsMj-1Q@mail.gmail.com>
References: <20140117184731.GE15937@n2100.arm.linux.org.uk>
 <52D98712.3070103@wwwdotorg.org>
 <20140117202405.GF15937@n2100.arm.linux.org.uk>
 <52D995C4.80104@wwwdotorg.org>
 <20140117205346.GH15937@n2100.arm.linux.org.uk>
 <CACRpkdaRQRD85-0wUmip=j1SHzti6Nb69JEUXznYTkrxGvky=A@mail.gmail.com>
 <CAAVeFuJhYv_vKqgyyaw7LOzRvErjf4u=5jJCvpoEgA0ZsMj-1Q@mail.gmail.com>
Message-ID: <20140121081134.1cf7924f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexandre Courbot wrote:
> On Sat, Jan 18, 2014 at 7:43 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Jan 17, 2014 at 9:53 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Fri, Jan 17, 2014 at 01:42:44PM -0700, Stephen Warren wrote:
> >
[...]
> > If the OPEN_DRAIN flag is set on that descriptor we should
> > always be able to read the input. But as this is not really what the
> > I2C core wants to know (it really would prefer not to bother with
> > such GPIO flag details) so is it better if we add a special call to
> > figure out if the input can be read? Like:
> >
> > bool gpiod_input_always_valid(const struct gpio_desc *desc);
> >
> > And leave it up to the core to look at flags, driver characteristics
> > etc and determine whether the input can be trusted?
> 
> I am personally a little bit scared by the number of exported
> functions in the GPIO framework. It is a pretty large number for
> something that is supposed to be simple, so I'd like to avoid adding
> more. :) How about the following:
> 
> 1) GPIOs configured as output without the open drain or open source
> flag either return -EINVAL on gpiod_get_value(), or a cached value
> tracked by gpiolib for consistency (probably the latter).
> 2) GPIOs configured as open drain or open source report the actual
> value read on the pin, like i2c-core needs. This requires that, for
> each GPIO that can be set open drain or open source,
> gpiod_input_always_valid() == true.
> 
I would not bind this to the open drain configuration. Any GPIO output
pin may actually be in a different state than programmed when the
output is forcefully driven by another source (shortcut).
So it makes sense to be able to read back the real state of the pad
even for push pull outputs.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
