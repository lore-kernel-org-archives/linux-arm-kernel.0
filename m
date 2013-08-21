From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 21 Aug 2013 14:59:39 -0500
Subject: [RFC PATCH] ARM: smp_twd: Fix twd_get_clock() to get clock from
 dts or clock framework
In-Reply-To: <CACRpkdb3C4FScyChR2TyZUpbNnhfArE+CDRWYj1iKsQtZy94tg@mail.gmail.com>
References: <1376087720-14539-1-git-send-email-dinguyen@altera.com>
 <CACRpkdb3C4FScyChR2TyZUpbNnhfArE+CDRWYj1iKsQtZy94tg@mail.gmail.com>
Message-ID: <1377115179.1554.19.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-08-14 at 21:47 +0200, Linus Walleij wrote:
> On Sat, Aug 10, 2013 at 12:35 AM,  <dinguyen@altera.com> wrote:
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> >
> > Some platforms have a clock for the smp_twd that goes through a fixed
> > divider. Registering this smp_twd clocks is done by calling
> > clk_register_fixed_factor().
> >
> > Fix up twd_get_clock() so that it can get the clock from the device
> > tree node or clk_register_fixed_factor().
> >
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> (...)
> >         if (np)
> >                 twd_clk = of_clk_get(np, 0);
> > -       else
> > +
> > +       /* Some platforms do not register the smp_twd clock in the device */
> > +       /* node of the twd timer. */
> > +       if (IS_ERR(twd_clk))
> >                 twd_clk = clk_get_sys("smp_twd", NULL);
> 
> NACK.
> 
> The patch commit message and the patch itself does not match.
> This has nothing to do with using fixed factor or whatever.
> 
> What it wants to do is use clk_get_sys() in case of_clk_get() fails,
> so DT clocks take precedence.
> 
> But this patch is buggy. If you have only platform data, and boot
> without device tree, np will be NULL, and twd_clk will also be
> NULL and thus clk_get_sys() will not execute and the system
> is bugged up.

Ah, I apologize. I did not even think about the none device tree case.

Dinh
> 
> Yours,
> Linus Walleij
> 
