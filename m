From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jun 2015 09:17:37 +0800
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-1-git-send-email-tharvey@gateworks.com>
 <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
Message-ID: <20150629011737.GG10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 01:15:59PM -0700, Tim Harvey wrote:
> @@ -90,6 +92,11 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
>  	struct imx2_wdt_device *wdev = container_of(this,
>  						    struct imx2_wdt_device,
>  						    restart_handler);
> +
> +	/* Use external reset */
> +	if (wdev->ext_reset)
> +		wcr_enable |= IMX2_WDT_WCR_SRS;
> +

The existing code simply writes the register with only WDE (Watchdog
Enable) bit set.  That said, bit WDA and SRS are cleared at the same
time.  What's the result of that?  Both internal reset and external
reset will be asserted?  If this is the case, it's unsafe per your reply
to Frank's comment, right?  So we should only clear one bit between
these two based on ext_reset flag to avoid asserting both internal and
external reset?

Shawn

>  	/* Assert SRS signal */
>  	regmap_write(wdev->regmap, 0, wcr_enable);
>  	/*
