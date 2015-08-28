From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Fri, 28 Aug 2015 19:23:18 +0000
Subject: [PATCH v2 1/1] irqchip: imx-gpcv2: Simplify the implementation
In-Reply-To: <alpine.DEB.2.11.1508282110260.15006@nanos>
References: <1440617755-2942-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508282110260.15006@nanos>
Message-ID: <CY1PR0301MB08439B2D50D3A2C0EC80D579836E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: 2015?8?28? 14:11
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; jason at lakedaemon.net; sudeep.holla at arm.com;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
> Yongcai-B20788
> Subject: Re: [PATCH v2 1/1] irqchip: imx-gpcv2: Simplify the implementation
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
> >  }
> 
> So once again. As you said before nothing is going to use the case where source
> == NULL, can we please get rid of it?

It will be used to allocate the memory for the predefined values of interrupts for each power
Domain. Can we keep it?

Thanks,
Shenwei

> Thanks,
> 
> 	tglx
