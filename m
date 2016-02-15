From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 15 Feb 2016 17:16:01 +0100
Subject: GPIO regression in Linux next caused by syscon change
In-Reply-To: <20160215160115.GU19432@atomide.com>
References: <20160213002643.GQ19432@atomide.com>
 <20160213004935.GR19432@atomide.com>
 <CA+gwMccZeYimupmGsMX8YbNH9eEA6=Xi=rupciubBwzktfjvBA@mail.gmail.com>
 <20160215160115.GU19432@atomide.com>
Message-ID: <1455552961.4899.37.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 15.02.2016, 08:01 -0800 schrieb Tony Lindgren:
> * Philipp Zabel <philipp.zabel@gmail.com> [160214 11:24]:
> > I've just replaced the of_iomap() call with an open coded version,
> > calling of_address_to_resource() and ioremap() directly. That was
> > needed so I can use the struct resource returned by
> > of_address_to_resource() to set the syscon_config.max_register. I
> > don't see where this could cause resource overlap. Does just setting
> > syscon_config.max_register to zero again make the problem disappear?
> 
> Yes commenting out the syscon_config.max_register line in your patch
> makes things work again.
> 
> So what does that tell us about the problem?

Maybe some out of bounds writes that previously worked are now catched
by the max_register check in regmap_writable and regmap_write returns
-EIO instead of the write being executed.
Is there any omap_ctrl_write?() call with an offset > 0x32c into
scm_conf?

regards
Philipp
