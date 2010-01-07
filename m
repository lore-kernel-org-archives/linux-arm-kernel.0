From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 7 Jan 2010 15:06:02 +0530
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C041C1BD@dbde02.ent.ti.com>
References: <1262851175.3933.5.camel@Nokia-N900-51-1>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C041C1BD@dbde02.ent.ti.com>
Message-ID: <0680EC522D0CC943BC586913CF3768C003AF886DA0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Venkatraman S wrote: 
> > On Wed, Jan 6, 2010 at 6:46 PM, Adrian Hunter 
> > <adrian.hunter@nokia.com>
> > wrote: 
> > > Venkatraman S wrote: 
> > > > 
> > > > On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren 
> <tony@atomide.com>
> > wrote: 
> > > > > 
> > > > > * Venkatraman S <svenkatr@ti.com> [091211 07:01]: 
> > > > > > 
> > > > > > Here is the most updated version of the patch (thanks to 
> > > > > > Russell's review). This patch is applicable to OMAP4xxx as 
> > > > > > well as OMAP3630 Reference to previous posts
> > > > > > v1? http://marc.info/?l=linux-omap&m=125012097403050&w=2
> > > > > > v2? http://marc.info/?l=linux-omap&m=125137152606644&w=2
> > > > > > v3? http://patchwork.kernel.org/patch/45408/
> > > > > 
> > > > > Do you have a patch for drivers/mmc/host/omap_hsmmc.c to use 
> > > > > this feature? Or some other driver?
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Tony
> > > > 
> > > > I am about to start working on omap_hsmmc to use the descriptor 
> > > > load feature. If the DMA changes are acceptable, I can post the 
> > > > driver patch as well.
> > > 
> > > I presume this is about performance.? How does it compare 
> to chained
> > DMA? 
> > > We have a patch for omap_hsmmc for chained DMA that we are still
> > testing. 
> > > 
> >? The main difference would be the number of logical channels used. 
> > With chaining, I assume you'd request for (or the API internally
> > reserves) as many logical channels as there are segments. Here a  
> >single logical channel would do.
> > 
> 
> How does the performance compare? Which is faster? Does 
> descriptor autoloading reduce the number of interrupts? 
> >>
> This should improve the perforamance compared to chaining  
> case. This features emulates scatter gather transfers 
> capability with minimum MPU support by removing the 
> successive channel configuration processing and the 
> associated interrupt handling overheads. 
> This is apart from optimize channel resources by enabling 
> efficient transfer ?serialization? on a single logical 
> channel versus concurrent (multiple) logical channel usage. 
> 
> Regards,
> Santosh
> 

We have not done full benchmark tests yet, but as Santosh mentioned,
1) Only one logical channel is used.
2) No interrupts are generated till the end of transfer of the entire scatterlist.
(Infact, multiple scatterlists can be combined by the user driver to a single
descriptor list, and no IRQs would be generated till the entire transfer completes.
If needed, the descriptors can be programmed to generate interrupt(s) at any point.)
This should yield better performance / CPU utilization than chaining.

Regards,
Venkat.
