From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 27 Jul 2011 09:27:15 +0000
Subject: [PATCH 1/1] fix card interrupt losing issue on freescale eSDHC
In-Reply-To: <20110727074710.GS16561@pengutronix.de>
References: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
	<20110727074710.GS16561@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5166B17@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Uwe Kleine-K?nig
> Sent: Wednesday, July 27, 2011 3:47 PM
> To: Lin Tony-B19295
> Cc: cjb at laptop.org; linux-mmc at vger.kernel.org; kernel at pengutronix.de;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] fix card interrupt losing issue on freescale
> eSDHC
> 
> Hello Tony,
> 
> On Mon, Jul 18, 2011 at 01:20:02PM +0800, Tony Lin wrote:
> > apply workaround for imx eSDHC controller to avoid missing card
> > interrupt so that SDIO function is workable
> Fixing a few typos (but note, I'm not a native speaker):
> 
> 	mmc/sdhci-esdhc-imx: fix losing card interrupt
> 
> 	Apply workaround for the imx eSDHC controller to avoid missing a
> 	card interrupt.
> 
> 	Signed-off-by: ...
> 
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |   39 +++++++++++++++++++++++++++-
> -------
> >  1 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index a19967d..da77cae 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -32,6 +32,8 @@
> >  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
> >
> >  #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
> > +
> > +#define	SDHCI_CTRL_D3CD			0x08
> >  /*
> >   * The CMDTYPE of the CMD register (offset 0xE) should be set to
> >   * "11" when the STOP CMD12 is issued on imx53 to abort one @@ -87,14
> > +89,31 @@ static void esdhc_writel_le(struct sdhci_host *host, u32
> > val, int reg)  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> > -
> > -	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
> > -			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
> > -		/*
> > -		 * these interrupts won't work with a custom card_detect gpio
> > -		 * (only applied to mx25/35)
> > -		 */
> > -		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
> > +	u32 data;
> > +
> > +	if (unlikely((reg == SDHCI_INT_ENABLE || reg ==
> SDHCI_SIGNAL_ENABLE))) {
> > +		if (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)
> > +			/*
> > +			 * these interrupts won't work with a custom
> > +			 * card_detect gpio (only applied to mx25/35)
> hmm, ok, this was here before, but I wonder about the "only applied to
> mx25/35" part. How is that meant? I don't see logic to prevent other socs
> using this workaround.
Sorry, not so sure about mx25/35 history. But the flag is set only if it's mx25 or mx35. 
You can check the code in esdhc_pltfm_init.
> 
> > +			 */
> > +			val &= ~(SDHCI_INT_CARD_REMOVE | \
> > +				SDHCI_INT_CARD_INSERT);
> > +
> > +		if (val & SDHCI_INT_CARD_INT) {
> > +			/*
> > +			 * clear D3CD bit and set D3CD bit to avoid
> > +			 * missing card interrupt
> > +			 * this is a eSDHC controller problem so that
> > +			 * we need to apply following workaround
> s/following/this/ ? If not, according to my (non-native) English you need
> to add a "the" before "following".
> 
> > +			 */
> > +			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
> > +			data &= ~SDHCI_CTRL_D3CD;
> > +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> > +			data |= SDHCI_CTRL_D3CD;
> > +			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
> Is there some Documentation about this problem? If yes, maybe add a link
> to it? Alternatively describe the problem more exact in a comment please.
> 
> > +		}
> > +	}
> >
> >  	if (unlikely((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
> >  				&& (reg == SDHCI_INT_STATUS)
> > @@ -165,7 +184,9 @@ static void esdhc_writeb_le(struct sdhci_host *host,
> u8 val, int reg)
> >  		return;
> >  	case SDHCI_HOST_CONTROL:
> >  		/* FSL messed up here, so we can just keep those two */
> > -		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
> > +		new_val = val & (SDHCI_CTRL_LED | \
> > +				SDHCI_CTRL_4BITBUS | \
> > +				SDHCI_CTRL_D3CD);
> This makes the comment wrong---now there are three bits that can be
> preserved.
> 
Thanks for your comments. Accepted.

> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
