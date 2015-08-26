From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 26 Aug 2015 19:05:18 +0000
Subject: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
In-Reply-To: <alpine.DEB.2.11.1508262052260.15006@nanos>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508261756540.15006@nanos>
 <CY1PR0301MB084315B04E53CF64EF299D0B83600@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1508262052260.15006@nanos>
Message-ID: <CY1PR0301MB0843D0E99E78F30D0DEBC8B783600@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > > > +
> > > >  	if (sources)
> > > > -		*sources = imx_gpcv2_instance->wakeup_sources;
> > > > +		*sources = cd->wakeup_sources;
> > > >
> > > >  	return IMR_NUM;
> > >
> > > You do not need the intermediate storage at all.
> > >
> > > u32 imx_gpcv2_get_wakeup_source(u32 *sources) {
> > > 	if (sources) {
> > > 		for (i = 0; i < IMR_NUM; i++) {
> > > 			reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > > 			sources[i] = readl_relaxed(reg);
> > > 		}
> > > 	}
> > > 	....
> >
> > Using the intermediate storage here can make the caller a little
> > easier, because the caller does not need to malloc the memory before the call.
> > Especially the caller does not even know how many memory to allocate
> > In the beginning.
> 
> Fair enough, but why do you need that case where sources can be NULL just to
> return IMR_NUM?

The intention is to get the IMR_NUM only. But so far no user uses this feature.

Thanks,
Shenwei

> Thanks,
> 
> 	tglx
