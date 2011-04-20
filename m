From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 20 Apr 2011 16:29:58 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTinaOk4Qq+uwdZQtapncwjpdTg9wmQ@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
	<BANLkTinaOk4Qq+uwdZQtapncwjpdTg9wmQ@mail.gmail.com>
Message-ID: <20110420162958.09286aa7@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Some people inevitably think that GPIO and pin/padmux are
> intertwined, but as far as I have seen they are not. However there

It's not just pin muxing - gpio pins are sometimes shared between
firmware and OS and belong to one or the other depending upon what is
going on. For example the OS may need to own the pin for things like
updating or eeprom writing but the firmware or another device owns it for
day to day processing.

> may be a cross dependency so that a GPIO driver may need to
> export an additional pin/padmux interface or so, e.g we have
> a separate chip in I2C which can mux pins...

Would it not make sense to assume that given a situation where you have a
GPIO that can be routed four ways that you actually implement it like the
rest of the kernel - ie

	r = gpio_request(n);	/* n, n+1, n+2, n+3 are the four ways
				*/

	if (r < 0) 	/* EBUSY - someone else is using one of the
				four */ 
		return -EBUSY;
	/* Succeeded - will also have set the mux for us */

At that point drivers don't need to know if a GPIO is muxed it'll just be
busy if someone else is using it.

It seems to me that if the goal of the gpio layer is to provide an
abstraction then it can abstract muxes just fine and without needing
drivers to know.

Alan
