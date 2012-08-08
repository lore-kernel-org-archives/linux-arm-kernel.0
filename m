From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2012 08:28:35 +0000
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between DT
 and non-DT boots
In-Reply-To: <20120808080411.GB4728@gmail.com>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
Message-ID: <201208080828.35451.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Lee Jones wrote:
> Okay, actually this isn't so easy. Currently we have:
> 
> During DT boot:
>  - No platform data is passed, hence no IRQ base for AB8500 is either
>  - No IRQ base means we register a Linear IRQ Domain
>  - MFD sees there is no base and leaves the IRQ resource as a hwirq
>  - AB8500 child devices use *_get_virq() to convert the hwirq to a virq
> 
> During non-DT boot:
>  - Platform data is passed, which contains an IRQ base
>  - If an IRQ base is requested we use it to register a Legacy IRQ Domain
>  - MFD adds the IRQ base to the hwirq and registers it as a virq
>  - AB8500 child devices use *_get_virq() to convert virq to virq - ERROR
> 
> I guess my suggestion falls-back to placing logic in *_get_virq() to only
> call irq_create_mapping() when when !ab8500->irq_base.

In general, it seems easier to use the same domain type for both cases.
I don't think that MOP500_AB8500_VIR_GPIO_IRQ_BASE is used anywhere
else besides the .irq_base definition in board-mop500.c, so I would guess
that you can just remove that identifier and always use the linear
domain.

	Arnd
