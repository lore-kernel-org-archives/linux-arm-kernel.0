From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 20:00:48 +0900
Subject: [PATCH] sdhci-s3c: support non-standard clock setting for c210
References: <4C7CDA39.1020907@samsung.com>
	<005101cb4a88$7283d080$578b7180$%kim@samsung.com>
	<AANLkTik7RV8nSxPb4NQ+D3n6C_bO6L=WZvfd==7u3fJO@mail.gmail.com>
Message-ID: <005401cb4a8e$1c65dbc0$55319340$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Kyungmin Park wrote:
> >
> > On Thu, Sep 2, 2010 at 7:20 PM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> > > Jaehoon Chung wrote:
> > >>
> > >> This is sdhci-s3c patch for c210.
> > >> c210 didn't use divider of host controller.
> > >>
> > >> Host Controller need other clock setting methods.
> > >>
> > >> So I add the callback functions for s5pc210.
> > >> also I set 400KHz for initial clock.
> > >>
> > >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > >> ?Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>    ^^^
> Unnecessary whitespace
> 
> If your patch includes arch/arm stuff, please add Linux-arm-kernel
maillinglist.
> (Cc'ed that)
> 
> > >>
> > >> ---
> > >> ?arch/arm/plat-samsung/include/plat/sdhci.h | ? 19 ++++++++
> > >> ?drivers/mmc/host/sdhci-s3c.c ? ? ? ? ? ? ? | ? 68
> > >> ++++++++++++++++++++++++++++
> > >> ?2 files changed, 87 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h
b/arch/arm/plat-
> > >> samsung/include/plat/sdhci.h
> > >> index 30844c2..7c75ee3 100644
> > >> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> > >> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h

(snip)

> > >> diff --git a/drivers/mmc/host/sdhci-s3c.c
b/drivers/mmc/host/sdhci-s3c.c
> > >> index 71ad416..3927793 100644
> > >> --- a/drivers/mmc/host/sdhci-s3c.c
> > >> +++ b/drivers/mmc/host/sdhci-s3c.c
> 
> (snip)
> 
> > >
> > > How do you think about using quirk to separate S5PV310 case as
following?
> > > I think this is more general method in here...And will be submitted
soon
> > > after fixing something.

mm...I will think about your comments again. Then let's discuss about this
issue.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> > What's the meaning of "general method"?
> >
> I'd like to ask you why there is quirk in sdmmc driver.
> 
> > and how/where do you set the host->quirks? when board or platform set
> > the these quirks? who know it uses nonstandard quirk?
> 
> How about following?
> 
> static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
> ...
> +	if (pdev->id_entry->driver_data == TYPE_S5PV310)
> +		host->quirks |= SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER;
> ...
> 
> > In case s5pc210 don't have standard host controller. it's more clear
> > to use own functions instead of quirks.
> >
> Why do we add another callback function?
> 
> > >
> > > From: Hyuk Lee <hyuk1.lee@samsung.com>
> > >
> > > diff --git a/drivers/mmc/host/sdhci-s3c.c
b/drivers/mmc/host/sdhci-s3c.c
> > > index 71ad416..1ac2f36 100644
> > > --- a/drivers/mmc/host/sdhci-s3c.c
> > > +++ b/drivers/mmc/host/sdhci-s3c.c
> 
> (snip)
> 
> > > @@ -221,6 +257,11 @@ static unsigned int
sdhci_s3c_get_min_clock(struct
> > > sdhci_host *host)
> > > ? ? ? ?unsigned int delta, min = UINT_MAX;
> > > ? ? ? ?int src;
> > >
> > > + ? ? ? /* There is only one clock source(sclk) if there is no clock
divider
> > > + ? ? ? ?* in the host controller */
> > > + ? ? ? if(host->quirks & SDHCI_QUIRK_BROKEN_CLOCK_DIVIDER)
> > > + ? ? ? ? ? ? ? return clk_round_rate(ourhost->clk_bus[2], 400000);
> > what's the clk_bus[2]?
> >
> Should be clk_bus[ourhost->cur_clk]
> 
> (snip)
> 
