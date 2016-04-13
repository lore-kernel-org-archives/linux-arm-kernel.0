From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 13 Apr 2016 17:18:11 +0100
Subject: [PATCH v2] sunxi-irq: Fix Kconfig dependency on GENERIC_IRQ_CHIP
In-Reply-To: <1460563167-18517-1-git-send-email-suzuki.poulose@arm.com>
References: <1460563167-18517-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <570E7143.4030206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 16:59, Suzuki K Poulose wrote:
> The sunxi-nmi and sun4i irq chips are selected by ARCH_SUNXI on both arm
> and arm64 (recently added). However on arm64, we don't explicitly select
> GENERIC_IRQ_CHIP which is required by the sunxi-nmi irq chip driver and
> causes build breaks on 4.6-rc1 :
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
> This patch fixes the dependency by introducing a separate Kconfig
> symbol for sunxi irqchips which does the proper dependency selections.
> 
> Build tested on arm and arm64.
> 
> Fixes: commit ce3dd55b99b1 ("arm64: Introduce Allwinner SoC config option")
> Suggested-by: Olof Johansson <olof@lixom.net>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
