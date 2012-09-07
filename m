From: mturquette@ti.com (Mike Turquette)
Date: Thu, 06 Sep 2012 17:19:27 -0700
Subject: [PATCH 1/4] clk: Provide option for clk_get_rate to issue hw for
 new rate
In-Reply-To: <CAPDyKFrS7tKu5AcjL7+R8V5Nvo0O+BVwc8HtGFqQGSf12wMioQ@mail.gmail.com>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
 <1346415691-13371-2-git-send-email-ulf.hansson@stericsson.com>
 <20120831192906.31162.97714@nucleus>
 <CAPDyKFrS7tKu5AcjL7+R8V5Nvo0O+BVwc8HtGFqQGSf12wMioQ@mail.gmail.com>
Message-ID: <20120907001927.20289.41627@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ulf Hansson (2012-09-06 02:09:33)
> On 31 August 2012 21:29, Mike Turquette <mturquette@ti.com> wrote:
> > This is a bit subtle.  Calling __clk_recalc_rates will walk the subtree
> > of children recalculating rates as well as firing off notifiers.  Is
> > this what you want?  If your clock changes rates behind your back AND
> > has chilren then this is probably the right thing to do.  However you
> > might be better off with:
> >
> >         if (clk && (clk->flags & CLK_GET_RATE_NOCACHE))
> >                 rate = clk->ops->recalc_rate(clk->hw, clk->parent->rate);
> >
> > This doesn't update children or fire off notifiers.  What is best for
> > your platform?
> 
> For my platform, ux500 and for the clock connected to this
> patchseries, your suggesting above is enough. (Well some additional
> error handling is needed in your code proposal though :-) )
> 
> The reason for why I used "__clk_recalc_rates" was because I think it
> could make sense to have a more generic approach, not sure if it is
> needed as you mention. Additionally, using  __clk_recalc_rates with
> "0" as the notification argument, should prevent notifications from
> happen, right?
> 

You are right.  I didn't catch that when running through this patch the
first time.

> So basically, I wanted the clock rates for the children to be updated
> as well as the parent clock rate, but no notifications.
> 

This is the answer I was looking for.  You DO want to walk the subtree
of children and recalc the rates.  Since you are the first user of such
a feature I am happy to shape it for your needs ;-)

> I can happily update the patch according to your proposal if you still
> think it is the best way to do it, just tell me again then. :-)
> 

No your patch does the right thing for your platform and looks sane and
generic for others.  I feel much better about not firing off random
notifiers (which I missed when I reviewed your patch last time).

I'll take this series into clk-next.

Regards,
Mike

> Kind regards
> Ulf Hansson
