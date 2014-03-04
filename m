From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 04 Mar 2014 15:54:24 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NSAxLzNdIHR0eS9zZXJpYWw6IEFkZCBHUElPTElCIGhl?=
 =?UTF-8?B?bHBlcnMgZm9yIGNvbnRyb2xsaW5nIG1vZGVtIGxpbmVz?=
In-Reply-To: <CACQ1gAgURezr+Oqd6mX4D4K_C1LtmVh4a2fOnie0Xfj9sfYjQQ@mail.gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
 <1393846030.273217958@f113.i.mail.ru>
 <CACQ1gAgURezr+Oqd6mX4D4K_C1LtmVh4a2fOnie0Xfj9sfYjQQ@mail.gmail.com>
Message-ID: <1393934064.723888132@f365.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

???????,  4 ????? 2014, 12:37 +01:00 ?? Richard Genoud <richard.genoud@gmail.com>:
> 2014-03-03 12:27 GMT+01:00 Alexander Shiyan <shc_work@mail.ru>:
> > Hello.
> >
> > ???????????,  3 ????? 2014, 12:11 +01:00 ?? Richard Genoud <noreply.rgenoud@gmail.com>:
> >> This patch add some helpers to control modem lines (CTS/RTS/DSR...) via
> >> GPIO.
> >> This will be useful for many boards which have a serial controller that
> >> only handle CTS/RTS pins (or even just RX/TX).
> >>
> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> > ...
> >> +struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
> >> +{
> >> +     struct mctrl_gpios *gpios;
> >> +     enum mctrl_gpio_idx i;
> >> +     int err;
> >> +
> >> +     gpios = devm_kzalloc(dev, sizeof(*gpios), GFP_KERNEL);
> >> +     if (!gpios)
> >> +             goto out;
> >
> > if (!gpios)
> >   return ERR_PTR(-ENOMEM);
> I think we are looping here...
> If I returns a ERR_PTR(-ENOMEM), I'll have to change back all tests
> from if (!gpios) to if (IS_ERR_OR_NULL(gpios))
> So, I'll just return NULL here, and change the test in atmel_serial.c
> (that was wrong anyway, as you pointed out)

Yes, a little confused :)
So, let's revert back to check IS_ERR_OR_NULL(gpios).
We able to check error codes in the driver in this case.
gpios = NULL at the end of mctrl_gpio_free() is still needed.

---
