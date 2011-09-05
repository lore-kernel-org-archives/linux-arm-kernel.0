From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 5 Sep 2011 17:17:52 +0200
Subject: [PATCH v11 1/3] MTD : add the common code for GPMI-NAND
	controller driver
In-Reply-To: <1314616381-11615-2-git-send-email-b32955@freescale.com>
References: <1314616381-11615-1-git-send-email-b32955@freescale.com>
	<1314616381-11615-2-git-send-email-b32955@freescale.com>
Message-ID: <20110905151752.GA10987@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 07:12:59PM +0800, Huang Shijie wrote:
> These files contain the common code for the GPMI-NAND driver.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Tested-by: Koen Beel <koen.beel@barco.com>

...

> +static int __devinit
> +acquire_register_block(struct gpmi_nand_data *this, const char *res_name)
> +{
> +	struct platform_device *pdev = this->pdev;
> +	struct resources *res = &this->resources;
> +	struct resource *r;
> +	void *p;
> +
> +	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
> +	if (!r) {
> +		pr_err("Can't get resource for %s\n", res_name);
> +		return -ENXIO;
> +	}
> +
> +	p = ioremap(r->start, resource_size(r));
> +	if (!p) {
> +		pr_err("Can't remap %s\n", res_name);
> +		return -ENOMEM;
> +	}
> +
> +	if (res_name == GPMI_NAND_GPMI_REGS_ADDR_RES_NAME)
> +		res->gpmi_regs = p;
> +	else if (res_name == GPMI_NAND_BCH_REGS_ADDR_RES_NAME)
> +		res->bch_regs = p;

Am I the only one getting warnings here?

drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'acquire_register_block':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:345:15: warning: comparison with string literal results in unspecified behavior
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:347:20: warning: comparison with string literal results in unspecified behavior

Really worth fixing IMHO...

> +	else
> +		BUG();

dev_err + ENODEV?

Might be worth checking the other BUG()-occurences as well if they really need
to halt the kernel.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110905/1b9a6723/attachment.sig>
