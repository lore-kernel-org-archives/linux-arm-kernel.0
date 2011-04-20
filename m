From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 20 Apr 2011 10:45:07 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <D3BCC8A3-7570-49F2-838C-A2B1899B0519@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<D3BCC8A3-7570-49F2-838C-A2B1899B0519@niasdigital.com>
Message-ID: <20110420104507.69ebb8e8@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 	gpio_get_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER);
> > 	gpio_set_property(gpio, GPIO_BIAS, GPIO_BIAS_WHATEVER_ELSE);
> 
> Yeah I'm all for that so long as the capability constants are defined by the gpio provider, eg <linux/gpio/mygpioexpander.h>.  There's no way gpiolib should be keeping a big ole list of every possible config option for every gpio provider.  Well, maybe gpiolib can know about the options (eg GPIO_BIAS) so long as it doesn't have to enumerate every possible value.

It needs to know about any that might become common across multiple
devices so that if multiple devices have the same feature set it works
but I agree entirely about any weird platform or device specific stuff.

Perhaps for that it just needs to define

GPIO_PRIVATE_PROP		0x8000	/* to FFFF */

and be done with it


For multiple properties that can be shared you can't really get away from
needing a common name or number space. The good thing is that gpiolib
itself doesn't really care about that. To the core gpio code it's just a
set of numbers that only drivers and users know about.

Alan
