From: varkabhadram@gmail.com (Varka Bhadram)
Date: Mon, 20 Oct 2014 17:31:51 +0530
Subject: [PATCH v6 1/2] mtd: nand: add sunxi NAND flash controller support
In-Reply-To: <1413805520-14947-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1413805520-14947-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413805520-14947-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5444F9AF.5000104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 05:15 PM, Boris Brezillon wrote:
> Add support for the sunxi NAND Flash Controller (NFC).
>
(...)

> +
> +static int sunxi_nfc_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd->priv;
> +	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
> +	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
> +	struct sunxi_nand_rb *rb;
> +	unsigned long timeo = (sunxi_nand->nand.state == FL_ERASING ? 400 : 20);
> +	int ret;
> +
> +	if (sunxi_nand->selected < 0)
> +		return 0;
> +
> +	rb = &sunxi_nand->sels[sunxi_nand->selected].rb;
> +
> +	switch (rb->type) {
> +	case RB_NATIVE:
> +		ret = !!(readl(nfc->regs + NFC_REG_ST) &
> +			 (NFC_RB_STATE0 << rb->info.nativeid));
> +		if (ret)
> +			break;
> +
> +		sunxi_nfc_wait_int(nfc, NFC_RB_B2R, timeo);
> +		ret = !!(readl(nfc->regs + NFC_REG_ST) &
> +			 (NFC_RB_STATE0 << rb->info.nativeid));
> +		break;
> +	case RB_GPIO:
> +		ret = gpio_get_value(rb->info.gpio);
> +		break;
> +	case RB_NONE:
> +	default:
> +		ret = 0;
> +		pr_err("cannot check R/B NAND status!");

Missed terminating  new line...  :-)

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +

(...)

> +static struct platform_driver sunxi_nfc_driver = {
> +	.driver = {
> +		.name = "sunxi_nand",
> +		.owner = THIS_MODULE,

This field updated by module_platform_driver()..

> +		.of_match_table = sunxi_nfc_ids,
> +	},
> +	.probe = sunxi_nfc_probe,
> +	.remove = sunxi_nfc_remove,
> +};
> +module_platform_driver(sunxi_nfc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Boris BREZILLON");
> +MODULE_DESCRIPTION("Allwinner NAND Flash Controller driver");
> +MODULE_ALIAS("platform:sunxi_nand");

-- 
Regards,
Varka Bhadram.
