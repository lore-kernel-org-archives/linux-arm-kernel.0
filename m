From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jul 2015 09:02:35 +0800
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
 <20150727132802.GK12927@tiger>
 <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150728010235.GU12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 06:24:26PM +0000, Shenwei Wang wrote:
> > > @@ -87,6 +87,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> > >
> > >  ifeq ($(CONFIG_SUSPEND),y)
> > >  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> > > +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> > > +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o
> > 
> > Shouldn't it be controlled by CONFIG_SOC_IMX7D instead?
> 
> CONFIG_IMX_GPCV2 is more suitable here. As long as a SOC has the same GPCv2 block, the codes should be reused.

Let's see what problem it will have.  Saying GPCv2 block is used on
imx8, we will have something like below.

obj-$(CONFIG_IMX_GPCV2) += suspend-imx7.o pm-imx7.o suspend-imx8.o pm-imx8.o

If people want to build a kernel with imx8 support only, suspend-imx7.o
and pm-imx7.o will also be built in there, which is undesirable.

The files are named with "-imx7".  It's a clear sign that the build of
the files should be controlled by something like related to "imx7".
Ideally, it should be CONFIG_SOC_IMX7.  Since imx7d is the only
supported imx7 soc and there is no CONFIG_SOC_IMX7 available so far,
it falls on CONFIG_SOC_IMX7D.

> > > +extern struct imx_gpcv2_irq *gpcv2_irq_instance;
> > 
> > Will this give a checkpatch warning?
> 
> Yes. Any suggestion for that? Move it to a header file?

Get rid of it.

Shawn
