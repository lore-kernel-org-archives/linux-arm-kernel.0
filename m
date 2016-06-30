From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Jun 2016 15:10:15 +0200
Subject: [PATCH v2] arm64: barrier: implement wfe-based
 smp_cond_load_acquire
In-Reply-To: <20160630130016.GE7962@arm.com>
References: <1467049434-30451-1-git-send-email-will.deacon@arm.com>
 <20160630130016.GE7962@arm.com>
Message-ID: <20160630131015.GD30921@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 02:00:17PM +0100, Will Deacon wrote:
> On Mon, Jun 27, 2016 at 06:43:54PM +0100, Will Deacon wrote:
> > smp_cond_load_acquire is used to spin on a variable until some
> > expression involving that variable becomes true.
> > 
> > On arm64, we can build this using WFE and LDXR, since clearing of the
> > exclusive monitor as a result of the variable being changed by another
> > CPU generates an event, which will wake us up out of WFE.
> > 
> > This patch implements smp_cond_load_acquire using LDXR and WFE, which
> > themselves are contained in an internal __cmpwait function.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > Based on Peter's locking/core branch.
> > 
> > v1->v2: Use cmpwait_relaxed
> > 
> >  arch/arm64/include/asm/barrier.h | 13 ++++++++++
> >  arch/arm64/include/asm/cmpxchg.h | 51 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> 
> Peter -- could you take this one via locking/core for 4.8, please? I don't
> anticipate any conflicts with the arm64 tree and it relies on your other
> cond-wait patches anyway.

OK, queued it. Thanks!
