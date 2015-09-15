From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Sep 2015 13:22:22 +0100
Subject: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency
 on struct device_node
In-Reply-To: <55F7F9E2.3070105@linaro.org>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
 <1442249047-21182-3-git-send-email-marc.zyngier@arm.com>
 <55F7F9E2.3070105@linaro.org>
Message-ID: <55F80D7E.9090208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/15 11:58, Tomasz Nowicki wrote:
> On 14.09.2015 18:44, Marc Zyngier wrote:
>> struct device_node is very much DT specific, and the original authors
>> of the irqdomain subsystem recognized that tie, and went as far as
>> mentionning that this could be replaced by some "void *token",
>> should another firmware infrastructure be using it.
>>
>> As we move ACPI on arm64 towards this model too, it makes a lot of sense
>> to perform that particular move.
>>
>> We replace "struct device_node *of_node" with "void *domain_token", which
>> is a benign enough transformation. A non DT user of irqdomain can now
>> identify its domains using this pointer.
>>
>> Also, in order to prevent the introduction of sideband type information,
>> only DT is allowed to store a valid kernel pointer in domain_token
>> (a pointer that passes the virt_addr_valid() test will be considered
>> as a valid device_node).
>>
>> non-DT users that wish to store valid pointers in domain_token are
>> required to use another structure such as an IDR.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   include/linux/irqdomain.h | 68 +++++++++++++++++++-----------------
>>   kernel/irq/irqdomain.c    | 89 ++++++++++++++++++++++++++++++++++-------------
>>   2 files changed, 101 insertions(+), 56 deletions(-)
>>

[...]

>> -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
>> +struct irq_domain *__irq_domain_add(void *domain_token, int size,
>>   				    irq_hw_number_t hwirq_max, int direct_max,
>>   				    const struct irq_domain_ops *ops,
>>   				    void *host_data)
>>   {
>> +	struct device_node *of_node;
>>   	struct irq_domain *domain;
>>
>> +	of_node = irq_domain_token_to_of_node(domain_token);
>>   	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>>   			      GFP_KERNEL, of_node_to_nid(of_node));
> 
> While we are here, do you think it makes sense to abstract 
> of_node_to_nid as well? Then we would really remove device_node 
> dependency for irqdomain.

Not quite sure yet. I've decided to completely ignore the whole NUMA
thing for the time being. This is a performance issue, not a
functionality problem.

Once we have something that actually makes sense, we can have a look.

	M.
-- 
Jazz is not dead. It just smells funny...
