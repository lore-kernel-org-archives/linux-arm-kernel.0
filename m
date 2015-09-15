From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Sep 2015 10:18:32 +0100
Subject: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency
 on struct device_node
In-Reply-To: <2330801.UsQO8cZmqT@vostro.rjw.lan>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
 <1442249047-21182-3-git-send-email-marc.zyngier@arm.com>
 <2330801.UsQO8cZmqT@vostro.rjw.lan>
Message-ID: <55F7E268.1040302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/15 00:15, Rafael J. Wysocki wrote:
> On Monday, September 14, 2015 05:44:01 PM Marc Zyngier wrote:
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
>>  include/linux/irqdomain.h | 68 +++++++++++++++++++-----------------
>>  kernel/irq/irqdomain.c    | 89 ++++++++++++++++++++++++++++++++++-------------
>>  2 files changed, 101 insertions(+), 56 deletions(-)
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index f644fdb..ac7041b 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -17,16 +17,14 @@
>>   * model). It's the domain callbacks that are responsible for setting the
>>   * irq_chip on a given irq_desc after it's been mapped.
>>   *
>> - * The host code and data structures are agnostic to whether or not
>> - * we use an open firmware device-tree. We do have references to struct
>> - * device_node in two places: in irq_find_host() to find the host matching
>> - * a given interrupt controller node, and of course as an argument to its
>> - * counterpart domain->ops->match() callback. However, those are treated as
>> - * generic pointers by the core and the fact that it's actually a device-node
>> - * pointer is purely a convention between callers and implementation. This
>> - * code could thus be used on other architectures by replacing those two
>> - * by some sort of arch-specific void * "token" used to identify interrupt
>> - * controllers.
>> + * The host code and data structures are agnostic to whether or not we
>> + * use an open firmware device-tree. Domains can be assigned a
>> + * "void *domain_token" identifier, which is assumed to represent a
>> + * "struct device_node" if the pointer is a valid virtual address.
>> + *
>> + * Otherwise, the value is assumed to be an opaque identifier. Should
>> + * a pointer to a non "struct device_node" be required, another data
>> + * structure should be used to indirect it (an IDR for example).
>>   */
>>  
>>  #ifndef _LINUX_IRQDOMAIN_H
>> @@ -108,8 +106,8 @@ struct irq_domain_chip_generic;
>>   * @flags: host per irq_domain flags
>>   *
>>   * Optional elements
>> - * @of_node: Pointer to device tree nodes associated with the irq_domain. Used
>> - *           when decoding device tree interrupt specifiers.
>> + * @domain_token: optional firmware-specific identifier for
>> + *                the interrupt controller
>>   * @gc: Pointer to a list of generic chips. There is a helper function for
>>   *      setting up one or more generic chips for interrupt controllers
>>   *      drivers using the generic chip library which uses this pointer.
>> @@ -130,7 +128,7 @@ struct irq_domain {
>>  	unsigned int flags;
>>  
>>  	/* Optional data */
>> -	struct device_node *of_node;
>> +	void *domain_token;
> 
> I'm wondering if that may be something which isn't (void *), but a specific
> pointer type, so the compiler warns us when something suspicious is assigned
> to it?
> 
> [Somewhat along the lines struct fwnode_handle is used elsewehere.]

Yeah, I'm obviously being lazy ;-).

More seriously, I'm trying hard to avoid anything that will require an
additional memory allocation. Going from a device_node to a
fwnode_handle-like structure requires such an allocation which is going
to be a massive pain to retrofit - not impossible, but painful.

What I'm currently aiming for is tagged pointers, where the two bottom
bits indicate the type of the pointed object (see patch #3):
- 00 indicates a device node
- 01 indicates an IDR entry (shifted left by two bits)
- 10 and 11 are currently unallocated, and one of them could be used to
encode a fwnode_handle.

It would be slightly easier to replace the (void *) with a union of the
above types:

	union domain_token {
		struct device_node *of_node;
		struct fwnode_handle *fwnode;
		unsigned long id;
	};

That would remove the need for an extra allocation (at the cost of the
above hack). We just need the accessors to strip the tag. Still need to
repaint all the users of irq_domain_add_*, which is going to be
amazingly invasive.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
