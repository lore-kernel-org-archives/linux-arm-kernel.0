From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 10 Mar 2015 14:00:41 +0100
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310125351.GD2896@worktop.programming.kicks-ass.net>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
Message-ID: <20150310130041.GC11574@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 01:53:51PM +0100, Peter Zijlstra wrote:
> > It would be nicer if we could prevent this in the core so we're not
> > reliant on every PMU driver doing the same verification. My initial
> > thought was that seemed like unnecessary duplication of the ctx checking
> > above, but if we're going to end up shoving it into several drivers
> > anyway perhaps it's the lesser evil.
> 
> Again, agreed, that would be better and less error prone. But I'm not
> entirely sure how to go about doing it :/ I'll have to go think about
> that; and conferences are not the best place for that.
> 
> Suggestions on that are welcome of course ;)

So the problem is that event_init() is what will return the pmu, so we
cannot make decisions on it until after that returns.

Maybe we can pull out the validate step into its own funciton;
pmu->validate() or whatnot, to be called slightly later.
