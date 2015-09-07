From: lee@kernel.org (Lee Jones)
Date: Mon, 7 Sep 2015 07:48:38 +0100
Subject: [PATCH 1/4] clk: bcm2835: Move under bcm/ with other Broadcom
 SoC clk drivers.
In-Reply-To: <1441562263-19888-2-git-send-email-eric@anholt.net>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-2-git-send-email-eric@anholt.net>
Message-ID: <20150907064838.GE4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 06 Sep 2015, Eric Anholt wrote:

> clk-bcm2835.c predates the drivers under bcm/, but all the new BCM
> drivers are going in there so let's follow them.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/clk/Makefile          |  1 -
>  drivers/clk/bcm/Makefile      |  1 +
>  drivers/clk/bcm/clk-bcm2835.c | 60 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk-bcm2835.c     | 60 -------------------------------------------

You need to resubmit this with `git format-patch -M`.

>  4 files changed, 61 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/clk/bcm/clk-bcm2835.c
>  delete mode 100644 drivers/clk/clk-bcm2835.c
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index c4cf075..1bdbe9b 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -19,7 +19,6 @@ endif
>  obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
>  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
>  obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
> -obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
>  obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
>  obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
>  obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index 8a7a477..ee2349b 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
>  obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
>  obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
>  obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
> +obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> new file mode 100644
> index 0000000..6b950ca
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright (C) 2010 Broadcom
> + * Copyright (C) 2012 Stephen Warren
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/bcm2835.h>
> +#include <linux/of.h>
> +
> +/*
> + * These are fixed clocks. They're probably not all root clocks and it may
> + * be possible to turn them on and off but until this is mapped out better
> + * it's the only way they can be used.
> + */
> +void __init bcm2835_init_clocks(void)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
> +					250000000);
> +	if (IS_ERR(clk))
> +		pr_err("sys_pclk not registered\n");
> +
> +	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
> +					126000000);
> +	if (IS_ERR(clk))
> +		pr_err("apb_pclk not registered\n");
> +
> +	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
> +					3000000);
> +	if (IS_ERR(clk))
> +		pr_err("uart0_pclk not registered\n");
> +	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
> +	if (ret)
> +		pr_err("uart0_pclk alias not registered\n");
> +
> +	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
> +					125000000);
> +	if (IS_ERR(clk))
> +		pr_err("uart1_pclk not registered\n");
> +	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
> +	if (ret)
> +		pr_err("uart1_pclk alias not registered\n");
> +}
> diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> deleted file mode 100644
> index 6b950ca..0000000
> --- a/drivers/clk/clk-bcm2835.c
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/*
> - * Copyright (C) 2010 Broadcom
> - * Copyright (C) 2012 Stephen Warren
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
> -#include <linux/clk/bcm2835.h>
> -#include <linux/of.h>
> -
> -/*
> - * These are fixed clocks. They're probably not all root clocks and it may
> - * be possible to turn them on and off but until this is mapped out better
> - * it's the only way they can be used.
> - */
> -void __init bcm2835_init_clocks(void)
> -{
> -	struct clk *clk;
> -	int ret;
> -
> -	clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
> -					250000000);
> -	if (IS_ERR(clk))
> -		pr_err("sys_pclk not registered\n");
> -
> -	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
> -					126000000);
> -	if (IS_ERR(clk))
> -		pr_err("apb_pclk not registered\n");
> -
> -	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
> -					3000000);
> -	if (IS_ERR(clk))
> -		pr_err("uart0_pclk not registered\n");
> -	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
> -	if (ret)
> -		pr_err("uart0_pclk alias not registered\n");
> -
> -	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
> -					125000000);
> -	if (IS_ERR(clk))
> -		pr_err("uart1_pclk not registered\n");
> -	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
> -	if (ret)
> -		pr_err("uart1_pclk alias not registered\n");
> -}
