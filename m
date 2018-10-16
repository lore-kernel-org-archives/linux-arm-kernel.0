From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 16 Oct 2018 09:43:51 +0200
Subject: [PATCH v6 17/18] mm/memory-failure: increase queued recovery
 work's priority
In-Reply-To: <20181015164913.GE11434@zn.tnic>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-18-james.morse@arm.com>
 <20181015164913.GE11434@zn.tnic>
Message-ID: <20181016074351.GC4030@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 06:49:13PM +0200, Borislav Petkov wrote:
> On Fri, Sep 21, 2018 at 11:17:04PM +0100, James Morse wrote:
> > @@ -1463,11 +1465,14 @@ void memory_failure_queue(unsigned long pfn, int flags)
> >  
> >  	mf_cpu = &get_cpu_var(memory_failure_cpu);
> >  	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> > -	if (kfifo_put(&mf_cpu->fifo, entry))
> > -		schedule_work_on(smp_processor_id(), &mf_cpu->work);
> > -	else
> > +	if (kfifo_put(&mf_cpu->fifo, entry)) {
> > +		queue_work_on(cpu, system_highpri_wq, &mf_cpu->work);
> > +		set_tsk_need_resched(current);
> > +		preempt_set_need_resched();
> 
> What guarantees the workqueue would run before the process? I see this:
> 
> ``WQ_HIGHPRI``
>   Work items of a highpri wq are queued to the highpri
>   worker-pool of the target cpu.  Highpri worker-pools are
>   served by worker threads with elevated nice level.
> 
> but is that enough?

Nope. Nice just makes it more likely, but no guarantees what so ever.

If you want to absolutely run something before we return to userspace,
would not task_work() be what we're looking for?
