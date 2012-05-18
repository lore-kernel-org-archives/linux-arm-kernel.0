From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 18 May 2012 10:18:37 +0530
Subject: Clock register in early init
In-Reply-To: <20120517062131.GA9305@gmail.com>
References: <1337227884.2066.9.camel@pgaikwad-dt2>
 <20120517062131.GA9305@gmail.com>
Message-ID: <1337316517.22560.19.camel@pgaikwad-dt2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the reply Mike!!

On Thu, 2012-05-17 at 11:51 +0530, Mike Turquette wrote:
> On 20120517-09:41, Prashant Gaikwad wrote:
> > Hi Mike,
> > 
> > While porting Tegra to common clock framework I observed that if we try
> > to allocate struct clk dynamically in early init, kernel panics since
> > memory is not initialized yet.
> > 
> > In your clk-next for omap you are registering clocks in early init and
> > clk_register allocates struct clk dynamically.
> > 
> > So, am I missing something here?
> > 
> 
> You have the same problem as my platform (OMAP).  Please check out
> include/linux/clk-private.h.  That is a really nasty terrible hack that
> exists for statically initializing all data.  It exposes the definition
> of struct clk (which is bad and violates the design philosophy that
> struct clk should be an opaque cookie).
> 
> Please review Documentat/clk.txt to understand the rules around
> clk-private.h.  Namely that you MUST separate your data from your clock
> function definitions (the clk_ops should never know the definition of
> struct clk).
> 

Yes, currently I am also doing same for Tegra and it works well. clk_ops
and clk initialization data are in separate files. clk_ops does not
include clk-private.h so it does not know the definition of struct clk.

Will send patches for shortly.

> Finally, I really want to kill off clk-private.h.  Currently OMAP does
> clock registration during early init and that is why this crap exists.
> However we are going to move our clock initialization to be initcall
> based at some point in the future.  No other platform (until now) was
> using these macros in clk-private.h, so I had planned on removing them
> after OMAP migrated.
> 
> What are the plans for Tegra?  I really don't want to have to support
> this stuff.  Can you migrate your clock initialization to be initcall
> based at some point in the future?
> 

We had initcall based implementation in old kernel versions. It was
moved to early init since some clocks were required for delay
calibrations. It may be possible to migrate it be initcall based in
future.

> Regards,
> Mike
> 
> p.s: best to have these kinds of discussions on the list, out in the
> open.  If you want to continue our discussion can you loop in LAKML?
> 

Added LAKML in loop.

> > Same is observed if we try to allocate parent list dynamically.
> > 
> > Thanks & regards,
> > Prashant G

Prashant G
