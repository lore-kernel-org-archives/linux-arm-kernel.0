From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 28 Mar 2012 11:01:14 +1100
Subject: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
In-Reply-To: <20120325174210.GA23605@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com>
Message-ID: <1332892874.2882.66.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> > Also, Per Peter Zijlstra's idea, now we don't grab tasklist_lock in
> > the new helper, instead we take the rcu read lock. We can do this
> > because the function is called after the cpu is taken down and
> marked
> > offline, so no new tasks will get this cpu set in their mm mask.
> 
> And only powerpc needs rcu_read_lock() and task_lock().
> 
> OTOH, I do not understand why powepc does this on CPU_DEAD...
> And probably CPU_UP_CANCELED doesn't need to clear mm_cpumask().
> 
> That said, personally I think these patches are fine, the common
> helper makes sense. 

Not strictly speaking a problem with this patch, but I was wondering...

Do we know for sure that the mmu context has been fully flushed out
before the unplug ? idle_task_exit() will do a context switch but in our
case that may not be enough.

Once the CPU is offline, tlb flushes won't hit it any more so it can get
out of sync (in some cases the offlining process is just some kind of
deep sleep loop that doesn't involve a TLB state loss).

Should we add a flush_tlb_mm of all those bits in that loop ? that would
be a tad expensive... we don't have a flush_tlb_all() as a generic kind
of accessors, but we could add something like that as a requirement for
ppc_md.cpu_die ?

Cheers,
Ben.
