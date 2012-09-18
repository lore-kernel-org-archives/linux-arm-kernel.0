From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 18 Sep 2012 10:31:52 -0700
Subject: [PATCH V5 4/5] ARM: bcm2835: add stub clock driver
In-Reply-To: <1347690093-16910-4-git-send-email-swarren@wwwdotorg.org>
References: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
 <1347690093-16910-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120918173152.17033.40823@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2012-09-14 23:21:32)
> diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
> new file mode 100644
> index 0000000..148ac35
> --- /dev/null
> +++ b/drivers/clk/clk-bcm2835.c
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (C) 2010 Broadcom
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
> +#include <linux/clk.h>
> +#include <linux/clk-private.h>
> +#include <linux/clk-provider.h>

No need to include clk-provider.h or clk.h if you pull in clk-private.h.

Do you really need clk-private.h?  I really hate that approach and I'm
trying to minimize the number of platforms using those interfaces.  I
plan to delete clk-private.h once OMAP and Tegra move away from
statically initialized clocks needed during early boot.

> +#include <linux/clkdev.h>
> +#include <linux/clk/bcm2835.h>
> +
> +/*
> + * These are fixed clocks (and device tree doesn't support clk!).
> + *
> + * They're probably not all root clocks and it may be possible to
> + * turn them on and off but until this is mapped out better it's
> + * the only way they can be used.
> + */
> +DEFINE_CLK_FIXED_RATE(sys_pclk,   CLK_IS_ROOT, 250000000, 0);
> +DEFINE_CLK_FIXED_RATE(apb_pclk,   CLK_IS_ROOT, 126000000, 0);
> +DEFINE_CLK_FIXED_RATE(uart0_pclk, CLK_IS_ROOT,   3000000, 0);
> +DEFINE_CLK_FIXED_RATE(uart1_pclk, CLK_IS_ROOT, 125000000, 0);
> +

How about:

clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT, 250000000);

Regards,
Mike
