From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jun 2015 11:40:26 +0100
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <558D2937.7060408@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
 <558CF1CD.5020200@huawei.com> <558D10E1.8040701@arm.com>
 <558D2937.7060408@huawei.com>
Message-ID: <558D2C1A.3070702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/15 11:28, majun (F) wrote:
> 
> Hi Marc:
> 
> ? 2015/6/26 16:44, Marc Zyngier ??:
>>
>> You can then keep your MBI stuff in a separate file, and call into 
>> its_msi_prepare.
>>
> Thanks for your good suggestion!
> I have two questions:
> 
> Question 1:
> 
> I found the ?its_msi_preapare ' defined without static.
> So,I guess you mean I can call this fucntion directly
> from mbigen driver, right?

Yes. You can use it as part of your own msi_prepare function.

> or I need make the code likes below and leave these code in ITS?
> 
> static struct mbigen_domain_ops its_mbigen_ops = {
> +	.mbigen_prepare	= its_msi_prepare,
> };

This structure does not exist. Use the normal msi_domain_ops structure.

> 
> static struct mbigen_domain_info its_mbigen_domain_info = {
> 	.ops	= &its_mbigen_ops,
> };
> 
> Question 2:
> 
> @@ -1489,6 +1538,18 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
>  		err = of_pci_msi_chip_add(&its->msi_chip);
>  		if (err)
>  			goto out_free_domains;
> +
> +		if (IS_ENABLED(CONFIG_MBIGEN_IRQ_DOMAIN)) {
> +			its->mbi_chip.domain = its_mbigen_create_irq_domain(node,
> +										&its_mbigen_domain_info,
> +										its->domain);
> +
> +			if (!its->mbi_chip.domain) {
> +				err = -ENOMEM;
> +				pr_warn_once("ITS:no mbigen chip found\n");
> +				goto out_free_mbigen;
> +			}
> +		}
>  	}
> 
>  	spin_lock(&its_lock);
> @@ -1497,6 +1558,9 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
> 
>  	return 0;
> 
> +out_free_mbigen:
> +	if (its->mbi_chip.domain)
> +		irq_domain_remove(its->mbi_chip.domain);
>  out_free_domains:
>  	if (its->msi_chip.domain)
>  		irq_domain_remove(its->msi_chip.domain);
> 
> What's you opinion about the code above
> Leave it in ITS or create the mbi irq domain in mbigen driver?
> If I have to create mbi irq domain in mbigen driver,
> I need a pointer of its domain.
> 
> For this problem, I think i can solve it by using its_nodes?
> in mbigen driver *if*
> [1] add a member " struct device_node *node" in 'struct its_node'
> [2] in 'its_probe' function , add
> 	its->node = node;
> [3] remove the static definition from  'static LIST_HEAD(its_nodes);'
> 
> How is you opinion?

My opinion is that we need to be able to lookup the domain from the core
code without any of these hacks, and this is what I'm working on at the
moment. There is no way external code will be allowed to mess with the
internals of the ITS.

For the time being, just expose the domain with a helper (you can match
it with the of_node). In the long run, you should be able to look it up
directly from the domain list.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
