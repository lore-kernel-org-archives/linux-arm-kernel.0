From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 17 Jun 2016 17:42:42 +0200
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
In-Reply-To: <20160617153803.GA1284@arm.com>
References: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
 <20160617142738.GA20181@leverpostej>
 <20160617153803.GA1284@arm.com>
Message-ID: <20160617154242.GZ30154@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 04:38:03PM +0100, Will Deacon wrote:
> > Is there any case where we wouldn't want the memory clobber?
> 
> I don't think you'd need it for cmpwait_relaxed, because the CPU could
> reorder stuff anyway, so anything the compiler does is potentially futile.
> So actually, I can respin this without the clobber. I'll simplify
> the __CMPWAIT_CASE macro to drop the last two parameters as well.

In my previous patches I promoted cmpwait() as a cpu_relax()
'replacement'. Should we not retain the compiler barrier semantics
because of that?

That is, anywhere you use this, you basically _have_ to reread memory,
because the very fact that you return from this basically indicates its
been changed.
