From: Chaotian.Jing@mediatek.com (=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=)
Date: Fri, 3 Apr 2015 08:27:45 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMy81XSBtbWM6IG1lZGlhdGVrOiBBZGQgUE0g?=
 =?utf-8?Q?support_for_MMC_driver?=
In-Reply-To: <CAPDyKFqA=9mgzGkeBjkMxr3jhqxnEYov_4rf=OfdQ7_rAHicyw@mail.gmail.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFqA=9mgzGkeBjkMxr3jhqxnEYov_4rf=OfdQ7_rAHicyw@mail.gmail.com>
Message-ID: <B077351396223C4F8FE8C4C13672A9CA609796EC@mtkmbs33n1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ulf,

Thanks for your review,
Please help to check my comments:

> -----????-----
> ???: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> ????: 2015?3?31? 22:47
> ???: Chaotian Jing (???)
> ??: Rob Herring; Matthias Brugger; Chris Ball; Mark Rutland; JamesJJ Liao
> (???); srv_heupstream; Arnd Bergmann; devicetree at vger.kernel.org;
> HONGZHOU Yang; Catalin Marinas; linux-mmc; Will Deacon;
> linux-kernel at vger.kernel.org; linux-gpio at vger.kernel.org; Sascha Hauer;
> Yingjoe Chen (???); Eddie Huang (???); Bin Zhang (??);
> linux-arm-kernel at lists.infradead.org; linux-mediatek at lists.infradead.org
> ??: Re: [PATCH v2 3/5] mmc: mediatek: Add PM support for MMC driver
> 
> On 17 March 2015 at 04:13, Chaotian Jing <chaotian.jing@mediatek.com>
> wrote:
> > Add PM support for Mediatek MMC driver
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 94
> > ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 93 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 86c999b..e02f6a6 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>  #include <linux/spinlock.h>
> >
> > @@ -223,6 +224,7 @@
> >  #define MSDC_OCR_AVAIL      (MMC_VDD_28_29 | MMC_VDD_29_30
> \
> >                 | MMC_VDD_30_31 | MMC_VDD_31_32 |
> MMC_VDD_32_33)
> >
> > +#define MTK_MMC_AUTOSUSPEND_DELAY      500
> >  #define CMD_TIMEOUT         (HZ/10 * 5)        /* 100ms x5 */
> >  #define DAT_TIMEOUT         (HZ    * 5)        /* 1000ms x5 */
> >
> > @@ -535,6 +537,38 @@ static void msdc_set_mclk(struct msdc_host *host,
> int ddr, u32 hz)
> >         dev_dbg(host->dev, "sclk: %d, ddr: %d\n", host->sclk, ddr);  }
> >
> > +#ifdef CONFIG_PM
> 
> I suggest you move this complete code snippets within the ifdefs for where the
> runtime PM callbacks is implemented.
> 
I will remove the CONFIG_PM, because that if the kernel config do not enable CONFIG_PM, it still need do gate/ungate clock.
> > +static int msdc_gate_clock(struct msdc_host *host) {
> > +       int ret = 0;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       /* disable SD/MMC/SDIO bus clock */
> > +       sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE,
> MSDC_MS);
> 
> This seems like it also belongs in the ->set_ios() function, when the rate
> requested by the core is zero!? Maybe that's already dealt with?
Yes, but it is not the same, the set_ios() set the bus clock to 0, only need set the MODE to MSDC_MS.
But the gate clock will gate the source clock of MSDC host, when the host is idle, runtime pm will gate it, but the ios->clock is not 0.
> 
> > +       /* turn off SDHC functional clock */
> > +       clk_disable(host->src_clk);
> 
> Change to clk_disable_unprepare() and move it outside the spin_lock.
> 
OK, will fix it at next revision.
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +       return ret;
> > +}
> > +
> > +static void msdc_ungate_clock(struct msdc_host *host) {
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       clk_enable(host->src_clk);
> 
> Change to clk_prepare_enable() and move it outside the spin_lock.
> 
OK, will fix it at next revision,
> > +       /* enable SD/MMC/SDIO bus clock:
> > +        * it will be automatically gated when the bus is idle
> > +        * (set MSDC_CFG_CKPDN bit to have it always on)
> > +        */
> > +       sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE,
> MSDC_SDMMC);
> > +       while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> > +               cpu_relax();
> 
> I guess you already have this piece of code in ->set_ios() in some form!?
> 
> What's missing here is a kind of a save/restore mechanism of the clock. You
> need to save the value for the clock in msdc_ungate_clock() and restore the
> clock here. Else you might end up ungating the clock when it actually should
> remain gated.
> 
When we ungate the clock or change the frequency of the clock, both need wait the clock stable.

> > +       spin_unlock_irqrestore(&host->lock, flags); } #endif
> > +
> >  static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
> >                 struct mmc_request *mrq, struct mmc_command *cmd)
> {
> > @@ -702,6 +736,9 @@ static void msdc_request_done(struct msdc_host
> *host, struct mmc_request *mrq)
> >         if (mrq->data)
> >                 msdc_unprepare_data(host, mrq);
> >         mmc_request_done(host->mmc, mrq);
> > +
> > +       pm_runtime_mark_last_busy(host->dev);
> > +       pm_runtime_put_autosuspend(host->dev);
> >  }
> >
> >  /* returns true if command is fully handled; returns false otherwise
> > */ @@ -863,6 +900,8 @@ static void msdc_ops_request(struct mmc_host
> *mmc, struct mmc_request *mrq)
> >         }
> >         spin_unlock_irqrestore(&host->lock, flags);
> >
> > +       pm_runtime_get_sync(host->dev);
> > +
> >         if (mrq->data)
> >                 msdc_prepare_data(host, mrq);
> >
> > @@ -1003,6 +1042,8 @@ static int msdc_ops_switch_volt(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >
> >         if (!IS_ERR(mmc->supply.vqmmc)) {
> >
> > +               pm_runtime_get_sync(host->dev);
> > +
> >                 if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> >                         min_uv = 3300000;
> >                         max_uv = 3300000; @@ -1011,6 +1052,9 @@
> static
> > int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
> >                         max_uv = 1800000;
> >                 } else {
> >                         dev_err(host->dev, "Unsupported signal
> > voltage!\n");
> > +
> > +                       pm_runtime_mark_last_busy(host->dev);
> > +                       pm_runtime_put_autosuspend(host->dev);
> >                         return -EINVAL;
> 
> I suggest to assign a local "ret" variable which value you can return at the end
> of this function. Thus you won't need to duplicate the
> pm_runtime*() calls.
> 
OK, will fix at next revision.
> >                 }
> >
> > @@ -1022,6 +1066,8 @@ static int msdc_ops_switch_volt(struct mmc_host
> *mmc, struct mmc_ios *ios)
> >                 }
> >         }
> >
> > +       pm_runtime_mark_last_busy(host->dev);
> > +       pm_runtime_put_autosuspend(host->dev);
> >         return ret;
> >  }
> >
> > @@ -1186,6 +1232,8 @@ static void msdc_ops_set_ios(struct mmc_host
> *mmc, struct mmc_ios *ios)
> >         int ret;
> >         u32 ddr = 0;
> >
> > +       pm_runtime_get_sync(host->dev);
> > +
> >         if (ios->timing == MMC_TIMING_UHS_DDR50)
> >                 ddr = 1;
> >
> > @@ -1230,6 +1278,9 @@ static void msdc_ops_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >
> >         if (host->mclk != ios->clock || host->ddr != ddr)
> >                 msdc_set_mclk(host, ddr, ios->clock);
> > +
> > +       pm_runtime_mark_last_busy(host->dev);
> > +       pm_runtime_put_autosuspend(host->dev);
> >  }
> >
> >  static struct mmc_host_ops mt_msdc_ops = { @@ -1341,6 +1392,11 @@
> > static int msdc_drv_probe(struct platform_device *pdev)
> >         platform_set_drvdata(pdev, mmc);
> >         clk_prepare(host->src_clk);
> >
> > +       pm_runtime_enable(host->dev);
> > +       pm_runtime_get_sync(host->dev);
> > +       pm_runtime_set_autosuspend_delay(host->dev,
> MTK_MMC_AUTOSUSPEND_DELAY);
> > +       pm_runtime_use_autosuspend(host->dev);
> 
> This shall be changed to the following:
> 
Ok, will fix it.
> pm_runtime_set_active();
> pm_runtime_set_autosuspend_delay(host->dev,
> MTK_MMC_AUTOSUSPEND_DELAY);
> pm_runtime_use_autosuspend(host->dev);
> pm_runtime_enable(host->dev);
> 
> ... and to simplify error handling, move it just prior mmc_add_host().
> 	
Will fix it at next revision.
> > +
> >         ret = devm_request_irq(&pdev->dev, (unsigned int) host->irq,
> msdc_irq,
> >                 IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name,
> host);
> >         if (ret)
> > @@ -1348,10 +1404,15 @@ static int msdc_drv_probe(struct
> > platform_device *pdev)
> >
> >         ret = mmc_add_host(mmc);
> >         if (ret)
> > -               goto release;
> > +               goto end;
> >
> > +       pm_runtime_mark_last_busy(host->dev);
> > +       pm_runtime_put_autosuspend(host->dev);
> 
> According to above, remove these pm_runtime_*() calls.
> 
Okay.
> >         return 0;
> >
> > +end:
> > +       pm_runtime_put_sync(host->dev);
> 
> According to above, remove the pm_runtime_put_sync().
> Will remove it at next revision,
> > +       pm_runtime_disable(host->dev);
> >  release:
> >         platform_set_drvdata(pdev, NULL);
> >         msdc_deinit_hw(host);
> > @@ -1364,6 +1425,7 @@ release_mem:
> >                 dma_free_coherent(&pdev->dev,
> >                         MAX_BD_NUM * sizeof(struct
> mt_bdma_desc),
> >                         host->dma.bd, host->dma.bd_addr);
> > +
> >  host_free:
> >         mmc_free_host(mmc);
> >
> > @@ -1378,10 +1440,14 @@ static int msdc_drv_remove(struct
> platform_device *pdev)
> >         mmc = platform_get_drvdata(pdev);
> >         host = mmc_priv(mmc);
> >
> > +       pm_runtime_get_sync(host->dev);
> > +
> >         platform_set_drvdata(pdev, NULL);
> >         mmc_remove_host(host->mmc);
> >         msdc_deinit_hw(host);
> >
> > +       pm_runtime_put_sync(host->dev);
> 
> Change to pm_runtime_put_noidle() and reverse the order of the call to
> pm_runtime_disable().
> 
Ok. Will fix it at next revision,
> > +       pm_runtime_disable(host->dev);
> >         dma_free_coherent(&pdev->dev,
> >                         MAX_GPD_NUM * sizeof(struct
> mt_gpdma_desc),
> >                         host->dma.gpd, host->dma.gpd_addr); @@
> -1393,6
> > +1459,31 @@ static int msdc_drv_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_PM
> > +static int msdc_runtime_suspend(struct device *dev) {
> > +       int ret = 0;
> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       ret = msdc_gate_clock(host);
> > +       return ret;
> > +}
> > +
> > +static int msdc_runtime_resume(struct device *dev) {
> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       msdc_ungate_clock(host);
> > +       return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops msdc_dev_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(msdc_runtime_suspend,
> msdc_runtime_resume,
> > +NULL) };
> > +
> >  static const struct of_device_id msdc_of_ids[] = {
> >         {   .compatible = "mediatek,mt8135-mmc", },
> >         {}
> > @@ -1404,6 +1495,7 @@ static struct platform_driver mt_msdc_driver = {
> >         .driver = {
> >                 .name = "mtk-msdc",
> >                 .of_match_table = msdc_of_ids,
> > +               .pm = &msdc_dev_pm_ops,
> >         },
> >  };
> >
> > --
> > 1.8.1.1.dirty
> >
> 
> Kind regards
> Uffe

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
