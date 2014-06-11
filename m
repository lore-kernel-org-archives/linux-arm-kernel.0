From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Jun 2014 10:50:43 +0200
Subject: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
In-Reply-To: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1402476643.32147.6.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-04-04 at 11:48 +0200, Daniel Lezcano wrote:
> The following driver is for exynos4210. I did not yet finished the other boards, so
> I created a specific driver for 4210 which could be merged later.
> 
> The driver is based on Colin Cross's driver found at:
> 
> https://android.googlesource.com/kernel/exynos/+/e686b1ec67423c40b4fdf811f9a4dfa3b393a010%5E%5E!/
> 
> This one was based on a 3.4 kernel and an old API.
> 
> It has been refreshed, simplified and based on the recent code cleanup I sent
> today.
> 
> The AFTR could be entered when all the cpus (except cpu0) are down. In order to
> reach this situation, the couple idle states are used.
> 
> There is a sync barrier at the entry and the exit of the low power function. So
> all cpus will enter and exit the function at the same time.
> 
> At this point, CPU0 knows the other cpu will power down itself. CPU0 waits for
> the CPU1 to be powered down and then initiate the AFTR power down sequence.
> 
> No interrupts are handled by CPU1, this is why we switch to the timer broadcast
> even if the local timer is not impacted by the idle state.
> 
> When CPU0 wakes up, it powers up CPU1 and waits for it to boot. Then they both
> exit the idle function.
> 
> This driver allows the exynos4210 to have the same power consumption at idle
> time than the one when we have to unplug CPU1 in order to let CPU0 to reach
> the AFTR state.
> 
> This patch is a RFC because, we have to find a way to remove the macros
> definitions and cpu powerdown function without pulling the arch dependent
> headers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c        |   11 +-
>  drivers/cpuidle/Kconfig.arm          |    8 ++
>  drivers/cpuidle/Makefile             |    1 +
>  drivers/cpuidle/cpuidle-exynos4210.c |  226 ++++++++++++++++++++++++++++++++++
>  4 files changed, 245 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpuidle/cpuidle-exynos4210.c

(...)

> diff --git a/drivers/cpuidle/cpuidle-exynos4210.c b/drivers/cpuidle/cpuidle-exynos4210.c
> new file mode 100644
> index 0000000..56f6d51
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-exynos4210.c
> @@ -0,0 +1,226 @@
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Copyright (c) 2014 Linaro : Daniel Lezcano <daniel.lezcano@linaro.org>
> + *		http://www.linaro.org
> + *
> + * Based on the work of Colin Cross <ccross@android.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> +#include <asm/cpuidle.h>
> +
> +#include <plat/pm.h>
> +#include <plat/cpu.h>
> +#include <plat/map-base.h>
> +#include <plat/map-s5p.h>
> +
> +static atomic_t exynos_idle_barrier;

Hi,

Shouldn't the exynos_idle_barrier be initialized here?

I know you sent the patch almost 2 months ago but I stomped on this
while testing it on Exynos3250.

Best regards,
Krzysztof
