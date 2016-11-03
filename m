From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 3 Nov 2016 15:53:47 -0600
Subject: [RFC PATCH 1/3] ARM64: meson: Add Amlogic Meson GX PM Suspend
In-Reply-To: <1478183365-23708-2-git-send-email-narmstrong@baylibre.com>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161103215347.GA23902@e106835-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:29:23PM +0100, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs uses a non-standard argument to the
> PSCI CPU_SUSPEND call to enter system suspend.
> 
> Implement such call within platform_suspend_ops.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/firmware/meson/Kconfig       |  6 +++
>  drivers/firmware/meson/Makefile      |  1 +
>  drivers/firmware/meson/meson_gx_pm.c | 86 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 drivers/firmware/meson/meson_gx_pm.c
> 
> diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
> index 170d7e8..5b3fea3 100644
> --- a/drivers/firmware/meson/Kconfig
> +++ b/drivers/firmware/meson/Kconfig
> @@ -7,3 +7,9 @@ config MESON_SM
>  	depends on ARM64_4K_PAGES
>  	help
>  	  Say y here to enable the Amlogic secure monitor driver
> +
> +config MESON_GX_PM
> +	bool
> +	default ARCH_MESON if ARM64
> +	help
> +	  Say y here to enable the Amlogic GX SoC Power Management
> diff --git a/drivers/firmware/meson/Makefile b/drivers/firmware/meson/Makefile
> index 9ab3884..b6e285d 100644
> --- a/drivers/firmware/meson/Makefile
> +++ b/drivers/firmware/meson/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MESON_SM) +=	meson_sm.o
> +obj-$(CONFIG_MESON_GX_PM) +=	meson_gx_pm.o
> diff --git a/drivers/firmware/meson/meson_gx_pm.c b/drivers/firmware/meson/meson_gx_pm.c
> new file mode 100644
> index 0000000..c104c2e
> --- /dev/null
> +++ b/drivers/firmware/meson/meson_gx_pm.c
> @@ -0,0 +1,86 @@
> +/*
> + * Amlogic Meson GX Power Management
> + *
> + * Copyright (c) 2016 Baylibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/suspend.h>
> +#include <linux/arm-smccc.h>
> +
> +#include <uapi/linux/psci.h>
> +
> +#include <asm/suspend.h>
> +
> +/*
> + * The Amlogic GX SoCs uses a special argument value to the
> + * PSCI CPU_SUSPEND method to enter SUSPEND_MEM.
> + */
> +
> +#define MESON_SUSPEND_PARAM	0x0010000
> +#define PSCI_FN_NATIVE(version, name)	PSCI_##version##_FN64_##name
> +
> +static int meson_gx_suspend_finish(unsigned long arg)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(PSCI_FN_NATIVE(0_2, CPU_SUSPEND), arg,
> +		      virt_to_phys(cpu_resume), 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int meson_gx_suspend_enter(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		return cpu_suspend(MESON_SUSPEND_PARAM,
> +				   meson_gx_suspend_finish);

Short response to this patch: NAK

To be constructive, since this system lacks PSCI system suspend, it just
can't support. Alternatively, this can be normal cpuidle state and you
can use suspend to idle to achieve the same and you need not hack/work
around using platform specific driver.

--
Regards,
Sudeep
