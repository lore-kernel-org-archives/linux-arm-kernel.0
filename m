From: robherring2@gmail.com (Rob Herring)
Date: Thu, 28 Mar 2013 13:40:09 -0500
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq function
 is specified
In-Reply-To: <20130328145155.GB3368@n2100.arm.linux.org.uk>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364463704-13692-2-git-send-email-maxime.ripard@free-electrons.com>
 <51545832.1050504@gmail.com> <20130328145155.GB3368@n2100.arm.linux.org.uk>
Message-ID: <51548E89.9060505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2013 09:51 AM, Russell King - ARM Linux wrote:
> On Thu, Mar 28, 2013 at 09:48:18AM -0500, Rob Herring wrote:
>> On 03/28/2013 04:41 AM, Maxime Ripard wrote:
>>> +	if (machine_desc->init_irq)
>>> +		machine_desc->init_irq();
>>> +	else
>>> +		irqchip_init();
>>
>> There needs to be an empty version defined for !OF.
> 
> Better:
> 
> #ifdef CONFIG_OF
> 	if (!machine_desc->init_irq)
> 		irqchip_init();
> 	else
> #endif

Or the new style:

	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
		irqchip_init();
	else

That needs the empty version, but handles your case.

Rob

> 		machine_desc->init_irq();
> 
> which means we don't even get the test if !OF, and if someone mistakenly
> sets this to NULL for a !OF platform, they get to know about it.
> 
