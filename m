From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jun 2012 16:38:41 +0300
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338974414-5308-1-git-send-email-stigge@antcom.de>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
Message-ID: <1338989921.6875.50.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 11:20 +0200, Roland Stigge wrote:
> +#ifdef CONFIG_PM
> +static int lpc32xx_nand_resume(struct platform_device *pdev)
> +{
> +	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
> +
> +	/* Re-enable NAND clock */
> +	clk_enable(host->clk);
> +
> +	/* Fresh init of NAND controller */
> +	lpc32xx_nand_setup(host);
> +
> +	/* Disable write protect */
> +	lpc32xx_wp_disable(host);
> +
> +	return 0;
> +}
> +
> +static int lpc32xx_nand_suspend(struct platform_device *pdev, pm_message_t pm)
> +{
> +	u32 tmp;
> +	struct lpc32xx_nand_host *host = platform_get_drvdata(pdev);
> +
> +	/* Force CE high */
> +	tmp = readl(SLC_CTRL(host->io_base));
> +	tmp &= ~SLCCFG_CE_LOW;
> +	writel(tmp, SLC_CTRL(host->io_base));
> +
> +	/* Enable write protect for safety */
> +	lpc32xx_wp_enable(host);
> +
> +	/* Disable clock */
> +	clk_disable(host->clk);
> +
> +	return 0;
> +}
> +
> +#else
> +#define lpc32xx_nand_resume NULL
> +#define lpc32xx_nand_suspend NULL
> +#endif

0, not NULL.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/7e9ba702/attachment.sig>
