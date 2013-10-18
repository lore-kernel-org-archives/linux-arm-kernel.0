From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 18 Oct 2013 16:59:47 +0100
Subject: [PATCH v8 08/19] arm/xen: get_dma_ops: return xen_dma_ops if we
 are running as xen_initial_domain
In-Reply-To: <20131018154847.GD25034@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
 <1382031814-8782-8-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1310181319300.26077@kaball.uk.xensource.com>
 <20131018154246.GB25034@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1310181643260.26077@kaball.uk.xensource.com>
 <20131018154847.GD25034@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1310181658020.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Russell King - ARM Linux wrote:
> On Fri, Oct 18, 2013 at 04:46:00PM +0100, Stefano Stabellini wrote:
> > On Fri, 18 Oct 2013, Russell King - ARM Linux wrote:
> > > On Fri, Oct 18, 2013 at 01:22:18PM +0100, Stefano Stabellini wrote:
> > > > Russell,
> > > > are you OK with this patch?
> > > 
> > > Only concern is why the change is soo large.
> > > 
> > > > > -static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> > > > > +static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
> > > > >  {
> > > > >  	if (dev && dev->archdata.dma_ops)
> > > > >  		return dev->archdata.dma_ops;
> > > > >  	return &arm_dma_ops;
> > > > >  }
> > > > >  
> > > > > +static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> > > > > +{
> > > > > +	if (xen_initial_domain())
> > > > > +		return xen_dma_ops;
> > > > > +	else
> > > > > +		return __generic_dma_ops(dev);
> > > > > +}
> > > > > +
> > > 
> > > What's wrong with:
> > > 
> > >  static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> > >  {
> > > +	if (xen_initial_domain())
> > > +		return xen_dma_ops;
> > >  	if (dev && dev->archdata.dma_ops)
> > >  		return dev->archdata.dma_ops;
> > >  	return &arm_dma_ops;
> > >  }
> > 
> > 
> > xen_dma_ops functions might have to call back the native implementation.
> > With the above there is no way for a xen_dma_ops function to get to
> > archdata.dma_ops or arm_dma_ops.
> > This is the reason why this patch introduces __generic_dma_ops.
> 
> Ah, that's fine then, but having that described in the commit message
> would be useful.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Thanks.

Thank you. I'll add a note to the commit message.
