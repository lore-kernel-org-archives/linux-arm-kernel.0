From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Dec 2017 16:37:43 +0000
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
In-Reply-To: <20171205110619.et5nhkkprv7tmshu@lakrids.cambridge.arm.com>
References: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
 <20171204165533.GI29619@arm.com>
 <20171204180001.7gsub3wt6h5nl3v3@lakrids.cambridge.arm.com>
 <72abe8f2-4d82-1375-956c-5e8b7869864c@codeaurora.org>
 <20171205110619.et5nhkkprv7tmshu@lakrids.cambridge.arm.com>
Message-ID: <20171205163743.gjwr4zdk57awhlya@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 11:06:20AM +0000, Mark Rutland wrote:
> On Tue, Dec 05, 2017 at 10:30:40AM +0530, Vinayak Menon wrote:
> > On 12/4/2017 11:30 PM, Mark Rutland wrote:
> > > On Mon, Dec 04, 2017 at 04:55:33PM +0000, Will Deacon wrote:
> > >> On Mon, Dec 04, 2017 at 09:53:26PM +0530, Vinayak Menon wrote:
> > >>> A case is observed where a wrong physical address is read,
> > >>> resulting in a bus error and that happens soon after TTBR0 is
> > >>> set to the saved ttbr by uaccess_ttbr0_enable. This is always
> > >>> seen to happen in the exit path of the task.
> > >>>
> > >>> exception
> > >>> __arch_copy_from_user
> > >>> __copy_from_user
> > >>> probe_kernel_read
> > >>> get_freepointer_safe
> > >>> slab_alloc_node
> > >>> slab_alloc
> > >>> kmem_cache_alloc
> > >>> kmem_cache_zalloc
> > >>> fill_pool
> > >>> __debug_object_init
> > >>> debug_object_init
> > >>> rcuhead_fixup_activate
> > >>> debug_object_fixup
> > >>> debug_object_activate
> > >>> debug_rcu_head_queue
> > >>> __call_rcu
> > >>> ep_remove
> > >>> eventpoll_release_file
> > >>> __fput
> > >>> ____fput
> > >>> task_work_run
> > >>> do_exit
> > >>>
> > >>> The mm has been released and the pgd is freed, but probe_kernel_read
> > >>> invoked from slub results in call to __arch_copy_from_user. At the
> > >>> entry to __arch_copy_from_user, when SW PAN is enabled, this results
> > >>> in stale value being set to ttbr0. May be a speculative fetch aftwerwards
> > >>> is resulting in invalid physical address access.
> 
> > > I think the problem here is that switch_mm() avoids updating the saved ttbr
> > > value when the next mm is init_mm.
> 
> > For this switch to happen, the schedule() in do_task_dead at the end
> > of do_exit() need to be called, right ?  The issue is happening soon
> > after exit_mm (probably from exit_files).
> 
> I'd assumed that we'd switch_mm() away from the task's mm prior to the
> final mmput(). Otherwise, I can't see why we don't have issues in the
> non SW PAN case (as that would leave the HW TTBR0 stale).
> 
> However, I can't see exactly where we do that, so I'll go diggging.
> Something doesn't seem quite right.

AFAICT, we rely on finish_task_switch() to do the final drop of the mm,
after* we've switched away from the task. So while the task is
installed, the mm (and associated pgd) should still be live, and not
freed.

So my patch shouldn't be necessary.

I'm afraid I don't have any other theory as to what's going on here.

Thanks,
Mark.
