From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 17 Jun 2016 10:13:57 -0400
Subject: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling for
 ACPI based PCI host controller
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F790346@lhreml507-mbx>
References: <1466004851-10214-1-git-send-email-cov@codeaurora.org>
 <1466004851-10214-2-git-send-email-cov@codeaurora.org>
 <20160616174856.GB32388@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F790346@lhreml507-mbx>
Message-ID: <576405A5.3010407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2016 04:01 AM, Gabriele Paoloni wrote:
> Hi Lorenzo and All
> 
>> -----Original Message-----
>> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
>> Sent: 16 June 2016 18:49
>> To: Christopher Covington
>> Cc: Tomasz Nowicki; Duc Dang; liudongdong (C); Sinan Kaya; Jeff Hugo;
>> Gabriele Paoloni; Jon Masters; Mark Salter; Suravee Suthikulpanit;
>> Jayachandran C; David Daney; Robert Richter; Hanjun Guo; linux-arm-
>> kernel at lists.infradead.org; Catalin Marinas; Will Deacon; Bjorn Helgaas;
>> Ganapatrao Kulkarni; linux-kernel at vger.kernel.org
>> Subject: Re: [RFC PATCH v3 2/2] ARM64/PCI: Start using quirks handling
>> for ACPI based PCI host controller
>>
>> On Wed, Jun 15, 2016 at 11:34:11AM -0400, Christopher Covington wrote:
>>> From: Tomasz Nowicki <tn@semihalf.com>
>>>
>>> pci_generic_ecam_ops is used by default. Since there are platforms
>>> which have non-compliant ECAM space we need to overwrite these
>>> accessors prior to PCI buses enumeration. In order to do that
>>> we call pci_mcfg_get_ops to retrieve pci_ecam_ops structure so that
>>> we can use proper PCI config space accessors and bus_shift.
>>>
>>> pci_generic_ecam_ops is still used for platforms free from quirks.
>>>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> ---
>>>  arch/arm64/kernel/pci.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>>> index 94cd43c..a891bda 100644
>>> --- a/arch/arm64/kernel/pci.c
>>> +++ b/arch/arm64/kernel/pci.c
>>> @@ -139,6 +139,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root
>> *root)
>>>  	struct pci_config_window *cfg;
>>>  	struct resource cfgres;
>>>  	unsigned int bsz;
>>> +	struct pci_ecam_ops *ops;
>>>
>>>  	/* Use address from _CBA if present, otherwise lookup MCFG */
>>>  	if (!root->mcfg_addr)
>>> @@ -150,12 +151,12 @@ pci_acpi_setup_ecam_mapping(struct
>> acpi_pci_root *root)
>>>  		return NULL;
>>>  	}
>>>
>>> -	bsz = 1 << pci_generic_ecam_ops.bus_shift;
>>> +	ops = pci_mcfg_get_ops(root);
>>> +	bsz = 1 << ops->bus_shift;
>>>  	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
>>>  	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
>>>  	cfgres.flags = IORESOURCE_MEM;
>>> -	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
>>> -			      &pci_generic_ecam_ops);
>>> +	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ops);
>>
>> Arnd pointed this out already, I think that's the only pending question
>> here.
>>
>> pci_ecam_create() maps ECAM space for config regions retrieved from
>> the MCFG, which are *supposed* to be ECAM compliant.
>>
>> Do we think that's *always* correct/safe regardless of the kind
>> of quirk we are currently fixing up ?

> From my perspective I think the easiest solution is to keep this
> quirk mechanism in place and then review vendor by vendor solution
> as they are pushed to the mailing list; if some vendors are abusing
> of some addresses/resources then they can be rejected...

Using pci_ecam_create() works well for QDF2432:

https://us.codeaurora.org/cgit/quic/server/kernel/commit/?h=cov/4.7-rc3-testing&id=ca7439a54ddd8612b435c797ffc54f4e19f03e2b

Cheers,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
