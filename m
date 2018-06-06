From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 06 Jun 2018 10:13:44 +0100
Subject: [PATCH v2] irqchip/gic-v3-its: fix ITS queue timeout
In-Reply-To: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
References: <1528252824-15144-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <86a7s89t13.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Jun 2018 03:40:24 +0100,
Yang Yingliang wrote:

[I'm travelling, so please do not expect any quick answer...]

> 
> When the kernel booted with maxcpus=x, 'x' is smaller
> than actual cpu numbers, the TAs of offline cpus won't

TA? Target Address? Target Affinity? Timing Advance? Terrible Acronym?

> be set to its->collection.
> 
> If LPI is bind to offline cpu, sync cmd will use zero TA,
> it leads to ITS queue timeout.  Fix this by choosing a
> online cpu, if there is no online cpu in cpu_mask.

So instead of fixing the emission of a sync command on a non-mapped
collection, you hack set_affinity? It doesn't feel like the right
thing to do.

It is also worth noticing that mapping an LPI to a collection that is
not mapped yet is perfectly legal.

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5416f2b..d8b9539 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2309,7 +2309,9 @@ static int its_irq_domain_activate(struct irq_domain *domain,
>  		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
>  
>  	/* Bind the LPI to the first possible CPU */
> -	cpu = cpumask_first(cpu_mask);
> +	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> +	if (cpu >= nr_cpu_ids)
> +		cpu = cpumask_first(cpu_online_mask);

Now you're completely ignoring cpu_mask which constraints the NUMA
affinity. On some systems, this ends up with a deadlock (Cavium TX1,
if I remember well).

Wouldn't it be better to just return that the affinity setting request
is impossible to satisfy? And more to the point, how comes we end-up
in such a case?

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
