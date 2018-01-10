From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 10 Jan 2018 20:22:00 +0000
Subject: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP PM driver
In-Reply-To: <1515467395.31546.11.camel@mtkswgap22>
References: <1515449444-5274-1-git-send-email-jollys@xilinx.com>
 <1515467395.31546.11.camel@mtkswgap22>
Message-ID: <DM2PR0201MB07677F68C24683D6BF9EDFDEB8110@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Sean for review,

> -----Original Message-----
> From: Sean Wang [mailto:sean.wang at mediatek.com]
> Sent: Monday, January 08, 2018 7:10 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> geert+renesas at glider.be; bjorn.andersson at linaro.org;
> m.szyprowski at samsung.com; michal.simek at xilinx.com; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP PM driver
> 
> On Mon, 2018-01-08 at 14:10 -0800, Jolly Shah wrote:
> > Add ZynqMP PM driver. PM driver provides power management support for
> > ZynqMP.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../bindings/soc/xilinx/xlnx,zynqmp-pm.txt         |  15 ++
> 
> 
> The patch should be split into two: one is for dt-bindings part and the other is for
> driver part. Where dt-binding part should require additionally to send to Rob and
> Cc. devicetree at vger.kernel.org.
> 

Sure. Will do it in next version.


> > diff --git a/drivers/soc/xilinx/zynqmp/Makefile
> > b/drivers/soc/xilinx/zynqmp/Makefile
> > new file mode 100644
> > index 0000000..98034f7
> > --- /dev/null
> > +++ b/drivers/soc/xilinx/zynqmp/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_ZYNQMP_PM) += pm.o
> > diff --git a/drivers/soc/xilinx/zynqmp/pm.c
> > b/drivers/soc/xilinx/zynqmp/pm.c new file mode 100644 index
> > 0000000..7178fb5
> > --- /dev/null
> > +++ b/drivers/soc/xilinx/zynqmp/pm.c
> > @@ -0,0 +1,265 @@
> > +/*
> > + * Xilinx Zynq MPSoC Power Management
> > + *
> > + *  Copyright (C) 2014-2017 Xilinx, Inc.
> 
> should include 2018 ?
> 

Will fix in next version

> > +	if (!eemi_ops || !eemi_ops->get_api_version)
> > +		return -ENXIO;
> > +
> > +	eemi_ops->get_api_version(&pm_api_version);
> > +
> > +	/* Check PM API version number */
> > +	if (pm_api_version != ZYNQMP_PM_VERSION)
> > +		return -ENODEV;
> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq <= 0)
> > +		return -ENXIO;
> > +
> > +	ret = request_irq(irq, zynqmp_pm_isr, IRQF_SHARED, DRIVER_NAME,
> pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
> > +			irq, ret);
> > +		return ret;
> > +	}
> 
> 
> how about use devm_request_irq to simplify error path?

Will change in next version

Thanks,
Jolly Shah
