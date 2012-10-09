From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Oct 2012 13:59:24 +0200
Subject: [PATCH 05/11] fsmc: Implement ready/busy through gpio pin
In-Reply-To: <e455d98df0fba37e8b7ecd7e72d510a05f23d2ba.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <e455d98df0fba37e8b7ecd7e72d510a05f23d2ba.1349778821.git.vipin.kumar@st.com>
Message-ID: <20121009115924.GO12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:14 Tue 09 Oct     , Vipin Kumar wrote:
> The NAND devices have a ready/busy (active low) output which is connected to the
> FSMC controller FSMC_RnB pin
> 
> The CPU can work in following two ways
> * CPU keeps waiting for a ready response and it halts until it receives a ready
>   response from NAND device. This halts the ldr instruction in between and in
>   effect holds the CPU down for a number of cycles. During this period, CPU
>   can't even service interrupts. This behavior is enabled via WAIT_ON bit of
>   FSMC controller
> * CPU merely issues the command and does not wait for response. The NAND device
>   is later probed for being ready by reading the NAND_RnB signal
> 
> Until now, WAIT_ON was enabled by default. This patch implements reading the
> device ready state through a gpio. The gpio number is passed via DT and this
> patch also adds a corresponding binding for fsmc
> 
> Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
> ---
>  .../devicetree/bindings/mtd/fsmc-nand.txt          |  5 ++
>  drivers/mtd/nand/fsmc_nand.c                       | 54 +++++++++++++++++++---
>  include/linux/mtd/fsmc.h                           | 11 +++++
>  3 files changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> index 6a7fc43..598bca2 100644
> --- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> @@ -25,6 +25,11 @@ Optional properties:
>    period of hclk ie a number 4 in thold with hclk = 166MHz means that
>    thold = (1000 / 166) * 4 ns = 24.09ns
>  
> +- st,ready-busy: Should contain either of "rb-gpio" or "rb-wait". When
> +  this property is not defined, the default is to use rb-wait.
> +- st,rb-gpios: When the st,ready-busy is defined as "rb-gpio", a gpio
> +  pin number is defined in this property
> +
>  Example:
>  
>  	fsmc: flash at d1800000 {
> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> index f3d69b3..eaffd3b 100644
> --- a/drivers/mtd/nand/fsmc_nand.c
> +++ b/drivers/mtd/nand/fsmc_nand.c
> @@ -22,6 +22,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> +#include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/resource.h>
> @@ -32,6 +33,7 @@
>  #include <linux/mtd/nand_ecc.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -289,6 +291,7 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
>   * @write_dma_chan:	DMA channel for write access to NAND
>   * @dma_access_complete: Completion structure
>   *
> + * @rb_pin:		Ready/Busy data
>   * @dev_timings:	Timings to be programmed in controller
>   * @partitions:		Partition info for a NAND Flash
>   * @nr_partitions:	Total number of partition of a NAND flash
> @@ -322,6 +325,7 @@ struct fsmc_nand_data {
>  	struct completion	dma_access_complete;
>  
>  	/* Recieved from plat data */
> +	struct fsmc_rbpin	*rbpin;
>  	struct fsmc_nand_timings *dev_timings;
>  	struct mtd_partition	*partitions;
>  	unsigned int		nr_partitions;
> @@ -410,12 +414,16 @@ static void fsmc_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
>   * This routine initializes timing parameters related to NAND memory access in
>   * FSMC registers
>   */
> -static void fsmc_nand_setup(void __iomem *regs, uint32_t bank,
> -			   uint32_t busw, struct fsmc_nand_timings *timings)
> +static void fsmc_nand_setup(void __iomem *regs, uint32_t bank, uint32_t busw,
> +			   struct fsmc_nand_timings *timings,
> +			   struct fsmc_rbpin *rbpin)
>  {
> -	uint32_t value = FSMC_DEVTYPE_NAND | FSMC_ENABLE | FSMC_WAITON;
> +	uint32_t value = FSMC_DEVTYPE_NAND | FSMC_ENABLE;
>  	uint32_t tclr, tar, thiz, thold, twait, tset;
>  
> +	if (!rbpin || (rbpin->use_pin == FSMC_RB_WAIT))
> +		value |= FSMC_WAITON;
> +
>  	tclr = (timings->tclr & FSMC_TCLR_MASK) << FSMC_TCLR_SHIFT;
>  	tar = (timings->tar & FSMC_TAR_MASK) << FSMC_TAR_SHIFT;
>  	thiz = (timings->thiz & FSMC_THIZ_MASK) << FSMC_THIZ_SHIFT;
> @@ -857,6 +865,14 @@ static bool filter(struct dma_chan *chan, void *slave)
>  	return true;
>  }
>  
> +static int fsmc_dev_ready(struct mtd_info *mtd)
> +{
> +	struct fsmc_nand_data *host = container_of(mtd,
> +					struct fsmc_nand_data, mtd);
> +
> +	return !!gpio_get_value(host->rbpin->gpio_pin);
> +}
> +
>  #ifdef CONFIG_OF
>  static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>  					       struct device_node *np)
> @@ -870,7 +886,9 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>  		.twait	= FSMC_TWAIT_6,
>  		.tset	= FSMC_TSET_0,
>  	};
> +	const char *rb;
>  	u32 val;
> +	enum of_gpio_flags flags;
>  
>  	/* Set default NAND width to 8 bits */
>  	pdata->width = 8;
> @@ -911,6 +929,14 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>  				sizeof(default_timings));
>  	}
>  
> +	if (!of_property_read_string(np, "st,ready-busy", &rb) &&
> +			!strcmp(rb, "rb-gpio")) {
> +		pdata->rbpin.use_pin = FSMC_RB_GPIO;
> +		pdata->rbpin.gpio_pin =
> +			of_get_named_gpio_flags(np, "st,rb-gpios", 0, &flags);
> +	} else
> +		pdata->rbpin.use_pin = FSMC_RB_WAIT;
> +
>  	return 0;
>  }
>  #else
> @@ -1049,6 +1075,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>  	host->nr_partitions = pdata->nr_partitions;
>  	host->dev = &pdev->dev;
>  	host->dev_timings = &pdata->nand_timings;
> +	host->rbpin = &pdata->rbpin;
> +
>  	host->mode = pdata->mode;
>  	host->max_banks = pdata->max_banks;
>  
> @@ -1074,6 +1102,18 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>  	nand->select_chip = fsmc_select_chip;
>  	nand->badblockbits = 7;
>  
> +	if (host->rbpin->use_pin != FSMC_RB_WAIT)
> +		nand->dev_ready = fsmc_dev_ready;
> +
> +	if (host->rbpin->use_pin == FSMC_RB_GPIO) {
> +		ret = gpio_request(host->rbpin->gpio_pin, "fsmc-rb");
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "gpio request fail: %d\n",
> +					host->rbpin->gpio_pin);
> +			goto err_gpio_req;
> +		}
> +	}
> +
>  	if (pdata->width == FSMC_NAND_BW16)
>  		nand->options |= NAND_BUSWIDTH_16;
>  
> @@ -1107,7 +1147,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>  	for (bank = 0; bank < host->max_banks; bank++)
>  		fsmc_nand_setup(host->regs_va, bank,
>  				nand->options & NAND_BUSWIDTH_16,
> -				host->dev_timings);
> +				host->dev_timings, host->rbpin);
>  
>  	if (AMBA_REV_BITS(host->pid) >= 8) {
>  		nand->ecc.read_page = fsmc_read_page_hwecc;
> @@ -1211,6 +1251,9 @@ err_req_write_chnl:
>  	if (host->mode == USE_DMA_ACCESS)
>  		dma_release_channel(host->read_dma_chan);
>  err_req_read_chnl:
> +	if (host->rbpin->use_pin == FSMC_RB_GPIO)
> +		gpio_free(host->rbpin->gpio_pin);
> +err_gpio_req:
>  	clk_disable_unprepare(host->clk);
>  err_clk_prepare_enable:
>  	clk_put(host->clk);
> @@ -1260,8 +1303,7 @@ static int fsmc_nand_resume(struct device *dev)
>  		for (bank = 0; bank < host->max_banks; bank++)
>  			fsmc_nand_setup(host->regs_va, bank,
>  					host->nand.options & NAND_BUSWIDTH_16,
> -					host->dev_timings);
> -
> +					host->dev_timings, host->rbpin);
>  	}
>  	return 0;
>  }
> diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
> index 4fbdce4..eed22a1 100644
> --- a/include/linux/mtd/fsmc.h
> +++ b/include/linux/mtd/fsmc.h
> @@ -130,6 +130,16 @@ struct fsmc_nand_timings {
>  	uint8_t tset;
>  };
>  
> +enum rbpin {
> +	FSMC_RB_WAIT = 0,
> +	FSMC_RB_GPIO,
> +};
> +
> +struct fsmc_rbpin {
> +	enum rbpin	use_pin;
> +	uint32_t	gpio_pin;
> +};
> +
>  enum access_mode {
>  	USE_DMA_ACCESS = 1,
>  	USE_WORD_ACCESS,
> @@ -149,6 +159,7 @@ enum access_mode {
>   */
>  struct fsmc_nand_platform_data {
>  	struct fsmc_nand_timings nand_timings;
> +	struct fsmc_rbpin	rbpin;
do more simple
	int 			rbpin;

	and set it as -EINVAL to use RB_WAIT

so in the binding if you do not specifcy a gpio or a valid one we switch to
wait

Best Regards,
J.
