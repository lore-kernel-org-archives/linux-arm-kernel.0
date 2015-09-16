From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 Sep 2015 10:09:11 +0100
Subject: [PATCH] arm64: hw_breakpoint: use target state to determine ABI
 behaviour
In-Reply-To: <20150915165528.GH31157@arm.com>
References: <1442333773-16446-1-git-send-email-will.deacon@arm.com>
 <20150915164301.GI14287@e104818-lin.cambridge.arm.com>
 <20150915165528.GH31157@arm.com>
Message-ID: <20150916090911.GA25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 05:55:29PM +0100, Will Deacon wrote:
> On Tue, Sep 15, 2015 at 05:43:01PM +0100, Catalin Marinas wrote:
> > On Tue, Sep 15, 2015 at 05:16:13PM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> > > index bba85c8f8037..2926c3dd6479 100644
> > > --- a/arch/arm64/kernel/hw_breakpoint.c
> > > +++ b/arch/arm64/kernel/hw_breakpoint.c
> > > @@ -163,6 +163,12 @@ enum hw_breakpoint_ops {
> > >  	HW_BREAKPOINT_RESTORE
> > >  };
> > >  
> > > +static int is_compat_bp(struct perf_event *bp)
> > > +{
> > > +	struct task_struct *tsk = bp->hw.target;
> > > +	return tsk && is_compat_thread(task_thread_info(tsk));
> > > +}
> > 
> > What are the conditions for tsk == NULL?
> 
> If you create a per-cpu breakpoint (i.e. a breakpoint that isn't affine
> to a task), then the target is NULL. These can only be created by the
> perf_event_open syscall, not from ptrace.

OK, so can sys_perf_event_open() be called from a compat task? If that's
the case, is_compat_bp() should do:

	if (tsk)
		return is_compat_thread(task_thread_info(tsk));
	else
		return is_compat_task();

and a comment on why this is (not) needed. Your patch changes the
current code behaviour when tsk == NULL.

-- 
Catalin
