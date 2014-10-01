From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 01 Oct 2014 12:33:05 +0200
Subject: [PATCH 1/2] clk: samsung: exynos5440: move restart code into
 clock driver
In-Reply-To: <1412142540-3667-2-git-send-email-pankaj.dubey@samsung.com>
References: <1412142540-3667-1-git-send-email-pankaj.dubey@samsung.com>
 <1412142540-3667-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <542BD861.6030705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

Please see my comments inline.

On 01.10.2014 07:48, Pankaj Dubey wrote:
> Let's register reboot_notifier for Exynos5440 from it's clock driver
> for reboot functionality. So that we can cleanup restart hooks from
> machine specific file.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c        |   13 ------------
>  drivers/clk/samsung/clk-exynos5440.c |   37 ++++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 2f2f7b2..d56134a 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -143,19 +143,6 @@ static void exynos_restart(enum reboot_mode mode, const char *cmd)
>  	u32 val = 0x1;
>  	void __iomem *addr = pmu_base_addr + EXYNOS_SWRESET;

You can remove the variables above as well...

>  
> -	if (of_machine_is_compatible("samsung,exynos5440")) {
> -		u32 status;
> -		np = of_find_compatible_node(NULL, NULL, "samsung,exynos5440-clock");
> -
> -		addr = of_iomap(np, 0) + 0xbc;
> -		status = __raw_readl(addr);
> -
> -		addr = of_iomap(np, 0) + 0xcc;
> -		val = __raw_readl(addr);
> -
> -		val = (val & 0xffff0000) | (status & 0xffff);
> -	}
> -
>  	__raw_writel(val, addr);

and make this use the constants instead.

>  }
>  
> diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
> index 00d1d00..171d3af 100644
> --- a/drivers/clk/samsung/clk-exynos5440.c
> +++ b/drivers/clk/samsung/clk-exynos5440.c
> @@ -15,6 +15,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
>  
>  #include "clk.h"
>  #include "clk-pll.h"
> @@ -89,6 +91,38 @@ static const struct of_device_id ext_clk_match[] __initconst = {
>  	{},
>  };
>  
> +static int exynos5440_clk_reboot_notify_handler(struct notifier_block *this,
> +		unsigned long code, void *unused)
> +{
> +	if (code == SYS_RESTART) {
> +		struct device_node *np;
> +		void __iomem *addr;
> +		u32 val, status;
> +
> +		np = of_find_compatible_node(NULL, NULL,
> +				"samsung,exynos5440-clock");
> +
> +		addr = of_iomap(np, 0) + 0xbc;

You can just save the address in exynos5440_clk_init() and use it here
without the whole dance with DT and ioremap.

Best regards,
Tomasz
