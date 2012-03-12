From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Mar 2012 10:57:10 -0600
Subject: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
In-Reply-To: <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de>
 <4F59213F.6070107@wwwdotorg.org>
 <20120312080023.GA13788@avionic-0098.mockup.avionic-design.de>
Message-ID: <4F5E2AE6.3030404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2012 02:00 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
...
>> Free the IRQ descriptors in the error paths?
...
>>> +	for (msi = 0; msi < INT_PCI_MSI_NR; msi++) {
>>> +		unsigned int irq = irq_find_mapping(pcie->msi_domain, msi);
>>> +
>>> +		irq_set_chip_data(irq, pcie);
>>> +		irq_set_chip_and_handler(irq, &pcie->msi_chip,
>>> +					 handle_simple_irq);
>>> +		set_irq_flags(irq, IRQF_VALID);
>>> +	}
>>> +
>>> +	err = platform_get_irq(pdev, 1);
>>> +	if (err < 0) {
>>> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
>>
>> Same here, and undo setting IRQF_VALID?
> 
> Does it make sense to explicitly unset the IRQF_VALID flag when the IRQ
> descriptors are free'd afterwards anyway?

Good point. Probably not per my gut instinct.

...
> I'm also Cc'ing Thomas
> Gleixner as maintainer of the IRQ subsystem, he probably knows best how
> dynamically allocated interrupts should be cleaned up.

But yes, best to check with someone more familiar with interrupts.
