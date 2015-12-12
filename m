From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 11 Dec 2015 16:18:14 -0800
Subject: [PATCH] locking/osq: fix ordering of node initialisation in
 osq_lock
In-Reply-To: <1449856001-21177-1-git-send-email-will.deacon@arm.com>
References: <1449856001-21177-1-git-send-email-will.deacon@arm.com>
Message-ID: <566B67C6.9050700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2015 09:46 AM, Will Deacon wrote:
> The Cavium guys reported a soft lockup on their arm64 machine, caused
> by c55a6ffa6285 ("locking/osq: Relax atomic semantics"):
>
> [   68.909948] [<fffffe00000da03c>] mutex_optimistic_spin+0x9c/0x1d0
> [   68.909951] [<fffffe00006fe4b8>] __mutex_lock_slowpath+0x44/0x158
> [   68.909953] [<fffffe00006fe620>] mutex_lock+0x54/0x58
> [   68.909956] [<fffffe0000265efc>] kernfs_iop_permission+0x38/0x70
> [   68.909959] [<fffffe00001fbf50>] __inode_permission+0x88/0xd8
> [   68.909961] [<fffffe00001fbfd0>] inode_permission+0x30/0x6c
> [   68.909964] [<fffffe00001fe26c>] link_path_walk+0x68/0x4d4
> [   68.909966] [<fffffe00001ffa14>] path_openat+0xb4/0x2bc
> [   68.909968] [<fffffe000020123c>] do_filp_open+0x74/0xd0
> [   68.909971] [<fffffe00001f13e4>] do_sys_open+0x14c/0x228
> [   68.909973] [<fffffe00001f1544>] SyS_openat+0x3c/0x48
> [   68.909976] [<fffffe00000851f0>] el0_svc_naked+0x24/0x28
>
> This is because in osq_lock we initialise the node for the current CPU:
>
> 	node->locked = 0;
> 	node->next = NULL;
> 	node->cpu = curr;
>
> and then publish the current CPU in the lock tail:
>
> 	old = atomic_xchg_acquire(&lock->tail, curr);
>
> Once the update to lock->tail is visible to another CPU, the node is
> then live and can be both read and updated by concurrent lockers.
>
> Unfortunately, the ACQUIRE semantics of the xchg operation mean that
> there is no guarantee the contents of the node will be visible before
> lock tail is updated. This can lead to lock corruption when, for example,
> a concurrent locker races to set the next field.
>
> Fixes: c55a6ffa6285 ("locking/osq: Relax atomic semantics"):
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Reported-by: Andrew Pinski <andrew.pinski@caviumnetworks.com>
> Tested-by: Andrew Pinski <andrew.pinski@caviumnetworks.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Tested-by: David Daney <david.daney@cavium.com>

Thanks Will, this fixes a kernel from two days ago (commit 5406812e5976) 
for me.

Interestingly a more recent kernel from today (commit b9d85451ddd4), was 
not failing.  I think this shows that you have to get the timing Just 
Right to hit the problem, and minor unrelated changes can change the 
outcome.  I also noticed that turning on lock debugging would fix some 
systems, but not others.

David Daney

> ---
>   kernel/locking/osq_lock.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d092a0c9c2d4..05a37857ab55 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -93,10 +93,12 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	node->cpu = curr;
>
>   	/*
> -	 * ACQUIRE semantics, pairs with corresponding RELEASE
> -	 * in unlock() uncontended, or fastpath.
> +	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> +	 * unlock() uncontended, or fastpath) and RELEASE (to publish
> +	 * the node fields we just initialised) semantics when updating
> +	 * the lock tail.
>   	 */
> -	old = atomic_xchg_acquire(&lock->tail, curr);
> +	old = atomic_xchg(&lock->tail, curr);
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>
>
