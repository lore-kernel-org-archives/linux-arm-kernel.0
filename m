From: stefan@agner.ch (Stefan Agner)
Date: Sun, 08 Feb 2015 16:45:52 +0100
Subject: [PATCH v5 1/3] irqchip: vf610-mscm-ir: add support for MSCM
 interrupt router
In-Reply-To: <1423306617.2246.23.camel@x220>
References: <1423252286-17814-1-git-send-email-stefan@agner.ch>
 <1423252286-17814-2-git-send-email-stefan@agner.ch>
 <1423306617.2246.23.camel@x220>
Message-ID: <4ba5a546aba95bb0948c8a070648bb45@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-07 11:56, Paul Bolle wrote:
> On Fri, 2015-02-06 at 20:51 +0100, Stefan Agner wrote:
>> This adds support for Vybrid's interrupt router. On VF6xx models,
>> almost all peripherals can be used by either of the two CPU's,
>> the Cortex-A5 or the Cortex-M4. The interrupt router routes the
>> peripheral interrupts to the configured CPU.
>>
>> This IRQ chip driver configures the interrupt router to route
>> the requested interrupt to the CPU the kernel is running on.
>> The driver makes use of the irqdomain hierarchy support. The
>> parent is given by the device tree. This should be one of the
>> two possible parents either ARM GIC or the ARM NVIC interrupt
>> controller. The latter is currently not yet supported.
>>
>> Note that there is no resource control mechnism implemented to
>> avoid concurrent access of the same peripheral. The user needs
>> to make sure to use device trees which assign the peripherals
>> orthogonally. However, this driver warns the user in case the
>> interrupt is already configured for the other CPU. This provides
>> a poor man's resource controller.
>>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/mach-imx/Kconfig           |   1 +
>>  drivers/irqchip/Kconfig             |  11 ++
>>  drivers/irqchip/Makefile            |   1 +
>>  drivers/irqchip/irq-vf610-mscm-ir.c | 206 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 219 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-vf610-mscm-ir.c
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index e8627e0..bf91a59 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -631,6 +631,7 @@ config SOC_IMX6SX
>>
>>  config SOC_VF610
>>  	bool "Vybrid Family VF610 support"
>> +	select VF610_MSCM_IR
>>  	select ARM_GIC
>>  	select PINCTRL_VF610
>>  	select PL310_ERRATA_769419 if CACHE_L2X0
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index cc79d2a..9c13d81 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -136,6 +136,17 @@ config IRQ_CROSSBAR
>>  	  a free irq and configures the IP. Thus the peripheral interrupts are
>>  	  routed to one of the free irqchip interrupt lines.
>>
>> +config VF610_MSCM_IR
>> +	bool
>> +	help
>> +	  Support for MSCM interrupt router available on Vybrid SoC's. The
>> +	  interrupt router is between the CPU's interrupt controller and the
>> +	  peripheral. The router allows to route the peripheral interrupts to
>> +	  one of the two available CPU's on Vybrid VF6xx SoC's (Cortex-A5 or
>> +	  Cortex-M4). The router will be configured transparently on a IRQ
>> +	  request.
>> +	select IRQ_DOMAIN_HIERARCHY
>> +
> 
> As far as I can tell this new Kconfig symbol operates in lockstep with
> SOC_VF610: if SOC_VF610 is set, this will also be set, and if SOC_VF610
> is not set, this won't be set either. Is a separate symbol needed?

Theoretically, this could be used by other SoC's. However, afaik the
i.MX6 SoloX, which one could see as something like the successor of
Vybrid, implements the interrupt routing differently. So I would be fine
to just use the SOC_VF610 symbol instead.

The only thing which I would rather prefer to keep is the comment what
this is all about (the help text). But I guess I could move that as
comment into the source file...

> 
> If you decide to keep it, I have two minor nits.
> 
> 1) Make the help text the last option of the Kconfig entry. It's legal
> to put Kconfig options in any order that you'd like. But with very few
> exceptions, the help text is always the last. Please use that pattern.
> 
> 2) This Kconfig entry has no prompt, so I'm not aware of a way that
> people ever can read this help text when running "make *configure". So
> this help text is basically a comment. You might as well format it as a
> comment then.
> 
>>  config KEYSTONE_IRQ
>>  	tristate "Keystone 2 IRQ controller IP"
>>  	depends on ARCH_KEYSTONE

--
Stefan
