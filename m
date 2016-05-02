From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 May 2016 08:48:54 +0200
Subject: [PATCH v3] sunxi-irq: Fix Kconfig dependency on GENERIC_IRQ_CHIP
In-Reply-To: <1461546292-21110-1-git-send-email-andre.przywara@arm.com>
References: <1461546292-21110-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20160502064854.GL17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 25, 2016 at 02:04:52AM +0100, Andre Przywara wrote:
> The Allwinner NMI irqchip driver requires GENERIC_IRQ_CHIP, but
> we can't select it directly, because there is no specific Kconfig entry
> for the driver. Compiling this NMI driver with certain arm64
> configurations thus fails due to the missing dependency:
> 
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
> Add separate Kconfig options for both Allwinner specific irqchip
> drivers and select GENERIC_IRQ_CHIP for the NMI driver.
> The older sun4i IRQ driver only gets selected when support for these
> specific SoCs is compiled, while the NMI driver is selected for all
> Allwinner SoCs (copying the current behaviour and covering future SoCs
> automatically).
> 
> Reported-by: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> this is a new approach to the problem that Suzuki tried to address
> already.
> It separates the sun4i IRQ controller driver and the NMI driver as
> Maxime requested.
> While there should be no difference for the NMI driver, the sun4i
> driver now only gets selected for certain SoCs, which is admittedly
> a bold call for -rc5. If people find this too risky, I can bring the
> sun4i in line with the NMI driver (selected for all ARCH_SUNXI) for
> this release and re-create the more selective dependency as a merge
> window patch, so that it gets more testing.
> Please let me know.
> 
> Cheers,
> Andre.
> 
>  arch/arm/mach-sunxi/Kconfig | 3 ++-
>  drivers/irqchip/Kconfig     | 8 ++++++++
>  drivers/irqchip/Makefile    | 4 ++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index c124d65..c092bc2 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -4,7 +4,6 @@ menuconfig ARCH_SUNXI
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select CLKSRC_MMIO
> -	select GENERIC_IRQ_CHIP
>  	select PINCTRL
>  	select SUN4I_TIMER
>  	select RESET_CONTROLLER
> @@ -14,11 +13,13 @@ if ARCH_SUNXI
>  config MACH_SUN4I
>  	bool "Allwinner A10 (sun4i) SoCs support"
>  	default ARCH_SUNXI
> +	select SUN4I_IRQCHIP
>  
>  config MACH_SUN5I
>  	bool "Allwinner A10s / A13 (sun5i) SoCs support"
>  	default ARCH_SUNXI
>  	select SUN5I_HSTIMER
> +	select SUN4I_IRQCHIP
>  
>  config MACH_SUN6I
>  	bool "Allwinner A31 (sun6i) SoCs support"
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3e12479..94f3f42 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -165,6 +165,14 @@ config ST_IRQCHIP
>  	help
>  	  Enables SysCfg Controlled IRQs on STi based platforms.
>  
> +config SUN4I_IRQCHIP
> +	bool
> +
> +config SUNXI_NMI
> +	bool "Allwinner SoC NMI controller"
> +	default ARCH_SUNXI
> +	select GENERIC_IRQ_CHIP

This one is only used on SUN6I, SUN7I and SUN8I. There's no need to
enable it for all the SoCs.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/d0f52893/attachment.sig>
