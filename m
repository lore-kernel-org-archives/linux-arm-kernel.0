From: jason@lakedaemon.net (Jason)
Date: Wed, 7 Mar 2012 08:11:37 -0500
Subject: [RFC 09/14] MV SATA: Add per channel clk/clkdev support.
In-Reply-To: <20120307063858.GA18792@lunn.ch>
References: <20120307063858.GA18792@lunn.ch>
Message-ID: <20120307131137.GY5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 07:38:58AM +0100, Andrew Lunn wrote:
> > Date: Tue, 6 Mar 2012 14:01:39 -0500
> > From: Jason <jason@lakedaemon.net>
> > To: Andrew Lunn <andrew@lunn.ch>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Subject: Re: [RFC 09/14] MV SATA: Add per channel clk/clkdev support.
> > Message-ID: <20120306190139.GW5050@titan.lakedaemon.net>
> > Content-Type: text/plain; charset=us-ascii
> > 
> > On Tue, Mar 06, 2012 at 07:31:05AM +0100, Andrew Lunn wrote:
> > > The Orion kirkwood chips have a gatable clock per SATA channel. Add
> > 
> > +mv_sata_platform_data *sata_data)
> > >       if (sata_data->n_ports > 1)
> > >               kirkwood_clk_ctrl |= CGC_SATA1;
> > >
> > > +     orion_clkdev_add("0", "sata_mv.0", &clk_sata0);
> > > +     orion_clkdev_add("1", "sata_mv.0", &clk_sata1);
> > > +
> > 
> > This is a problem for devicetree.  With devicetree, neither
> > kirkwood_sata_init(), nor orion_sata_init() are ever called.  The same
> > is true for all the other drivers as well.
> > 
> > Could this be moved into the driver's _probe() function?
> 
> No, this cannot be in the driver. This is setting up the mapping
> between the device name and the clk the device should use. dove,
> orion5x, mv78xx0 need a different clk to kirkwood and this is hidden
> by clkdev, so the driver does not have to care.

Thanks for the clarification.

> BTW: Not all drivers which orion uses are only used by orion. So we
> have to be careful not to add orion specific stuff into some of the
> drivers. This is particularly true for Ethernet and SATA.
> 
> There are two possible solutions to clkdev:
> 
> 1) Add DT bindings for clkdev. I don't know if this is currently
>    supported?

I came to the same conclusion late last night and started poking around.
I didn't see it in any of Mike's patches.

> 2) I can refactor the code. Currently i create the clkdev entries on
>    demand. However i could just create them all just after creating
>    the clocks.

Hmmm, I wouldn't worry about it too much, absent == disabled.  Which is
what I'm thinking for the dt bindings.

> Maybe you can take a look at 1) and see if its possible, while i look
> at refactoring the code.

drivers/clk/of_clk.c ?  I'll start looking at it.

thx,

Jason.
