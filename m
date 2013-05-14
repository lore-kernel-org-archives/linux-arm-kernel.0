From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 May 2013 09:59:37 -0700
Subject: [PATCH v2 0/3] clk: implement remuxing during set_rate
In-Reply-To: <CAAG0J991BCziPFddzBrx9vcwRxyRgcCd38A01uKXTDDK9xTnbQ@mail.gmail.com>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <20130513195746.10068.92303@quantum>
 <CAAG0J991BCziPFddzBrx9vcwRxyRgcCd38A01uKXTDDK9xTnbQ@mail.gmail.com>
Message-ID: <20130514165937.10068.18501@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Hogan (2013-05-13 14:30:46)
> On 13 May 2013 20:57, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting James Hogan (2013-04-19 09:28:21)
> >> This patchset adds support for automatic selection of the best parent
> >> for a clock mux, i.e. the one which can provide the closest clock rate
> >> to that requested. It can be controlled by a new CLK_SET_RATE_REMUX flag
> >> so that it doesn't happen unless explicitly allowed.
> >>
> >
> > I'm not sure about the new flag.  One of my regrets during the early
> > development of the common struct clk is the CLK_SET_RATE_PARENT flag.
> > In hindsight I would have preferred to make parent-propagation of rate
> > changes the default behavior, and instead provide a flag to prevent that
> > behavior, such as CLK_SET_RATE_NO_PROPAGATE.
> >
> > One reason for this is the difficulty some have had with setting flags
> > from DT bindings.
> 
> Could you elaborate on this? I've been adding flags to DT bindings for
> this sort of thing, but it feels a bit like it's in that grey area of
> not really describing the hardware itself. This information needs to
> be specified somehow though.
> 

It depends on the flag.  A good example is the CLK_DIVIDER_ONE_BASED
flag which does describe the hardware.  It informs the binding that
indexing starts at 1, not 0, which is a valid part of the hardware
description.

However flags that deal with software policy do not belong on DT.
CLK_SET_RATE_PARENT certainly does not belong in the DT binding since
this is a pure Linux-ism.  Every binding just needs to be reviewed on a
case-by-case basis to make sure the flags are related only to the
hardware.

Regards,
Mike

> > Another reason is that a core goal of the framework
> > is to remove topology info from drivers; having to set a flag explicitly
> > on each clock to propagate rate changes is an impediment to that goal.
> 
> (Something that I have found also where CLK_SET_RATE_PARENT doesn't
> fit well is when you have a mux where you want the set_rate propagated
> to one possible parent (e.g. a dedicated PLL) but not the other (e.g.
> the system clock - which happens to be a divider). In this case what I
> really want to say is "don't change the rate of this particular
> clock", in fact I added a CLK_DIVIDER_READ_ONLY divider flag locally
> for this purpose. Was there a particular use case of
> CLK_SET_RATE_PARENT where you'd want a clock to be changed from one
> child but not another?)
> 
> >
> > So perhaps CLK_SET_RATE_REMUX is a similar situation.  What do you think
> > about making remuxing the default and providing a flag to prevent it?
> 
> Yes, fine by me.
> 
> > And also we can assume for the immediate future that users of
> > .determine_rate WANT to remux, since .round_rate won't do it.  Though
> > eventually it might be wise to convert all users of .round_rate over to
> > .determine_rate and deprecate .round_rate entirely.
> 
> True.
> 
> Cheers
> James
