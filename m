From: lee.jones@linaro.org (Lee Jones)
Date: Sun, 18 Jan 2015 09:52:14 +0000
Subject: [PATCH 1/5] mfd: tps65218: make INT[12] and STATUS registers
 volatile
In-Reply-To: <1419622104-25812-2-git-send-email-balbi@ti.com>
References: <1419622104-25812-1-git-send-email-balbi@ti.com>
 <1419622104-25812-2-git-send-email-balbi@ti.com>
Message-ID: <20150118095214.GA3574@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Dec 2014, Felipe Balbi wrote:

> STATUS register can be modified by the HW, so we
> should bypass cache because of that.
> 
> In the case of INT[12] registers, they are the ones
> that actually clear the IRQ source at the time they
> are read. If we rely on the cache for them, we will
> never be able to clear the interrupt, which will cause
> our IRQ line to be disabled due to IRQ throttling.
> 
> Fixes: 44b4dc6 mfd: tps65218: Add driver for the TPS65218 PMIC
> Cc: <stable@vger.kernel.org> # v3.15+
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/tps65218.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Sorry for the delay.  It's difficult to get a WiFi signal 2000m up in
an Austrian mountain. :)

Applied now, thanks.

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 0d256cb..2243f75 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -125,10 +125,21 @@ int tps65218_clear_bits(struct tps65218 *tps, unsigned int reg,
>  }
>  EXPORT_SYMBOL_GPL(tps65218_clear_bits);
>  
> +static const struct regmap_range tps65218_yes_ranges[] = {
> +	regmap_reg_range(TPS65218_REG_INT1, TPS65218_REG_INT2),
> +	regmap_reg_range(TPS65218_REG_STATUS, TPS65218_REG_STATUS),
> +};
> +
> +static const struct regmap_access_table tps65218_volatile_table = {
> +	.yes_ranges = tps65218_yes_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(tps65218_yes_ranges),
> +};
> +
>  static struct regmap_config tps65218_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &tps65218_volatile_table,
>  };
>  
>  static const struct regmap_irq tps65218_irqs[] = {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
