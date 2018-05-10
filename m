From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 10 May 2018 15:56:08 +0100
Subject: [PATCH v1 2/5] gpio: syscon: Add gpio-syscon for rockchip
In-Reply-To: <1525943800-14095-3-git-send-email-djw@t-chip.com.cn>
References: <1525943800-14095-1-git-send-email-djw@t-chip.com.cn>
 <1525943800-14095-3-git-send-email-djw@t-chip.com.cn>
Message-ID: <c0f520d1-42e3-e8b5-128e-3ff3d532ec4c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/18 10:16, djw at t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
> which do not belong to the general pinctrl.
> 
> Adding gpio-syscon support makes controlling regulator or
> LED using these special pins very easy by reusing existing
> drivers, such as gpio-regulator and led-gpio.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v1:
> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> - Add doc rockchip,gpio-syscon.txt
> 
>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
>   drivers/gpio/gpio-syscon.c                         | 30 ++++++++++++++++
>   2 files changed, 71 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> new file mode 100644
> index 0000000..e4c1650
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> @@ -0,0 +1,41 @@
> +* Rockchip GPIO support for GRF_SOC_CON registers
> +
> +Required properties:
> +- compatible: Should contain "rockchip,gpio-syscon".
> +- gpio-controller: Marks the device node as a gpio controller.
> +- #gpio-cells: Should be two. The first cell is the pin number and

I would suggest s/pin number/bit number in the associated GRF register/ 
here. At least in this RK3328 case there's only one pin, which isn't 
numbered, and if you naively considered it pin 0 of this 'bank' you'd 
already have the wrong number. Since we're dealing with the "random 
SoC-specific controls" region of the GRF as opposed to the 
relatively-consistent and organised pinmux parts, I don't think we 
should rely on any assumptions about how things are laid out.

I was initially going to suggest a more specific compatible string as 
well, but on reflection I think the generic "rockchip,gpio-syscon" for 
basic "flip this single GRF bit" functionality actually is the right way 
to go. In the specific RK3328 GPIO_MUTE case, there look to be 4 bits in 
total related to this pin - the enable, value, and some pull controls 
(which I assume apply when the output is disabled) - if at some point in 
future we *did* want to start explicitly controlling the rest of them 
too, then would be a good time to define a separate 
"rockchip,rk3328-gpio-mute" binding (and probably a dedicated driver) 
for that specialised functionality, independently of this basic one.

> +  the second cell is used to specify the gpio polarity:
> +    0 = Active high,
> +    1 = Active low.
> +- gpio,syscon-dev: Should contain <grf_phandle syscon_offset 0>.
> +  If declared as child of the grf node, the grf_phandle can be 0.
> +
> +Example:
> +
> +1. As child of grf node:
> +
> +	grf: syscon at ff100000 {
> +		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> +
> +		gpio_syscon10: gpio-syscon10 {
> +			compatible = "rockchip,gpio-syscon";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <0 0x0428 0>;
> +		};
> +	};
> +
> +
> +2. Not child of grf node:
> +
> +	grf: syscon at ff100000 {
> +		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> +		//...
> +	};
> +
> +	gpio_syscon10: gpio-syscon10 {
> +		compatible = "rockchip,gpio-syscon";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio,syscon-dev = <&grf 0x0428 0>;
> +	};
> diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
> index 7325b86..e24b408 100644
> --- a/drivers/gpio/gpio-syscon.c
> +++ b/drivers/gpio/gpio-syscon.c
> @@ -135,6 +135,32 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
>   	.dat_bit_offset	= 0x40 * 8 + 8,
>   };
>   
> +static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			      int val)
> +{
> +	struct syscon_gpio_priv *priv = gpiochip_get_data(chip);
> +	unsigned int offs;
> +	u8 bit;
> +	u32 data;
> +	int ret;
> +
> +	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;

data->dat_bit_offset is always 0 here, but given that wrapping large 
offsets to successive GRF registers doesn't make sense (and wouldn't 
work anyway with this arithmetic) I don't think you even need this 
calculation of offs at all...

> +	bit = offs % SYSCON_REG_BITS;

... since it would suffice to use offset here...

> +	data = (val ? BIT(bit) : 0) | BIT(bit + 16);
> +	ret = regmap_write(priv->syscon,
> +			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,

... and priv->dreg_offset here.

Robin.

> +			   data);
> +	if (ret < 0)
> +		dev_err(chip->parent, "gpio write failed ret(%d)\n", ret);
> +}
> +
> +static const struct syscon_gpio_data rockchip_gpio_syscon = {
> +	/* Rockchip GRF_SOC_CON Bits 0-15 */
> +	.flags		= GPIO_SYSCON_FEAT_OUT,
> +	.bit_count	= 16,
> +	.set		= rockchip_gpio_set,
> +};
> +
>   #define KEYSTONE_LOCK_BIT BIT(0)
>   
>   static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
> @@ -175,6 +201,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
>   		.compatible	= "ti,keystone-dsp-gpio",
>   		.data		= &keystone_dsp_gpio,
>   	},
> +	{
> +		.compatible	= "rockchip,gpio-syscon",
> +		.data		= &rockchip_gpio_syscon,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
> 
