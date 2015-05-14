From: joshc@ni.com (Josh Cartwright)
Date: Thu, 14 May 2015 13:19:53 -0500
Subject: [PATCH 1/2] rtc: add rtc-lpc24xx driver
In-Reply-To: <1431624875-20990-2-git-send-email-manabian@gmail.com>
References: <1431624875-20990-1-git-send-email-manabian@gmail.com>
 <1431624875-20990-2-git-send-email-manabian@gmail.com>
Message-ID: <20150514181953.GC23600@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

Just a quick comment/question below.

On Thu, May 14, 2015 at 07:34:34PM +0200, Joachim Eastwood wrote:
> Add driver for the RTC found on NXP LPC24xx/178x/18xx/43xx devices.
> The RTC provides calendar and clock functionality together with
> periodic tick and alarm interrupt support.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
[..]
> +
> +static const struct of_device_id lpc24xx_rtc_match[] = {
> +	{ .compatible = "nxp,lpc1788-rtc", .data = (void *)HAVE_CALIBRATION},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lpc24xx_rtc_match);
> +
> +static int lpc24xx_rtc_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct lpc24xx_rtc *rtc;
> +	struct resource *res;
> +	u32 rtc_ccr = 0;
> +	int irq, ret;
> +
[..]
> +
> +	/* Clear the counter increment state */
> +	rtc_writel(rtc, LPC24XX_ILR, LPC24XX_RTCCIF);
> +
> +	if (rtc->features & HAVE_PRESCALER) {
> +		/* Clock source is 32k oscillator */
> +		rtc_ccr = LPC24XX_CLKSRC;
> +		rtc_writel(rtc, LPC24XX_CCR, rtc_ccr);
> +
> +		/* Set prescaler to divide by 1 */
> +		rtc_writel(rtc, LPC24XX_PREINT, 0);
> +		rtc_writel(rtc, LPC24XX_PREFRAC, 0);
> +	}
> +
> +	if (rtc->features & HAVE_SUBSECOND) {
> +		/* Disable sub-second interrupt */
> +		rtc_writel(rtc, LPC24XX_CISS, 0);
> +	}

Neither HAVE_PRESCALER, nor HAVE_SUBSECOND are used for the claimed
supported RTC, so this is effectively dead code.  Was this something you
intended to add later?  Some remnant of the rework?

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/7011b7fc/attachment.sig>
