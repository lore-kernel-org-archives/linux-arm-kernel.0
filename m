From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 7 Dec 2009 07:47:44 -0500
Subject: [PATCH 02/10] support 88pm8606 in 860x driver
In-Reply-To: <20091207131508.3ed89841@hyperion.delvare>
References: <771cded00911130054p2ef293ebse84b1de3cf4fa9fd@mail.gmail.com>
	<20091120150215.GF3733@sortiz.org>
	<771cded00911211625g74601e5die59a680f36903cb3@mail.gmail.com>
	<20091127145820.GA3640@sortiz.org>
	<771cded00911291743u76688d24ja40a30472ebd6af8@mail.gmail.com>
	<20091130101943.GA3696@sortiz.org>
	<771cded00912062334q7f92bf25hb9e7a10f8720812@mail.gmail.com>
	<20091207113927.GB7279@sortiz.org>
	<20091207131508.3ed89841@hyperion.delvare>
Message-ID: <771cded00912070447t1b1b5105m4ade492b2bc7e70d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Some more background would be welcome, yes. In particular on how the
> 8806 and 8807 relate to each other, and what kind of chips they are.
> And what problem you are trying to solve in the first place ;)

These two chips can be used together for power management. 8807 is
focus on regulator, RTC, touch, vibrator. 8806 is focus on backlight,
led, charger, and so on. When charger is in use, it also need to
access registers in 8807. In original implementation, one static mixed
structure is defined to link these two chips together. One i2c driver
was serviced for both 8806 and 8807 by i2c id table. Now Samuel is
help me to remove the static mixed structure.

User can use them together or use only one.

>
> In any case, you never get to duplicate the i2c-pxa driver code
> anywhere. If you have several I2C bus segments controlled by PXA-like
> hardware, then you instantiate that many i2c_adapters, all driven by
> the same driver (i2c-pxa.)
>
> Calling i2c_new_device() from an i2c client's probe() routine is rather
> unusual. I can't really think of a good reason to do this. If the first
> client was declared as part of platform init data, I'd expect the
> second to be declared there as well.
>
> There's one which is somewhat similar though: chips which reply to more
> than one I2C address. The extra addresses are reserved using
> i2c_new_dummy(). This gives you an i2c_client handle for easy register
> access. This might be suitable for the problem at hand, but I can't
> tell for sure without knowing the details.
>

Does it mean that i2c_new_dummy()/i2c_new_device() is doing the same
thing like declaring of i2c chip in platform init data?
