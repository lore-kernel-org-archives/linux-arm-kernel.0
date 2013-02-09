From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Fri, 8 Feb 2013 16:14:39 -0800
Subject: [PATCH v5 14/45] rcu, CPU hotplug: Fix comment referring to
 stop_machine()
In-Reply-To: <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130209001439.GQ2666@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 01:06:34PM +0530, Srivatsa S. Bhat wrote:
> Don't refer to stop_machine() in the CPU hotplug path, since we are going
> to get rid of it. Also, move the comment referring to callback adoption
> to the CPU_DEAD case, because that's where it happens now.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Ouch!  That comment is indeed obsolete and must die.

I queued this to -rcu with your Signed-off-by.  However, I omitted
the added comment, as it is imcomplete -- it is easy to look at
rcu_cleanup_dead_cpu() to see what it does.

							Thanx, Paul

> ---
> 
>  kernel/rcutree.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index e441b77..ac94474 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -2827,11 +2827,6 @@ static int __cpuinit rcu_cpu_notify(struct notifier_block *self,
>  		break;
>  	case CPU_DYING:
>  	case CPU_DYING_FROZEN:
> -		/*
> -		 * The whole machine is "stopped" except this CPU, so we can
> -		 * touch any data without introducing corruption. We send the
> -		 * dying CPU's callbacks to an arbitrarily chosen online CPU.
> -		 */
>  		for_each_rcu_flavor(rsp)
>  			rcu_cleanup_dying_cpu(rsp);
>  		rcu_cleanup_after_idle(cpu);
> @@ -2840,6 +2835,10 @@ static int __cpuinit rcu_cpu_notify(struct notifier_block *self,
>  	case CPU_DEAD_FROZEN:
>  	case CPU_UP_CANCELED:
>  	case CPU_UP_CANCELED_FROZEN:
> +		/*
> +		 * We send the dead CPU's callbacks to an arbitrarily chosen
> +		 * online CPU.
> +		 */
>  		for_each_rcu_flavor(rsp)
>  			rcu_cleanup_dead_cpu(cpu, rsp);
>  		break;
> 
