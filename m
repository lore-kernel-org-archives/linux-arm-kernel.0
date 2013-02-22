From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Feb 2013 09:29:08 +0000
Subject: randconfig errors
In-Reply-To: <511E9A73.4090806@boundarydevices.com>
References: <511E6FA4.2000709@gmail.com> <20130215201121.11471.66349@quantum>
 <511E9A73.4090806@boundarydevices.com>
Message-ID: <201302220929.08736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Troy Kisky wrote:
> > Commit 7248001, "clk: vt8500: Fix device clock divisor calculations"
> > introduced logic to improve divider selection while changing rates for
> > the VT8500 dclk.  However a copy-paste error results in using the wrong
> > variable name in the .set_rate callback.  Fixed by changing *prate to
> > parent_rate.  The .round_rate function is correct and remains unchanged.
> >
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > Cc: Tony Prisk <linux@prisktech.co.nz>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robherring2@gmail.com>
> > ---
> >   drivers/clk/clk-vt8500.c |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
> > index b5538bb..c010861 100644
> > --- a/drivers/clk/clk-vt8500.c
> > +++ b/drivers/clk/clk-vt8500.c
> > @@ -156,8 +156,8 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
> >   
> >       divisor =  parent_rate / rate;
> >   
> > -     /* If prate / rate would be decimal, incr the divisor */
> > -     if (rate * divisor < *prate)
> > +     /* If parent_rate / rate would be decimal, incr the divisor */
> > +     if (rate * divisor < parent_rate)
> >               divisor++;
> >   
> >       if (divisor == cdev->div_mask + 1)
> What about just
> 
>          divisor = (parent_rate + rate - 1) / rate;
> 

This is now broken in Linus' upstream tree. Could you get one fix merged?

	Arnd
