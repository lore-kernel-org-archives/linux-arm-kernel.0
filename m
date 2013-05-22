From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 22 May 2013 18:19:35 +0200
Subject: [PATCH] kernel/sched/core.c: need return NULL when BUG() is
 defined as empty.
In-Reply-To: <20130522133317.GC18614@n2100.arm.linux.org.uk>
References: <5199D565.4070307@asianux.com>
 <20130522091156.GC18810@twins.programming.kicks-ass.net>
 <20130522133317.GC18614@n2100.arm.linux.org.uk>
Message-ID: <20130522161935.GR18810@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 02:33:17PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 22, 2013 at 11:11:56AM +0200, Peter Zijlstra wrote:
> > On Mon, May 20, 2013 at 03:48:53PM +0800, Chen Gang wrote:
> > > 
> > > When neither CONFIG_BUG nor HAVE_ARCH_BUG is defined, need let function
> > > return failure value ('NULL') instead of random value.
> > 
> > What will such a kernel do? Happily continue running whenever we hit a
> > BUG? that seems like a particularly bad idea. Should we not have a stub
> > BUG() function like:
> > 
> > void BUG(void) __attribute__((noreturn))
> > {
> > 	local_irq_disable();
> > 	while (1) ;
> > }
> 
> Eww.  So you've a platform where you have things like panic_on_oops
> enabled, and you hit this bug... do we really want to just stop?
> Wouldn't replacing BUG() with panic("BUG"); be better ?
> 
> But, this begs the question - what is the point of being able to turn
> off BUG() ?  As BUG() on any sensible architecture is implemented by
> placing the minimum of code at the callsite (eg, one instruction if
> not using verbose) anything like the above is likely to be bigger.
> 
> So, I'd actually argue that rather than trying to "fix" this, get rid
> of CONFIG_BUG and make it always enabled everywhere - just like what
> has recently been done with hotplug.

Works for me. 
