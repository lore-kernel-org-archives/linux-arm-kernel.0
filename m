From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Nov 2015 00:13:27 +0100
Subject: [PATCH v3 2/5] mfd: syscon: add a DT property to set value width
In-Reply-To: <20151117172649.GA11035@roeck-us.net>
References: <1447700814-5391-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151117091946.GG17829@x1> <20151117172649.GA11035@roeck-us.net>
Message-ID: <4478024.TgK5OkRQEy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 09:26:49 Guenter Roeck wrote:
> > 
> > This syntax is confusing, as we normally associate it with an error
> > condition.  Instead, I'd use:
> > 
> >   if (of_property_read_u32(np, "bus-width", &bus_width) == 0)
> 
> Or maybe better
> 
>         if (!of_property_read_u32(np, "bus-width", &bus_width))

I would also prefer the latter, but it doesn't matter much either way.

> > 
> > Or, for more clarity:
> > 
> >   of_property_read_u32(np, "bus-width", &bus_width);
> >   if (bus_width)
> > 
> > If you choose this version (which I think is my preferred method, don't
> > forget to initialise 'bus_width' to zero.
> > 
> Ignoring an error and depending on bus_width==0 to determine if the property
> was provided seems odd, especially since it would "hide" if the bus-width
> property is set to 0. In the original code, this would be detected as error.

Right.

Another option would be

	ret = of_property_read_u32(np, "bus-width", &bus_width);
	/* no bus width provided, default to 32-bit */
	if (ret)
		bus_width = 32;

	syscon_config.val_bits = bus_width;
	syscon_config.reg_stride = syscon_config.val_bits / 8;

which has the same effect but seems a little clearer to me.

	Arnd
