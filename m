From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 26 Jun 2015 14:14:33 +0100
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <558D3FDA.6000903@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
 <558CF1CD.5020200@huawei.com> <558D10E1.8040701@arm.com>
 <558D2937.7060408@huawei.com> <558D2C1A.3070702@arm.com>
 <558D3FDA.6000903@huawei.com>
Message-ID: <558D5039.2090803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/15 13:04, majun (F) wrote:
> 
> 
> ? 2015/6/26 18:40, Marc Zyngier ??:
>>
>> My opinion is that we need to be able to lookup the domain from the core
>> code without any of these hacks, and this is what I'm working on at the
>> moment. There is no way external code will be allowed to mess with the
>> internals of the ITS.
>>
>> For the time being, just expose the domain with a helper (you can match
>> it with the of_node). 
> Do you mean add a fucntion in ITS likes below:
> 
> struct irq_domain *get_its_domain(struct device_node *node)
> {
> 	struct its_node *its = NULL;
> 	
> 	list_for_each_entry(its, &its_nodes, entry) {
> 		if(its->msi_chip.of_node == node)
> 			break;
> 	}
> 
> 	return (its)?its->domain:NULL;
> }

Yes.

> 
> How about add a '.match ' member in its_domain_ops
> just like:
> 	.match = get_its_domain;
> 
> So, I can use the fucntion 'irq_find_host' in mbigne driver

And that will only return the PCI/MSI domain, which is not of any help
to you.

At the moment, we register the PCI/MSI domain with the the of_node of
the ITS so that a PCI controller can match the its MSI controller, and
the ITS domain is completely anonymous (it doesn't have an of_node).

What I'm working on is a way to distinguish between several domains that
are identified by the same of_node, but cater for different bus types.
The current match function doesn't quite work for that case.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
