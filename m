From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 14:11:47 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <34EB51B7-AF3B-4DCE-A402-953B2DBC0474@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418115903.GB9462@sirena.org.uk>
	<34EB51B7-AF3B-4DCE-A402-953B2DBC0474@niasdigital.com>
Message-ID: <BANLkTik_cSUDEjfF6VqdNgxAgQjftGRc4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/19 Ben Nizette <bn@niasdigital.com>:

> It just doesn't make sense to me to bounce from the board code in to
> 'generic' gpio code then back to platform-specific implementations when
> you could cut out the middle man.

In the demonstrated case the U300 GPIO controller has a number
of registers banks per 8-bit port, the U300 GPIO driver in
drivers/gpio/u300-cgpio.c knows the physical whereabouts of
these registers. So it maps them into virtual memory and
manipulate them.

Now to configure a pin from the board code without calling out
to the GPIO subsystem you need to map the same registers
into virtual memory a second time from board-u300-gpio.c,
provide custom set-up functions there and manipulate the
same register range from another place.

This is intuitively bad design to me, it's better to compartmentalize
the GPIO pin handling and whatever it takes into *one*
driver file, not two drivers writing into the same register
range, thanks.

Yours,
Linus Walleij
