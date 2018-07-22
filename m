From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 22 Jul 2018 10:59:44 +0200
Subject: [PATCH v4 30/35] mtd: rawnand: qcom: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-31-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-31-miquel.raynal@bootlin.com>
Message-ID: <20180722105944.76a5941c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jul 2018 17:15:22 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

>  
> -static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
> -			       struct qcom_nand_host *host,
> -			       struct device_node *dn)
> +static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
> +					    struct qcom_nand_host *host,
> +					    struct device_node *dn)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
> @@ -2824,36 +2828,20 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
>  	chip->block_markbad	= qcom_nandc_block_markbad;
>  
>  	chip->controller = &nandc->controller;
> +	chip->controller->ops = &qcom_nandc_ops;

This assignment should be moved here [1].

Once fixed you can add

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>


[1]https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/mtd/nand/raw/qcom_nandc.c#L2574
