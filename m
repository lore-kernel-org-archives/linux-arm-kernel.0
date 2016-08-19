From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 19 Aug 2016 18:07:04 +0900
Subject: [PATCH 4/7] pinctrl: samsung: Add GPFx support of Exynos5433
In-Reply-To: <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <CGME20160816062943epcas1p15015ed6a3e22ef0b723c2b84edc93d3d@epcas1p1.samsung.com>
 <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <57B6CC38.9090403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz Figa,

Due to wrong setting of email client,
your reply is deleted on my email client at the company.
I'm so sorry. So, I add your comment on below and then
I reply the detailed description.

On 2016? 08? 16? 15:27, Chanwoo Choi wrote:
> From: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> This patch add the support of GPFx pin of Exynos5433 SoC. Exynos5433 has
> different memory map of GPFx from previous Exynos SoC. Exynos GPIO has
> following register to control gpio funciton. Usually, all registers of GPIO
> are included in same domain.
> - CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND
> 
> But, GPFx are included in two domain as following. So, this patch supports
> the GPFx pin which handle the on separate two domains.
> - ALIVE domain : CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - IMEM domain  : EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND

---------
I'm afraid I don't get anything from the description above. Could you
describe the layout of registers in memory map and IRQ routing of the
pins?

Best regards,
Tomasz
----------

On this patch, I'm sorry that I described the wrong information about GFP1~5.
I explained the memory map of GPF[1-5] the oppositely. Following compositions
are correct.
- ALIVE : WEINT_FLTCONx, WEINT_MASK, WEING_PEND
- IMEM : CON, DAT, PUD, DRV, CONPDN, PUDPDN
And, I add the memory map for GPF[1~5][2] and the wakeup interrupt information[1].

[1] Memory map for GPF1~5
[ALIVE]
WEINT_GPA0_CON         : 0x1058_0000 (ALIVE) + (0x0700 = 0x0700 + 0x0)
WEINT_GPA1_CON         : 0x1058_0000 (ALIVE) + (0x0704 = 0x0700 + 0x4)
WEINT_GPA2_CON         : 0x1058_0000 (ALIVE) + (0x0708 = 0x0700 + 0x8)
WEINT_GPA3_CON         : 0x1058_0000 (ALIVE) + (0x070C = 0x0700 + 0xC)

WEINT_GPF1_CON         : 0x1058_0000 (ALIVE) + (0x1704 = 0x0700 + 0x1004)
WEINT_GPF2_CON         : 0x1058_0000 (ALIVE) + (0x1708 = 0x0700 + 0x1008)
WEINT_GPF3_CON         : 0x1058_0000 (ALIVE) + (0x170C = 0x0700 + 0x100C)
WEINT_GPF4_CON         : 0x1058_0000 (ALIVE) + (0x1710 = 0x0700 + 0x10010)
WEINT_GPF5_CON         : 0x1058_0000 (ALIVE) + (0x1714 = 0x0700 + 0x1014)

WEINT_GPF[x]_MASK     : 0x1058_0000 (ALIVE) + (0x1900 + (x * 4))
WEINT_GPF[x]_PEND     : 0x1058_0000 (ALIVE) + (0x1A00 + (x * 4))
(x : 1 ~ 5)

[IMEM]
GPF1_CON          : 0X1109_0000 (IMEM) + 0x0020
GPF1_DAT           : 0X1109_0000 (IMEM) + 0x0024
GPF1_PUD          : 0X1109_0000 (IMEM) + 0x0028
GPF1_DRV          : 0X1109_0000 (IMEM) + 0x002C
GPF1_CONPDN  : 0X1109_0000 (IMEM) + 0x0030
GPF1_PUDPDN  : 0X1109_0000 (IMEM) + 0x0034

GPF2_CON         : 0X1109_0000 (IMEM) + 0x0040
...
GPF3_CON         : 0X1109_0000 (IMEM) + 0x0060
...
GPF4_CON         : 0X1109_0000 (IMEM) + 0x0080
...
GPF5_CON         : 0X1109_0000 (IMEM) + 0x00A0

[2] Interrput pin information
- the total number of wakeup external IRQ is 64.
----------------------------------------------------------------------------------
domain| gpio : nr  | wakeup interrput name   | SPI number       |
-----------------------------------------------------------------------------------
ALIVE | GPA0 : 8 | INTREQ__EINT[0~7]     | SPI[0] ~ SPI[7]   |
ALIVE | GPA1 : 8 | INTREQ__EINT[8~15]   | SPI[8] ~ SPI[15] |
ALIVE | GPA2 : 8 | INTREQ__EINT_16_63 | SPI[16]               |
ALIVE | GPA3 : 8 | INTREQ__EINT_16_63 | SPI[16]               |
-----------------------------------------------------------------------------------
ALIVE | GPF1 : 8 | INTREQ__EINT_16_63 | SPI[16]               |
ALIVE | GPF2 : 4 | INTREQ__EINT_16_63 | SPI[16]               |
ALIVE | GPF3 : 4 | INTREQ__EINT_16_63 | SPI[16]               |
ALIVE | GPF4 : 8 | INTREQ__EINT_16_63 | SPI[16]               |
ALIVE | GPF5 : 8 | INTREQ__EINT_16_63 | SPI[16]               |
-----------------------------------------------------------------------------------

In summary,
If gpf[1-5] handle the CON/DAT/PUD/DRV register,
the driver will use the drvdata->ext_base (IMEM base address)
instead of drvdata->virt_base(ALIVE base address)
because the CON/DAT/PUD/DRV register of gpf[1-5] are included
in the IMEM domain.

If gpf[1-5] handle the WEINT_* register,
the driver will use the drvdata->virt_base(ALIVE base address)
because the WEINT_* registers of gpf[1-5] are included in the ALIVE domain.

Best Regards,
Chanwoo Choi


> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/pinctrl/samsung-pinctrl.txt           |  1 +
>  drivers/pinctrl/samsung/pinctrl-exynos.c           |  5 +++
>  drivers/pinctrl/samsung/pinctrl-exynos.h           | 11 ++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c          | 43 ++++++++++++++++++----
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |  5 +++
>  5 files changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index 6db16b90873a..807fba1f829f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -19,6 +19,7 @@ Required Properties:
>    - "samsung,exynos5260-pinctrl": for Exynos5260 compatible pin-controller.
>    - "samsung,exynos5410-pinctrl": for Exynos5410 compatible pin-controller.
>    - "samsung,exynos5420-pinctrl": for Exynos5420 compatible pin-controller.
> +  - "samsung,exynos5433-pinctrl": for Exynos5433 compatible pin-controller.
>    - "samsung,exynos7-pinctrl": for Exynos7 compatible pin-controller.
>  
>  - reg: Base address of the pin controller hardware module and length of
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index 051b5bf701a8..4f95983e0cdd 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -1350,6 +1350,11 @@ static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
>  	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
>  	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
>  	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
> +	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004),
> +	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008),
> +	EXYNOS_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c),
> +	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010),
> +	EXYNOS_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014),
>  };
>  
>  /* pin banks of exynos5433 pin-controller - AUD */
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
> index 0f0f7cedb2dc..4b737b6c434d 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
> @@ -79,6 +79,17 @@
>  		.name		= id			\
>  	}
>  
> +#define EXYNOS_PIN_BANK_EINTW_EXT(pins, reg, id, offs)	\
> +	{						\
> +		.type		= &bank_type_off,	\
> +		.pctl_offset	= reg,			\
> +		.nr_pins	= pins,			\
> +		.eint_type	= EINT_TYPE_WKUP,	\
> +		.eint_offset	= offs,			\
> +		.eint_ext	= true,			\
> +		.name		= id			\
> +	}
> +
>  /**
>   * struct exynos_weint_data: irq specific data for all the wakeup interrupts
>   * generated by the external wakeup interrupt controller.
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 513fe6b23248..57e22085c2db 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -338,6 +338,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
>  			struct samsung_pin_bank **bank)
>  {
>  	struct samsung_pin_bank *b;
> +	void __iomem *virt_base = drvdata->virt_base;
>  
>  	b = drvdata->pin_banks;
>  
> @@ -345,7 +346,10 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
>  			((b->pin_base + b->nr_pins - 1) < pin))
>  		b++;
>  
> -	*reg = drvdata->virt_base + b->pctl_offset;
> +	if (b->eint_ext)
> +		virt_base = drvdata->ext_base;
> +
> +	*reg = virt_base + b->pctl_offset;
>  	*offset = pin - b->pin_base;
>  	if (bank)
>  		*bank = b;
> @@ -523,10 +527,12 @@ static void samsung_gpio_set_value(struct gpio_chip *gc,
>  {
>  	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
>  	const struct samsung_pin_bank_type *type = bank->type;
> +	void __iomem *virt_base = bank->eint_ext ?
> +		bank->drvdata->ext_base : bank->drvdata->virt_base;
>  	void __iomem *reg;
>  	u32 data;
>  
> -	reg = bank->drvdata->virt_base + bank->pctl_offset;
> +	reg = virt_base + bank->pctl_offset;
>  
>  	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
>  	data &= ~(1 << offset);
> @@ -553,8 +559,10 @@ static int samsung_gpio_get(struct gpio_chip *gc, unsigned offset)
>  	u32 data;
>  	struct samsung_pin_bank *bank = gpiochip_get_data(gc);
>  	const struct samsung_pin_bank_type *type = bank->type;
> +	void __iomem *virt_base = bank->eint_ext ?
> +		bank->drvdata->ext_base : bank->drvdata->virt_base;
>  
> -	reg = bank->drvdata->virt_base + bank->pctl_offset;
> +	reg = virt_base + bank->pctl_offset;
>  
>  	data = readl(reg + type->reg_offset[PINCFG_TYPE_DAT]);
>  	data >>= offset;
> @@ -574,6 +582,7 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
>  	const struct samsung_pin_bank_type *type;
>  	struct samsung_pin_bank *bank;
>  	struct samsung_pinctrl_drv_data *drvdata;
> +	void __iomem *virt_base;
>  	void __iomem *reg;
>  	u32 data, mask, shift;
>  
> @@ -581,7 +590,8 @@ static int samsung_gpio_set_direction(struct gpio_chip *gc,
>  	type = bank->type;
>  	drvdata = bank->drvdata;
>  
> -	reg = drvdata->virt_base + bank->pctl_offset +
> +	virt_base = bank->eint_ext ? drvdata->ext_base : drvdata->virt_base;
> +	reg = virt_base + bank->pctl_offset +
>  					type->reg_offset[PINCFG_TYPE_FUNC];
>  
>  	mask = (1 << type->fld_width[PINCFG_TYPE_FUNC]) - 1;
> @@ -1007,6 +1017,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>  		bank->eint_type = bdata->eint_type;
>  		bank->eint_mask = bdata->eint_mask;
>  		bank->eint_offset = bdata->eint_offset;
> +		bank->eint_ext = bdata->eint_ext;
>  		bank->name = bdata->name;
>  
>  		spin_lock_init(&bank->slock);
> @@ -1065,6 +1076,14 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  	if (IS_ERR(drvdata->virt_base))
>  		return PTR_ERR(drvdata->virt_base);
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		drvdata->ext_base =
> +			devm_ioremap(dev, res->start, resource_size(res));
> +		if (!drvdata->ext_base)
> +			return -ENXIO;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (res)
>  		drvdata->irq = res->start;
> @@ -1102,16 +1121,20 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>  static void samsung_pinctrl_suspend_dev(
>  	struct samsung_pinctrl_drv_data *drvdata)
>  {
> -	void __iomem *virt_base = drvdata->virt_base;
> +	void __iomem *virt_base;
>  	int i;
>  
>  	for (i = 0; i < drvdata->nr_banks; i++) {
>  		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
> -		void __iomem *reg = virt_base + bank->pctl_offset;
> +		void __iomem *reg;
>  		const u8 *offs = bank->type->reg_offset;
>  		const u8 *widths = bank->type->fld_width;
>  		enum pincfg_type type;
>  
> +		virt_base = bank->eint_ext ?
> +			drvdata->ext_base : drvdata->virt_base;
> +		reg = virt_base + bank->pctl_offset;
> +
>  		/* Registers without a powerdown config aren't lost */
>  		if (!widths[PINCFG_TYPE_CON_PDN])
>  			continue;
> @@ -1148,7 +1171,7 @@ static void samsung_pinctrl_suspend_dev(
>   */
>  static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
>  {
> -	void __iomem *virt_base = drvdata->virt_base;
> +	void __iomem *virt_base;
>  	int i;
>  
>  	if (drvdata->resume)
> @@ -1156,11 +1179,15 @@ static void samsung_pinctrl_resume_dev(struct samsung_pinctrl_drv_data *drvdata)
>  
>  	for (i = 0; i < drvdata->nr_banks; i++) {
>  		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
> -		void __iomem *reg = virt_base + bank->pctl_offset;
> +		void __iomem *reg;
>  		const u8 *offs = bank->type->reg_offset;
>  		const u8 *widths = bank->type->fld_width;
>  		enum pincfg_type type;
>  
> +		virt_base = bank->eint_ext ?
> +			drvdata->ext_base : drvdata->virt_base;
> +		reg = virt_base + bank->pctl_offset;
> +
>  		/* Registers without a powerdown config aren't lost */
>  		if (!widths[PINCFG_TYPE_CON_PDN])
>  			continue;
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.h b/drivers/pinctrl/samsung/pinctrl-samsung.h
> index cd31bfaf62cb..3005135f4565 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.h
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.h
> @@ -131,6 +131,7 @@ struct samsung_pin_bank_data {
>  	enum eint_type	eint_type;
>  	u32		eint_mask;
>  	u32		eint_offset;
> +	bool		eint_ext;
>  	const char	*name;
>  };
>  
> @@ -163,6 +164,7 @@ struct samsung_pin_bank {
>  	enum eint_type	eint_type;
>  	u32		eint_mask;
>  	u32		eint_offset;
> +	bool		eint_ext;
>  	const char	*name;
>  
>  	u32		pin_base;
> @@ -201,6 +203,8 @@ struct samsung_pin_ctrl {
>   * struct samsung_pinctrl_drv_data: wrapper for holding driver data together.
>   * @node: global list node
>   * @virt_base: register base address of the controller.
> + * @ext_base: external register base address of the controller.
> + * @ext_base: external register base address of the controller.
>   * @dev: device instance representing the controller.
>   * @irq: interrpt number used by the controller to notify gpio interrupts.
>   * @ctrl: pin controller instance managed by the driver.
> @@ -216,6 +220,7 @@ struct samsung_pin_ctrl {
>  struct samsung_pinctrl_drv_data {
>  	struct list_head		node;
>  	void __iomem			*virt_base;
> +	void __iomem			*ext_base;
>  	struct device			*dev;
>  	int				irq;
>  
> 
