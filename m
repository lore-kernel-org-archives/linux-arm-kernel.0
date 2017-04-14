From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 15 Apr 2017 00:14:55 +0800
Subject: [RFC PATCH 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <CAMuHMdXuuHmjWCrLa7r8xK=Dgad9Cz9C6xibJPRVud6aq4oHxQ@mail.gmail.com>
References: <1491969809-20154-1-git-send-email-aisheng.dong@nxp.com>
 <1491969809-20154-2-git-send-email-aisheng.dong@nxp.com>
 <CAMuHMdXuuHmjWCrLa7r8xK=Dgad9Cz9C6xibJPRVud6aq4oHxQ@mail.gmail.com>
Message-ID: <20170414161455.GE1792@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thu, Apr 13, 2017 at 09:56:31PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 12, 2017 at 6:03 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -520,6 +520,23 @@ void clk_unprepare(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(clk_unprepare);
> >
> > +/**
> > + * clk_bulk_unprepare - undo preparation of a bulk of clock sources
> > + * @num_clks: the number of clk_bulk_data
> > + * @clks: the clk_bulk_data table being ungated
> > + *
> > + * clk_bulk_unprepare may sleep, which differentiates it from clk_bulk_disable.
> > + * Returns 0 on success, -EERROR otherwise.
> > + */
> > +void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
> 
> unsigned int num_clks (everywhere)
> 
> > +{
> > +       int i;
> 
> unsigned int i (everywhere)

Any special purpose?

Looks like 'int i' for a loop is widely used in kernel.

Would you please help clarify more?

> > +
> > +       for (i = 0; i < num_clks; i++)
> > +               clk_unprepare(clks[i].clk);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_bulk_unprepare);
> 
> This does mean you have to change your "while (--i >= 0)" loops.

Is that really necessary as i thought the clk_bulk_get/put does not
guarantee any clk operation orders within the bulk?
Should we need add that support?

And currently this does the same thing as bulk regulator.

Regards
Dong Aisheng
