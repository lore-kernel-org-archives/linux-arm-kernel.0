From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 31 Jul 2014 11:54:44 -0700
Subject: [PATCH v4 6/6] clk: Add floor and ceiling constraints to clock
 rates
In-Reply-To: <53DA8218.7070300@wwwdotorg.org>
References: <1405606399-26608-1-git-send-email-tomeu.vizoso@collabora.com>
 <1405606399-26608-7-git-send-email-tomeu.vizoso@collabora.com>
 <53CEA483.6090704@wwwdotorg.org> <53DA2CCB.2080300@collabora.com>
 <53DA8218.7070300@wwwdotorg.org>
Message-ID: <20140731185444.4463.35237@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2014-07-31 10:51:20)
> On 07/31/2014 05:47 AM, Tomeu Vizoso wrote:
> > On 07/22/2014 07:50 PM, Stephen Warren wrote:
> >> On 07/17/2014 08:13 AM, Tomeu Vizoso wrote:
> >>> Adds a way for clock consumers to set maximum and minimum rates. This
> >>> can be
> >>> used for thermal drivers to set ceiling rates, or by misc. drivers to
> >>> set
> >>> floor rates to assure a minimum performance level.
> >>
> >>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >>
> >>> +struct rate_constraint {
> >>> +    struct hlist_node    node;
> >>> +    const char        *dev_id;
> >>> +    const char        *con_id;
> >>> +    enum constraint_type    type;
> >>> +    unsigned long        rate;
> >>> +};
> >>
> >> I would personally still prefer either:
> >>
> >> a) The struct rate_constraints be stored in struct clk rather than
> >> struct clk_core, so they're stored in the container that "set" the
> >> constraints. This would mean iterating over a struct clk_core's
> >> associated struct clks, then iterating over the struct rate_constraints
> >> within each struct clk.
> >>
> >> or:
> >>
> >> b) struct rate_constraint to contain a pointer to the struct clk that
> >> created the constraint, rather than copying the dev_id/con_id from that
> >> struct clk into the struct rate_constraint.
> >>
> >> With either of those changes, the constraints are directly associated
> >> with the clock client object that created the constraint much better
> >> than right now, where the matching is only because the struct clk and
> >> struct rate_constraint "happen to" have the same dev_id/con_id values.
> >>
> >> Still, this is a pretty minor issue, and overall this series looks
> >> reasonable to me at a quick look.
> >
> > Yeah, I agree and personally prefer a), but given the little feedback
> > that I have gotten so far on the refactoring, I'm starting to consider
> > forgetting about the per-user clk struct and go instead with a
> > request-based API similar to that of pm_qos, for setting floor and
> > ceiling frequencies.
> 
> I would obviously encourage you to continue pushing for this feature, 
> although I understand it can be difficult to be motivated when the 
> patches don't get much feedback.

Sorry for not giving this more of a look. My secret plan was to review
this in more detail once we're closer to the merge window and, if
appropriate, apply it as one of the first things since this is bound to
cause some breakage early on which needs to be caught and fixed up
quickly.

We are very close to the merge window so I will try to get to this later
this week. I like the per-user struct clk myself and I hope we can get
this in for 3.18.

Regards,
Mike
