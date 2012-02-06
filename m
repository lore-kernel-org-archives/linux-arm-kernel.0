From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Feb 2012 17:39:50 +0000
Subject: [PATCH 2/2] misc: c2c: Add C2C(Chip to Chip) device driver for
 EXYNOS
In-Reply-To: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
References: <000601cce315$18c82510$4a586f30$%lee@samsung.com>
Message-ID: <20120206173950.GA17927@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2012 at 05:15:03PM +0900, Kisang Lee wrote:
> Cc: Arnd Bergmann <arnd <at> arndb.de>
> Cc: Greg Kroah-Hartman <greg <at> kroah.com>
> 
> Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>

What is a chip to chip driver?  It looks like there is some overlap with
the remoteproc work that Ohad Ben-Cohen has been doing, or I think there
was also some work for communicating with things like basebands?
Perhaps even UIO?

> +		if (opp_val == C2C_OPP100)
> +			req_clk = c2c_con.clk_opp100;
> +		else if (opp_val == C2C_OPP50)
> +			req_clk = c2c_con.clk_opp50;
> +		else if (opp_val == C2C_OPP25)
> +			req_clk = c2c_con.clk_opp25;

This looks like a switch statement.

> +		dev_info(c2c_con.c2c_dev, "Get C2C sclk rate : %ld\n",
> +					clk_get_rate(c2c_con.c2c_sclk));
> +		dev_info(c2c_con.c2c_dev, "Get C2C aclk rate : %ld\n",
> +					clk_get_rate(c2c_con.c2c_aclk));
> +		break;
> +	default:
> +		dev_info(c2c_con.c2c_dev, "---C2C Operation Number---\n");
> +		dev_info(c2c_con.c2c_dev, "1. C2C Reset\n");
> +		dev_info(c2c_con.c2c_dev, "2. Set OPP25\n");
> +		dev_info(c2c_con.c2c_dev, "3. Set OPP50\n");
> +		dev_info(c2c_con.c2c_dev, "4. Set OPP100\n");

These log messages probably shouldn't be in.

> +static irqreturn_t c2c_sscm0_irq(int irq, void *data)
> +{
> +	/* Nothing here yet */
> +	return IRQ_HANDLED;
> +}

This doesn't look terribly clever - if the interrupt has been asserted
and we don't do anything to handle it won't we end up spinning for ever
with repeated calls to the interrupt handler?

> +		if (opp_val == C2C_OPP100)
> +			req_clk = c2c_con.clk_opp100;
> +		else if (opp_val == C2C_OPP50)
> +			req_clk = c2c_con.clk_opp50;
> +		else if (opp_val == C2C_OPP25)
> +			req_clk = c2c_con.clk_opp25;

This and the surrounding code looks a lot like the code I commented on
above - shouldn't this be factored out into a single function called
from both places?

> +	/* resource for AP's SSCM region */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no memory resource defined(AP's SSCM)\n");
> +		return -ENOENT;
> +	}

devm_requets_and_ioremap() perhaps?

> +#ifdef CONFIG_PM
> +static int samsung_c2c_suspend(struct platform_device *dev, pm_message_t pm)
> +{
> +	/* Nothing here yet */
> +	return 0;
> +}
> +
> +static int samsung_c2c_resume(struct platform_device *dev)
> +{
> +	/* Nothing here yet */
> +	return 0;
> +}
> +#else
> +#define samsung_c2c_suspend NULL
> +#define samsung_c2c_resume NULL
> +#endif

No need to include this if it doesn't do anything.

> +static struct platform_driver samsung_c2c_driver = {
> +	.probe		= samsung_c2c_probe,
> +	.remove		= __devexit_p(samsung_c2c_remove),
> +	.suspend	= samsung_c2c_suspend,
> +	.resume		= samsung_c2c_resume,

If you were including pm operations they should be in the pm_ops rather
than using the platform-specific variants - this makes it easier to do
things like runtime PM later.

> +static int __init samsung_c2c_init(void)
> +{
> +	return platform_driver_register(&samsung_c2c_driver);
> +}
> +module_init(samsung_c2c_init);

module_platform_driver().
