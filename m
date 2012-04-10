From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 18:11:42 +0200
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120410143055.GT24211@n2100.arm.linux.org.uk>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
Message-ID: <20120410161142.GG3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:30:55PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 10, 2012 at 03:45:14PM +0200, Sascha Hauer wrote:
> > With the generic clock framework we do not necessarily have
> > a pointer to the struct clk we want to register a lookup
> > for, so add a const char *clkname field to struct clk_lookup
> > so that a lookup can be registered with a clock name.
> 
> All this silly names all over the place is getting to be utterly
> rediculous. Why do we need to name clocks and look them up by name
> when we have a perfectly good way (clkdev) to do this already?  Yes,
> it takes a struct clk pointer but that's exactly because that's what
> it has to return.
> 
> Why do we want to have another idiotic string to look up a clock which
> is named using an idiotic scheme to find out its pointer to only then
> register that with clkdev?
> 
> I think this clk stuff has gone totally insane wrt names recently.

clk names and clk lookups are two different things. The former is a
unique identifier for a clock whereas the latter associates a clock
to a device. Multiple lookups can point to the same clock, so they can't
be used to identify a particular clock. I know I'm not telling anything
new to you here, so I think your question goes down to why we need a
unique identifier string for clocks.

For me the big advantage for clocks having unique names is that I do not
have to have a struct clk * to pass the (possible) parents of a clock to
the clock framework during registration. Also it makes us independent of
the registration order of the clock tree (no need to register the
parents before the children). The debugfs representation of the clock
tree also makes use of the names.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
