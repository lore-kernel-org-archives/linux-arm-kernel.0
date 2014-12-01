From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 2 Dec 2014 00:58:29 +0800
Subject: [PATCH 1/2] watchdog: Add driver for Mediatek mt6589 watchdog
In-Reply-To: <1415705357.1776.11.camel@mtksdaap41>
References: <1414428092-20725-1-git-send-email-matthias.bgg@gmail.com>
 <1414428092-20725-2-git-send-email-matthias.bgg@gmail.com>
 <1415705357.1776.11.camel@mtksdaap41>
Message-ID: <1417453109.10558.38.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-11 at 19:29 +0800, Eddie Huang wrote:
> On Tue, 2014-10-28 at 00:41 +0800, Matthias Brugger wrote:
> > This patch adds a driver for the Mediatek mt6589 SoC integrated
> > watchdog.
> > 
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  drivers/watchdog/Kconfig   |  10 ++
> >  drivers/watchdog/Makefile  |   1 +
> >  drivers/watchdog/mtk_wdt.c | 264 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 275 insertions(+)
> >  create mode 100644 drivers/watchdog/mtk_wdt.c

> > +
> > +static int mtk_reset_handler(struct notifier_block *this, unsigned long mode,
> > +                               void *cmd)
> > +{
> > +       struct mtk_wdt_dev *mtk_wdt = container_of(this,
> > +                                                      struct mtk_wdt_dev,
> > +                                                      restart_handler);
> > +       void __iomem *wdt_base = mtk_wdt->wdt_base;
> > +       u32 reg;
> > +
> > +       /* Enable watchdog */
> > +       reg = readl(wdt_base + WDT_MODE);
> > +       reg |= WDT_MODE_EN;
> > +       writel(reg, wdt_base + WDT_MODE);
> > +
> > +       /* Reload counter */
> > +       writel(WDT_RST_RELOAD, wdt_base + WDT_RST);
> > +
> > +       /* Reset system */
> > +       writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
> > +
> > +       while (1) {
> > +               mdelay(5);
> > +               writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
> > +       }
> > +       return NOTIFY_DONE;
> > +
> > +}
> > +

you can use "WDT_SWRST_KEY" to trigger reset signal. It is unnecessary
to enable watchdog and reload counter.

> +
> > +static int mtk_wdt_start(struct watchdog_device *wdt_dev)
> > +{
> > +       u32 reg;
> > +       struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
> > +       void __iomem *wdt_base = mtk_wdt->wdt_base;
> > +       u32 ret;
> > +
> > +       ret = mtk_wdt_set_timeout(&mtk_wdt->wdt_dev,
> > +                       mtk_wdt->wdt_dev.timeout);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       reg = ioread32(wdt_base + WDT_MODE);
> > +       reg |= (WDT_MODE_EN | WDT_MODE_KEY);
> 
> According to datasheet, default value of register WDT_MODE bit6 is 1.
> Which means when reach timeout, still need another timeout time to
> restart the system. Should clear this bit to disable dual mode:
>         reg &= ~(WDT_MODE_DUAL_EN);
> 
> > +       iowrite32(reg, wdt_base + WDT_MODE);
> > +
> > +       return 0;
> > +}

According to datasheet, default value of register WDT_MODE bit3 and bit
6 is 1, 1'bit3 means trigger irq instead of reset, bit6 means open
dual_mode or not.

If you just set bit0 to 1 to enable watchdog, it will be irq +
dual_mode, which means it will trigger irq first when reach timeout,
still need another timeout time to trigger reset signal.

If you set bit bit6 to 0, it will be irq only, and when timeout
reaches,only irq happens, never reset.

So if want to trigger reset only,should clear bit3 and bit6 to disable
irq or dual_mode.
       reg &= ~(WDT_MODE_IRQ_EN | WDT_MODE_DUAL_EN);   

I test this patch with above comment ok on my mt8135 tablet platform.
