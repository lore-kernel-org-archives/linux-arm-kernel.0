From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 26 May 2011 19:17:44 +0200
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <20110526170422.GA18413@redhat.com>
References: <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526154508.GA13788@redhat.com> <1306425584.2497.81.camel@laptop>
	<1306426148.2497.83.camel@laptop> <20110526170422.GA18413@redhat.com>
Message-ID: <1306430264.2497.88.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-26 at 19:04 +0200, Oleg Nesterov wrote:
> On 05/26, Peter Zijlstra wrote:
> >
> > @@ -2636,7 +2636,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  		 * to spin on ->on_cpu if p is current, since that would
> >  		 * deadlock.
> >  		 */
> > -		if (p == current) {
> > +		if (cpu == smp_processor_id()) {
> > +			p->sched_contributes_to_load = 0;
> >  			ttwu_queue(p, cpu);
> 
> Btw. I do not pretend I really understand se->vruntime, but in this
> case we are doing enqueue_task() without ->task_waking(), however we
> pass ENQUEUE_WAKING. Is it correct?

No its not, that's the thing that I got wrong the first time and caused
these pauses.
