From: majun258@huawei.com (majun (F))
Date: Fri, 25 Sep 2015 19:56:10 +0800
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <20150924203006.4bb162aa@arm.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-2-git-send-email-majun258@huawei.com>
 <20150921225324.5568f673@arm.com> <560253C2.60609@huawei.com>
 <20150924203006.4bb162aa@arm.com>
Message-ID: <5605365A.80605@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/9/25 3:30, Marc Zyngier ??:
> On Wed, 23 Sep 2015 15:24:50 +0800
> "majun (F)" <majun258@huawei.com> wrote:
> 
> [...]
> 
>>>> +static int mbigen_device_init(struct mbigen_chip *chip,
>>>> +                       struct device_node *node)
[...]
>>>> +
>>>> +core_initcall(mbigen_init);
>>>
>>> That's the wrong thing to do. The interrupt controller should be
>>> probed with IRQCHIP_DECLARE(). Yes, this creates a dependency
>>> problem between the MSI layer and the irqchip layer, but that
>>> should be easy (-ish) to solve.
>>
>> Based on our discusstion about DTS,I will change the code likes below:
>> IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-v2", mbigen_of_init);
>>
>> Mbigen device is initialized as a interrupt controller.
>>
>> But I still can't call platform_msi_domain_alloc_irqs()
>> to apply the msi irqs.
>>
>> It think this is what you said "dependency problem between
>>  the MSI layer and the irqchip layer" , am i right ?
>>
>> Do you have any idea about this problem?
> 
> You need to have multiple phases for initializing this beast:
> - IRQCHIP_DECLARE() to create the irqchips, allocate the domains and
>   the main data structures,
> - platform device probing of the top-level device to do some HW probing
>   and to kick of_platform_populate on the subnodes,
> - Handle the the subnode probing, allocate the MSIs, and finish the
>   initialization of the irqchip how that you have all the information.

Ok, I got it. But I still have a question.
According to your suggestions, the initial flow is:

Step1: IRQCHIP_DECLARE() to create the irqchips, allocate the domains and
	the main data structures,
Step2: Parse the device node and apply the irq(named as *device-virq*) within mbigen-device	
	domain (handled by irq core code).
Step3: platform device probing of the top-level device to do some HW probing
	and to kick of_platform_populate on the subnodes,
Step4: Handle the the subnode probing, allocate the MSIs(named as *msi-virq*), and finish the
	initialization of the irqchip how that you have all the information.

My questions is:
	How to connect msi-virq and device-virq ?

In my v4 version, I used the

irq_set_chained_handler(msi-virq, mbigen_handle_cascade_irq);

as msi-virq primary handler function .

Then find  device-virq in mbigen_handle_cascade_irq()
and call device-virq corresponding handler fucntion.

But it seems not a right solution.

So I want try another solution for this problem.

[1] In step2, when the interrupt controller map function is called, using
	irq_set_chip_and_handler(device-irq, &mbigen_irq_chip, handle_fasteoi_irq);
[2] In step4, using
	for_each_msi_entry(desc, &mgn_dev->dev) {
		request_irq( msi-virq, msi_irq_handler, **);
	}

But I am not sure about this solution, please review this and offer me some suggestions.

Best Regards,
Ma Jun


	
