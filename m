From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 26 Aug 2015 20:54:21 +0200 (CEST)
Subject: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
In-Reply-To: <CY1PR0301MB084315B04E53CF64EF299D0B83600@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1508261756540.15006@nanos>
 <CY1PR0301MB084315B04E53CF64EF299D0B83600@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1508262052260.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2015, Shenwei Wang wrote:
> > From: Thomas Gleixner [mailto:tglx at linutronix.de]
> > > +	cd = imx_gpcv2_instance;
> > > +	if (!cd)
> > >  		return 0;
> > >
> > > +	for (i = 0; i < IMR_NUM; i++) {
> > > +		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > > +		cd->wakeup_sources[i] = readl_relaxed(reg);
> > > +	}
> > > +
> > >  	if (sources)
> > > -		*sources = imx_gpcv2_instance->wakeup_sources;
> > > +		*sources = cd->wakeup_sources;
> > >
> > >  	return IMR_NUM;
> > 
> > You do not need the intermediate storage at all.
> > 
> > u32 imx_gpcv2_get_wakeup_source(u32 *sources) {
> > 	if (sources) {
> > 		for (i = 0; i < IMR_NUM; i++) {
> > 			reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > 			sources[i] = readl_relaxed(reg);
> > 		}
> > 	}
> > 	....
> 
> Using the intermediate storage here can make the caller a little easier,
> because the caller does not need to malloc the memory before the call.
> Especially the caller does not even know how many memory to allocate
> In the beginning.

Fair enough, but why do you need that case where sources can be NULL
just to return IMR_NUM?

Thanks,

	tglx
