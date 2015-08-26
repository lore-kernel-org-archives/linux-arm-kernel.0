From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 26 Aug 2015 16:32:11 +0000
Subject: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
In-Reply-To: <alpine.DEB.2.11.1508261756540.15006@nanos>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508261756540.15006@nanos>
Message-ID: <CY1PR0301MB084315B04E53CF64EF299D0B83600@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?26? 11:00
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net; sudeep.holla at arm.com;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: Re: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
> 
> On Wed, 26 Aug 2015, Shenwei Wang wrote:
> >  u32 imx_gpcv2_get_wakeup_source(u32 **sources)  {
> > -	if (!imx_gpcv2_instance)
> > +	struct gpcv2_irqchip_data *cd;
> > +	void __iomem *reg;
> > +	int i;
> > +
> > +	cd = imx_gpcv2_instance;
> > +	if (!cd)
> >  		return 0;
> >
> > +	for (i = 0; i < IMR_NUM; i++) {
> > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > +		cd->wakeup_sources[i] = readl_relaxed(reg);
> > +	}
> > +
> >  	if (sources)
> > -		*sources = imx_gpcv2_instance->wakeup_sources;
> > +		*sources = cd->wakeup_sources;
> >
> >  	return IMR_NUM;
> 
> You do not need the intermediate storage at all.
> 
> u32 imx_gpcv2_get_wakeup_source(u32 *sources) {
> 	if (sources) {
> 		for (i = 0; i < IMR_NUM; i++) {
> 			reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> 			sources[i] = readl_relaxed(reg);
> 		}
> 	}
> 	....

Using the intermediate storage here can make the caller a little easier,
because the caller does not need to malloc the memory before the call.
Especially the caller does not even know how many memory to allocate
In the beginning.

Thanks,
Shenwei

> Hmm?
