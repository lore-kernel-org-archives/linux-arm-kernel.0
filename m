From: leilk.liu@mediatek.com (leilk liu)
Date: Thu, 2 Jul 2015 16:20:32 +0800
Subject: [PATCH v2 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
In-Reply-To: <CALW4P+++mD-pLFGmAF0__F-1nOqTzEi7ScXVkrKrKfOSN0K=vA@mail.gmail.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-4-git-send-email-leilk.liu@mediatek.com>
 <CALW4P+++mD-pLFGmAF0__F-1nOqTzEi7ScXVkrKrKfOSN0K=vA@mail.gmail.com>
Message-ID: <1435825232.7819.19.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey,

> > +config SPI_MT65XX
> > +       tristate "MediaTek SPI controller"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       help
> > +         This selects the MediaTek(R) SPI bus driver.
> > +         If you want to use MediaTek(R) SPI interface,
> > +         say Y or M here.If you are not sure, say N.
> > +         SPI drivers for Mediatek mt65XX series ARM SoCs.
> 
> Commit subject and code here and there tells us it's compatible with
> mt81xx series. What do you think, does it make any sense to extend
> help description here?
> 

The help description will be extended.

> 
> > +
> >  config SPI_OC_TINY
> >         tristate "OpenCores tiny SPI"
> >         depends on GPIOLIB
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index d8cbf65..ab332ef 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > +
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/ioport.h>
> > +#include <linux/errno.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/types.h>
> > +#include <linux/delay.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/sched.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_address.h>
> 
> > +#include <linux/of_gpio.h>
> 
> > +#include <linux/kernel.h>
> > +#include <linux/gpio.h>
> 
> Could you please help me? I can't find any gpio-related things here.
> Maybe i miss something.
> Maybe is it for future?
> 
The gpio-related include files are not need now, I will delete extra
inclde files and sort others.

> 
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>

> > +static int mtk_spi_transfer_one(struct spi_master *master,
> > +                               struct spi_device *spi,
> > +                               struct spi_transfer *xfer)
> > +{
> > +       int cmd = 0, ret = 0;
> 
> Maybe initialization of 'cmd' is not needed.
> 

Yes.

> > +       unsigned int tx_sgl_len = 0, rx_sgl_len = 0;
> > +       struct scatterlist *tx_sgl = NULL, *rx_sgl = NULL;
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       /* Here is mt8173 HW issue: RX must enable TX, then TX transfer
> > +        * dummy data; TX don't need to enable RX. so enable TX dma for
> > +        * RX to workaround.
> > +        */


> > +static int mtk_spi_probe(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master;
> > +       struct mtk_spi_ddata *mdata;
> > +       const struct of_device_id *of_id;
> > +       struct resource *res;
> > +       int     ret;
> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(struct mtk_spi_ddata));
> > +       if (!master) {
> > +               dev_err(&pdev->dev, "failed to alloc spi master\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       pm_runtime_set_active(&pdev->dev);
> > +       pm_runtime_enable(&pdev->dev);
> > +
> > +       master->auto_runtime_pm = true;
> > +       master->dev.of_node = pdev->dev.of_node;
> > +       master->bus_num = pdev->id;
> > +       master->num_chipselect = 1;
> > +       master->mode_bits = SPI_CPOL | SPI_CPHA;
> > +
> > +       mdata = spi_master_get_devdata(master);
> > +       memset(mdata, 0, sizeof(struct mtk_spi_ddata));
> 
> Could you please check if you really need to fill in mdata by zeroes?
> I checked spi_alloc_master() and for me it looks like it calls
> kzalloc() for master + mdata.

Yes, memset() is not really need.
> 
> > +       mdata->master = master;
> > +       mdata->dev = &pdev->dev;
> > +
> > +       master->set_cs = mtk_spi_set_cs;
> > +       master->prepare_message = mtk_spi_prepare_message;
> > +       master->transfer_one = mtk_spi_transfer_one;
> > +       master->can_dma = mtk_spi_can_dma;
> > +
> > +       of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
> > +       if (!of_id) {
> > +               dev_err(&pdev->dev, "failed to probe of_node\n");
> > +               ret = -EINVAL;
> > +               goto err;
> > +       }
> > +
> > +       mdata->platform_compat = (unsigned long)of_id->data;
> > +
> > +       if (mdata->platform_compat & COMPAT_MT8173) {
> > +               ret = of_property_read_u32(pdev->dev.of_node, "pad-select",
> > +                                          &mdata->pad_sel);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "failed to read pad select: %d\n",
> > +                               ret);
> > +                       goto err;
> > +               }
> > +
> > +               if (mdata->pad_sel > MT8173_MAX_PAD_SEL) {
> > +                       dev_err(&pdev->dev, "wrong pad-select: %u\n",
> > +                               mdata->pad_sel);
> > +                       ret = -EINVAL;
> > +                       goto err;
> > +               }
> > +       }
> > +
> > +       platform_set_drvdata(pdev, master);
> > +       init_completion(&mdata->done);
> > +
> > +       mdata->clk = devm_clk_get(&pdev->dev, "main");
> > +       if (IS_ERR(mdata->clk)) {
> > +               ret = PTR_ERR(mdata->clk);
> > +               dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               ret = -ENODEV;
> > +               dev_err(&pdev->dev, "failed to determine base address\n");
> > +               goto err;
> > +       }
> > +
> > +       mdata->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(mdata->base)) {
> > +               ret = PTR_ERR(mdata->base);
> > +               goto err;
> > +       }
> > +
> > +       ret = platform_get_irq(pdev, 0);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to get irq (%d)\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       mdata->irq = ret;
> > +
> > +       if (!pdev->dev.dma_mask)
> > +               pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > +
> > +       ret = clk_prepare_enable(mdata->clk);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to enable clock (%d)\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       ret = devm_request_irq(&pdev->dev, mdata->irq, mtk_spi_interrupt,
> > +                              IRQF_TRIGGER_NONE, dev_name(&pdev->dev), mdata);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to register irq (%d)\n", ret);
> > +               goto err_disable_clk;
> > +       }
> > +
> > +       ret = devm_spi_register_master(&pdev->dev, master);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
> > +err_disable_clk:
> > +               clk_disable_unprepare(mdata->clk);
> > +err:
> > +               spi_master_put(master);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int mtk_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       pm_runtime_disable(&pdev->dev);
> > +
> > +       mtk_spi_reset(mdata);
> > +       clk_disable_unprepare(mdata->clk);
> > +       spi_master_put(master);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_spi_suspend(struct device *dev)
> > +{
> > +       int ret = 0;
> 
> Maybe initialization of ret here is not needed.
> 
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       ret = spi_master_suspend(master);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!pm_runtime_suspended(dev))
> > +               clk_disable_unprepare(mdata->clk);
> > +
> > +       return ret;
> > +}
> > +
> > +static int mtk_spi_resume(struct device *dev)
> > +{
> > +       int ret = 0;
> 
> 
> Maybe initialization of ret here is not needed. You have two return paths: one
> doesn't use ret as return value and second re-initializes it.
> 

Yes, it will be fixed on next version.

> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       if (!pm_runtime_suspended(dev)) {
> > +               ret = clk_prepare_enable(mdata->clk);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return spi_master_resume(master);
> > +}
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> > +#ifdef CONFIG_PM
> > +static int mtk_spi_runtime_suspend(struct device *dev)
> > +{
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct mtk_spi_ddata *mdata = spi_master_get_devdata(master);
> > +
> > +       clk_disable_unprepare(mdata->clk);
> > +
> > +       return 0;
> > +}
> > +
> > --
> > 1.8.1.1.dirty
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> Thanks and best regards,
> Klimov Alexey
