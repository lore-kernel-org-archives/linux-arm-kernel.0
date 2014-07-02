From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 01 Jul 2014 20:44:20 -0700
Subject: [PATCH] clk: Add tracepoints for hardware operations
In-Reply-To: <53B209E5.1050701@codeaurora.org>
References: <1404172599-10171-1-git-send-email-sboyd@codeaurora.org>
 <20140630205211.3d114169@gandalf.local.home>
 <53B209E5.1050701@codeaurora.org>
Message-ID: <20140702034420.32686.53303@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-06-30 18:07:49)
> On 06/30/14 17:52, Steven Rostedt wrote:
> > On Mon, 30 Jun 2014 16:56:39 -0700
> > Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> >> @@ -483,10 +486,12 @@ static void clk_unprepare_unused_subtree(struct clk *clk)
> >>              return;
> >>  
> >>      if (__clk_is_prepared(clk)) {
> >> +            trace_clk_unprepare(clk);
> > Does it make sense to do these when clk->ops->unprepared_unused or
> > uprepare is not set?
> >
> > You can use DEFINE_EVENT_CONDITIONAL() and add as condition:
> >
> >    clk->ops->unprepared_unused || clk->ops->unprepare
> >
> 
> Neat. I don't know if we actually want to do that though. If we always
> record an event even when the hardware doesn't support the operation we
> get information about events happening to the clock from a software
> perspective. If that isn't important, then we can probably just put it
> under the if conditions.

+1 for recording the tree walk even if no hardware operation is backing
it.

Regards,
Mike

> 
> >
> >>              if (clk->ops->enable) {
> >>                      ret = clk->ops->enable(clk->hw);
> >>                      if (ret) {
> >> @@ -945,6 +965,7 @@ static int __clk_enable(struct clk *clk)
> >>                              return ret;
> > It may make even more sense to add the tracepoints within the if
> > statement. Especially if you have a return on error.
> >
> >
> 
> Right. I was thinking that no "clk*_complete" event would mean there was
> some error. Detecting that case is not so easy though. It may be better
> to always have the completion event so we know how long hardware
> operations take and so that error handling is simpler.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
