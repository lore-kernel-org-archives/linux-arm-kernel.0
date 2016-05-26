From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 26 May 2016 20:21:44 +0800
Subject: [PATCH 18/23] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 STD_TUNING
In-Reply-To: <5731C3CC.1000806@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-19-git-send-email-aisheng.dong@nxp.com>
 <5731C3CC.1000806@intel.com>
Message-ID: <20160526122144.GE23988@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 02:19:40PM +0300, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
> > Enable HW auto retuning when set SDHCI_CTRL_EXEC_TUNING and clear it
> > when clear SDHCI_CTRL_TUNED_CLK.
> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> I presume this patch should wait for patch 17, but nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

Actually the interesting thing here is patch 18 and 19 do not need
patch 17 since our IC guy told me IMX uSDHC auto-tuning will
not Retuning request for mode 3.

Thanks for the pre-ACK.

Regards
Dong Aisheng

> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 9f9be3f..a582a83 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -44,6 +44,7 @@
> >  #define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
> >  #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
> >  #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
> > +#define  ESDHC_MIX_CTRL_AUTO_TUNE_EN	(1 << 24)
> >  #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
> >  #define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
> >  /* Bits 3 and 6 are not SDHCI standard definitions */
> > @@ -484,11 +485,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
> >  			} else {
> >  				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> >  				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> > +				m &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> >  			}
> >  
> >  			if (val & SDHCI_CTRL_EXEC_TUNING) {
> >  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
> >  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> > +				m |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
> >  				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> >  				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
> >  				if (imx_data->boarddata.tuning_start_tap) {
> > 
> 
