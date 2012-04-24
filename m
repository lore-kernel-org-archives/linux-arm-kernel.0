From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Apr 2012 08:42:03 +0100
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <20120424072653.GB24089@lunn.ch>
References: <20120424070426.GA24089@lunn.ch> <4F9650B3.9030406@st.com>
 <20120424072653.GB24089@lunn.ch>
Message-ID: <20120424074202.GO24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 09:26:53AM +0200, Andrew Lunn wrote:
> On Tue, Apr 24, 2012 at 12:35:23PM +0530, Viresh Kumar wrote:
> > On 4/24/2012 12:34 PM, Andrew Lunn wrote:
> > > I don't think this change is correct. With the old semantics, it was:
> > 
> > Sorry. :(
> > 
> > > If we have CLK support, we expect there to be a clock for sata_mv, and
> > > if there is no such clock, output a notice message, something is
> > > probably wrong, i expected there to be a clock.
> > > 
> > > The new semantics are:
> > > 
> > > We expect there to be a clock for sata_mv, and if there is no such
> > > clock, output a notice message, something is probably wrong, i
> > > expected there to be a clock.
> > > 
> > > We are going to see this notice message much more, when it is not
> > > expected.
> > 
> > So, the only problem is this message?
> > How do you suggest to tackle this now. Have #ifdef,#endif around this print?
> 
> Well, adding #ifdef defeats the point of adding dummy implementations.
> 
> Maybe, rather than return -ENODEV, return -ENOTSUP.
> 
> IS_ERR() still returns true, so in most cases, no code needs
> changing. However, when you need to differentiate between, "clock does
> not exists" and "Dummy clock functions being used", you can tell the
> difference. mv_sata could look like:
> 
>         hpriv->clk = clk_get(&pdev->dev, NULL);
>         if (IS_ERR(hpriv->clk))
> 	        if (PTR_ERR(hpriv->clk) == -ENODEV)
> 		        dev_notice(&pdev->dev, "cannot get clkdev\n");
>         else
>                 clk_prepare_enable(hpriv->clk);
> 
> 
> You would however, need to look at all uses of clk_get and see if any
> are looked for ENODEV, and not just IS_ERR(), and fix those....

Why bother?

If you don't have the clk API configured, you have no clocks to control.
So, why not make clk_get() return NULL, and make the rest of the API
calls do nothing?  That's what you'll end up codifying in the drivers
anyway.
