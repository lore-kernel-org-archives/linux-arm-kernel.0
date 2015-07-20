From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 Jul 2015 18:45:42 +0100
Subject: [PATCH v3 4/8] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <1436525114-14425-5-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
 <1436525114-14425-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55AD33C6.3000809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/15 11:45, Hanjun Guo wrote:
> For now, ACPI based GICv2 is using the irq_default_domain as the
> ACPI core domain which is not scalable, also we don't support
> stacked irq domains in ACPI, this patch is trying to implement that.
> 
> Firstly, we need to find the irqdomain with GSI, because we use
> different model of mapping interrupt with device in ACPI than DT,
> in DT, we using the interrupt parent property to get the device
> node of irqchip for devices, that's why we need the matching function
> that match the device node with the one associated with the irqdomain.
> But for ACPI, we only can get the GSI which the device is using, no
> interrupt parent will be specified, then we need a mechanism to find
> GSI's (also the device's) irqdomain to make the code scalable.
> 
> Thanks to the usage of GSI, it is a flat hwirq number which is unique
> in the system, then we can get its associated irq domain by matching
> the GSI supported by this irqchip (see drawings below), then we can
> live without the token pointer matching the interrupt controller as
> DT did.
> 
>                   ------------      ---> gsi_base0
>                  |            |
>                  |            |
>   irqdomain <----| irqchip 0  |
>                  |            |
>                  |            |
>                  |____________|     ---> gsi_end0
> 
>                   ------------      ---> gsi_base1 (probably gsi_end0+1)
>                  |            |
>                  |            |
>   irqdomain <----| irqchip 1  |
>                  |            |
>                  |            |
>                  |____________|     ---> gsi_end1
> 
>                   .....
> 
> if a device is using GSI n, then we can find GSI's irqdomain by matching
> gsi_base <= n <= gsi_end.
> 
> For GIC, we only have one GICD, but the above model still valid. GICD
> structure in ACPI MADT defines System Vector Base in the GICD entry,
> which means the global system interrupt number where this GIC
> Distributor?s interrupt inputs start, then we can get the hwirq numbers
> supported by reading the register, so we can explictly get the GSI's
> associated irqdomain if the GSI is within the range of hwirq supported
> by this GICD.
> 
> Secondly, pass the GSI as the arg for domain's ops alloc() function
> when register the GSI, then we can take advantage of stacked irqdomains.

I'm sorry, but this doesn't make much sense to me.

This patch doesn't only convert GICv2 ACPI support to stacked domains,
it adds a whole new concept of "banks of wired interrupts".

Why do we need this? How relevant is that to making the ACPI code
stacked-domain aware? As far as I understand, only SPIs provided by the
GIC can be expressed as a GSI. And you can only have one GIC.

I'm more and more puzzled by this series.

	M.
-- 
Jazz is not dead. It just smells funny...
