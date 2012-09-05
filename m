From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 12:09:06 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <20120905114645.57bfe591@eb-e6520>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate> <20120905114645.57bfe591@eb-e6520>
Message-ID: <20120905120906.12d08bf5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 5 Sep 2012 11:46:45 +0200,
Eric B?nard <eric@eukrea.com> a ?crit :

> > Well, thinking more about this, and reviewing the i.MX 28 datasheet a
> > bit more thoroughly, I don't think you need this GPIO thing. It is an
> > active-low pin that should be kept low during the entire duration of
> > the transfer, which basically is a chip select. And in turns out that
> > the CFA10049 board uses pins that can be controlled as chip selects
> > directly by the SPI controller, so you should rather use this rather
> > than introduce a specially handled GPIO. This needs testing, but I
> > don't see why it wouldn't work.
> > 
> are you talking of the /OE pin of the 74HC595 ?

No. Our chip select lines are connected to the STCP pin. It is
technically not a chip select, but a low-to-high transition on this pin
triggers the apparition on the output pins of the 74HC595 of the
contents of the storage register. So, doing a high-to-low transition
before the SPI transfer, and then a low-to-high transition after the
SPI transfer will actually do what we want. But maybe this is an abuse
of the chip select concept, I don't know.

I don't think the /OE pin can be used as a chip select, because when it
is high, the state of the output pins is not maintained to their
previous state: the pins are turned into the high impedance state. If
used as a chip select, it would mean that the value of the output pins
transition from their old state to high impedance at the beginning of
the transfer, and then from the high impedance to their new state at
the end of the transfer. And of course, this signal is inverted
compared to a normal chip select.

Note that I may be completely wrong, I'm a software guy, not a hardware
one :)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
