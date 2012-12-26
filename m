From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 26 Dec 2012 16:17:19 +0800
Subject: [PATCH v4 3/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <1353599478-24617-4-git-send-email-t.figa@samsung.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
 <1353599478-24617-4-git-send-email-t.figa@samsung.com>
Message-ID: <CAGsJ_4yjm-CE6iJC+pAT=aiNAf0dpANH49e2OD+CqBG+JveGfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/22, Tomasz Figa <t.figa@samsung.com>:
> Some Exynos-based boards contain secure firmware and must use firmware
> operations to set up some hardware.
>
> This patch adds firmware operations for Exynos secure firmware and a way
> for board code and device tree to specify that they must be used.
>
> Example of use:
>
> In board code:
>
> 	...MACHINE_START(...)
> 		/* ... */
> 		.init_early	= exynos_firmware_init,
> 		/* ... */
> 	MACHINE_END
>
> In device tree:
>
> 	/ {
> 		/* ... */
>
> 		firmware at 0203F000 {
> 			compatible = "samsung,secure-firmware";
> 			reg = <0x0203F000 0x1000>;
> 		};
>
> 		/* ... */
> 	};

well. amazing, dts is used to describle hardware details, here the
firmware is just a software and reg is the memory the firmware will
use. is this something againest the dt rule?
but it is really simple.

>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung-boards.txt     | 10 ++++
>  arch/arm/mach-exynos/Makefile                      |  1 +
>  arch/arm/mach-exynos/common.h                      |  2 +
>  arch/arm/mach-exynos/firmware.c                    | 70
> ++++++++++++++++++++++
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
>  5 files changed, 84 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/firmware.c
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> index 0bf68be..2168ed3 100644
> --- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> @@ -6,3 +6,13 @@ Required root node properties:
>      - compatible = should be one or more of the following.
>          (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
>          (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
> +
> +Optional:
> +    - firmware node, specifying presence and type of secure firmware:
> +        - compatible: only "samsung,secure-firmware" is currently
> supported
> +        - reg: address of non-secure SYSRAM used for communication with
> firmware
> +
> +	firmware at 0203F000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x0203F000 0x1000>;
> +	};
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index a031012..685e4a7 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
>
>  obj-$(CONFIG_ARCH_EXYNOS)	+= exynos-smc.o
> +obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
>
>  plus_sec := $(call as-instr,.arch_extension sec,+sec)
>  AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index dac146d..5f1d393 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -22,6 +22,8 @@ void exynos4_restart(char mode, const char *cmd);
>  void exynos5_restart(char mode, const char *cmd);
>  void exynos_init_late(void);
>
> +void exynos_firmware_init(void);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>  int exynos_pm_late_initcall(void);
>  #else
> diff --git a/arch/arm/mach-exynos/firmware.c
> b/arch/arm/mach-exynos/firmware.c
> new file mode 100644
> index 0000000..88e3eed
> --- /dev/null
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (C) 2012 Samsung Electronics.
> + * Kyungmin Park <kyungmin.park@samsung.com>
> + * Tomasz Figa <t.figa@samsung.com>
> + *
> + * This program is free software,you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/firmware.h>
> +
> +#include <mach/map.h>
> +
> +#include "smc.h"
> +
> +static int exynos_do_idle(void)
> +{
> +        exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
> +        return 0;
> +}
> +
> +static int exynos_cpu_boot(int cpu)
> +{
> +	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> +	return 0;
> +}
> +
> +static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
> +{
> +	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> +
> +	__raw_writel(boot_addr, boot_reg);
> +	return 0;
> +}
> +
> +static const struct firmware_ops exynos_firmware_ops = {
> +	.do_idle		= exynos_do_idle,
> +	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
> +	.cpu_boot		= exynos_cpu_boot,
> +};
> +
> +void __init exynos_firmware_init(void)
> +{
> +	if (of_have_populated_dt()) {
> +		struct device_node *nd;
> +		const __be32 *addr;
> +
> +		nd = of_find_compatible_node(NULL, NULL,
> +						"samsung,secure-firmware");
> +		if (!nd)
> +			return;
> +
> +		addr = of_get_address(nd, 0, NULL, NULL);
> +		if (!addr) {
> +			pr_err("%s: No address specified.\n", __func__);
> +			return;
> +		}
> +	}
> +
> +	pr_info("Running under secure firmware.\n");
> +
> +	register_firmware_ops(&exynos_firmware_ops);
> +}

except these smc calls when system boots, there must be some smc calls
in the runtime of linux. it seems the firmware_ops can cover those
callbacks of the communication between linux and firmware as well?

> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c
> b/arch/arm/mach-exynos/mach-exynos4-dt.c
> index 8858068..3f967e5 100644
> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
> @@ -107,6 +107,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4
> (Flattened Device Tree)")
>  	.init_irq	= exynos4_init_irq,
>  	.map_io		= exynos4_dt_map_io,
>  	.handle_irq	= gic_handle_irq,
> +	.init_early	= exynos_firmware_init,
>  	.init_machine	= exynos4_dt_machine_init,
>  	.init_late	= exynos_init_late,
>  	.timer		= &exynos4_timer,
> --
> 1.8.0

-barry
