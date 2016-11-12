From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 11 Nov 2016 18:38:44 -0800
Subject: [RFC 00/17] clk: Add per-controller locks to fix deadlocks
In-Reply-To: <7933d51e-92a8-ca6d-84f0-70b22fe17568@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
 <20160909002432.GE13062@codeaurora.org>
 <CGME20161104105318eucas1p2e9458dbe7039f2a81419fae8cf6bc4c8@eucas1p2.samsung.com>
 <7933d51e-92a8-ca6d-84f0-70b22fe17568@samsung.com>
Message-ID: <20161112023844.GG5177@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04, Marek Szyprowski wrote:
> Hi Stephen,
> 
> Krzysztof has left Samsung, but we would like to continue this task, because
> the ABBA dead-locks related to global prepare lock becomes more and more
> problematic for us to workaround.

Hmm. Ok. Thanks for the info.

> 
> On 2016-09-09 02:24, Stephen Boyd wrote:
> 
> >So I'm not very fond of this design because the locking scheme is
> >pretty much out of the hands of the framework and can be easily
> >broken.
> 
> Well, switching from a single global lock to more granular locking
> is always a good approach. Please note that the global lock sooner
> or later became a serious bottleneck if one wants to make somehow
> more aggressive power management and clock gating.

I'm not so sure switching from a global lock to a more granular
lock is _always_ a great idea. Sometimes simpler code is better,
even if it doesn't scale to a million clk nodes. The largest
systems I've seen only have clocks in the hundreds, and a
majority of those aren't rate changing in parallel, so it's not
like we're suffering from VFS type scalability problems here with
tens of thousands of inodes.

That isn't to say I don't agree there's a scalability problem
here, but I'd like to actually see numbers to prove that there's
some sort of scalability problem before making drastic changes.

> 
> >  I'm biased of course, because I'd prefer we go with my
> >wwmutex design of per-clk locks[1]. Taking locks in any order
> >works fine there, and we resolve quite a few long standing
> >locking problems that we have while improving scalability. The
> >problem there is that we don't get the recursive mutex design
> >(maybe that's a benefit!).
> 
> Do you have any plan to continue working on your approach? per-clk
> wwmutex looks like an overkill on the first glance, but that's probably
> the only working solution if you want to get rid of recursive locks.
> I'm still not really convinced that we really need wwmutex here,
> especially if it is possible to guarantee the same order of locking
> operations inside the clock core. This requires a bit of cooperation
> from clock providers (with proper documentation and a list of
> DO/DON'T it shouldn't be that hard).

So far I haven't gotten around to resurrecting the wwmutex stuff.
If you have interest in doing it that's great. Having a locking
scheme with rules of DO/DON'T sounds brittle to me, unless it can
be automated to find problems. I know that I'm not going to spend
time policing that.

> 
> >Once a clk_op reenters the framework
> >with consumer APIs and tries to grab the same lock we deadlock.
> >This is why I've been slowly splitting consumers from providers
> >so we can easily identify these cases. If we had something like
> >coordinated clk rate switching, we could get rid of clk_ops
> >reentering the framework and avoid this problem (and we really do
> >need to do that).
> 
> I'm not sure that this makes really sense split consumers and
> providers. You will get recursive calls to clk core anyway with
> consumers calls if you are implementing i2c clock, for which an i2c
> bus driver does it's own clock gating (i2c controller uses
> consumer clk api).
> 
> 

I suppose this is a different topic. Regardless of the recursive
call or not, we can easily see that a clk consumer is also a clk
provider and just knowing that is useful. Once we know that, we
can look to see if they're calling clk consumer APIs from their
provider callbacks which is not desired because it makes it
impossible to get rid of the recursive lock design. If the lock
is per-clock, then recursion doesn't happen when the provider is
also a consumer. If it does, that's bad and lockdep should tell
us.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
