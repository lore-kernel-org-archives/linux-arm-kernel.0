From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Aug 2015 15:45:56 +0100
Subject: [PATCH v9 1/1] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1440443055-7291-1-git-send-email-shenwei.wang@freescale.com>
 <55DC3452.3070205@arm.com>
 <CY1PR0301MB08439B6C5F841AFFD152DFD883610@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <55DC738D.8000302@arm.com>
 <CY1PR0301MB0843AE566996617D855CC00683610@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <55DC7FA4.7040902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/08/15 15:14, Shenwei Wang wrote:
>
>
>> -----Original Message-----
>> From: Sudeep Holla [mailto:sudeep.holla at arm.com]

[...]

>> I don't see this driver doing anything extra apart from keeping the wakeup irqs
>> enabled. i.e. You use the same cpu*wake register to mask/unmask the interrupt
>> as well as set the wakeup source. Since the wakeup interrupt will be enabled by
>> the driver, you just need to mark it as wake-up source and nothing extra in the
>> controller right ?
>> If so, you need to set IRQCHIP_SKIP_SET_WAKE as you are just leaving that irq
>> enabled and not doing any extra configuration to enable it as wakeup source.
>> Please correct if that wrong, but from the code that's what I could infer.
>
> There is no special for this driver. We just use the IRQCHIP driver framework to
> manage the wakeup sources. Why did you propose to set IRQCHIP_SKIP_SET_WAKE
> flag here? If you don't need the wakeup feature, you should just not enable this
> driver in the configuration.
>

No, if the driver doesn't nothing extra to configure the wake up source
other than keeping it enabled, then it fits the case of SKIP_SET_WAKE.
The driver using this wake would have requested and enabled the irq.
When it calls enable_irq_wake, you have nothing extra to set(atleast
from the looks of the driver), so setting SKIP_SET_WAKE will skip the
call and updated the wake flags in irq core.

I don't see the real need of 2 separate sets of irq mask being saved in
either case.

Regards,
Sudeep
