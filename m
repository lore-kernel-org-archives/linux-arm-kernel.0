From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jun 2016 17:04:15 +0100
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
In-Reply-To: <20160617154242.GZ30154@twins.programming.kicks-ass.net>
References: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
 <20160617142738.GA20181@leverpostej>
 <20160617153803.GA1284@arm.com>
 <20160617154242.GZ30154@twins.programming.kicks-ass.net>
Message-ID: <20160617160415.GC1284@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 05:42:42PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 17, 2016 at 04:38:03PM +0100, Will Deacon wrote:
> > > Is there any case where we wouldn't want the memory clobber?
> > 
> > I don't think you'd need it for cmpwait_relaxed, because the CPU could
> > reorder stuff anyway, so anything the compiler does is potentially futile.
> > So actually, I can respin this without the clobber. I'll simplify
> > the __CMPWAIT_CASE macro to drop the last two parameters as well.
> 
> In my previous patches I promoted cmpwait() as a cpu_relax()
> 'replacement'. Should we not retain the compiler barrier semantics
> because of that?

To be honest, it's never been clear to me what purpose the memory clobber
serves in cpu_relax().

> That is, anywhere you use this, you basically _have_ to reread memory,
> because the very fact that you return from this basically indicates its
> been changed.

Sure, but that re-read is likely to be done with an acquire. I think this
boils down to whether or not cmpwait_relaxed has any use-cases outside of
an acquire-based outer-loop like that in smp_cond_load_acquire.

Will
