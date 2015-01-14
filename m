From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 Jan 2015 19:24:47 -0600
Subject: [PATCH 6/7] ARM: OMAP2+: Fix reboot for 81xx
In-Reply-To: <1421190837-4692-7-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-7-git-send-email-tony@atomide.com>
Message-ID: <20150114012447.GF18523@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 03:13:56PM -0800, Tony Lindgren wrote:
> We are missing proper hooks for 81xx for reboot to work.
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile         |  1 +
>  arch/arm/mach-omap2/common.h         |  8 ++++++++
>  arch/arm/mach-omap2/ti81xx-restart.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/ti81xx-restart.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5d27dfd..3a6463f 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -58,6 +58,7 @@ AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
>  # Restart code (OMAP4/5 currently in omap4-common.c)
>  obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
> +obj-$(CONFIG_SOC_TI81XX)		+= ti81xx-restart.o
>  obj-$(CONFIG_SOC_AM33XX)		+= am33xx-restart.o
>  obj-$(CONFIG_SOC_AM43XX)		+= omap4-restart.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= omap3-restart.o
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 900ebdd..65b4371 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -164,6 +164,14 @@ static inline void omap3xxx_restart(enum reboot_mode mode, const char *cmd)
>  }
>  #endif
>  
> +#ifdef CONFIG_SOC_TI81XX
> +void ti81xx_restart(enum reboot_mode mode, const char *cmd);
> +#else
> +static inline void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> +{
> +}
> +#endif
> +
>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>  	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>  void omap44xx_restart(enum reboot_mode mode, const char *cmd);
> diff --git a/arch/arm/mach-omap2/ti81xx-restart.c b/arch/arm/mach-omap2/ti81xx-restart.c
> new file mode 100644
> index 0000000..68b29be
> --- /dev/null
> +++ b/arch/arm/mach-omap2/ti81xx-restart.c
> @@ -0,0 +1,31 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/reboot.h>
> +
> +#include "iomap.h"
> +#include "common.h"
> +#include "control.h"
> +#include "prm3xxx.h"
> +
> +#define TI81XX_PRM_DEVICE_RSTCTRL	0x00a0
> +#define TI81XX_GLOBAL_RST_COLD		BIT(1)
> +
> +/**
> + * ti81xx_restart - trigger a software restart of the SoC
> + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> + * @cmd: passed from the userspace program rebooting the system (if provided)
> + *
> + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> + * kernel/sys.c.  No return value.
> + */
> +void ti81xx_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
> +				   TI81XX_PRM_DEVICE_RSTCTRL);

do you need to check that mode == REBOOT_COLD here ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/5a6e3206/attachment-0001.sig>
