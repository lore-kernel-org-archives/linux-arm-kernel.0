From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Dec 2017 16:55:33 +0000
Subject: [RFC PATCH] arm64: deactivate saved ttbr when mm is deactivated
In-Reply-To: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
References: <1512404606-26498-1-git-send-email-vinmenon@codeaurora.org>
Message-ID: <20171204165533.GI29619@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 09:53:26PM +0530, Vinayak Menon wrote:
> A case is observed where a wrong physical address is read,
> resulting in a bus error and that happens soon after TTBR0 is
> set to the saved ttbr by uaccess_ttbr0_enable. This is always
> seen to happen in the exit path of the task.
> 
> exception
> __arch_copy_from_user
> __copy_from_user
> probe_kernel_read
> get_freepointer_safe
> slab_alloc_node
> slab_alloc
> kmem_cache_alloc
> kmem_cache_zalloc
> fill_pool
> __debug_object_init
> debug_object_init
> rcuhead_fixup_activate
> debug_object_fixup
> debug_object_activate
> debug_rcu_head_queue
> __call_rcu
> ep_remove
> eventpoll_release_file
> __fput
> ____fput
> task_work_run
> do_exit
> 
> The mm has been released and the pgd is freed, but probe_kernel_read
> invoked from slub results in call to __arch_copy_from_user. At the
> entry to __arch_copy_from_user, when SW PAN is enabled, this results
> in stale value being set to ttbr0. May be a speculative fetch aftwerwards
> is resulting in invalid physical address access.
> 
> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
> ---
> 
> I have not tested this patch to see if it fixes the problem.
> Sending it early for comments.

I wonder whether it would be better to avoid restoring the user TTBR0 if
KERNEL_DS is set. We could do the same thing for PAN. Do we ever access
user addresses under KERNEL_DS?

Will
