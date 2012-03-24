From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sat, 24 Mar 2012 20:21:52 +0400
Subject: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
In-Reply-To: <1332593574.16159.31.camel@twins>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
 <1332593574.16159.31.camel@twins>
Message-ID: <20120324162151.GA3640@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2012 at 01:52:54PM +0100, Peter Zijlstra wrote:
[...]
> > p.s. I know Peter Zijlstra detest the __cond_lock() stuff, but untill
> >      we have anything better in sparse, let's use it. This particular
> >      patch helped me to detect one bug that I myself made during
> >      task->mm fixup series. So, it is useful.
> 
> Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Also, why didn't lockdep catch it?

Because patch authors test their patches on architectures they own
(well, sometimes I do check patches on exotic architectures w/ qemu,
but it is less convenient than just build/sparse-test the patch w/
a cross compiler).

And since lockdep is a runtime checker, it is not very useful.

Sparse is a build-time checker, so it is even better in the sense
that it is able to catch bugs even in code that is executed rarely.

> Fix sparse already instead of smearing ugly all over.

Just wonder how do you see the feature implemented?

Something like this?

#define __ret_cond_locked(l, c)	__attribute__((ret_cond_locked(l, c)))
#define __ret_value		__attribute__((ret_value))
#define __ret_locked_nonnull(l)	__ret_cond_locked(l, __ret_value);

extern struct task_struct *find_lock_task_mm(struct task_struct *p)
	__ret_locked_nonnull(&__ret_value->alloc_lock);

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
