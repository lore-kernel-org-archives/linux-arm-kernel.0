From: yt.chang@mediatek.com (Kathleen Chang)
Date: Wed, 21 Mar 2018 13:52:06 +0800
Subject: update vruntime incorrectly When use rt_mutex
In-Reply-To: <20180316095113.GA4064@hirez.programming.kicks-ass.net>
References: <1521099370.7712.4.camel@mtkswgap22>
 <20180316095113.GA4064@hirez.programming.kicks-ass.net>
Message-ID: <1521611526.11277.2.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, 

Thanks for your feedback.  

On Fri, 2018-03-16 at 10:51 +0100, Peter Zijlstra wrote:
> On Thu, Mar 15, 2018 at 03:36:10PM +0800, Kathleen Chang wrote:
> > hi,  
> > 
> > We found the vruntime might update incorrectly when use rt_mutex.
> 
> That's nice, on what kernel?
> 
> Also, your email is very hard to make sense of.
> 
> > <<abnormal case>>
> > When the Task is waking, update vruntime incorrectly.
> > 1.  When there is a CFS task (A) hold  rt_mutex_lock and the state is
> > TASK_WAKING (on_rq=0),  a RT task (B) want to hold this rt_mutex_lock.
> > Update vruntime incorrectly.
> > 
> >   RT task (B)
> >      rt_mutex_setprio  (cfs->RT)  ->  Task is waking , and update
> > vruntime
> > 
> >        queued = task_on_rq_queued(p); // task is waking, queued=0
> >        running = task_current(rq, p);
> >        if (queued)      /*   don't update vruntime here!   */
> >                 dequeue_task(rq, p, queue_flag);                      
> >        if (running)
> >                 put_prev_task(rq, p);
> >        
> >        check_class_changed(rq, p, prev_class, oldprio);   -> 
> >                 switched_from_fair -> 
> >                       detach_task_cfs_rq  
> >           ( due to task is waking, and bypass
> > vruntime-=cfs_rq.min_vruntime) 
> > 
> > static void detach_task_cfs_rq(struct task_struct *p)
> > {
> >         struct sched_entity *se = &p->se;
> >         struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > 
> >         if (!vruntime_normalized(p)) {   // return 1, then p->state is
> > TASK_WAKING
> >                 /*
> >                  * Fix up our vruntime so that the current sleep doesn't
> >                  * cause 'unlimited' sleep bonus.
> >                  */
> >                 place_entity(cfs_rq, se, 0);
> >                 check_vruntime(8, se, cfs_rq->min_vruntime);
> >                 se->vruntime -= cfs_rq->min_vruntime;
> 
> So here we subtract min_vruntime,

When the p->state is TASK_WAKING, vruntime_normlized will return 1 
and if(!vruntime_normalized(p)) will be 0

in this case, don't subtract min_vruntime. 


> 
> >                 se->normalized = true;
> 
> this doesn't exist.. which makes me wonder what you're looking at,
> 
> >         }
> > 
> >         detach_entity_cfs_rq(se);
> > }
> > 
> > // when p->state is TASK_WAKING, the task's vruntime is normalized 
> > static inline bool vruntime_normalized(struct task_struct *p)
> > {
> > .....
> >         if (!se->sum_exec_runtime || p->state == TASK_WAKING)
> >                 return true;
> > 
> > }
> > 
> > 2.  When the task (A) which holds the rt_muex_lock unlock the
> > rt_mutex_lock.
> >      Task (A) must be on_rq=1 
> > 
> >     rt_mutex_setprio (RT->CFS)     
> >        if (queued)
> >                 enqueue_task(rq, p, queue_flag);    );     
> >                     /* vruntime += cfs_rq.min_vruntime */
> 
> And here we're adding min_vruntime.
> 
> >        if (running)
> >                 set_curr_task(rq, p);
> > 
> >     that result in vruntime accumulates
> 
> So what exactly is the problem?
> 
> 
