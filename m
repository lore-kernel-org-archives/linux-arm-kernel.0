From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Jun 2012 13:49:46 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <20120614183231.GA30185@sirena.org.uk>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk>
Message-ID: <4FDB2F6A.8080300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/12 19:32, Mark Brown wrote:
> On Mon, Jun 11, 2012 at 04:25:01PM +0100, Lee Jones wrote:
>
>> +	if (np) {
>> +		ab8500->domain = irq_domain_add_linear(
>> +			np, num_irqs,&ab8500_irq_ops, ab8500);
>> +	}
>> +	else {
>> +		ab8500->domain = irq_domain_add_legacy(
>> +			NULL, num_irqs, ab8500->irq_base,
>> +			0,&ab8500_irq_ops, ab8500);
>> +	}
>
> This is odd, why are you forcing non-DT systems to use a legacy mapping?
> The more usual approach is to use a legacy mapping if and only if a base
> for the legacy range has been provided, otherwise the system will
> needlessly fail to initialise the device...

Makes sense. I'll re-submit.

>> +	if (!(ab8500->irq_base || np)) {
>> +		dev_info(&pdev->dev, "couldn't find irq-base and not doing DT boot\n");
>
> ...like this.  See regmap_irq for an example.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
