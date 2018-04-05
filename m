From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Apr 2018 19:28:08 +0200
Subject: [PATCH 10/10] locking/qspinlock: Elide back-to-back RELEASE
 operations with smp_wmb()
In-Reply-To: <1522947547-24081-11-git-send-email-will.deacon@arm.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-11-git-send-email-will.deacon@arm.com>
Message-ID: <20180405172808.GG4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 05:59:07PM +0100, Will Deacon wrote:
> @@ -340,12 +341,17 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		goto release;
>  
>  	/*
> +	 * Ensure that the initialisation of @node is complete before we
> +	 * publish the updated tail and potentially link @node into the
> +	 * waitqueue.
> +	 */
> +	smp_wmb();

Maybe an explicit note to where the matching barrier lives..
