From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jul 2015 16:13:45 +0100
Subject: [PATCH v3 5/6] mmc: sdhci-esdhc-imx: config watermark level and
 burst length
In-Reply-To: <20150731145140.GE27806@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-6-git-send-email-haibo.chen@freescale.com>
 <20150731145140.GE27806@shlinux1.ap.freescale.net>
Message-ID: <20150731151345.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:51:41PM +0800, Dong Aisheng wrote:
> On Wed, Jul 29, 2015 at 05:03:56PM +0800, Haibo Chen wrote:
> > i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
> > DDR mode. So the I/O speed improve a lot compare to SD3.0
> > 
> > The default burst length is 8, if we don't change this value, in
> > HS400 mode, when we do eMMC read operation, we can find that the
> > clock signal will stop for a period of time. This means the speed
> > of data moving on AHB bus is slower than I/O speed. So we should
> > improve the speed of data moving on AHB bus.
> > 
> > For imx7d usdhc, this patch set the burst length as 16, and set
> > watermark level as 64. The test result is the clock signal has
> > no stop during the eMMC HS400 operation. For other imx usdhc, remain
> > the default value: burst length as 8, watermark level as 16.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 158f93b..37d0095 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -239,6 +239,11 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
> >  	return data->socdata == &usdhc_imx6q_data;
> >  }
> >  
> > +static inline int is_imx7d_usdhc(struct pltfm_imx_data *data)
> > +{
> > +	return data->socdata == &usdhc_imx7d_data;
> > +}
> 
> Can we using flag to check instead of adding more is_imx_usdhc()?

No, not more flags.  Do the job properly and parameterise the differences.

> >  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
> >  {
> >  	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> > @@ -1145,7 +1150,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >  	 * to something insane.  Change it back here.
> >  	 */
> >  	if (esdhc_is_usdhc(imx_data)) {
> > -		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
> > +		if (is_imx7d_usdhc(imx_data))
> > +			writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > +		else
> > +			writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);

So the value to be written to this register should come from the
driver data, which is already used as a struct esdhc_soc_data to
extrapolate out the differences.

Going down the flag path will lead you to an even more of a stinking
shitpile than sdhci already is - if another version of the SoC requires
a different value there, what are you going to do?  Add yet another
flag for the next value?  What are you going to do when you have 16
different values?  Use 16 different flags?  Clearly that path is insane.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
