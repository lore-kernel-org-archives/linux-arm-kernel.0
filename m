From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Oct 2016 10:03:57 +0200
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix the clock provider
 registration
In-Reply-To: <20160929142855.30408-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 29 Sep 2016 16:28:55 +0200")
References: <20160929142855.30408-1-gregory.clement@free-electrons.com>
Message-ID: <87h98ovb4i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen and Mike
 
 On jeu., sept. 29 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> While trying using a peripheral clock on a driver, I saw that the clock
> pointer returned by the provider was NULL.
>
> The problem was a missing indirection. It was the pointer stored in the
> hws array which needed to be updated not the value it contains.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I saw that you already did the pull request for the clk subsystem.

Do you consider to do a another pull request for the fixes?

It would be nice to have this driver working since the rc1 :)

For this driver an other fix is needed:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/459640.html

Thanks!

Gregory

> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index 45905fc0d75b..d5dfbad4ceab 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -305,7 +305,7 @@ static const struct of_device_id armada_3700_periph_clock_of_match[] = {
>  };
>  static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
>  					 void __iomem *reg, spinlock_t *lock,
> -					 struct device *dev, struct clk_hw *hw)
> +					 struct device *dev, struct clk_hw **hw)
>  {
>  	const struct clk_ops *mux_ops = NULL, *gate_ops = NULL,
>  		*rate_ops = NULL;
> @@ -353,13 +353,13 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
>  		}
>  	}
>  
> -	hw = clk_hw_register_composite(dev, data->name, data->parent_names,
> +	*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
>  				       data->num_parents, mux_hw,
>  				       mux_ops, rate_hw, rate_ops,
>  				       gate_hw, gate_ops, CLK_IGNORE_UNUSED);
>  
> -	if (IS_ERR(hw))
> -		return PTR_ERR(hw);
> +	if (IS_ERR(*hw))
> +		return PTR_ERR(*hw);
>  
>  	return 0;
>  }
> @@ -400,7 +400,7 @@ static int armada_3700_periph_clock_probe(struct platform_device *pdev)
>  	spin_lock_init(&driver_data->lock);
>  
>  	for (i = 0; i < num_periph; i++) {
> -		struct clk_hw *hw = driver_data->hw_data->hws[i];
> +		struct clk_hw **hw = &driver_data->hw_data->hws[i];
>  
>  		if (armada_3700_add_composite_clk(&data[i], reg,
>  						  &driver_data->lock, dev, hw))
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
