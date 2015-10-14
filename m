From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 14 Oct 2015 11:08:15 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <11240940.NHO2vFoJOz@wuerfel>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014083707.GR11639@twins.programming.kicks-ass.net>
 <11240940.NHO2vFoJOz@wuerfel>
Message-ID: <20151014090815.GS17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:00:20AM +0200, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 10:37:07 Peter Zijlstra wrote:

> > > Uuh, I just looked at next and saw this regulator_lock_supply()
> > > function. How is that limited? subclass must be <8 otherwise bad things
> > > happen.
> > 
> > Also, the function appears unused, just delete it 
> 
> That was my first suggestion as well when I ran into 
> 
> drivers/regulator/core.c:139:13: warning: 'regulator_lock_supply' defined but not used
> 
> but apparently this is work-in-progress and the plan is to use it
> in 4.4 when the rest of the currently-under-review patches are merged.

And here I thought we had a fairly strong rule that we should not merge
unused code :/

In any case, whomever wrote that function had better first explain why
its not broken.

And I'm not too keen on making mutex_lock_nested() an inline due it
being too easy to generate code with it. I'd much rather work around the
occasional warning than have to deal with silent but unintended code
spills.
