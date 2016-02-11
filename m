From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 10 Feb 2016 16:38:30 -0800
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <20160201082245.GV3368@x1>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
 <56A95811.8010200@arm.com> <20160201063256.GE32462@lukather>
 <20160201082245.GV3368@x1>
Message-ID: <20160211003830.26445.88202@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2016-02-01 00:22:45)
> On Mon, 01 Feb 2016, Maxime Ripard wrote:
> > On Wed, Jan 27, 2016 at 11:51:45PM +0000, Andr? Przywara wrote:
> > > Hi,
> > > 
> > > On 18/01/16 14:28, Lee Jones wrote:
> > > > This call matches clocks which have been marked as critical in DT
> > > > and sets the appropriate flag.  These flags can then be used to
> > > > mark the clock core flags appropriately prior to registration.
> > > 
> > > I like the idea of having a generic property very much. Also this solves
> > > a problem I have in a very elegant way.
> > 
> > Not really. It has a significant set of drawbacks that we already
> > detailed in the initial thread, which are mostly related to the fact
> > that the clocks are to be left on is something that totally depends on
> > the software support in the kernel. Some clocks should be reported as
> > critical because they are simply missing a driver for it, some should
> > be because the driver for it as not been compiled, some should because
> > we don't have the proper clocks drivers yet for one of their
> > downstream clocks.
> 
> Exactly.  This is a not a CLK_DRIVER_NOT_{AUTHORED|UPSTREAM} or
> CLK_DRIVER_NOT_ENABLED implementation, it's for CLK_CRITICALs.
> Critical clocks must _never_ be turned off, no matter what, else
> something really bad will happen.  In our use-case, if the clocks are
> turned of, it will be catastrophic to the running system.
> 
> > Basically, it all boils down to this: some clocks should never ever be
> > shutdown because <hardware reason>, and I believe it's the case Lee is
> > in. But most of the current code that would use it might, and might
> > even need at some point to shut down such a clock.

Handoff clocks solved both the handoff clock problem (which Rhyland's
thread[0] brings back up) and the critical clock problem entirely except
for a single corner case: if a *critical* clk is enabled at boot via the
HANDOFF flag and then a driver get's that clk and enables/disables it.
Then we lose the refcount and the critical clock (which must never be
gated) will be gated.

That is the executive summary of my discussion with Lee last year. I'm
fine to merge both critical clocks and handoff clocks into the clk core
to cover all corner cases.

I'll post a series combining both sets of patches later today for
review.

> > 
> > Mike's solution with the flags + handover was solving all this, I'm
> > not sure why he's not pushed it forward.

Because I was super busy. I'm still super busy but now I will ignore
other important things and catch up on clk land. ;-)

[0] https://lkml.org/lkml/2016/2/9/817

Regards,
Mike

> 
> Right, but I think you are missing part of the conversation.  Mike and
> I had a face-to-face meeting in San Francisco last year.  The
> conclusion was that the CLK_CRITICAL and CLK_HANDOVER solutions should
> be separated.  Different handling, different code.  This submission
> only solves the former problem.  I believe Mike was going to submit
> and follow-up on the CLK_HANDOVER solution separately.
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
