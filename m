From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2016 17:44:36 +0200
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <CAKv+Gu_100mM7EvaxAMoZvnr1Ce_EC=wzYkB80AjUmBx9exkGQ@mail.gmail.com>
References: <20161017183806.GG5601@arm.com> <4333753.kxspqi1Miz@wuerfel>
 <CAKv+Gu_100mM7EvaxAMoZvnr1Ce_EC=wzYkB80AjUmBx9exkGQ@mail.gmail.com>
Message-ID: <2995302.b19MFEzy6p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 19, 2016 4:27:51 PM CEST Ard Biesheuvel wrote:
> >
> > Why not turn it into a runtime warning in this driver?
> >
> > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> > index cecb0fdfaef6..711d1d9842cc 100644
> > --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > @@ -349,8 +349,10 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
> >                         rate->reg = reg + (u64)rate->reg;
> >                         for (clkt = rate->table; clkt->div; clkt++)
> >                                 table_size++;
> > -                       rate->width = order_base_2(table_size);
> > -                       rate->lock = lock;
> > +                       if (!WARN_ON(table_size == 0)) {
> > +                               rate->width = order_base_2(table_size);
> > +                               rate->lock = lock;
> > +                       }
> >                 }
> >         }
> >
> 
> I guess Will is not looking for a way to fix the driver, but for a way
> to eliminate this issue entirely going forward.
>
> In general, I think the issue where constant folding results in
> ilog2() or other similar functions being called with invalid build
> time constant parameter values is simply something we have to deal
> with.
> 
> In this case, it is in fact order_base_2() that deviates from its
> documented behavior (as Will points out), and fixing /that/ should
> make this particular issue go away afaict.

Ah, right. I also noticed that order_base_2() is defined as
log2(1 << (log2(n-1)+1)), which seems a bit redundant.
Maybe we can simplify it to something like

#define order_base_2(n) ((n) <= 1) ? 0 : log2((n) - 1) + 1)

	Arnd
