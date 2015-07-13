From: joshc@ni.com (Josh Cartwright)
Date: Mon, 13 Jul 2015 12:37:39 -0500
Subject: [PATCH v3 1/2] rtc: add rtc-lpc24xx driver
In-Reply-To: <1436635730-15617-2-git-send-email-manabian@gmail.com>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <1436635730-15617-2-git-send-email-manabian@gmail.com>
Message-ID: <20150713173739.GF25028@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 11, 2015 at 07:28:49PM +0200, Joachim Eastwood wrote:
> Add driver for the RTC found on NXP LPC178x/18xx/408x/43xx devices.
> The RTC provides calendar and clock functionality together with
> alarm interrupt support.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
[..]
> +static int lpc24xx_rtc_remove(struct platform_device *pdev)
> +{
> +	struct lpc24xx_rtc *rtc = platform_get_drvdata(pdev);
> +
> +	/* Ensure all interrupt sources are masked */
> +	rtc_writel(rtc, LPC24XX_AMR, LPC24XX_ALARM_DISABLE);
> +	rtc_writel(rtc, LPC24XX_CIIR, 0);
> +
> +	rtc_writel(rtc, LPC24XX_CCR, LPC178X_CCALEN);
> +
> +	clk_disable_unprepare(rtc->clk_rtc);
> +	clk_disable_unprepare(rtc->clk_reg);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lpc24xx_rtc_match[] = {
> +	{ .compatible = "nxp,lpc1788-rtc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
> +
> +static struct platform_driver lpc24xx_rtc_driver = {
> +	.probe	= lpc24xx_rtc_probe,
> +	.remove	= lpc24xx_rtc_remove,
> +	.driver	= {
> +		.name = "lpc24xx-rtc",
> +		.of_match_table	= lpc24xx_rtc_match,
> +	},
> +};
> +module_platform_driver(lpc24xx_rtc_driver);
> +
> +MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com");

Missing closing '>'.

Otherwise,

Reviewed-by: Josh Cartwright <joshc@ni.com>

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150713/a7b93098/attachment-0001.sig>
