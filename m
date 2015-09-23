From: ddaney@caviumnetworks.com (David Daney)
Date: Wed, 23 Sep 2015 09:59:35 -0700
Subject: [PATCH v2 2/3] of/irq: Add new function of_msi_map_rid()
In-Reply-To: <20150923175216.3384d7b4@arm.com>
References: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
 <1442966406-13198-3-git-send-email-ddaney.cavm@gmail.com>
 <20150923175216.3384d7b4@arm.com>
Message-ID: <5602DA77.9090108@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2015 09:52 AM, Marc Zyngier wrote:
> On Tue, 22 Sep 2015 17:00:05 -0700
> David Daney <ddaney.cavm@gmail.com> wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> The device tree property "msi-map" specifies how to create the PCI
>> requester id used in some MSI controllers.  Add a new function
>> of_msi_map_rid() that finds the msi-map property and applies its
>> translation to a given requester id.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/of/irq.c       | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/of_irq.h |  7 ++++
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>> index 55317fa..3f64d2e 100644
>> --- a/drivers/of/irq.c
>> +++ b/drivers/of/irq.c
>> @@ -598,3 +598,89 @@ void of_msi_configure(struct device *dev, struct device_node *np)
[...]
>> +	while (!matched && msi_map_len >= 4 * sizeof(__be32)) {
>> +		rid_base = be32_to_cpup(msi_map + 0);
>> +		phandle = be32_to_cpup(msi_map + 1);
>> +		msi_base = be32_to_cpup(msi_map + 2);
>> +		rid_len = be32_to_cpup(msi_map + 3);
>
> Rob did suggest to use of_property_read_u32_index() instead of these
> be32_to_cpup(). Not sure if that'd be a major improvement though.
>

I did think about that, but the micro-optimizer in me didn't feel 
comfortable with the overhead of rerunning of_find_property() for each 
value.  I decided to run of_find_property() once, and then iterate 
through the individual values within the property.

If there are strong objections to doing it this way, we can change it.

David Daney
