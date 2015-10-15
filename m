From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Oct 2015 17:06:43 +0100
Subject: [PATCH 04/13] irqchip/gic: support RealView variant setup
In-Reply-To: <1444916813-31024-5-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
 <1444916813-31024-5-git-send-email-linus.walleij@linaro.org>
Message-ID: <561FCF13.1080809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 14:46, Linus Walleij wrote:
> The ARM RealView PB11MPCore reference design has some special
> bits in a system controller register to set up the GIC in one
> of three modes: legacy, new with DCC, new without DCC. The
> register is also used to enable FIQ.
> 
> Since the platform will not boot unless this register is set
> up to "new with DCC" mode, we need a special quirk to be
> compiled-in for the RealView platforms.
> 
> If we find the right compatible string on the GIC TestChip,
> we enable this quirk by looking up the system controller and
> enabling the special bits.
> 
> We depend on the CONFIG_REALVIEW_DT Kconfig symbol as the old
> boardfile code has the same fix hardcoded, and this is only
> needed for the attempts to modernize the RealView code using
> device tree.
> 
> After fixing this, the PB11MPCore boots with device tree
> only.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Looking for an ACK for this (unless the irqchip maintainers
> barf at it) so I can take it through the ARM SoC tree.
> ---
>  drivers/irqchip/Makefile           |  1 +
>  drivers/irqchip/irq-gic-realview.c | 39 ++++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-realview.h |  5 +++++
>  drivers/irqchip/irq-gic.c          |  4 ++++
>  4 files changed, 49 insertions(+)
>  create mode 100644 drivers/irqchip/irq-gic-realview.c
>  create mode 100644 drivers/irqchip/irq-gic-realview.h
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index bb3048f00e64..7a7d4182777d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
>  obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
>  obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
>  obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
> +obj-$(CONFIG_REALVIEW_DT)		+= irq-gic-realview.o
>  obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
>  obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
>  obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
> diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-realview.c
> new file mode 100644
> index 000000000000..2e8a4b129f5f
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-realview.c
> @@ -0,0 +1,39 @@
> +/*
> + * Special GIC quirks for the ARM RealView
> + * Copyright (C) 2015 Linus Walleij
> + */
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/bitops.h>
> +
> +#define REALVIEW_SYS_LOCK_OFFSET	0x20
> +#define REALVIEW_PB11MP_SYS_PLD_CTRL1	0x74
> +#define VERSATILE_LOCK_VAL		0xA05F
> +#define PLD_INTMODE_MASK		BIT(22)|BIT(23)|BIT(24)
> +#define PLD_INTMODE_LEGACY		0x0
> +#define PLD_INTMODE_NEW_DCC		BIT(22)
> +#define PLD_INTMODE_NEW_NO_DCC		BIT(23)
> +#define PLD_INTMODE_FIQ_ENABLE		BIT(24)
> +
> +void __init realview_gic_init(struct device_node *np)
> +{
> +	static struct regmap *map;
> +
> +	/* The PB11MPCore GIC needs to be configured in the syscon */
> +	if (of_device_is_compatible(np, "arm,tc11mp-gic")) {
> +		map = syscon_regmap_lookup_by_compatible("arm,realview-pb11mp-syscon");
> +		if (!IS_ERR(map)) {
> +			/* new irq mode with no DCC */
> +			regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
> +				     VERSATILE_LOCK_VAL);
> +			regmap_update_bits(map, REALVIEW_PB11MP_SYS_PLD_CTRL1,
> +					   PLD_INTMODE_NEW_NO_DCC,
> +					   PLD_INTMODE_MASK);
> +			regmap_write(map, REALVIEW_SYS_LOCK_OFFSET, 0x0000);
> +			pr_info("TC11MP GIC: set up interrupt controller to NEW mode, no DCC\n");
> +		} else {
> +			pr_err("TC11MP GIC setup: could not find syscon\n");
> +		}
> +	}
> +}
> diff --git a/drivers/irqchip/irq-gic-realview.h b/drivers/irqchip/irq-gic-realview.h
> new file mode 100644
> index 000000000000..06ebdfc523a8
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-realview.h
> @@ -0,0 +1,5 @@
> +#ifdef CONFIG_REALVIEW_DT
> +void realview_gic_init(struct device_node *np);
> +#else
> +static void realview_gic_init(struct device_node *np) {}
> +#endif
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 5376d1cb0a4f..bd021e1e4847 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -50,6 +50,7 @@
>  #include <asm/virt.h>
>  
>  #include "irq-gic-common.h"
> +#include "irq-gic-realview.h"
>  
>  union gic_base {
>  	void __iomem *common_base;
> @@ -1158,6 +1159,9 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  	cpu_base = of_iomap(node, 1);
>  	WARN(!cpu_base, "unable to map gic cpu registers\n");
>  
> +	/* Special quirk for ARM RealView */
> +	realview_gic_init(node);
> +

How about having a special entry in the IRQCHIP_OF_DECLARE section,
which would call this, and then gic_of_init? It would look slightly
nicer, and you could from the check in realview_gic_init...

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
