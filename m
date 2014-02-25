From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Feb 2014 09:20:31 +0000
Subject: [PATCH 1/2] mfd: palmas: support IRQ inversion at the board level
In-Reply-To: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
References: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140225092031.GF19099@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

> From: Stephen Warren <swarren@nvidia.com>
> 
> Some boards or SoCs have an inverter between the PMIC IRQ output pin and
> the IRQ controller input signal.
> 
> The IRQ specifier in DT is meant to represent the IRQ flags at the input
> to the IRQ controller.
> 
> The Palmas HW's IRQ output has configurable polarity. The driver
> currently selects the output polarity by querying the input polarity at
> the IRQ controller. This works fine if the IRQ signal is routed directly
> from the PMIC to the IRQ controller with no intervening logic. However,
> if the signal is inverted between the two, this automatic polarity
> selection gets the wrong answer.
> 
> Add an additional optional DT and platform data parameter which indicates
> that such an inversion occurs. If this option is enabled, the Palmas
> driver will configure its IRQ output to the opposite polarity of the IRQ
> controller's input.
> 
> An alternative would have been to add a new non-optional DT parameter to
> indicate the exact desired output polarity. However, this would have been
> an incompatible change to the DT binding.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> If this patch could be applied to its own branch (w/ signed tag) in the
> MFD tree, that would great; then I can pull patch 1/2 into the Tegra tree
> so that I can apply patch 2/2 to the Tegra tree. Thanks.
> ---
>  Documentation/devicetree/bindings/mfd/palmas.txt | 6 ++++++

Would you care to review this for Stephen please?

>  drivers/mfd/palmas.c                             | 4 ++++
>  include/linux/mfd/palmas.h                       | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
> index e5f0f8303461..76ec509d5f87 100644
> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
> +++ b/Documentation/devicetree/bindings/mfd/palmas.txt
> @@ -18,6 +18,12 @@ Required properties:
>    ti,tps659038
>  and also the generic series names
>    ti,palmas
> +- interrupts : Should contain a single entry for the IRQ output.
> +- ti,irq-externally-inverted : If missing, the polarity of the Palmas IRQ
> +  output should be set to the opposite of the polarity indicated by the IRQ
> +  specifier in the interrupts property. If absent, the polarity should be
> +  configured to match. This allows the representation of an inverter between
> +  the Palmas IRQ output and the interrupt parent's IRQ input.
>  - interrupt-controller : palmas has its own internal IRQs
>  - #interrupt-cells : should be set to 2 for IRQ number and flags
>    The first cell is the IRQ number.
> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
> index d280d789e55a..f4ea932adf8d 100644
> --- a/drivers/mfd/palmas.c
> +++ b/drivers/mfd/palmas.c
> @@ -293,6 +293,8 @@ static int palmas_set_pdata_irq_flag(struct i2c_client *i2c,
>  	}
>  
>  	pdata->irq_flags = irqd_get_trigger_type(irq_data);
> +	pdata->irq_external_inversion = of_property_read_bool(i2c->dev.of_node,
> +						"ti,irq-externally-inverted");
>  	dev_info(&i2c->dev, "Irq flag is 0x%08x\n", pdata->irq_flags);
>  	return 0;
>  }
> @@ -447,6 +449,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  		reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
>  	else
>  		reg = 0;
> +	if (pdata->irq_external_inversion)
> +		reg ^= PALMAS_POLARITY_CTRL_INT_POLARITY;
>  	ret = palmas_update_bits(palmas, PALMAS_PU_PD_OD_BASE,
>  			PALMAS_POLARITY_CTRL, PALMAS_POLARITY_CTRL_INT_POLARITY,
>  			reg);
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 9974e387e483..2fdf08c50a48 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -292,6 +292,7 @@ struct palmas_clk_platform_data {
>  
>  struct palmas_platform_data {
>  	int irq_flags;
> +	bool irq_external_inversion;
>  	int gpio_base;
>  
>  	/* bit value to be loaded to the POWER_CTRL register */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
