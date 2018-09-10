From: navam@xilinx.com (Nava kishore Manne)
Date: Mon, 10 Sep 2018 04:49:50 +0000
Subject: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for Xilinx
 zynqmp reset controller.
In-Reply-To: <1536143395.4084.5.camel@pengutronix.de>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-4-git-send-email-nava.manne@xilinx.com>
 <1536143395.4084.5.camel@pengutronix.de>
Message-ID: <BYAPR02MB47101009A8B5F7E1BB20C7A2C2050@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp

Thanks for the quick response...
Please find my response inline.

> -----Original Message-----
> From: Philipp Zabel [mailto:p.zabel at pengutronix.de]
> Sent: Wednesday, September 5, 2018 4:00 PM
> To: Nava kishore Manne <navam@xilinx.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [RFC PATCH v3 3/3] reset: reset-zynqmp: Adding support for Xilinx
> zynqmp reset controller.
> 
> Hi,
> 
> thank you for the patch. I have a few comments below:
> 
> On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> > Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
> > The zynqmp reset-controller has the ability to reset lines connected
> > to different blocks and peripheral in the Soc.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v3:
> > 		-None.
> > Changes for v2:
> > 		-Moved eemi_ops into a priv struct as suggested
> > 		 by philipp.
> >
> >  drivers/reset/Makefile       |   1 +
> >  drivers/reset/reset-zynqmp.c | 115
> > +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 116 insertions(+)
> >  create mode 100644 drivers/reset/reset-zynqmp.c
> >
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile index
> > c1261dc..27e4a33 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -21,4 +21,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
> >  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> >  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> >  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> > +obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> >
> > diff --git a/drivers/reset/reset-zynqmp.c
> > b/drivers/reset/reset-zynqmp.c new file mode 100644 index
> > 0000000..f908492
> > --- /dev/null
> > +++ b/drivers/reset/reset-zynqmp.c
> > @@ -0,0 +1,115 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2018 Xilinx, Inc.
> > + *
> > + */
> > +
> > +#include <linux/io.h>
> 
> I think including io.h is not necessary.
> 
> [...]

Will fix in the next version.

> > +static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
> > +			       unsigned long id)
> > +{
> > +	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
> > +	int val, err;
> > +
> > +	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
> > +	if (!err)
> > +		return -EINVAL;
> 
> This looks like it should be
> 
> 	if (err)
> 		return err;
> 
> instead.
> 
> [...]
Will fix in the next version.

> > +static struct reset_control_ops zynqmp_reset_ops = {
> 
> static const struct reset_control_ops zynqmp_reset_ops = {
> 
Will fix in the next version.

> > +	.reset = zynqmp_reset_reset,
> > +	.assert = zynqmp_reset_assert,
> > +	.deassert = zynqmp_reset_deassert,
> > +	.status = zynqmp_reset_status,
> > +};
> > +
> > +static int zynqmp_reset_probe(struct platform_device *pdev) {
> > +	struct zynqmp_reset_data *priv;
> > +
> > +	priv = devm_kzalloc(&pdev->dev,
> > +			    sizeof(*priv), GFP_KERNEL);
> 
> This should fit on one line.
> 
Will fix in the next version.

Regards,
Navakishore.
