From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jul 2015 16:19:46 +0100
Subject: [PATCH v4 07/19] PCI/MSI: Let pci_msi_get_domain use struct
 device's msi_domain
In-Reply-To: <20150721211731.GA3691@google.com>
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com>
 <1436962613-17359-8-git-send-email-marc.zyngier@arm.com>
 <20150721211731.GA3691@google.com>
Message-ID: <55AFB492.7070800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/15 22:17, Bjorn Helgaas wrote:
> Hi Marc,
> 
> On Wed, Jul 15, 2015 at 01:16:41PM +0100, Marc Zyngier wrote:
>> Now that we can easily find which MSI domain a PCI device is
>> using, use dev_get_msi_domain as a way to retrieve the information.
>>
>> The original code is still used as a fallback.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/pci/msi.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index ef4ec6e..c77fdaf 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -41,7 +41,8 @@ static struct irq_domain *pci_msi_get_domain(struct pci_dev *dev)
>>  {
>>  	struct irq_domain *domain = NULL;
>>  
>> -	if (dev->bus->msi)
>> +	domain = dev_get_msi_domain(&dev->dev);
>> +	if (!domain && dev->bus->msi)
>>  		domain = dev->bus->msi->domain;
>>  	if (!domain)
>>  		domain = arch_get_pci_msi_domain(dev);
> 
> I think this would be slightly easier to read as:
> 
>     struct irq_domain *domain;
> 
>     domain = dev_get_msi_domain(&dev->dev);
>     if (domain)
> 	return domain;
> 
>     if (dev->bus->msi && (domain = dev->bus->msi->domain))
> 	return domain;
> 
>     return arch_get_pci_msi_domain(dev);
> 
> I'm not a huge fan of assignments inside "if" conditions, and checkpatch
> might even complain about it, but it exposes the fallback order pretty well
> here.  I guess we could also just repeat the dev->bus->msi->domain
> expression:
> 
>     if (dev->bus->msi && dev->bus->msi->domain)
> 	return dev->bus->msi->domain;
> 
> We can at least get rid of the superfluous initialization of domain to
> NULL.

Yeah, that's better, considering that (as you've noticed) the ugly
assignment is removed in the last patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
