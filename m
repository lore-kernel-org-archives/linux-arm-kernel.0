From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jul 2015 22:30:45 +0800
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <CY1PR0301MB0843D0437575B34EE569F50A838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
 <20150727132802.GK12927@tiger>
 <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150728010235.GU12927@tiger>
 <CY1PR0301MB0843D0437575B34EE569F50A838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150728143045.GG12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:16:20PM +0000, Shenwei Wang wrote:
> > The files are named with "-imx7".  It's a clear sign that the build of the files
> > should be controlled by something like related to "imx7".
> > Ideally, it should be CONFIG_SOC_IMX7.  Since imx7d is the only supported imx7
> > soc and there is no CONFIG_SOC_IMX7 available so far, it falls on
> > CONFIG_SOC_IMX7D.
> 
> We can also interpret "-imx7" is the first SoC which has the GPCv2 block. 

In that case you should name the block gpc-imx7d rather than gpcv2 and
symbol as GPC_IMX7D rather than IMX_GPCV2.

> > > > > +extern struct imx_gpcv2_irq *gpcv2_irq_instance;
> > > >
> > > > Will this give a checkpatch warning?
> > >
> > > Yes. Any suggestion for that? Move it to a header file?
> > 
> > Get rid of it.
> 
> Then you may resolve the following compile error:

You didn't get my point.  Rather than defining it as a global variable,
we should try to keep imx_gpcv2_irq as an internal data structure to
irqchip driver, and use well-defined interface to access the data from
pm driver when necessary.

Shawn

> 
> CC      arch/arm/mach-imx/pm-imx7.o
> arch/arm/mach-imx/pm-imx7.c: In function ?imx_gpcv2_pm_init?:
> arch/arm/mach-imx/pm-imx7.c:836:7: error: ?gpcv2_irq_instance? undeclared (first use in this function)
>   cd = gpcv2_irq_instance;
>        ^
> arch/arm/mach-imx/pm-imx7.c:836:7: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/mach-imx/pm-imx7.o] Error 1
