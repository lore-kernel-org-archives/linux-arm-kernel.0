From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 29 Jul 2014 18:00:23 +0200
Subject: [PATCH 13/35] arm: omap: irq: call set_handle_irq() from
 intc_of_init
In-Reply-To: <20140729153649.GD17808@saruman.home>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-14-git-send-email-balbi@ti.com>
 <20140729022019.GB4421@earth.universe>
 <20140729153649.GD17808@saruman.home>
Message-ID: <20140729160022.GA21830@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 29, 2014 at 10:36:49AM -0500, Felipe Balbi wrote:
> On Tue, Jul 29, 2014 at 04:20:20AM +0200, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Mon, Jul 28, 2014 at 04:16:01PM -0500, Felipe Balbi wrote:
> > > this will let us drop .handle_irq and .init_irq fields
> > > from our generic machine_descs.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/irq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> > > index e6997c5..e452411 100644
> > > --- a/arch/arm/mach-omap2/irq.c
> > > +++ b/arch/arm/mach-omap2/irq.c
> > > @@ -314,6 +314,8 @@ static int __init intc_of_init(struct device_node *node,
> > >  
> > >  	omap_init_irq(res.start, nr_irq, of_node_get(node));
> > >  
> > > +	set_handle_irq(omap2_intc_handle_irq);
> > > +
> > >  	return 0;
> > >  }
> > >
> > 
> > if you respin the patchset you may want to call omap_intc_handle_irq
> > directly. It makes the review of the patchset less confusing.
> > 
> > (I was wondering why omap3 can call omap2_intc_handle_irq until I
> > noticed, that your previous changes made both functions simple
> > wrapper functions for omap_intc_handle_irq)
> 
> this is done later for a reason. At this point, omap_intc_handle_irq()
> still misses proper annotations for asmlinkage and
> __exception_irq_entry.

I guess that could be solved by moving the annotations to
omap_intc_handle_irq and just keeping omap{23}_intc_handle_irq as a
#define. Probably not worth the extra work, though.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/4ddde5b3/attachment-0001.sig>
