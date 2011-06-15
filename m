From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 15 Jun 2011 18:33:45 +0800
Subject: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
	write_protect support for mx5
In-Reply-To: <20110614130610.GH30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
	<1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
	<20110614095129.GD5043@pengutronix.de>
	<20110614130610.GH30295@S2100-06.ap.freescale.net>
Message-ID: <20110615103344.GA3579@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 09:06:11PM +0800, Shawn Guo wrote:
[...]
> > >  
> > > +static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
> > > +{
> > > +	struct esdhc_platform_data *boarddata =
> > > +			host->mmc->parent->platform_data;
> > > +
> > > +	if (gpio_is_valid(boarddata->wp_gpio))
> > > +		return gpio_get_value(boarddata->wp_gpio);
> > > +	else
> > > +		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
> > > +				SDHCI_WRITE_PROTECT);
> > > +}
> > 
> > Aren't you missing the NONE case here? Plus, I don't like having a
> > get_ro-function for the SIGNAL case, because in that case it is
> > superfluous. Though, I am not feeling strong about this if it makes the
> > rest of the code messier.
> > 
> OK, I will go back to the existing one, which only handles gpio case
> in esdhc_pltfm_get_ro and get it assigned to .get_ro only in case of
> ESDHC_WP_GPIO.
> 
Sorry.  I had some reason for moving esdhc_pltfm_get_ro around.  We
can not keep the existing approach (what I said above).  For mx51
babbage example, esdhc1 uses internal WP while esdhc2 uses gpio WP.
If we have esdhc_pltfm_get_ro handle gpio only and assign it to
sdhci_esdhc_ops.get_ro in .probe only when wp_type is ESDHC_WP_GPIO,
that works for esdhc2 but breaks esdhc1 WP function.  So no, I will
not change my code except adding NONE case handling there.

-- 
Regards,
Shawn
