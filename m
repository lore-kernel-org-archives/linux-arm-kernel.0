From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 3 May 2016 12:38:44 +0300
Subject: [PATCH v2 2/4] irqchip: add LPC32xx interrupt controller driver
In-Reply-To: <5728627B.1020602@arm.com>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
 <1461546038-25668-1-git-send-email-vz@mleia.com>
 <1461678082.9433.3.camel@localhost> <57228B68.8030706@mleia.com>
 <5728627B.1020602@arm.com>
Message-ID: <572871A4.5050003@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.05.2016 11:34, Marc Zyngier wrote:
> On 28/04/16 23:15, Vladimir Zapolskiy wrote:
>> On 26.04.2016 16:41, Sylvain Lemieux wrote:
>>> Hi Vladimir,
>>>
>>> On Mon, 2016-04-25 at 04:00 +0300, Vladimir Zapolskiy wrote:
>>>> The change adds improved support of NXP LPC32xx MIC, SIC1 and SIC2
>>>> interrupt controllers.
>>>>
>>>> This is a list of new features in comparison to the legacy driver:
>>>> * irq types are taken from device tree settings, no more need to
>>>>   hardcode them,
>>>> * old driver is based on irq_domain_add_legacy, which causes problems
>>>>   with handling MIC hardware interrupt 0 produced by SIC1,
>>>> * there is one driver for MIC, SIC1 and SIC2, no more need to handle
>>>>   them separately, e.g. have two separate handlers for SIC1 and SIC2,
>>>> * the driver does not have any dependencies on hardcoded register
>>>>   offsets,
>>>> * the driver is much simpler for maintenance,
>>>> * SPARSE_IRQS option is supported.
>>>>
>>>> Legacy LPC32xx interrupt controller driver was broken since commit
>>>> 76ba59f8366f ("genirq: Add irq_domain-aware core IRQ handler"), which
>>>> requires a private interrupt handler, otherwise any SIC1 generated
>>>> interrupt (mapped to MIC hwirq 0) breaks the kernel with the message
>>>> "unexpected IRQ trap at vector 00".
>>>>
>>>> The change disables compilation of a legacy driver found at
>>>> arch/arm/mach-lpc32xx/irq.c, the file will be removed in a separate
>>>> commit.
>>>>
>>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>>> ---
>>>> Changes from v1 to v2:
>>>> * added chained_irq_{enter,exit} for SIC chained handler,
>>>> * use {writel,readl}_relaxed flavour of io access functions,
>>>> * changed anchor data type to access iomem from struct irq_domain
>>>>   to private struct lpc32xx_irq_chip,
>>>> * do not read irq status register twice on every irq event,
>>>> * resource deallocation fixes on error path of irqchip driver init,
>>>> * removed handling of "interrupt-controller-name" property, name
>>>>   is constructed from mic/sic type and controller's physical address,
>>>> * minor improvements (renames, __ffs instead of ffs, etc.)
>>>>
>>>> Many kudos to Marc for review of v1.
>>>>
>>>>  arch/arm/Kconfig                |   2 +
>>>>  arch/arm/mach-lpc32xx/phy3250.c |   1 -
>>>>  drivers/irqchip/Makefile        |   1 +
>>>>  drivers/irqchip/irq-lpc32xx.c   | 238 ++++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 241 insertions(+), 1 deletion(-)
>>>>  create mode 100644 drivers/irqchip/irq-lpc32xx.c
>>>>
>>> I tested the driver on a custom LPC3250 board; I was having at
>>> least 1 interrupt generated from each source (MIC/SIC1/SIC2).
>>>
>>> Tested-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
>>>
>>
>> Thomas, Marc, Jason, Russell,
>>
>> in your opinion would it be still possible to accept this change v2 2/4 for v4.7?
> 
> I'll queue them.
> 

Marc, thank you in advance, please note that I ask to review/pick up
only 2/4 for v4.7 ("irqchip: add LPC32xx interrupt controller driver"),
DT changes are merged through arm-soc and the last 4/4 clean-up can
be deferred till v4.8.

--
With best wishes,
Vladimir
