From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Sep 2012 17:44:55 -0700
Subject: [PATCH 4/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <1347524018-19301-5-git-send-email-t.figa@samsung.com>
References: <1347524018-19301-1-git-send-email-t.figa@samsung.com>
 <1347524018-19301-5-git-send-email-t.figa@samsung.com>
Message-ID: <20120916004455.GD7028@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 10:13:37AM +0200, Tomasz Figa wrote:
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
> 		firmware {
> 			compatible = "samsung,secure-firmware";
> 		};
> 
> 		/* ... */
> 	};
> 
> This is a follow-up on the patch by Kyungmin Park:
> [PATCH v5 2/2] ARM: EXYNOS: SMC instruction (aka firmware) support
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/183608/focus=184109
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung-boards.txt     |  8 ++++
>  arch/arm/mach-exynos/Makefile                      |  1 +
>  arch/arm/mach-exynos/common.h                      |  2 +
>  arch/arm/mach-exynos/firmware.c                    | 52 ++++++++++++++++++++++
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |  1 +
>  5 files changed, 64 insertions(+)
>  create mode 100644 arch/arm/mach-exynos/firmware.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> index 0bf68be..f447059 100644
> --- a/Documentation/devicetree/bindings/arm/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung-boards.txt
> @@ -6,3 +6,11 @@ Required root node properties:
>      - compatible = should be one or more of the following.
>          (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
>          (b) "samsung,exynos4210"  - for boards based on Exynos4210 SoC.
> +
> +Optional:
> +    - firmware node, specifying presence and type of secure firmware, currently
> +        supported value of compatible property is "samsung,secure-firmware":
> +
> +	firmware {
> +		compatible = "samsung,secure-firmware";
> +	};
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 997864b..9451637 100644
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
> index d7f28ca..358f6a5 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -21,6 +21,8 @@ void exynos4_restart(char mode, const char *cmd);
>  void exynos5_restart(char mode, const char *cmd);
>  void exynos_init_late(void);
>  
> +void exynos_firmware_init(void);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>  int exynos_pm_late_initcall(void);
>  #else
> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> new file mode 100644
> index 0000000..3f3641d
> --- /dev/null
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -0,0 +1,52 @@
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
> +#include <linux/init.h>
> +#include <linux/of.h>
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
> +static void exynos_cpu_boot(int cpu)
> +{
> +	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
> +}
> +
> +static void __iomem *exynos_cpu_boot_reg(int cpu)
> +{
> +	return S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
> +}

This communication area in sysram should probably be seen as a part of
the firmware interface. It should thus be defined as part of the binding
instead, i.e.  through a reg property or similar there. That also would
make it easy to convert to using ioremap() instead of iodesc tables,
which always a nice thing.


-Olof
