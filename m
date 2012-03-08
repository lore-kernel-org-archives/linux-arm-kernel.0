From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Mar 2012 00:25:49 +0100
Subject: [PATCH v5 3/4] clk: introduce the common clock framework
In-Reply-To: <20120308062739.GE18513@lunn.ch>
References: <1330763341-3437-4-git-send-email-mturquette@linaro.org>
 <20120303133158.GA26882@pengutronix.de>
 <CAJOA=zNFNEHxBDhRDdvm7DYR83R0LJjsp_AT3BoG+nL+iN5_tw@mail.gmail.com>
 <20120304115201.GB26882@pengutronix.de>
 <CAJOA=zP8d8wm==7=svOzh03Ft-1_LV71q0mA6Pncrh5vQSWGEA@mail.gmail.com>
 <20120305073836.GU3852@pengutronix.de>
 <CAJOA=zMs75ZQ24g5PXpSLV3AJzWEo12g86G8+4+ryQR_cTYpzA@mail.gmail.com>
 <20120306190039.GJ3852@pengutronix.de>
 <CAJOA=zOG_6eSWPEfFL6VKWeTpGKD9y11xeHoOwdS3b59tAZ45A@mail.gmail.com>
 <20120308062739.GE18513@lunn.ch>
Message-ID: <20120308232549.GU3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 07:27:39AM +0100, Andrew Lunn wrote:
> > Assuming that some day OMAP code can be refactored to allow for lazy
> > (or at least initcall-based) registration of clocks then perhaps your
> > suggestion can take root.  Which leads me to this question: are there
> > any other platforms out there that require the level of expose to
> > struct clk present in this patchset?  OMAP does, for now, but if that
> > changes then I need to know if others require this as well.
> 
> Hi Mike
> 
> For kirkwood, i use static clk's for all but my root clock. I cannot
> statically know the rate of the root clock, so i have to determine it
> at boot time using heuristics, PCI ID, etc.
> 
> I used statics thinking it would be less code. No idea if it actually
> is, and there is nothing stopping me moving to creating the clocks
> after creating the root clock.

I'd say use the nonstatic ones. I think using the static initializers
will cause us much pain in the future. I've been through several rebases
on the i.MX clock rework and everytime I wish my sed foo would be
better. Now imagine what happens when it turns out that the internal
struct clk layout or the structs for the muxes/dividers/gates have to
be changed. This task is next to impossible when we have thousands of
clocks scattered around the tree.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
