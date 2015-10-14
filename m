From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 16:28:06 +0100
Subject: [PATCH v2 2/2] irqchip/gic-v2m: Add support for multiple MSI
 frames
In-Reply-To: <561E6322.6030601@amd.com>
References: <1444822037-16983-1-git-send-email-marc.zyngier@arm.com>
 <1444822037-16983-3-git-send-email-marc.zyngier@arm.com>
 <561E6322.6030601@amd.com>
Message-ID: <561E7486.6000803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/15 15:13, Suravee Suthikulanit wrote:
> Hi Marc,
> 
> On 10/14/2015 6:27 AM, Marc Zyngier wrote:
>> The GICv2m driver is so far limited to a single MSI frame, but
>> nothing prevents an implementation from having several of them.
>>
>> This patch expands the driver to enumerate all frames, keeping
>> the first one as the canonical identifier for the MSI domains.
>>
>> Tested-by: Duc Dang <dhdang@apm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   drivers/irqchip/irq-gic-v2m.c | 124 ++++++++++++++++++++++++++----------------
>>   1 file changed, 78 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
>> index bf9b3c0..87f8d10 100644
>> --- a/drivers/irqchip/irq-gic-v2m.c
>> +++ b/drivers/irqchip/irq-gic-v2m.c
>> @@ -50,8 +50,12 @@
>>   /* List of flags for specific v2m implementation */
>>   #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
>>
>> +static LIST_HEAD(v2m_nodes);
>> +static DEFINE_SPINLOCK(v2m_lock);
>> +
>>   struct v2m_data {
>> -	spinlock_t msi_cnt_lock;
>> +	struct list_head entry;
>> +	struct device_node *node;
> 
> Would it be better if we use struct fwnode_handle * here instead. I 
> noticed that later on, this is also used as of_node_to_fwnode(v2m->node) 
> in several places. Also, this would need to change anyways when we 
> introducing ACPI support (see here https://lkml.org/lkml/2015/10/13/846).

I was thinking that it would be part of your series adapting it to ACPI.
I don't mind either way...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
