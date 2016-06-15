From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 15 Jun 2016 11:12:57 -0400
Subject: [PATCH 1/5] clk: max77686: Combine Maxim max77686 and max77802
 driver
In-Reply-To: <1466000018-16784-2-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <4ba85edd-203f-c27f-f11c-5b64f972acc0@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laxman,

On 06/15/2016 10:13 AM, Laxman Dewangan wrote:
> The clock IP used on the Maxim PMICs max77686 and max77802 are
> same. The configuration of clock register is also same except
> the number of clocks.
> 
> Part of common code utilisation, there is 3 files for these chips
> clock driver, one for common and two files for driver registration.
> 
> Combine both drivers into single file and move common code into
> same common file reduces the 2 files and make max77686 and max77802
> clock driver in single fine. This driver does not depends on the
> parent driver structure. The regmap handle is acquired through
> regmap APIs for the register access.
> 
> This combination of driver helps on adding clock driver for different
> Maxim PMICs which has similar clock IP like MAX77620 and MAX20024.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---

[snip]

> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index 9b6f277..31ba726 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -1,5 +1,5 @@
>  /*
> - * clk-max77686.c - Clock driver for Maxim 77686
> + * clk-max77686.c - Clock driver for Maxim 77686/MAX77802
>   *
>   * Copyright (C) 2012 Samsung Electornics
>   * Jonghwa Lee <jonghwa3.lee@samsung.com>
> @@ -13,13 +13,7 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - *
>   */
> -

I think removing this part of the header is correct but it should be a
separate patch.

[snip]

> +
> +struct max_gen_hw_clk_data {
> +	const char *name;
> +	u32 reg;
> +	u32 mask;
> +	u32 flags;
> +};
> +
> +struct max_gen_clk_data {
> +	struct regmap *regmap;
> +	struct clk_init_data clk_idata;
> +	struct clk_hw hw;
> +	u32 reg;
> +	u32 mask;
> +};
> +

Probably now makes more sense to rename all the "max_gen_foo" structs and
functions to just "max77686_foo" since now are all defined in the max77686
so that naming is more consistent.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

I also tested on an Exynos5800 Peach Pi Chromebook that has a max77802 IP:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
