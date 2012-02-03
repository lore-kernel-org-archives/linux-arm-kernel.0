From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 2 Feb 2012 22:06:58 -0800
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120203025350.GF13456@leaf>
References: <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203025350.GF13456@leaf>
Message-ID: <20120203060658.GH2380@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 06:53:50PM -0800, Josh Triplett wrote:
> On Thu, Feb 02, 2012 at 09:45:31PM -0500, Steven Rostedt wrote:
> > On Thu, 2012-02-02 at 15:27 -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 02, 2012 at 06:03:39PM -0500, Steven Rostedt wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > Anyway, one answer is (and I was talking with Paul about this on IRC) is
> > > > that we can create a special "TRACE_EVENT_IDLE()" that will explicitly
> > > > call "rcu_idle_exit/enter()" as it expects to be called with it off.
> > > > 
> > > > This should solve most issues I believe.
> > > 
> > > You OK with something like RCU_NONIDLE() rather than RCU_EVENT_IDLE()?
> > > I have this funny feeling that tracing won't be the only thing using
> > > RCU from idle.  :-/
> > > 
> > > Something like this, perhaps?
> > > 
> > > 	#define RCU_NONIDLE(a) \
> > > 		do { \
> > > 			rcu_idle_exit(); \
> > > 			do { a; } while (0); \
> > > 			rcu_idle_enter(); \
> > > 		}
> > > 
> > 
> > I'm fine with this. But what is the overhead for doing such a thing.
> > Remember, to encapsulate a tracepoint means that you will be doing that
> > work everytime regardless if the tracepoint is ever activated or not. Or
> > even worse, not even compiled into the kernel.
> 
> Yeah, this should definitely try to avoid doing any work in the normal
> case, if at all possible.  Not quite sure how to integrate that into
> tracepoints, though, short of teaching the trace API how to deal with
> getting invoked with RCU currently idle.

I agree that we need to apply this on a tracepoint-by-tracepoint basis --
too expensive for every tracepoint to be doing this, so reserve it for
the ones used in idle.

							Thanx, Paul
