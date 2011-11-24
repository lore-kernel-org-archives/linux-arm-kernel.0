From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 24 Nov 2011 08:45:05 +0800
Subject: [RFC V1 2/8] clk: pass parent rate if recalc_rate is NULL
In-Reply-To: <CAPtuhThkadZ9CDnizqZOuUUC47so=PqW3j4gEHiBCoAz2SccAw@mail.gmail.com>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-3-git-send-email-richard.zhao@linaro.org>
 <CAPtuhThkadZ9CDnizqZOuUUC47so=PqW3j4gEHiBCoAz2SccAw@mail.gmail.com>
Message-ID: <20111124004505.GB15876@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 02:17:50PM -0800, Mike Turquette wrote:
> On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > ?drivers/clk/clk.c | ? ?4 ++++
> > ?1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index ed557c9..2d8422f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -256,6 +256,8 @@ static void clk_recalc_rates(struct clk *clk)
> >
> > ? ? ? ?if (clk->ops->recalc_rate)
> > ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> > + ? ? ? else if (clk->parent)
> > + ? ? ? ? ? ? ? clk->rate = clk->parent->rate;
> 
> My code at Linaro Connect did this but Saravana expressed that this
> was not a safe assumption to make.  I suppose it depends on how many
> clks you want to model, but don't provide good support with
> clk_hw_ops.
clk A --\              -- clk A1
          Shared Gate /
clk B --/             \-- clk B1
A.rate == A1.rate && B.rate == B1.rate is true but A.rate != B.rate

It's the only case I can find out not to pass parent rate. But I don't
think we need to support it at first stage.

Saravana, is it what you mean?

Thanks
Richard
> 
> I'm inclined to leave it out if it is making assumptions that work for
> one platform but not another.  Saravana can you clarify if I
> understood you correctly?
> 
> Regards,
> Mike
> 
> >
> > ? ? ? ?if (old_rate == clk->rate)
> > ? ? ? ? ? ? ? ?return;
> > @@ -527,6 +529,8 @@ void clk_init(struct device *dev, struct clk *clk)
> >
> > ? ? ? ?if (clk->ops->recalc_rate)
> > ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
> > + ? ? ? else if (clk->parent)
> > + ? ? ? ? ? ? ? clk->rate = clk->parent->rate;
> > ? ? ? ?else
> > ? ? ? ? ? ? ? ?clk->rate = 0;
> >
> > --
> > 1.7.5.4
> >
> >
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
