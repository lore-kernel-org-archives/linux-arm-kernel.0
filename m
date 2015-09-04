From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 04 Sep 2015 13:51:34 +0100
Subject: [PATCH v3 TRIVIAL] ARM: Enable GICv2m on 32-bit virt machine
In-Reply-To: <1441369867-2372-1-git-send-email-p.fedin@samsung.com>
References: <1441369867-2372-1-git-send-email-p.fedin@samsung.com>
Message-ID: <55E993D6.9050107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/15 13:31, Pavel Fedin wrote:
> qemu implementation of "virt" includes GICv2m. This commit allows to use
> it also on ARM32 architecture.
> 
> msi.h is added because it is required by linux/msi.h
> if CONFIG_GENERIC_MSI_IRQ_DOMAIN is defined. It gets enabled by the
> following KConfig dependency chain:
> ARM_GIC_V2M => PCI_MSI_IRQ_DOMAIN => GENERIC_MSI_IRQ_DOMAIN
> 
> drivers/irqchip/irq-gic-v2m.c: In function ?gicv2m_compose_msi_msg?:
> drivers/irqchip/irq-gic-v2m.c:100:2: warning: right shift count >= width
> of type [enabled by default]
>   msg->address_hi = (u32) (addr >> 32);
>   ^
> 
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
> v2 => v3:
> Fixed build warning in irq-gic-v2m.c
> 
> v1 => v2:
> Added verbose explanation in commit message
> ---
>  arch/arm/Kconfig              | 1 +
>  arch/arm/include/asm/Kbuild   | 1 +
>  drivers/irqchip/irq-gic-v2m.c | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 45df48b..1091025 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -815,6 +815,7 @@ config ARCH_VIRT
>  	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
>  	select ARM_AMBA
>  	select ARM_GIC
> +	select ARM_GIC_V2M if PCI_MSI
>  	select ARM_PSCI
>  	select HAVE_ARM_ARCH_TIMER
>  
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 3c4596d..01806f5 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -14,6 +14,7 @@ generic-y += local.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += msgbuf.h
> +generic-y += msi.h
>  generic-y += param.h
>  generic-y += parport.h
>  generic-y += poll.h
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index fdf7065..f76fc9a 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -97,7 +97,9 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
>  	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
>  
> +#ifdef CONFIG_ARM64
>  	msg->address_hi = (u32) (addr >> 32);
> +#endif
>  	msg->address_lo = (u32) (addr);
>  	msg->data = data->hwirq;
>  }
> 

Please use the upper_32_bits/lower_32_bits macros that will avoid this
ugly #ifdef. This should be a separate patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
