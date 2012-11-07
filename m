From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2012 10:23:57 +0000
Subject: [RFC PATCH 4/4] ARM: gic: use a private mapping for CPU target
 interfaces
In-Reply-To: <alpine.LFD.2.02.1211061755260.21033@xanadu.home>
References: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1350393709-23546-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20121106221651.GE21764@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211061755260.21033@xanadu.home>
Message-ID: <20121107102357.GD23305@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 10:59:35PM +0000, Nicolas Pitre wrote:
> On Tue, 6 Nov 2012, Will Deacon wrote:
> > >  arch/arm/common/gic.c | 42 ++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 34 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> > > index aa52699..1338a55 100644
> > > --- a/arch/arm/common/gic.c
> > > +++ b/arch/arm/common/gic.c
> > > @@ -70,6 +70,13 @@ struct gic_chip_data {
> > >  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> > >  
> > >  /*
> > > + * The GIC mapping of CPU interfaces does not necessarily match
> > > + * the logical CPU numbering.  Let's use a mapping as returned
> > > + * by the GIC itself.
> > > + */
> > > +static u8 gic_cpu_map[8] __read_mostly;
> > 
> > Can we have a #define for the number CPUs supported by the GIC? It gets
> > used a fair amount in this patch for loop bounds etc.
> 
> Sure.  I'll respin the patch.

Cheers Nicolas.

> > >  	/*
> > > +	 * Get what the GIC says our CPU mask is.
> > > +	 */
> > > +	BUG_ON(cpu >= 8);
> > > +	cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
> > 
> > Making the mask a u8 and using readb_relaxed here makes this bit of code
> > clearer to me (and the GIC apparently allows such an access to this
> > register).
> 
> Not always.  At least RTSM throws an exception if you do so.
> Been there.

That would be a bug in the RTSM then. Have you reported it to support? (if
not, I can chase this one up). I'd rather we just fix the model than work
around it in Linux.

Will
