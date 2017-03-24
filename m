From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Mar 2017 09:58:28 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
References: <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
 <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
 <20170323144325.GA952@dtor-ws> <20170323154441.GA9460@dtor-ws>
 <20170323191020.nrstp2cfh7cuqvf3@pengutronix.de>
Message-ID: <CACRpkdYBesafyhp0=W-cnOncYJ-1eNHZ4E_nv_f0AkWrhUk41Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 8:10 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Mar 23, 2017 at 08:44:41AM -0700, Dmitry Torokhov wrote:
>> On Thu, Mar 23, 2017 at 07:43:25AM -0700, Dmitry Torokhov wrote:
>> > On Thu, Mar 23, 2017 at 02:41:53PM +0100, Linus Walleij wrote:
>> > > On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K?nig
>> > > <u.kleine-koenig@pengutronix.de> wrote:
>> > >
>> > > > Maybe we can make gpiod_get_optional look like this:
>> > > >
>> > > >         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLED(GPIOLIB))
>> > > >                 return NULL;
>> > > >         else
>> > > >                 return -ENOSYS;
>> > > >
>> > > > I don't know how isnt_a_acpi_device looks like, probably it involves
>> > > > CONFIG_ACPI and/or dev->acpi_node.
>> > > >
>> > > > This should be safe and still comfortable for legacy platforms, isn't it?
>> > >
>> > > I like the looks of this.
>> > >
>> > > Can we revert Dmitry's patch and apply something like this instead?
>> > >
>> > > Dmitry, how do you feel about this?
>> >
>> > I frankly do not see the point. It still makes driver code more complex
>
> Note that this code is in the gpio header, and not in driver code. So
> the driver just does
>
>         gpiod = gpiod_get_optional(...)
>         if (IS_ERR(gpiod))
>                 return PTR_ERR(gpiod);
>
> (as it is supposed to do now). I think that's nice.

It does look nice. Compare this to what we must do for optional regulators:

        st->reg = devm_regulator_get_optional(&spi->dev, "vref");
        if (IS_ERR(st->reg)) {
                /* Any other error indicates that the regulator does exist */
                if (PTR_ERR(st->reg) != -ENODEV)
                        return PTR_ERR(st->reg);
                /* Use internal reference */
        }

So for optional regulators we get -ENODEV if we don't have it,
and then proceed on an alternate path, such as using an internal
reference voltage.

However the fact that regulators and GPIO optionals are already
handled differently is creating "cognitive dissonance" or what I
should call it.

Yours,
Linus Walleij
