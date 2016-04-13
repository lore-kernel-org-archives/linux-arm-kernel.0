From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 13:23:24 +0200
Subject: [PATCH 4/6] staging: fsl-mc: Use platform_msi_* infrastructure
In-Reply-To: <570E25DD.9070106@arm.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
 <1460543456-11345-5-git-send-email-mbrugger@suse.com>
 <570E25DD.9070106@arm.com>
Message-ID: <570E2C2C.6090900@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/04/16 12:56, Marc Zyngier wrote:
> On 13/04/16 11:30, Matthias Brugger wrote:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The fsl-mc driver can't be build as a module because it uses msi_*
>> functions directly. Port the driver to use the platform_msi_*
>> infrastructure instead, to allow it to be build as a module.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>   .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |   5 +-
>>   drivers/staging/fsl-mc/bus/mc-allocator.c          |   9 +-
>>   drivers/staging/fsl-mc/bus/mc-msi.c                | 169 +--------------------
>>   drivers/staging/fsl-mc/include/mc-sys.h            |   3 +
>>   4 files changed, 14 insertions(+), 172 deletions(-)
>>
>> diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
>> index 720e2b0..0eecb7e 100644
>> --- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
>> +++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
>> @@ -25,7 +25,6 @@ static struct irq_chip its_msi_irq_chip = {
>>   	.irq_mask = irq_chip_mask_parent,
>>   	.irq_unmask = irq_chip_unmask_parent,
>>   	.irq_eoi = irq_chip_eoi_parent,
>> -	.irq_set_affinity = msi_domain_set_affinity
>>   };
>>
>>   static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
>> @@ -86,7 +85,7 @@ int __init its_fsl_mc_msi_init(void)
>>   			continue;
>>   		}
>>
>> -		mc_msi_domain = fsl_mc_msi_create_irq_domain(
>> +		mc_msi_domain = platform_msi_create_irq_domain(
>>   						 of_node_to_fwnode(np),
>>   						 &its_fsl_mc_msi_domain_info,
>>   						 parent);
>
> What? We are already creating a platform MSI domain for the ITS. How is
> that going to work? If you want to convert this set of drivers to
> platform ITS, fine. But you can't randomly hack in the ITS code and pray
> for things not to fall apart.
>

 From what I see, the difference between irq-gic-v3-its-fsl-mc-msi and 
the irq-gic-v3-its-platform-msi is the way ITS specific DeviceID is 
created in msi_prepare.

German, is there a reason why you use the ICID read from the DPRC as dev_id?

Regards,
Matthias
