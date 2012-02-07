From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 06 Feb 2012 19:36:28 -0500
Subject: [PATCH][RFC] tracing/rcu: Add trace_##name##__rcuidle() static
 tracepoint for inside rcu_idle_exit() sections
In-Reply-To: <20120206220502.GA21340@leaf>
References: <20120202190708.GE2518@linux.vnet.ibm.com>
 <87obtgc1xx.fsf@ti.com> <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
 <1328563113.2200.39.camel@gandalf.stny.rr.com>
 <20120206220502.GA21340@leaf>
Message-ID: <1328574988.2200.54.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-06 at 14:05 -0800, Josh Triplett wrote:
> >   */
> > -#define __DO_TRACE(tp, proto, args, cond)				\
> > +#define __DO_TRACE(tp, proto, args, cond, pre, post)			\
> >  	do {								\
> >  		struct tracepoint_func *it_func_ptr;			\
> >  		void *it_func;						\
> > @@ -123,6 +123,7 @@ static inline void tracepoint_synchroniz
> >  		if (!(cond))						\
> >  			return;						\
> >  		rcu_read_lock_sched_notrace();				\
> > +		pre;							\
> >  		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> 
> This results in calling rcu_idle_exit after rcu_read_lock; it needs to
> occur before.

Bah! Good catch. The fumes of my furnace must have been sending out some
strong narcotics. Yeah yeah, that's the reason for this mistake, and
I'll stand by it!

-- Steve
