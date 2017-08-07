From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Aug 2017 16:40:49 +0100
Subject: [PATCH v2 2/3] mfd: syscon: atmel-smc: add helper to retrieve
 register layout
In-Reply-To: <20170718132220.25018-3-ludovic.desroches@microchip.com>
References: <20170718132220.25018-1-ludovic.desroches@microchip.com>
 <20170718132220.25018-3-ludovic.desroches@microchip.com>
Message-ID: <20170807154049.epfwvqa5pwvoyu7x@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jul 2017, Ludovic Desroches wrote:

> For HSMC controller, the register layout depends on the device i.e. the
> offset of setup, pulse, cycle, mode and timings registers is not the
> same. An helper is added to provide the correct register layout.
> 
> Fixes: fe9d7cb22ef3 ("mfd: syscon: atmel-smc: Add new helpers to ease
> SMC regs manipulation")
> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/memory/atmel-ebi.c               | 13 +++++--
>  drivers/mfd/atmel-smc.c                  | 67 +++++++++++++++++++++++++-------
>  drivers/mtd/nand/atmel/nand-controller.c | 10 +++--
>  include/linux/mfd/syscon/atmel-smc.h     | 32 ++++++++++-----
>  4 files changed, 92 insertions(+), 30 deletions(-)

Applied, thanks.

> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index 99e644cda4d1..63c9e7a76854 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -51,6 +51,7 @@ struct atmel_ebi {
>  	struct  {
>  		struct regmap *regmap;
>  		struct clk *clk;
> +		const struct atmel_hsmc_reg_layout *layout;
>  	} smc;
>  
>  	struct device *dev;
> @@ -84,8 +85,8 @@ static void at91sam9_ebi_get_config(struct atmel_ebi_dev *ebid,
>  static void sama5_ebi_get_config(struct atmel_ebi_dev *ebid,
>  				 struct atmel_ebi_dev_config *conf)
>  {
> -	atmel_hsmc_cs_conf_get(ebid->ebi->smc.regmap, conf->cs,
> -			       &conf->smcconf);
> +	atmel_hsmc_cs_conf_get(ebid->ebi->smc.regmap, ebid->ebi->smc.layout,
> +			       conf->cs, &conf->smcconf);
>  }
>  
>  static const struct atmel_smc_timing_xlate timings_xlate_table[] = {
> @@ -285,8 +286,8 @@ static void at91sam9_ebi_apply_config(struct atmel_ebi_dev *ebid,
>  static void sama5_ebi_apply_config(struct atmel_ebi_dev *ebid,
>  				   struct atmel_ebi_dev_config *conf)
>  {
> -	atmel_hsmc_cs_conf_apply(ebid->ebi->smc.regmap, conf->cs,
> -				 &conf->smcconf);
> +	atmel_hsmc_cs_conf_apply(ebid->ebi->smc.regmap, ebid->ebi->smc.layout,
> +				 conf->cs, &conf->smcconf);
>  }
>  
>  static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
> @@ -525,6 +526,10 @@ static int atmel_ebi_probe(struct platform_device *pdev)
>  	if (IS_ERR(ebi->smc.regmap))
>  		return PTR_ERR(ebi->smc.regmap);
>  
> +	ebi->smc.layout = atmel_hsmc_get_reg_layout(smc_np);
> +	if (IS_ERR(ebi->smc.layout))
> +		return PTR_ERR(ebi->smc.layout);
> +
>  	ebi->smc.clk = of_clk_get(smc_np, 0);
>  	if (IS_ERR(ebi->smc.clk)) {
>  		if (PTR_ERR(ebi->smc.clk) != -ENOENT)
> diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
> index 954cf0f66a31..4d34b22f859b 100644
> --- a/drivers/mfd/atmel-smc.c
> +++ b/drivers/mfd/atmel-smc.c
> @@ -258,19 +258,21 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_apply);
>   * atmel_hsmc_cs_conf_apply - apply an SMC CS conf
>   * @regmap: the HSMC regmap
>   * @cs: the CS id
> + * @layout: the layout of registers
>   * @conf the SMC CS conf to apply
>   *
>   * Applies an SMC CS configuration.
>   * Only valid on post-sama5 SoCs.
>   */
> -void atmel_hsmc_cs_conf_apply(struct regmap *regmap, int cs,
> -			      const struct atmel_smc_cs_conf *conf)
> +void atmel_hsmc_cs_conf_apply(struct regmap *regmap,
> +			      const struct atmel_hsmc_reg_layout *layout,
> +			      int cs, const struct atmel_smc_cs_conf *conf)
>  {
> -	regmap_write(regmap, ATMEL_HSMC_SETUP(cs), conf->setup);
> -	regmap_write(regmap, ATMEL_HSMC_PULSE(cs), conf->pulse);
> -	regmap_write(regmap, ATMEL_HSMC_CYCLE(cs), conf->cycle);
> -	regmap_write(regmap, ATMEL_HSMC_TIMINGS(cs), conf->timings);
> -	regmap_write(regmap, ATMEL_HSMC_MODE(cs), conf->mode);
> +	regmap_write(regmap, ATMEL_HSMC_SETUP(layout, cs), conf->setup);
> +	regmap_write(regmap, ATMEL_HSMC_PULSE(layout, cs), conf->pulse);
> +	regmap_write(regmap, ATMEL_HSMC_CYCLE(layout, cs), conf->cycle);
> +	regmap_write(regmap, ATMEL_HSMC_TIMINGS(layout, cs), conf->timings);
> +	regmap_write(regmap, ATMEL_HSMC_MODE(layout, cs), conf->mode);
>  }
>  EXPORT_SYMBOL_GPL(atmel_hsmc_cs_conf_apply);
>  
> @@ -297,18 +299,55 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_get);
>   * atmel_hsmc_cs_conf_get - retrieve the current SMC CS conf
>   * @regmap: the HSMC regmap
>   * @cs: the CS id
> + * @layout: the layout of registers
>   * @conf: the SMC CS conf object to store the current conf
>   *
>   * Retrieve the SMC CS configuration.
>   * Only valid on post-sama5 SoCs.
>   */
> -void atmel_hsmc_cs_conf_get(struct regmap *regmap, int cs,
> -			    struct atmel_smc_cs_conf *conf)
> +void atmel_hsmc_cs_conf_get(struct regmap *regmap,
> +			    const struct atmel_hsmc_reg_layout *layout,
> +			    int cs, struct atmel_smc_cs_conf *conf)
>  {
> -	regmap_read(regmap, ATMEL_HSMC_SETUP(cs), &conf->setup);
> -	regmap_read(regmap, ATMEL_HSMC_PULSE(cs), &conf->pulse);
> -	regmap_read(regmap, ATMEL_HSMC_CYCLE(cs), &conf->cycle);
> -	regmap_read(regmap, ATMEL_HSMC_TIMINGS(cs), &conf->timings);
> -	regmap_read(regmap, ATMEL_HSMC_MODE(cs), &conf->mode);
> +	regmap_read(regmap, ATMEL_HSMC_SETUP(layout, cs), &conf->setup);
> +	regmap_read(regmap, ATMEL_HSMC_PULSE(layout, cs), &conf->pulse);
> +	regmap_read(regmap, ATMEL_HSMC_CYCLE(layout, cs), &conf->cycle);
> +	regmap_read(regmap, ATMEL_HSMC_TIMINGS(layout, cs), &conf->timings);
> +	regmap_read(regmap, ATMEL_HSMC_MODE(layout, cs), &conf->mode);
>  }
>  EXPORT_SYMBOL_GPL(atmel_hsmc_cs_conf_get);
> +
> +static const struct atmel_hsmc_reg_layout sama5d3_reg_layout = {
> +	.timing_regs_offset = 0x600,
> +};
> +
> +static const struct atmel_hsmc_reg_layout sama5d2_reg_layout = {
> +	.timing_regs_offset = 0x700,
> +};
> +
> +static const struct of_device_id atmel_smc_ids[] = {
> +	{ .compatible = "atmel,at91sam9260-smc", .data = NULL },
> +	{ .compatible = "atmel,sama5d3-smc", .data = &sama5d3_reg_layout },
> +	{ .compatible = "atmel,sama5d2-smc", .data = &sama5d2_reg_layout },
> +	{ /* sentinel */ },
> +};
> +
> +/**
> + * atmel_hsmc_get_reg_layout - retrieve the layout of HSMC registers
> + * @np: the HSMC regmap
> + *
> + * Retrieve the layout of HSMC registers.
> + *
> + * Returns NULL in case of SMC, a struct atmel_hsmc_reg_layout pointer
> + * in HSMC case, otherwise ERR_PTR(-EINVAL).
> + */
> +const struct atmel_hsmc_reg_layout *
> +atmel_hsmc_get_reg_layout(struct device_node *np)
> +{
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(atmel_smc_ids, np);
> +
> +	return match ? match->data : ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(atmel_hsmc_get_reg_layout);
> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> index d922a88e407f..29396e618965 100644
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -247,6 +247,7 @@ struct atmel_hsmc_nand_controller {
>  		void __iomem *virt;
>  		dma_addr_t dma;
>  	} sram;
> +	const struct atmel_hsmc_reg_layout *hsmc_layout;
>  	struct regmap *io;
>  	struct atmel_nfc_op op;
>  	struct completion complete;
> @@ -1431,12 +1432,12 @@ static int atmel_hsmc_nand_setup_data_interface(struct atmel_nand *nand,
>  					int csline,
>  					const struct nand_data_interface *conf)
>  {
> -	struct atmel_nand_controller *nc;
> +	struct atmel_hsmc_nand_controller *nc;
>  	struct atmel_smc_cs_conf smcconf;
>  	struct atmel_nand_cs *cs;
>  	int ret;
>  
> -	nc = to_nand_controller(nand->base.controller);
> +	nc = to_hsmc_nand_controller(nand->base.controller);
>  
>  	ret = atmel_smc_nand_prepare_smcconf(nand, conf, &smcconf);
>  	if (ret)
> @@ -1451,7 +1452,8 @@ static int atmel_hsmc_nand_setup_data_interface(struct atmel_nand *nand,
>  	if (cs->rb.type == ATMEL_NAND_NATIVE_RB)
>  		cs->smcconf.timings |= ATMEL_HSMC_TIMINGS_RBNSEL(cs->rb.id);
>  
> -	atmel_hsmc_cs_conf_apply(nc->smc, cs->id, &cs->smcconf);
> +	atmel_hsmc_cs_conf_apply(nc->base.smc, nc->hsmc_layout, cs->id,
> +				 &cs->smcconf);
>  
>  	return 0;
>  }
> @@ -2166,6 +2168,8 @@ atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc)
>  		return -EINVAL;
>  	}
>  
> +	nc->hsmc_layout = atmel_hsmc_get_reg_layout(np);
> +
>  	nc->irq = of_irq_get(np, 0);
>  	of_node_put(np);
>  	if (nc->irq < 0) {
> diff --git a/include/linux/mfd/syscon/atmel-smc.h b/include/linux/mfd/syscon/atmel-smc.h
> index afa266169800..7a367f34b66a 100644
> --- a/include/linux/mfd/syscon/atmel-smc.h
> +++ b/include/linux/mfd/syscon/atmel-smc.h
> @@ -15,21 +15,26 @@
>  #define _LINUX_MFD_SYSCON_ATMEL_SMC_H_
>  
>  #include <linux/kernel.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  
>  #define ATMEL_SMC_SETUP(cs)			(((cs) * 0x10))
> -#define ATMEL_HSMC_SETUP(cs)			(0x600 + ((cs) * 0x14))
> +#define ATMEL_HSMC_SETUP(layout, cs)		\
> +	((layout)->timing_regs_offset + ((cs) * 0x14))
>  #define ATMEL_SMC_PULSE(cs)			(((cs) * 0x10) + 0x4)
> -#define ATMEL_HSMC_PULSE(cs)			(0x600 + ((cs) * 0x14) + 0x4)
> +#define ATMEL_HSMC_PULSE(layout, cs)		\
> +	((layout)->timing_regs_offset + ((cs) * 0x14) + 0x4)
>  #define ATMEL_SMC_CYCLE(cs)			(((cs) * 0x10) + 0x8)
> -#define ATMEL_HSMC_CYCLE(cs)			(0x600 + ((cs) * 0x14) + 0x8)
> +#define ATMEL_HSMC_CYCLE(layout, cs)			\
> +	((layout)->timing_regs_offset + ((cs) * 0x14) + 0x8)
>  #define ATMEL_SMC_NWE_SHIFT			0
>  #define ATMEL_SMC_NCS_WR_SHIFT			8
>  #define ATMEL_SMC_NRD_SHIFT			16
>  #define ATMEL_SMC_NCS_RD_SHIFT			24
>  
>  #define ATMEL_SMC_MODE(cs)			(((cs) * 0x10) + 0xc)
> -#define ATMEL_HSMC_MODE(cs)			(0x600 + ((cs) * 0x14) + 0x10)
> +#define ATMEL_HSMC_MODE(layout, cs)			\
> +	((layout)->timing_regs_offset + ((cs) * 0x14) + 0x10)
>  #define ATMEL_SMC_MODE_READMODE_MASK		BIT(0)
>  #define ATMEL_SMC_MODE_READMODE_NCS		(0 << 0)
>  #define ATMEL_SMC_MODE_READMODE_NRD		(1 << 0)
> @@ -59,7 +64,8 @@
>  #define ATMEL_SMC_MODE_PS_16			(2 << 28)
>  #define ATMEL_SMC_MODE_PS_32			(3 << 28)
>  
> -#define ATMEL_HSMC_TIMINGS(cs)			(0x600 + ((cs) * 0x14) + 0xc)
> +#define ATMEL_HSMC_TIMINGS(layout, cs)			\
> +	((layout)->timing_regs_offset + ((cs) * 0x14) + 0xc)
>  #define ATMEL_HSMC_TIMINGS_OCMS			BIT(12)
>  #define ATMEL_HSMC_TIMINGS_RBNSEL(x)		((x) << 28)
>  #define ATMEL_HSMC_TIMINGS_NFSEL		BIT(31)
> @@ -69,6 +75,10 @@
>  #define ATMEL_HSMC_TIMINGS_TRR_SHIFT		16
>  #define ATMEL_HSMC_TIMINGS_TWB_SHIFT		24
>  
> +struct atmel_hsmc_reg_layout {
> +	unsigned int timing_regs_offset;
> +};
> +
>  /**
>   * struct atmel_smc_cs_conf - SMC CS config as described in the datasheet.
>   * @setup: NCS/NWE/NRD setup timings (not applicable to at91rm9200)
> @@ -98,11 +108,15 @@ int atmel_smc_cs_conf_set_cycle(struct atmel_smc_cs_conf *conf,
>  				unsigned int shift, unsigned int ncycles);
>  void atmel_smc_cs_conf_apply(struct regmap *regmap, int cs,
>  			     const struct atmel_smc_cs_conf *conf);
> -void atmel_hsmc_cs_conf_apply(struct regmap *regmap, int cs,
> -			      const struct atmel_smc_cs_conf *conf);
> +void atmel_hsmc_cs_conf_apply(struct regmap *regmap,
> +			      const struct atmel_hsmc_reg_layout *reglayout,
> +			      int cs, const struct atmel_smc_cs_conf *conf);
>  void atmel_smc_cs_conf_get(struct regmap *regmap, int cs,
>  			   struct atmel_smc_cs_conf *conf);
> -void atmel_hsmc_cs_conf_get(struct regmap *regmap, int cs,
> -			    struct atmel_smc_cs_conf *conf);
> +void atmel_hsmc_cs_conf_get(struct regmap *regmap,
> +			    const struct atmel_hsmc_reg_layout *reglayout,
> +			    int cs, struct atmel_smc_cs_conf *conf);
> +const struct atmel_hsmc_reg_layout *
> +atmel_hsmc_get_reg_layout(struct device_node *np);
>  
>  #endif /* _LINUX_MFD_SYSCON_ATMEL_SMC_H_ */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
