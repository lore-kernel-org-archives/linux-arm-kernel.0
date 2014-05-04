From: max.schwarz@online.de (Max Schwarz)
Date: Sun, 04 May 2014 15:31:40 +0200
Subject: [PATCH 2/8] pinctrl: rockchip: use regmaps instead of raw mappings
In-Reply-To: <12837529.UNWjpLOtVY@diego>
References: <1414506.B4e2jZujVm@diego> <12837529.UNWjpLOtVY@diego>
Message-ID: <2503713.QQRxskQ1Pq@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wednesday 30 April 2014 at 00:08:19, Heiko St?bner wrote:
> This allows us to use syscons in the future.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 116
> +++++++++++++++++++++++++------------ 1 file changed, 80 insertions(+), 36
> deletions(-)

You should add a "select REGMAP_MMIO" in drivers/pinctrl/Kconfig to make sure 
it compiles. Or just add MFD_SYSCON since it depends on REGMAP_MMIO and is a 
runtime dependency for the new binding now.

Otherwise I tested your series with my tree on RK3188/Radxa Rock and 
everything works.

Cheers,
  Max

> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index ab71de8..71d9c99 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -37,6 +37,7 @@
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/clk.h>
> +#include <linux/regmap.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> 
>  #include "core.h"
> @@ -86,7 +87,7 @@ enum rockchip_pin_bank_type {
>   */
>  struct rockchip_pin_bank {
>  	void __iomem			*reg_base;
> -	void __iomem			*reg_pull;
> +	struct regmap			*regmap_pull;
>  	struct clk			*clk;
>  	int				irq;
>  	u32				pin_base;
> @@ -120,8 +121,9 @@ struct rockchip_pin_ctrl {
>  	char				*label;
>  	enum rockchip_pinctrl_type	type;
>  	int				mux_offset;
> -	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank, int pin_num,
> -				 void __iomem **reg, u8 *bit);
> +	void	(*pull_calc_reg)(struct rockchip_pin_bank *bank,
> +				    int pin_num, struct regmap **regmap,
> +				    int *reg, u8 *bit);
>  };
> 
>  struct rockchip_pin_config {
> @@ -159,9 +161,9 @@ struct rockchip_pmx_func {
>  };
> 
>  struct rockchip_pinctrl {
> -	void __iomem			*reg_base;
> +	struct regmap			*regmap_base;
>  	int				reg_size;
> -	void __iomem			*reg_pull;
> +	struct regmap			*regmap_pull;
>  	struct device			*dev;
>  	struct rockchip_pin_ctrl	*ctrl;
>  	struct pinctrl_desc		pctl;
> @@ -172,6 +174,12 @@ struct rockchip_pinctrl {
>  	unsigned int			nfunctions;
>  };
> 
> +static struct regmap_config rockchip_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
>  static inline struct rockchip_pin_bank *gc_to_pin_bank(struct gpio_chip
> *gc) {
>  	return container_of(gc, struct rockchip_pin_bank, gpio_chip);
> @@ -333,18 +341,24 @@ static const struct pinctrl_ops rockchip_pctrl_ops = {
> static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin) {
>  	struct rockchip_pinctrl *info = bank->drvdata;
> -	void __iomem *reg = info->reg_base + info->ctrl->mux_offset;
> +	unsigned int val;
> +	int reg, ret;
>  	u8 bit;
> 
>  	if (bank->bank_type == RK3188_BANK0 && pin < 16)
>  		return RK_FUNC_GPIO;
> 
>  	/* get basic quadrupel of mux registers and the correct reg inside */
> +	reg = info->ctrl->mux_offset;
>  	reg += bank->bank_num * 0x10;
>  	reg += (pin / 8) * 4;
>  	bit = (pin % 8) * 2;
> 
> -	return ((readl(reg) >> bit) & 3);
> +	ret = regmap_read(info->regmap_base, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return ((val >> bit) & 3);
>  }
> 
>  /*
> @@ -363,7 +377,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank
> *bank, int pin) static int rockchip_set_mux(struct rockchip_pin_bank *bank,
> int pin, int mux) {
>  	struct rockchip_pinctrl *info = bank->drvdata;
> -	void __iomem *reg = info->reg_base + info->ctrl->mux_offset;
> +	int reg, ret;
>  	unsigned long flags;
>  	u8 bit;
>  	u32 data;
> @@ -386,6 +400,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank
> *bank, int pin, int mux) bank->bank_num, pin, mux);
> 
>  	/* get basic quadrupel of mux registers and the correct reg inside */
> +	reg = info->ctrl->mux_offset;
>  	reg += bank->bank_num * 0x10;
>  	reg += (pin / 8) * 4;
>  	bit = (pin % 8) * 2;
> @@ -394,11 +409,11 @@ static int rockchip_set_mux(struct rockchip_pin_bank
> *bank, int pin, int mux)
> 
>  	data = (3 << (bit + 16));
>  	data |= (mux & 3) << bit;
> -	writel(data, reg);
> +	ret = regmap_write(info->regmap_base, reg, data);
> 
>  	spin_unlock_irqrestore(&bank->slock, flags);
> 
> -	return 0;
> +	return ret;
>  }
> 
>  #define RK2928_PULL_OFFSET		0x118
> @@ -406,11 +421,13 @@ static int rockchip_set_mux(struct rockchip_pin_bank
> *bank, int pin, int mux) #define RK2928_PULL_BANK_STRIDE		8
> 
>  static void rk2928_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, void __iomem **reg, u8 *bit)
> +				    int pin_num, struct regmap **regmap,
> +				    int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
> 
> -	*reg = info->reg_base + RK2928_PULL_OFFSET;
> +	*regmap = info->regmap_base;
> +	*reg = RK2928_PULL_OFFSET;
>  	*reg += bank->bank_num * RK2928_PULL_BANK_STRIDE;
>  	*reg += (pin_num / RK2928_PULL_PINS_PER_REG) * 4;
> 
> @@ -423,19 +440,23 @@ static void rk2928_calc_pull_reg_and_bit(struct
> rockchip_pin_bank *bank, #define RK3188_PULL_BANK_STRIDE		16
> 
>  static void rk3188_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
> -				    int pin_num, void __iomem **reg, u8 *bit)
> +				    int pin_num, struct regmap **regmap,
> +				    int *reg, u8 *bit)
>  {
>  	struct rockchip_pinctrl *info = bank->drvdata;
> 
>  	/* The first 12 pins of the first bank are located elsewhere */
>  	if (bank->bank_type == RK3188_BANK0 && pin_num < 12) {
> -		*reg = bank->reg_pull +
> -				((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
> +		*regmap = bank->regmap_pull;
> +		*reg = 0;
> +		*reg += ((pin_num / RK3188_PULL_PINS_PER_REG) * 4);
>  		*bit = pin_num % RK3188_PULL_PINS_PER_REG;
>  		*bit *= RK3188_PULL_BITS_PER_PIN;
>  	} else {
> -		*reg = info->reg_pull ? info->reg_pull
> -				      : info->reg_base + RK3188_PULL_OFFSET;
> +		*regmap = info->regmap_pull ? info->regmap_pull
> +					    : info->regmap_base;
> +		*reg = info->regmap_pull ? 0 : RK3188_PULL_OFFSET;
> +
>  		/* correct the offset, as it is the 2nd pull register */
>  		*reg -= 4;
>  		*reg += bank->bank_num * RK3188_PULL_BANK_STRIDE;
> @@ -455,7 +476,8 @@ static int rockchip_get_pull(struct rockchip_pin_bank
> *bank, int pin_num) {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  	struct rockchip_pin_ctrl *ctrl = info->ctrl;
> -	void __iomem *reg;
> +	struct regmap *regmap;
> +	int reg, ret;
>  	u8 bit;
>  	u32 data;
> 
> @@ -463,15 +485,19 @@ static int rockchip_get_pull(struct rockchip_pin_bank
> *bank, int pin_num) if (ctrl->type == RK3066B)
>  		return PIN_CONFIG_BIAS_DISABLE;
> 
> -	ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
> +	ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> +
> +	ret = regmap_read(regmap, reg, &data);
> +	if (ret)
> +		return ret;
> 
>  	switch (ctrl->type) {
>  	case RK2928:
> -		return !(readl_relaxed(reg) & BIT(bit))
> +		return !(data & BIT(bit))
>  				? PIN_CONFIG_BIAS_PULL_PIN_DEFAULT
> 
>  				: PIN_CONFIG_BIAS_DISABLE;
> 
>  	case RK3188:
> -		data = readl_relaxed(reg) >> bit;
> +		data >>= bit;
>  		data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
> 
>  		switch (data) {
> @@ -498,7 +524,8 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, {
>  	struct rockchip_pinctrl *info = bank->drvdata;
>  	struct rockchip_pin_ctrl *ctrl = info->ctrl;
> -	void __iomem *reg;
> +	struct regmap *regmap;
> +	int reg, ret;
>  	unsigned long flags;
>  	u8 bit;
>  	u32 data;
> @@ -510,7 +537,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, if (ctrl->type == RK3066B)
>  		return pull ? -EINVAL : 0;
> 
> -	ctrl->pull_calc_reg(bank, pin_num, &reg, &bit);
> +	ctrl->pull_calc_reg(bank, pin_num, &regmap, &reg, &bit);
> 
>  	switch (ctrl->type) {
>  	case RK2928:
> @@ -519,7 +546,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, data = BIT(bit + 16);
>  		if (pull == PIN_CONFIG_BIAS_DISABLE)
>  			data |= BIT(bit);
> -		writel(data, reg);
> +		ret = regmap_write(regmap, reg, data);
> 
>  		spin_unlock_irqrestore(&bank->slock, flags);
>  		break;
> @@ -548,7 +575,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, return -EINVAL;
>  		}
> 
> -		writel(data, reg);
> +		ret = regmap_write(regmap, reg, data);
> 
>  		spin_unlock_irqrestore(&bank->slock, flags);
>  		break;
> @@ -557,7 +584,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, return -EINVAL;
>  	}
> 
> -	return 0;
> +	return ret;
>  }
> 
>  /*
> @@ -1416,6 +1443,7 @@ static int rockchip_get_bank_data(struct
> rockchip_pin_bank *bank, struct device *dev)
>  {
>  	struct resource res;
> +	void __iomem *base;
> 
>  	if (of_address_to_resource(bank->of_node, 0, &res)) {
>  		dev_err(dev, "cannot find IO resource for bank\n");
> @@ -1440,9 +1468,14 @@ static int rockchip_get_bank_data(struct
> rockchip_pin_bank *bank, return -ENOENT;
>  		}
> 
> -		bank->reg_pull = devm_ioremap_resource(dev, &res);
> -		if (IS_ERR(bank->reg_pull))
> -			return PTR_ERR(bank->reg_pull);
> +		base = devm_ioremap_resource(dev, &res);
> +		if (IS_ERR(base))
> +			return PTR_ERR(base);
> +		rockchip_regmap_config.max_register = resource_size(&res) - 4;
> +		rockchip_regmap_config.name = "rockchip,rk3188-gpio-bank0-pull";
> +		bank->regmap_pull = devm_regmap_init_mmio(dev, base,
> +						  &rockchip_regmap_config);
> +
>  	} else {
>  		bank->bank_type = COMMON_BANK;
>  	}
> @@ -1507,6 +1540,7 @@ static int rockchip_pinctrl_probe(struct
> platform_device *pdev) struct device *dev = &pdev->dev;
>  	struct rockchip_pin_ctrl *ctrl;
>  	struct resource *res;
> +	void __iomem *base;
>  	int ret;
> 
>  	if (!dev->of_node) {
> @@ -1527,19 +1561,29 @@ static int rockchip_pinctrl_probe(struct
> platform_device *pdev) info->dev = dev;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	info->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(info->reg_base))
> -		return PTR_ERR(info->reg_base);
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rockchip_regmap_config.max_register = resource_size(res) - 4;
> +	rockchip_regmap_config.name = "rockchip,pinctrl";
> +	info->regmap_base = devm_regmap_init_mmio(&pdev->dev, base,
> +						  &rockchip_regmap_config);
> 
>  	/* to check for the old dt-bindings */
>  	info->reg_size = resource_size(res);
> 
>  	/* Honor the old binding, with pull registers as 2nd resource */
> -	if (ctrl->type == RK3188 &&  info->reg_size < 0x200) {
> +	if (ctrl->type == RK3188 && info->reg_size < 0x200) {
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		info->reg_pull = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(info->reg_pull))
> -			return PTR_ERR(info->reg_pull);
> +		base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(base))
> +			return PTR_ERR(base);
> +
> +		rockchip_regmap_config.max_register = resource_size(res) - 4;
> +		rockchip_regmap_config.name = "rockchip,pinctrl-pull";
> +		info->regmap_pull = devm_regmap_init_mmio(&pdev->dev, base,
> +						  &rockchip_regmap_config);
>  	}
> 
>  	ret = rockchip_gpiolib_register(pdev, info);
