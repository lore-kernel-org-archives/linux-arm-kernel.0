From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 27 Sep 2017 10:16:26 +0300
Subject: [PATCH v2 1/5] media: atmel_isc: Add spin lock for clock enable
 ops
In-Reply-To: <20170918063925.6372-2-wenyou.yang@microchip.com>
References: <20170918063925.6372-1-wenyou.yang@microchip.com>
 <20170918063925.6372-2-wenyou.yang@microchip.com>
Message-ID: <20170927071626.mok5h3ckisyipy53@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

On subject:

s/_/-/

On Mon, Sep 18, 2017 at 02:39:21PM +0800, Wenyou Yang wrote:
> Add the spin lock for the clock enable and disable operations.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/media/platform/atmel/atmel-isc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index 2f8e345d297e..78114193af4c 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c
> @@ -65,6 +65,7 @@ struct isc_clk {
>  	struct clk_hw   hw;
>  	struct clk      *clk;
>  	struct regmap   *regmap;
> +	spinlock_t	*lock;

Can this work? I don't see lock being assigned anywhere. Did you mean

	spinlock_t	lock;

?

>  	u8		id;
>  	u8		parent_id;
>  	u32		div;
> @@ -312,26 +313,37 @@ static int isc_clk_enable(struct clk_hw *hw)
>  	struct isc_clk *isc_clk = to_isc_clk(hw);
>  	u32 id = isc_clk->id;
>  	struct regmap *regmap = isc_clk->regmap;
> +	unsigned long flags;
> +	unsigned int status;
>  
>  	dev_dbg(isc_clk->dev, "ISC CLK: %s, div = %d, parent id = %d\n",
>  		__func__, isc_clk->div, isc_clk->parent_id);
>  
> +	spin_lock_irqsave(isc_clk->lock, flags);
>  	regmap_update_bits(regmap, ISC_CLKCFG,
>  			   ISC_CLKCFG_DIV_MASK(id) | ISC_CLKCFG_SEL_MASK(id),
>  			   (isc_clk->div << ISC_CLKCFG_DIV_SHIFT(id)) |
>  			   (isc_clk->parent_id << ISC_CLKCFG_SEL_SHIFT(id)));
>  
>  	regmap_write(regmap, ISC_CLKEN, ISC_CLK(id));
> +	spin_unlock_irqrestore(isc_clk->lock, flags);
>  
> -	return 0;
> +	regmap_read(regmap, ISC_CLKSR, &status);
> +	if (status & ISC_CLK(id))
> +		return 0;
> +	else
> +		return -EINVAL;
>  }
>  
>  static void isc_clk_disable(struct clk_hw *hw)
>  {
>  	struct isc_clk *isc_clk = to_isc_clk(hw);
>  	u32 id = isc_clk->id;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(isc_clk->lock, flags);
>  	regmap_write(isc_clk->regmap, ISC_CLKDIS, ISC_CLK(id));
> +	spin_unlock_irqrestore(isc_clk->lock, flags);
>  }
>  
>  static int isc_clk_is_enabled(struct clk_hw *hw)

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
