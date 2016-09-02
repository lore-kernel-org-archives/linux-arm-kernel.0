From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 2 Sep 2016 16:31:09 +0100
Subject: irq_create_fwspec_mapping() in 4.8-rc2
In-Reply-To: <B721D80D-B240-4779-8748-5CFAD330D986@gmail.com>
References: <483F737F-9868-4E8A-A831-AA3F6F410AFF@gmail.com>
 <57C98975.5020607@arm.com> <9FCA11A3-B677-42EA-80DB-674AC8E489E8@gmail.com>
 <57C99111.3030105@arm.com> <F5716CCD-34FF-4CA8-B5F5-C2A33A5D9E91@gmail.com>
 <57C9961F.8080602@arm.com> <B721D80D-B240-4779-8748-5CFAD330D986@gmail.com>
Message-ID: <57C99B3D.3010405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Linus, Jean-Christophe, Jon

On 02/09/16 16:15, Andras Szemzo wrote:
> Hi,
> 
>> On 02 Sep 2016, at 17:09, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>> So something has already configured the interrupt to be
>> IRQ_TYPE_EDGE_BOTH, and this clashes with your
>> IRQ_TYPE_EDGE_FALLING.
>>
>> My bet is on this one:
>>
>> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
>> index 80daead..9f09041 100644
>> --- a/drivers/pinctrl/pinctrl-at91.c
>> +++ b/drivers/pinctrl/pinctrl-at91.c
>> @@ -1614,7 +1614,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
>> 				   &gpio_irqchip,
>> 				   0,
>> 				   handle_edge_irq,
>> -				   IRQ_TYPE_EDGE_BOTH);
>> +				   IRQ_TYPE_NONE);
>> 	if (ret) {
>> 		dev_err(&pdev->dev, "at91_gpio.%d: Couldn't add irqchip to gpiochip.\n",
>> 			at91_gpio->pioc_idx);
>>
>> Can you give it a go and let me know what happens?
> 
> yes, this fixed the problem. Thank you, it was fast!

Right. So the at91 pinctlr seems to enforce a default configuration. The
question is *why*? All interrupts connected to it should provide their
own trigger coming from DT.

As we now actually check that we have some consistency between what is
configured and what is requested, it is bound to fail, unless you happen
to match the default.

What am I missing?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
