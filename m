From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 17:00:28 +0000
Subject: [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate
 before hot-unplugging a CPU
In-Reply-To: <alpine.LFD.2.02.1301141151510.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-8-git-send-email-nicolas.pitre@linaro.org>
 <20130114163755.GB31341@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1301141151510.6300@xanadu.home>
Message-ID: <20130114170028.GD31341@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 04:53:41PM +0000, Nicolas Pitre wrote:
> On Mon, 14 Jan 2013, Will Deacon wrote:
> 
> > On Thu, Jan 10, 2013 at 12:20:42AM +0000, Nicolas Pitre wrote:
> > > If for whatever reason a CPU is unexpectedly awaken, it shouldn't
> > > re-enter the kernel by using whatever entry vector that might have
> > > been set by a previous operation.
> > > 
> > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > ---
> > >  arch/arm/common/bL_platsmp.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm/common/bL_platsmp.c b/arch/arm/common/bL_platsmp.c
> > > index 0acb9f4685..0ae44123bf 100644
> > > --- a/arch/arm/common/bL_platsmp.c
> > > +++ b/arch/arm/common/bL_platsmp.c
> > > @@ -63,6 +63,11 @@ static int bL_cpu_disable(unsigned int cpu)
> > >  
> > >  static void __ref bL_cpu_die(unsigned int cpu)
> > >  {
> > > +	unsigned int mpidr, pcpu, pcluster;
> > > +	asm ("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> > > +	pcpu = mpidr & 0xff;
> > > +	pcluster = (mpidr >> 8) & 0xff;
> > 
> > Usual comment about helper functions :)
> > 
> > > +	bL_set_entry_vector(pcpu, pcluster, NULL);
> > 
> > Similar to the power_on story, you need a barrier here (unless you change
> > your platform_ops API to require barriers).
> 
> The bL_set_entry_vector() includes a cache flush which itself has a DSB.  
> Hence my previous interrogation.

For L1, sure, we always have the dsb for v7. However, for the outer-cache we
only have a dsb by virtue of a spin_unlock in l2x0.c... it seems a bit risky
to rely on that for ordering your entry_vector write with the power_on.

I think the best bet is to put a barrier in power_on, before invoking the
platform_ops function and similarly for power_off.

What do you reckon?

Will
