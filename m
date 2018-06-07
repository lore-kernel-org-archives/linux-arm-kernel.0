From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 07 Jun 2018 12:57:04 +0200
Subject: [PATCH v1 3/4] clk: rockchip: add support for half divider
In-Reply-To: <1528340786-462-4-git-send-email-zhangqing@rock-chips.com>
References: <1528340786-462-1-git-send-email-zhangqing@rock-chips.com>
 <1528340786-462-4-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2360735.SLDx3PN3Y9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

looks good to me overall, some minor things below.

Am Donnerstag, 7. Juni 2018, 05:06:25 CEST schrieb Elaine Zhang:
> The new Rockchip socs have optional half divider,
> so we use "branch_half_divider" + "COMPOSITE_NOMUX_HALFDIV \ DIV_HALF"
> to hook that special divider clock-type into our clock-tree.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Please provide a bit more explanation on how this clock type, so
people reading the git log later can understand how the divider works.


> ---
>  drivers/clk/rockchip/Makefile           |   1 +
>  drivers/clk/rockchip/clk-half-divider.c | 235
> ++++++++++++++++++++++++++++++++ drivers/clk/rockchip/clk.c              | 
> 10 ++
>  drivers/clk/rockchip/clk.h              |  45 ++++++
>  4 files changed, 291 insertions(+)
>  create mode 100644 drivers/clk/rockchip/clk-half-divider.c
> 
> diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
> index 59b8d320960a..023f83ad3429 100644
> --- a/drivers/clk/rockchip/Makefile
> +++ b/drivers/clk/rockchip/Makefile
> @@ -7,6 +7,7 @@ obj-y	+= clk-rockchip.o
>  obj-y	+= clk.o
>  obj-y	+= clk-pll.o
>  obj-y	+= clk-cpu.o
> +obj-y   += clk-half-divider.o

all other entries use tabs as spacers between obj-y and the +=

>  obj-y	+= clk-inverter.o
>  obj-y	+= clk-mmc-phase.o
>  obj-y	+= clk-muxgrf.o
> diff --git a/drivers/clk/rockchip/clk-half-divider.c
> b/drivers/clk/rockchip/clk-half-divider.c new file mode 100644
> index 000000000000..23830de254ec
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -0,0 +1,235 @@
> +/*

copyright line missing?

> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include "clk.h"
> +
> +#define div_mask(width)	((1 << (width)) - 1)
> +
> +static bool _is_best_half_div(unsigned long rate, unsigned long now,
> +			      unsigned long best, unsigned long flags)
> +{
> +	if (flags & CLK_DIVIDER_ROUND_CLOSEST)
> +		return abs(rate - now) < abs(rate - best);
> +
> +	return now <= rate && now > best;
> +}
> +
> +static unsigned long clk_half_divider_recalc_rate(struct clk_hw *hw,
> +						  unsigned long parent_rate)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);

While I find it very cool that we can reuse the clk_divider struct
and see no issue doing it, I'm hoping for either Mike or Stephen
to indicate if we're allowed to do that ;-)


> +const struct clk_ops clk_half_divider_ops = {
> +	.recalc_rate = clk_half_divider_recalc_rate,
> +	.round_rate = clk_half_divider_round_rate,
> +	.set_rate = clk_half_divider_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_half_divider_ops);

this is only used locally in rockchip_clk_register_halfdiv, so doesn't
need to be exported.


Heiko
