From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 5 Sep 2012 14:54:11 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <20120905142952.2e1f12fd@skate>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate> <20120905114645.57bfe591@eb-e6520>
 <20120905120906.12d08bf5@skate> <20120905122652.7c752e96@eb-e6520>
 <20120905135646.3bbf98fa@skate> <20120905142244.003e5e4b@eb-e6520>
 <20120905142952.2e1f12fd@skate>
Message-ID: <20120905145411.195f8438@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 5 Sep 2012 14:29:52 +0200,
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :

> Le Wed, 5 Sep 2012 14:22:44 +0200,
> Eric B?nard <eric@eukrea.com> a ?crit :
> 
> > > > OK that's exactly what I was thinking to ;-)
> > > 
> > > Good. So, do you think it's reasonable to use the STCP as a chip-select
> > > for this device?
> >
> > in your case maybe but that really depends on how the chip is wired to
> > the CPU so I'm not sure that can be a generic choice.
> 
> I'm not sure to see how this chip could be wired differently to the
> CPU. The CPU must do a low-to-high transition on STCP to get the values
> out from the internal register.
> 
> So, in other words, we don't know how to choose between:
> 
>  *) Keep the current solution Maxime has implemented, where we have a
>     specific latch GPIO property in the Device Tree for this 74HC595,
>     and the 74HC595 driver is responsible for toggling this GPIO when
>     needed.
> 
>  *) Use the internal SPI controller logic to control this pin as a
>     chip-select, and therefore get rid of Maxime's code with the
>     specific latch GPIO property in the Device Tree.
> 
daisy chaining won't work in the second case (I may be wrong but IIRC
the chip select will toggle at each spi_write) unless you configure the
spi controller to send a 8x(number of 74HC595) bits word :

 	gpio_set_value(chip->chip_select, 0);
	for (i = chip->registers - 1; i >= 0; i--) {
		ret = spi_write(chip->spi,
				chip->buffer + i, sizeof(u8));
		if (ret)
			return ret;
	}

 	gpio_set_value(chip->chip_select, 1);

Eric
