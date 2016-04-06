From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 6 Apr 2016 10:05:02 +0100
Subject: [PATCH] arm64/sunxi: 4.6-rc1: Add dependency on generic irq chip
In-Reply-To: <1459245786-11905-1-git-send-email-suzuki.poulose@arm.com>
References: <1459245786-11905-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <5704D13E.6060701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29/03/16 11:03, Suzuki K Poulose wrote:
> Commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option"),
> added support for ARCH_SUNXI on arm64, but failed to select
> GENERIC_IRQ_CHIP, which is required for drivers/irqchip/irq-sunxi-nmi.c
> and causes build failures like :

Thanks for the catch! GENERIC_IRQ_CHIP somehow gets selected by
defconfig, so I didn't see the issue.

Currently we don't need the irq-sunxi-nmi driver, but we may in the
future and it depends on CONFIG_ARCH_SUNXI only, so I guess this patch
is the easiest solution (rather than creating a separate config symbol
for it, which may be an option for later).

So...

> 
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> drivers/built-in.o: In function `sunxi_sc_nmi_set_type':
> drivers/irqchip/irq-sunxi-nmi.c:114: undefined reference to `irq_setup_alt_chip'
> drivers/built-in.o: In function `irq_domain_add_linear':
> include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
> include/linux/irqdomain.h:253: undefined reference to `irq_generic_chip_ops'
> drivers/built-in.o: In function `sunxi_sc_nmi_irq_init':
> drivers/irqchip/irq-sunxi-nmi.c:146: undefined reference to `irq_alloc_domain_generic_chips'
> drivers/irqchip/irq-sunxi-nmi.c:161: undefined reference to `irq_get_domain_generic_chip'
> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'
> drivers/irqchip/irq-sunxi-nmi.c:171: undefined reference to `irq_gc_mask_set_bit'
> drivers/irqchip/irq-sunxi-nmi.c:172: undefined reference to `irq_gc_ack_set_bit'
> drivers/irqchip/irq-sunxi-nmi.c:170: undefined reference to `irq_gc_mask_clr_bit'
> 
> Fixes: commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option")
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.


> ---
>  arch/arm64/Kconfig.platforms |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index efa77c1..521b1ec 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -2,6 +2,7 @@ menu "Platform selection"
>  
>  config ARCH_SUNXI
>  	bool "Allwinner sunxi 64-bit SoC Family"
> +	select GENERIC_IRQ_CHIP
>  	help
>  	  This enables support for Allwinner sunxi based SoCs like the A64.
>  
> 
