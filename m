From: R65037@freescale.com (Zhu Richard-R65037)
Date: Mon, 21 Feb 2011 10:18:30 +0000
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <20110221100439.GE2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221100439.GE2616@pengutronix.de>
Message-ID: <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfsang:
See my comments marked by Richard Zhu below.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Monday, February 21, 2011 6:05 PM
> To: Zhao Richard-B20223
> Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de; linux-
> mmc at vger.kernel.org; cjb at laptop.org; avorontsov at ru.mvista.com;
> eric at eukrea.com; linuxzsc at gmail.com; Zhu Richard-R65037; Zhu Richard-
> R65037
> Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
>
> On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> > Fix no INT in MULTI-BLK IO.
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 9b82910..2eeb03e 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -113,7 +113,10 @@ static int esdhc_pltfm_init(struct sdhci_host
> *host, struct sdhci_pltfm_data *pd
> >     clk_enable(clk);
> >     pltfm_host->clk = clk;
> >
> > -   if (cpu_is_mx35() || cpu_is_mx51())
> > +   if (cpu_is_mx53())
> > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
>
> Have you tried it doing it via IO-accessors?
Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.
So one quirk is used here, and used to fix two different case.
One is multi-blk read in SDIO mode, the other is the Mult-blk read/write in mass storage mode.

>
> > +   if (cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53())
>
> Maybe we should use !cpu_is_mx25 for simplicity?
Richard Zhu: Accepted.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
