From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Oct 2013 16:42:46 +0100
Subject: [PATCH v8 08/19] arm/xen: get_dma_ops: return xen_dma_ops if
 we are running as xen_initial_domain
In-Reply-To: <alpine.DEB.2.02.1310181319300.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
 <1382031814-8782-8-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1310181319300.26077@kaball.uk.xensource.com>
Message-ID: <20131018154246.GB25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 01:22:18PM +0100, Stefano Stabellini wrote:
> Russell,
> are you OK with this patch?

Only concern is why the change is soo large.

> > -static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> > +static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
> >  {
> >  	if (dev && dev->archdata.dma_ops)
> >  		return dev->archdata.dma_ops;
> >  	return &arm_dma_ops;
> >  }
> >  
> > +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> > +{
> > +	if (xen_initial_domain())
> > +		return xen_dma_ops;
> > +	else
> > +		return __generic_dma_ops(dev);
> > +}
> > +

What's wrong with:

 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
+	if (xen_initial_domain())
+		return xen_dma_ops;
 	if (dev && dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
 	return &arm_dma_ops;
 }
