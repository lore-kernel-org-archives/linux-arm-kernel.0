From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 01:55:33 -0400
Subject: [PATCH] GICv3: Fixing 32 bit compatibility
In-Reply-To: <540DBC0C.7080902@arm.com>
References: <1410185480-5153-1-git-send-email-rric@kernel.org>
 <540DBC0C.7080902@arm.com>
Message-ID: <20140914055533.GK21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 03:24:12PM +0100, Marc Zyngier wrote:
> Hi Robert,
> 
> On 08/09/14 15:11, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > Fixing 32 bit compatibility by using ULL for u64 constants.
> > 
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 57eaa5a0b1e3..9e13c87c7dfe 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -441,7 +441,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
> >  
> >  		mpidr = cpu_logical_map(cpu);
> >  
> > -		if (cluster_id != (mpidr & ~0xffUL)) {
> > +		if (cluster_id != (mpidr & ~0xffULL)) {
> >  			cpu--;
> >  			goto out;
> >  		}
> > @@ -479,7 +479,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >  	smp_wmb();
> >  
> >  	for_each_cpu_mask(cpu, *mask) {
> > -		u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
> > +		u64 cluster_id = cpu_logical_map(cpu) & ~0xffULL;
> >  		u16 tlist;
> >  
> >  		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
> > 
> 
> Yeah, and there are many more. I'm currently sitting on a rather long
> queue of GICv3-related 32bit patches. I'll try to get that posted shortly.

I'll hold off until you post a complete series then.

thx,

Jason.
