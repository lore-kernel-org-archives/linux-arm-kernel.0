From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 May 2011 08:26:20 +0200
Subject: [PATCH 0/4] Add a generic struct clk
In-Reply-To: <BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
References: <1305876469.325655.313573683829.0.gpush@pororo>
	<1305876469.325655.313573683829.0.gpush@pororo>
	<BANLkTik=EFayZW61TgfOni-XML+tRLOcqw@mail.gmail.com>
Message-ID: <20110524062620.GA22096@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 04:12:24PM -0700, Colin Cross wrote:
> >
> > ? tglx's plan is to create a separate struct clk_hwdata, which contains a
> > ? union of base data structures for common clocks: div, mux, gate, etc. The
> > ? ops callbacks are passed a clk_hw, plus a clk_hwdata, and most of the base
> > ? hwdata fields are handled within the core clock code. This means less
> > ? encapsulation of clock implementation logic, but more coverage of
> > ? clock basics through the core code.
> 
> I don't think they should be a union, I think there should be 3
> separate private datas, and three sets of clock ops, for the three
> different types of clock blocks: rate changers (dividers and plls),
> muxes, and gates.  These blocks are very often combined - a device
> clock often has a mux and a divider, and clk_set_parent and
> clk_set_rate on the same struct clk both need to work.

The idea is to being able to propagate functions to the parent. It's
very convenient for the implementation of clocks when they only
implement either a divider, a mux or a gate. Combining all of these
into a single clock leads to complicated clock trees and many different
clocks where you can't factor out the common stuff.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
