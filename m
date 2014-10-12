From: khilman@kernel.org (Kevin Hilman)
Date: Sun, 12 Oct 2014 05:56:23 -0700
Subject: [PATCH v1 2/4] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <1412001499-19369-3-git-send-email-grygorii.strashko@ti.com>
References: <1412001499-19369-1-git-send-email-grygorii.strashko@ti.com>
 <1412001499-19369-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CAMAWPa-sKGu_o0CDLCk_uKofxwOjXiiFBedjEP=OhQFmo+ehCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

On 9/29/14 7:38 AM, Grygorii Strashko wrote:
> This patch switches Keystone 2 PM code to use Generic PM domains
> instead of PM clock domains because of the lack of DT support
> for the last.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

IMO, this approach is much better.

One minor nit below...

> diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
> index ca79dda..3eb5257 100644
> --- a/arch/arm/mach-keystone/pm_domain.c
> +++ b/arch/arm/mach-keystone/pm_domain.c
> @@ -12,69 +12,110 @@
>   * version 2, as published by the Free Software Foundation.
>   */
>
> +#include <linux/clk.h>
>  #include <linux/init.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/pm_clock.h>
> +#include <linux/pm_domain.h>
>  #include <linux/platform_device.h>
> -#include <linux/clk-provider.h>
>  #include <linux/of.h>
>
> -#ifdef CONFIG_PM_RUNTIME
> -static int keystone_pm_runtime_suspend(struct device *dev)
> +#ifdef CONFIG_PM_GENERIC_DOMAINS
> +
> +struct keystone_domain {
> + struct generic_pm_domain base;
> + struct device *dev;
> +};

I think the name 'base' for this field leads to confusion later in the
code, since base usually means something else in drivers.  How about
'genpd'?

Kevin
