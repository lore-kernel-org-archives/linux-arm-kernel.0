From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:22:30 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Add check for NULL in clock interface
In-Reply-To: <CAJuYYwR9ttbL9oknv7L60GnS3U1c_MX0Qddr6fg1zh7T1LzR=w@mail.gmail.com>
References: <1346941534-4501-1-git-send-email-chander.kashyap@linaro.org>
 <CAJuYYwR9ttbL9oknv7L60GnS3U1c_MX0Qddr6fg1zh7T1LzR=w@mail.gmail.com>
Message-ID: <09a001cd96bd$a4155820$ec400860$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> On 6 September 2012 19:55, Chander Kashyap <chander.kashyap@linaro.org>
> wrote:
> > The clock instance parameter in Samsung clock interface is not being
> checked
> > for NULL pointers. Add checks for NULL pointers.
> >
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > ---
> >  arch/arm/plat-samsung/clock.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-
> samsung/clock.c
> > index 65c5eca..7938fbc 100644
> > --- a/arch/arm/plat-samsung/clock.c
> > +++ b/arch/arm/plat-samsung/clock.c
> > @@ -119,7 +119,7 @@ void clk_disable(struct clk *clk)
> >
> >  unsigned long clk_get_rate(struct clk *clk)
> >  {
> > -       if (IS_ERR(clk))
> > +       if (IS_ERR_OR_NULL(clk))
> >                 return 0;
> >
> >         if (clk->rate != 0)
> > @@ -136,7 +136,7 @@ unsigned long clk_get_rate(struct clk *clk)
> >
> >  long clk_round_rate(struct clk *clk, unsigned long rate)
> >  {
> > -       if (!IS_ERR(clk) && clk->ops && clk->ops->round_rate)
> > +       if (!IS_ERR_OR_NULL(clk) && clk->ops && clk->ops->round_rate)
> >                 return (clk->ops->round_rate)(clk, rate);
> >
> >         return rate;
> > @@ -146,7 +146,7 @@ int clk_set_rate(struct clk *clk, unsigned long
rate)
> >  {
> >         int ret;
> >
> > -       if (IS_ERR(clk))
> > +       if (IS_ERR_OR_NULL(clk))
> >                 return -EINVAL;
> >
> >         /* We do not default just do a clk->rate = rate as
> > @@ -175,7 +175,7 @@ int clk_set_parent(struct clk *clk, struct clk
> *parent)
> >  {
> >         int ret = 0;
> >
> > -       if (IS_ERR(clk))
> > +       if (IS_ERR_OR_NULL(clk) || IS_ERR_OR_NULL(parent))
> >                 return -EINVAL;
> >
> >         spin_lock(&clocks_lock);
> > --
> > 1.7.9.5
> 
> Acked-by: Thomas Abraham <thomas.abraham@linaro.org>

Looks OK, will apply.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
