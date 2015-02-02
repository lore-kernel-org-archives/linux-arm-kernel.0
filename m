From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 2 Feb 2015 17:05:39 +0100
Subject: [PATCH v6 6/8] input: touchscreen: imx25 tcq driver
In-Reply-To: <20150130185721.GA11695@dtor-ws>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-7-git-send-email-mpa@pengutronix.de>
 <54CA4320.4030607@gmail.com> <20150130185721.GA11695@dtor-ws>
Message-ID: <20150202160539.GS16879@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 30, 2015 at 10:57:21AM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 29, 2015 at 07:56:40PM +0530, Varka Bhadram wrote:
> > Hi,
> > 
> > On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> > >This is a driver for the imx25 ADC/TSC module. It controls the
> > >touchscreen conversion queue and creates a touchscreen input device.
> > >The driver currently only supports 4 wire touchscreens. The driver uses
> > >a simple conversion queue of precharge, touch detection, X measurement,
> > >Y measurement, precharge and another touch detection.
> > >
> > >This driver uses the regmap from the parent to setup some touch specific
> > >settings in the core driver and setup a idle configuration with touch
> > >detection.
> > >
> > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > >Signed-off-by: Denis Carikli <denis@eukrea.com>
> > >Acked-by: Dmitry Torokhov <dtor@vmware.com>
> > >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > >---
> > >  drivers/input/touchscreen/Kconfig         |   6 +
> > >  drivers/input/touchscreen/Makefile        |   1 +
> > >  drivers/input/touchscreen/fsl-imx25-tcq.c | 587 ++++++++++++++++++++++++++++++
> > >  3 files changed, 594 insertions(+)
> > >  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
> > >
> > (...)
> > 
> > >+	ret = request_threaded_irq(priv->irq, mx25_tcq_irq, mx25_tcq_irq_thread,
> > >+				   IRQF_ONESHOT, pdev->name, priv);
> > 
> > We can use devres API for request_thread_irq()...
> > 
> > >+	if (ret) {
> > >+		dev_err(dev, "Failed requesting IRQ\n");
> > >+		goto err_clk_unprepare;
> > >+	}
> > >+
> > >+	ret = mx25_tcq_init(priv);
> > >+	if (ret) {
> > >+		dev_err(dev, "Failed to init tcq\n");
> > >+		goto error_free_irq;
> > >+	}
> > >+
> > >+	platform_set_drvdata(pdev, priv);
> > >+
> > >+	return 0;
> > >+
> > >+error_free_irq:
> > >+	free_irq(priv->irq, priv);
> > 
> > This is not required if we use devres API
> 
> Yes it does - you do not really want to stop clocks in the middle of
> servicing interrupt.

Thanks, I missed the clocks. I will not use devm here then.

For the gcq (ADC) driver, it would still works to use devm_request_irq as the
interrupt can only trigger when the user requested an ADC conversion. So as
soon as the device is unregistered from the IIO subsystem, there should
not be any interrupts. However I would like to keep free_irq in the gcq
driver as well. Unexpected interrupts wouldn't be a problem and
especially if the driver is extended for continous conversion in the
future, this may be better.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/af3b8aeb/attachment.sig>
