From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 21 Jul 2016 18:45:21 +0800
Subject: "coupled" regulator support
In-Reply-To: <20160718180508.GV30372@sirena.org.uk>
References: <20160715200113.0f3cd823@xhacker>
 <20160715125039.GI30372@sirena.org.uk>	<20160718144422.30be1e2f@xhacker>
 <20160718180508.GV30372@sirena.org.uk>
Message-ID: <20160721184521.03a1b690@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Mon, 18 Jul 2016 19:05:08 +0100 Mark Brown wrote:

> On Mon, Jul 18, 2016 at 02:44:22PM +0800, Jisheng Zhang wrote:
> 
> > v1 and v2 and both valid voltages, but here we have an explicit limitation:
> > we must take the "regulator shared" fact into consideration. Let's assume
> > the voltage is at v2, devA is not busy now, it wants to scale down freq, then
> > scale down voltage to v1, but if devB hasn't call for setting voltage to
> > v1, we can't scale down voltage now, we need to wait for devB sending out
> > the voltage scaling down request when it is not busy in future some time.
> > Obviously, the last user will succeed to scale down the voltage.  
> 
> > My solution is
> > to extend regulator_check_consumers() to check whether all consumers agree
> > to scaling down voltage or not.  
> 
> I'm not sure I 100% follow your explanation above - it still sounds like
> a normal shared regulator situation.  In general I'm really unsure how

You are right!
After carefully checking the code, I found the existing regulator core could
meet my what I want.

Thanks so much,
Jisheng

> this sort of scheme is expected to work.  It seems like in a lot of
> cases there will be some other constraints in play (like needing to do
> frequency updates as part of the sequence) which can't be handled purely
> in the regulator API and/or that the DVFS driver ought to be able to use
> notifiers to discover when actual changes have happened and handle
> things in their own code.  But like I say I don't 100% follow what's new
> in your example so I may be missing something.
