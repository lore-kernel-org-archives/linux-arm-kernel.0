From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Oct 2009 10:00:53 +0200
Subject: [PATCH 4/4] i2c: imx: disable clock when it's possible to save
	power.
In-Reply-To: <4e090d470910010056n56bff9f4l1fec703c2dde9edf@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-3-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-4-git-send-email-linuxzsc@gmail.com>
	<20091001073434.GY27039@pengutronix.de>
	<4e090d470910010056n56bff9f4l1fec703c2dde9edf@mail.gmail.com>
Message-ID: <20091001080053.GA27039@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 03:56:29PM +0800, Richard Zhao wrote:
> On Thu, Oct 1, 2009 at 3:34 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Thu, Oct 01, 2009 at 09:13:33AM +0800, Richard Zhao wrote:
> >> Enable clock before START, disable it after STOP.
> >
> > The clk_diable/enable calls in suspend/resume should be removed also.
> >
> > Sascha
> >
> >>
> >> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index 87faea4..72ddea3 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -120,6 +120,7 @@ struct imx_i2c_struct {
> >> ? ? ? wait_queue_head_t ? ? ? queue;
> >> ? ? ? unsigned long ? ? ? ? ? i2csr;
> >> ? ? ? unsigned int ? ? ? ? ? ?disable_delay;
> >> + ? ? unsigned int ? ? ? ? ? ?ifdr; /* IMX_I2C_IFDR */
> >> ?};
> >>
> >> ?/** Functions for IMX I2C adapter driver ***************************************
> >> @@ -210,6 +211,8 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
> >>
> >> ? ? ? dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> >>
> >> + ? ? clk_enable(i2c_imx->clk);
> >> + ? ? writeb(i2c_imx->ifdr, i2c_imx->base + IMX_I2C_IFDR);
> >> ? ? ? /* Enable I2C controller */
> >> ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2SR);
> >> ? ? ? writeb(I2CR_IEN, i2c_imx->base + IMX_I2C_I2CR);
> >> @@ -254,6 +257,7 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
> >>
> >> ? ? ? /* Disable I2C controller */
> >> ? ? ? writeb(0, i2c_imx->base + IMX_I2C_I2CR);
> >> + ? ? clk_disable(i2c_imx->clk);
> >> ?}
> >>
> >> ?static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> >> @@ -273,8 +277,8 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
> >> ? ? ? else
> >> ? ? ? ? ? ? ? for (i = 0; i2c_clk_div[i][0] < div; i++);
> >>
> >> - ? ? /* Write divider value to register */
> >> - ? ? writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
> >> + ? ? /* Store divider value */
> >> + ? ? i2c_imx->ifdr = i2c_clk_div[i][1];
> >>
> >> ? ? ? if (cpu_is_mx1()) {
> >> ? ? ? ? ? ? ? /*
> >> @@ -555,7 +559,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
> >> ? ? ? ? ? ? ? dev_err(&pdev->dev, "can't get I2C clock\n");
> >> ? ? ? ? ? ? ? goto fail3;
> >> ? ? ? }
> >> - ? ? clk_enable(i2c_imx->clk);
> >>
> >> ? ? ? /* Request IRQ */
> >> ? ? ? ret = request_irq(i2c_imx->irq, i2c_imx_isr, 0, pdev->name, i2c_imx);
> >> @@ -604,7 +607,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
> >> ?fail5:
> >> ? ? ? free_irq(i2c_imx->irq, i2c_imx);
> >> ?fail4:
> >> - ? ? clk_disable(i2c_imx->clk);
> >> ? ? ? clk_put(i2c_imx->clk);
> >> ?fail3:
> >> ? ? ? release_mem_region(i2c_imx->res->start, resource_size(res));
> >> @@ -641,8 +643,6 @@ static int __exit i2c_imx_remove(struct platform_device *pdev)
> >> ? ? ? if (pdata && pdata->exit)
> >> ? ? ? ? ? ? ? pdata->exit(&pdev->dev);
> >>
> >> - ? ? /* Disable I2C clock */
> >> - ? ? clk_disable(i2c_imx->clk);
> >> ? ? ? clk_put(i2c_imx->clk);
> >>
> >> ? ? ? release_mem_region(i2c_imx->res->start, resource_size(i2c_imx->res));
> >> --
> >> 1.6.0.4
> >>
> >>
> >
> > --
> > Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> > Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> > Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
> >
> 
> I don't think we have any suspend/resume routine. And we won't need it any more.

Ups, my bad. I have it in my local tree and didn't realize it isn't
upstream.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
