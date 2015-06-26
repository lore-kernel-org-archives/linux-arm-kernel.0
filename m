From: majun258@huawei.com (majun (F))
Date: Fri, 26 Jun 2015 20:04:42 +0800
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <558D2C1A.3070702@arm.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
 <558CF1CD.5020200@huawei.com> <558D10E1.8040701@arm.com>
 <558D2937.7060408@huawei.com> <558D2C1A.3070702@arm.com>
Message-ID: <558D3FDA.6000903@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/6/26 18:40, Marc Zyngier ??:
> 
> My opinion is that we need to be able to lookup the domain from the core
> code without any of these hacks, and this is what I'm working on at the
> moment. There is no way external code will be allowed to mess with the
> internals of the ITS.
> 
> For the time being, just expose the domain with a helper (you can match
> it with the of_node). 
Do you mean add a fucntion in ITS likes below:

struct irq_domain *get_its_domain(struct device_node *node)
{
	struct its_node *its = NULL;
	
	list_for_each_entry(its, &its_nodes, entry) {
		if(its->msi_chip.of_node == node)
			break;
	}

	return (its)?its->domain:NULL;
}

How about add a '.match ' member in its_domain_ops
just like:
	.match = get_its_domain;

So, I can use the fucntion 'irq_find_host' in mbigne driver

>In the long run, you should be able to look it up
> directly from the domain list.
> 
I think the domain list you said is 'irq_domain_list'
which defined in Irqdomain.c
static LIST_HEAD(irq_domain_list);

Thanks!
