From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 28 Jul 2015 14:16:20 +0000
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <20150728010235.GU12927@tiger>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
 <20150727132802.GK12927@tiger>
 <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150728010235.GU12927@tiger>
Message-ID: <CY1PR0301MB0843D0437575B34EE569F50A838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?27? 20:03
> To: Wang Shenwei-B38339
> Cc: jason at lakedaemon.net; Huang Yongcai-B20788;
> linux-kernel at vger.kernel.org; tglx at linutronix.de; shawn.guo at linaro.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
> 
> On Mon, Jul 27, 2015 at 06:24:26PM +0000, Shenwei Wang wrote:
> > > > @@ -87,6 +87,8 @@ obj-$(CONFIG_SOC_IMX7D) += mach-imx7d.o
> > > >
> > > >  ifeq ($(CONFIG_SUSPEND),y)
> > > >  AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
> > > > +AFLAGS_suspend-imx7.o :=-Wa,-march=armv7-a
> > > > +obj-$(CONFIG_IMX_GPCV2)	+= suspend-imx7.o pm-imx7.o
> > >
> > > Shouldn't it be controlled by CONFIG_SOC_IMX7D instead?
> >
> > CONFIG_IMX_GPCV2 is more suitable here. As long as a SOC has the same
> GPCv2 block, the codes should be reused.
> 
> Let's see what problem it will have.  Saying GPCv2 block is used on imx8, we will
> have something like below.
> 
> obj-$(CONFIG_IMX_GPCV2) += suspend-imx7.o pm-imx7.o suspend-imx8.o
> pm-imx8.o

I don't think so. If imx8 use the same GPCv2 block, there should be no pm-imx8.o and suspend-imx8.o.
We should try to reuse the existing ones.
 
> If people want to build a kernel with imx8 support only, suspend-imx7.o and
> pm-imx7.o will also be built in there, which is undesirable.
> 
> The files are named with "-imx7".  It's a clear sign that the build of the files
> should be controlled by something like related to "imx7".
> Ideally, it should be CONFIG_SOC_IMX7.  Since imx7d is the only supported imx7
> soc and there is no CONFIG_SOC_IMX7 available so far, it falls on
> CONFIG_SOC_IMX7D.

We can also interpret "-imx7" is the first SoC which has the GPCv2 block. 

> > > > +extern struct imx_gpcv2_irq *gpcv2_irq_instance;
> > >
> > > Will this give a checkpatch warning?
> >
> > Yes. Any suggestion for that? Move it to a header file?
> 
> Get rid of it.

Then you may resolve the following compile error:

CC      arch/arm/mach-imx/pm-imx7.o
arch/arm/mach-imx/pm-imx7.c: In function ?imx_gpcv2_pm_init?:
arch/arm/mach-imx/pm-imx7.c:836:7: error: ?gpcv2_irq_instance? undeclared (first use in this function)
  cd = gpcv2_irq_instance;
       ^
arch/arm/mach-imx/pm-imx7.c:836:7: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-imx/pm-imx7.o] Error 1

Regards,
Shenwei

> Shawn
