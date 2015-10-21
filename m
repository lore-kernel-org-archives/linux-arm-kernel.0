From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 15:27:39 +0100
Subject: pmu: armv7_a9_pmu_init() fails with -ENXIO
In-Reply-To: <56279753.5000107@free.fr>
References: <56278C91.8050605@free.fr> <56279753.5000107@free.fr>
Message-ID: <5627A0DB.5030304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 14:46, Mason wrote:

[...]

>
> I also looked more closely at of_pmu_irq_cfg()
>
> platform_get_irq(pdev, 0); returns -6

Won't it return here ? Though you must first check why is that returning
error.

         irq = platform_get_irq(pdev, 0);
         if (irq >= 0 && irq_is_percpu(irq))
                 return 0;

> pdev->num_resources is 0 therefore...
>
> 	if (i == pdev->num_resources) {
> 		pmu->irq_affinity = irqs;
> 	} else {
> 		kfree(irqs);
> 		cpumask_setall(&pmu->supported_cpus);
> 	}
>
> pmu->irq_affinity gets set to an invalid pointer (0x00000010)
> and cpumask_setall() is not called.
>
> Something is not working as expected, right?
>

So you won't execute this in that case.

Sorry if I missed something, I briefly checked v4.2
Code have been changed and even moved since then.

-- 
Regards,
Sudeep
