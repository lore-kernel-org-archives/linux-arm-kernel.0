From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 23 Sep 2016 10:48:29 +0800
Subject: [PATCH] clocksource/drivers/ti-32k: Prevent ftrace recursion
In-Reply-To: <20160922224514.696ae61b@gandalf.local.home>
References: <20160922075621.3725-1-jszhang@marvell.com>
 <alpine.DEB.2.20.1609221555590.5599@nanos>	<20160923100431.6cf2c88f@xhacker>
 <20160922224514.696ae61b@gandalf.local.home>
Message-ID: <20160923104829.29a3b68b@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Sep 2016 22:45:14 -0400 Steven Rostedt wrote:

> On Fri, 23 Sep 2016 10:04:31 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > Hi Thomas,
> > 
> > On Thu, 22 Sep 2016 15:58:03 +0200 Thomas Gleixner wrote:
> >   
> > > On Thu, 22 Sep 2016, Jisheng Zhang wrote:
> > >     
> > > > Currently ti-32k can be used as a scheduler clock. We properly marked
> > > > omap_32k_read_sched_clock() as notrace but we then call another
> > > > function ti_32k_read_cycles() that _wasn't_ notrace.
> > > > 
> > > > Having a traceable function in the sched_clock() path leads to a
> > > > recursion within ftrace and a kernel crash.      
> > > 
> > > Kernel crash? Doesn't ftrace core prevent recursion?    
> > 
> > a recent similar issue:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg533480.html  
> 
> Right. But Thomas brought up recursion detection. And I said that would
> be the fix, but now thinking about it, I've updated the recursion
> protection so that timer issues should not cause a crash.
> 

Got it. Thanks for the clarification
