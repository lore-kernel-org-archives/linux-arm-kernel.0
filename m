From: leilk.liu@mediatek.com (lei liu)
Date: Tue, 18 Aug 2015 21:14:29 +0800
Subject: [PATCH] spi: mediatek: fix spi incorrect endian usage and
 remove redundant clock
In-Reply-To: <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
References: <1439895231-17778-1-git-send-email-leilk.liu@mediatek.com>
 <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
Message-ID: <1439903669.30929.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-08-18 at 14:19 +0200, Jonas Gorski wrote:
> Hi,
> 
> On Tue, Aug 18, 2015 at 12:53 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> > This patch fixes incorrect endian usage, removes redundant
> > clock in prepare_hardware/unprepare_hardware and revises
> > coding styles.
> >
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> >
> > ---
> > Change in this patch:
> > 1. fix incorrect endian usage on big-endian system.
> > 2. delete redundant clock in prepare/unprepare_hardware.
> > 3. revise coding styles.
> 
> The usual philosophy is to have one change per patch, so this might be
> better as three patches. But this is Mark's call. Since the driver
> isn't yet in Linus' tree, it might be a-ok to mix style improvements
> and actual fixes, but as soon as it landed in Linus' tree you need to
> keep them separate, so fixes can be easily backported.
> 

OK, I'll divide this patch to three patches on next version.

> Regarding the content ...
> 
> > ---
> >  drivers/spi/spi-mt65xx.c                 | 163 +++++++++++++------------------
> >  include/linux/platform_data/spi-mt65xx.h |   2 -
> >  2 files changed, 69 insertions(+), 96 deletions(-)
> >
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 519f50c..a9da887 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -694,6 +662,7 @@ static int mtk_spi_resume(struct device *dev)
> >         if (!pm_runtime_suspended(dev)) {
> >                 ret = clk_prepare_enable(mdata->spi_clk);
> >                 if (ret < 0)
> > +                       dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> >                         return ret;
> 
> You need to add braces here, else the "return ret" isn't covered by
> the if () anymore and you always return at this place.
> 
Yes.I'll fix it.

> >         }
> >
> > @@ -720,8 +689,14 @@ static int mtk_spi_runtime_resume(struct device *dev)
> >  {
> >         struct spi_master *master = dev_get_drvdata(dev);
> >         struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +       int ret;
> > +
> > +       ret = clk_prepare_enable(mdata->spi_clk);
> > +       if (ret < 0)
> > +               dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> > +               return ret;
> 
> Same here. Although at least here it should be harmless, as
> clk_prepare_enable doesn't return > 0.
> 
Yes.I'll fix it too.
> >
> > -       return clk_prepare_enable(mdata->spi_clk);
> > +       return 0;
> >  }
> >  #endif /* CONFIG_PM */
> >
> 
> 
> Jonas
