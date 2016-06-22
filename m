From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 22 Jun 2016 05:08:53 -0700
Subject: [PATCH] rcu: Use rcu_gp_kthread_wake() to wake up grace period
 kthreads again
In-Reply-To: <1466587167-3541-1-git-send-email-jszhang@marvell.com>
References: <1466587167-3541-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160622120853.GI3923@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 05:19:27PM +0800, Jisheng Zhang wrote:
> commit abedf8e2419f ("rcu: Use simple wait queues where possible in
> rcutree") converts wait queues in rcutree to use simple wait queues,
> but it incorrectly reverts the commit 2aa792e6faf1 ("rcu: Use
> rcu_gp_kthread_wake() to wake up grace period kthreads").
> 
> This patch tries to fix the above issue by useing rcu_gp_kthread_wake()
> to wake up grace period kthreads again.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Good catch!  Queued for testing and review.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c7f1bc4..c270ce0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2333,7 +2333,7 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
>  	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
>  	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
>  	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
> -	swake_up(&rsp->gp_wq);  /* Memory barrier implied by swake_up() path. */
> +	rcu_gp_kthread_wake(rsp);
>  }
> 
>  /*
> @@ -2961,7 +2961,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
>  	}
>  	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
> -	swake_up(&rsp->gp_wq); /* Memory barrier implied by swake_up() path. */
> +	rcu_gp_kthread_wake(rsp);
>  }
> 
>  /*
> -- 
> 2.8.1
> 
