From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 15 Jun 2018 08:23:01 +0200
Subject: [PATCH v1 4/4] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CAA+hA=Q-vJ8MyYpUFeZasCFnzOcgFG6+gY8VCVPfWH6ChvSbFw@mail.gmail.com>
References: <20180601065821.28234-1-o.rempel@pengutronix.de>
 <20180601065821.28234-5-o.rempel@pengutronix.de>
 <CAA+hA=RpoRXUK+jB18F4OeYE9PG73SDa_NLYeN5Q2G3B1bC-JA@mail.gmail.com>
 <CAA+hA=Q-vJ8MyYpUFeZasCFnzOcgFG6+gY8VCVPfWH6ChvSbFw@mail.gmail.com>
Message-ID: <20180615062301.vn34vdj53d6jx6as@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As promised, here are the sources.

I run Linux on Cortex M4 and A7 side. Here is my BSP:
git://git.pengutronix.de/ore/OSELAS.BSP-Pengutronix-DualKit
This BSP will create two images, for cortex m4, then make firmware image suitable
for rproc. Then it will create image for master system which will include rproc firmware.

and here is kernel source with all needed changes to run linux on both sides:
git://git.pengutronix.de/ore/linux

On Wed, Jun 13, 2018 at 08:24:09PM +0800, Dong Aisheng wrote:
> Copy linux-imx at nxp.com and more related guys to comment
> 
> On Wed, Jun 13, 2018 at 8:21 PM, Dong Aisheng <dongas86@gmail.com> wrote:
> > Hi Oleksij,
> >
> > On Fri, Jun 1, 2018 at 2:58 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >> The Mailbox controller is able to send messages (up to 4 32 bit words)
> >> between the endpoints.
> >
> > Could we really be able to send up to 4 42bit words with this driver?
> >
> > It looks to me the current Mailbox framework is more designed for share mem
> > transfer which does not fit i.MX MU well.
> >
> >>
> >> This driver was tested using the mailbox-test driver sending messages
> >> between the Cortex-A7 and the Cortex-M4.
> >
> > Would you please provide a guide on how to test it quickly?
> > I may want to give a test.
> >
> >>
> >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >> ---
> >>  drivers/mailbox/Kconfig       |   6 +
> >>  drivers/mailbox/Makefile      |   2 +
> >>  drivers/mailbox/imx-mailbox.c | 289 ++++++++++++++++++++++++++++++++++
> >>  3 files changed, 297 insertions(+)
> >>  create mode 100644 drivers/mailbox/imx-mailbox.c
> >>
> >> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> >> index a2bb27446dce..e1d2738a2e4c 100644
> >> --- a/drivers/mailbox/Kconfig
> >> +++ b/drivers/mailbox/Kconfig
> >> @@ -15,6 +15,12 @@ config ARM_MHU
> >>           The controller has 3 mailbox channels, the last of which can be
> >>           used in Secure mode only.
> >>
> >> +config IMX_MBOX
> >> +       tristate "iMX Mailbox"
> >> +       depends on SOC_IMX7D || COMPILE_TEST
> >> +       help
> >> +         Mailbox implementation for iMX7D Messaging Unit (MU).
> >> +
> >>  config PLATFORM_MHU
> >>         tristate "Platform MHU Mailbox"
> >>         depends on OF
> >> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> >> index cc23c3a43fcd..ba2fe1b6dd62 100644
> >> --- a/drivers/mailbox/Makefile
> >> +++ b/drivers/mailbox/Makefile
> >> @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)      += mailbox-test.o
> >>
> >>  obj-$(CONFIG_ARM_MHU)  += arm_mhu.o
> >>
> >> +obj-$(CONFIG_IMX_MBOX) += imx-mailbox.o
> >> +
> >>  obj-$(CONFIG_PLATFORM_MHU)     += platform_mhu.o
> >>
> >>  obj-$(CONFIG_PL320_MBOX)       += pl320-ipc.o
> >> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> >> new file mode 100644
> >> index 000000000000..2bc9f11393b1
> >> --- /dev/null
> >> +++ b/drivers/mailbox/imx-mailbox.c
> >> @@ -0,0 +1,289 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/mailbox_controller.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> >> +
> >> +/* Transmit Register */
> >> +#define IMX_MU_xTRn(x)         (0x00 + 4 * (x))
> >> +/* Receive Register */
> >> +#define IMX_MU_xRRn(x)         (0x10 + 4 * (x))
> >> +/* Status Register */
> >> +#define IMX_MU_xSR             0x20
> >> +#define IMX_MU_xSR_TEn(x)      BIT(20 + (x))
> >> +#define IMX_MU_xSR_RFn(x)      BIT(24 + (x))
> >> +#define IMX_MU_xSR_BRDIP       BIT(9)
> >> +
> >> +/* Control Register */
> >> +#define IMX_MU_xCR             0x24
> >> +/* Transmit Interrupt Enable */
> >> +#define IMX_MU_xCR_TIEn(x)     BIT(20 + (x))
> >> +/* Receive Interrupt Enable */
> >> +#define IMX_MU_xCR_RIEn(x)     BIT(24 + (x))
> >> +
> >> +#define IMX_MU_MAX_CHANS       4u
> >> +
> >> +struct imx_mu_priv;
> >> +
> >> +struct imx_mu_cfg {
> >> +       unsigned int            chans;
> >> +       void (*init_hw)(struct imx_mu_priv *priv);
> >> +};
> >> +
> >> +struct imx_mu_con_priv {
> >> +       int                     irq;
> >> +       unsigned int            bidx;
> >> +       unsigned int            idx;
> >> +};
> >> +
> >> +struct imx_mu_priv {
> >> +       struct device           *dev;
> >> +       const struct imx_mu_cfg *dcfg;
> >> +       void __iomem            *base;
> >> +
> >> +       struct mbox_controller  mbox;
> >> +       struct mbox_chan        mbox_chans[IMX_MU_MAX_CHANS];
> >> +
> >> +       struct imx_mu_con_priv  con_priv[IMX_MU_MAX_CHANS];
> >> +       struct clk              *clk;
> >> +};
> >> +
> >> +static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
> >> +{
> >> +       return container_of(mbox, struct imx_mu_priv, mbox);
> >> +}
> >> +
> >> +static void imx_mu_write(struct imx_mu_priv *priv, u32 val, u32 offs)
> >> +{
> >> +       iowrite32(val, priv->base + offs);
> >> +}
> >> +
> >> +static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
> >> +{
> >> +       return ioread32(priv->base + offs);
> >> +}
> >> +
> >> +static u32 imx_mu_rmw(struct imx_mu_priv *priv, u32 offs, u32 set, u32 clr)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = imx_mu_read(priv, offs);
> >> +       val &= ~clr;
> >> +       val |= set;
> >> +       imx_mu_write(priv, val, offs);
> >> +
> >> +       return val;
> >> +}
> >> +
> >> +static irqreturn_t imx_mu_isr(int irq, void *p)
> >> +{
> >> +       struct mbox_chan *chan = p;
> >> +       struct imx_mu_con_priv *cp = chan->con_priv;
> >> +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> >
> > Please do in reversed order from long to short
> >
> >> +
> >> +       u32 val, dat;
> >> +
> >> +       val = imx_mu_read(priv, IMX_MU_xSR);
> >> +       val &= IMX_MU_xSR_TEn(cp->bidx) | IMX_MU_xSR_RFn(cp->bidx);
> >> +       if (!val)
> >> +               return IRQ_NONE;
> >> +
> >> +       if (val & IMX_MU_xSR_TEn(cp->bidx)) {
> >> +               imx_mu_rmw(priv, IMX_MU_xCR, 0, IMX_MU_xCR_TIEn(cp->bidx));
> >> +               mbox_chan_txdone(chan, 0);
> >> +       }
> >> +
> >> +       if (val & IMX_MU_xSR_RFn(cp->bidx)) {
> >> +               dat = imx_mu_read(priv, IMX_MU_xRRn(cp->idx));
> >> +               mbox_chan_received_data(chan, (void *)&dat);
> >> +       }
> >> +
> >> +       return IRQ_HANDLED;
> >> +}
> >> +
> >> +static bool imx_mu_last_tx_done(struct mbox_chan *chan)
> >> +{
> >> +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> >> +       struct imx_mu_con_priv *cp = chan->con_priv;
> >> +       u32 val;
> >> +
> >> +       val = imx_mu_read(priv, IMX_MU_xSR);
> >> +       /* test if transmit register is empty */
> >> +       return (!(val & IMX_MU_xSR_TEn(cp->bidx)));
> >> +}
> >> +
> >> +static int imx_mu_send_data(struct mbox_chan *chan, void *data)
> >> +{
> >> +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> >> +       struct imx_mu_con_priv *cp = chan->con_priv;
> >> +       u32 *arg = data;
> >> +
> >> +       if (imx_mu_last_tx_done(chan))
> >
> > return true for tx_done?
> > Or maybe better imx_mu_is_busy?
> >
> >> +               return -EBUSY;
> >> +
> >> +       imx_mu_write(priv, *arg, IMX_MU_xTRn(cp->idx));
> >> +       imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xSR_TEn(cp->bidx), 0);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int imx_mu_startup(struct mbox_chan *chan)
> >> +{
> >> +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> >> +       struct imx_mu_con_priv *cp = chan->con_priv;
> >> +       int ret;
> >> +
> >> +       ret = request_irq(cp->irq, imx_mu_isr,
> >> +                         IRQF_SHARED, "imx_mu_chan", chan);
> >
> > This looks me to a bit strange as all virtual channels interrupts
> > line actually are the same. And we request that same irq line
> > repeatedly here with the same irq handler.
> >
> >> +       if (ret) {
> >> +               dev_err(chan->mbox->dev,
> >> +                       "Unable to acquire IRQ %d\n", cp->irq);
> >> +               return ret;
> >> +       }
> >> +
> >> +       imx_mu_rmw(priv, IMX_MU_xCR, IMX_MU_xCR_RIEn(cp->bidx), 0);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void imx_mu_shutdown(struct mbox_chan *chan)
> >> +{
> >> +       struct imx_mu_priv *priv = to_imx_mu_priv(chan->mbox);
> >> +       struct imx_mu_con_priv *cp = chan->con_priv;
> >> +
> >> +       imx_mu_rmw(priv, IMX_MU_xCR, 0,
> >> +                  IMX_MU_xCR_TIEn(cp->bidx) | IMX_MU_xCR_RIEn(cp->bidx));
> >> +
> >> +       free_irq(cp->irq, chan);
> >> +}
> >> +
> >> +static const struct mbox_chan_ops imx_mu_ops = {
> >> +       .send_data = imx_mu_send_data,
> >> +       .startup = imx_mu_startup,
> >> +       .shutdown = imx_mu_shutdown,
> >> +       .last_tx_done = imx_mu_last_tx_done,
> >
> > Do we really need this?
> > Looking at the code, it seems .last_tx_done() is only called for polling mode.
> > But what you set below is:
> > priv->mbox.txdone_irq = true;
> >
> > Or am i missed something?
> >
> >> +};
> >> +
> >> +static int imx_mu_probe(struct platform_device *pdev)
> >> +{
> >> +       struct device *dev = &pdev->dev;
> >> +       struct resource *iomem;
> >> +       struct imx_mu_priv *priv;
> >> +       const struct imx_mu_cfg *dcfg;
> >> +       unsigned int i, chans;
> >> +       int irq, ret;
> >> +
> >> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +       if (!priv)
> >> +               return -ENOMEM;
> >> +
> >> +       dcfg = of_device_get_match_data(dev);
> >> +       if (!dcfg)
> >> +               return -EINVAL;
> >> +
> >> +       priv->dcfg = dcfg;
> >> +       priv->dev = dev;
> >> +
> >> +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +       priv->base = devm_ioremap_resource(&pdev->dev, iomem);
> >> +       if (IS_ERR(priv->base))
> >> +               return PTR_ERR(priv->base);
> >> +
> >> +       irq = platform_get_irq(pdev, 0);
> >> +       if (irq <= 0)
> >> +               return irq < 0 ? irq : -EINVAL;
> >
> > Is it possible == 0?
> >
> >> +
> >> +       priv->clk = devm_clk_get(dev, NULL);
> >> +       if (IS_ERR(priv->clk)) {
> >> +               if (PTR_ERR(priv->clk) == -ENOENT) {
> >> +                       priv->clk = NULL;
> >> +               } else {
> >> +                       dev_err(dev, "Failed to get clock\n");
> >
> > The line looks not be quite meaningful as it may be defer probe.
> >
> >> +                       return PTR_ERR(priv->clk);
> >> +               }
> >> +       }
> >> +
> >> +       ret = clk_prepare_enable(priv->clk);
> >> +       if (ret) {
> >> +               dev_err(dev, "Failed to enable clock\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       chans = min(dcfg->chans, IMX_MU_MAX_CHANS);
> >> +       /* Initialize channel identifiers */
> >> +       for (i = 0; i < chans; i++) {
> >> +               struct imx_mu_con_priv *cp = &priv->con_priv[i];
> >> +
> >> +               cp->bidx = 3 - i;
> >> +               cp->idx = i;
> >> +               cp->irq = irq;
> >> +               priv->mbox_chans[i].con_priv = cp;
> >> +       }
> >> +
> >> +       priv->mbox.dev = dev;
> >> +       priv->mbox.ops = &imx_mu_ops;
> >> +       priv->mbox.chans = priv->mbox_chans;
> >> +       priv->mbox.num_chans = chans;
> >> +       priv->mbox.txdone_irq = true;
> >> +
> >> +       platform_set_drvdata(pdev, priv);
> >> +
> >> +       if (priv->dcfg->init_hw)
> >> +               priv->dcfg->init_hw(priv);
> >> +
> >> +       return mbox_controller_register(&priv->mbox);
> >> +}
> >> +
> >> +static int imx_mu_remove(struct platform_device *pdev)
> >> +{
> >> +       struct imx_mu_priv *priv = platform_get_drvdata(pdev);
> >> +
> >> +       mbox_controller_unregister(&priv->mbox);
> >> +       clk_disable_unprepare(priv->clk);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +
> >> +static void imx_mu_init_imx7d_a(struct imx_mu_priv *priv)
> >> +{
> >> +       /* Set default config */
> >> +       imx_mu_write(priv, 0, IMX_MU_xCR);
> >> +}
> >> +
> >> +static const struct imx_mu_cfg imx_mu_cfg_imx7d_a = {
> >> +       .chans = IMX_MU_MAX_CHANS,
> >> +       .init_hw = imx_mu_init_imx7d_a,
> >> +};
> >> +
> >> +static const struct imx_mu_cfg imx_mu_cfg_imx7d_b = {
> >> +       .chans = IMX_MU_MAX_CHANS,
> >> +};
> >> +
> >> +static const struct of_device_id imx_mu_dt_ids[] = {
> >> +       { .compatible = "fsl,imx7s-mu-a", .data = &imx_mu_cfg_imx7d_a },
> >> +       { .compatible = "fsl,imx7s-mu-b", .data = &imx_mu_cfg_imx7d_b },
> >> +       { },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
> >> +
> >> +static struct platform_driver imx_mu_driver = {
> >> +       .probe          = imx_mu_probe,
> >> +       .remove         = imx_mu_remove,
> >> +       .driver = {
> >> +               .name   = "imx_mu",
> >> +               .of_match_table = imx_mu_dt_ids,
> >> +       },
> >> +};
> >> +module_platform_driver(imx_mu_driver);
> >> +
> >> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> >> +MODULE_DESCRIPTION("Message Unit driver for i.MX7");
> >
> > s/i.MX7/i.MX
> >
> > Regards
> > Dong Aisheng
> >
> >> +MODULE_LICENSE("GPL v2");
> >> --
> >> 2.17.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> >> the body of a message to majordomo at vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180615/eee47033/attachment-0001.sig>
