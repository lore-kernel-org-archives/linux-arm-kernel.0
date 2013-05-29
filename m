From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 May 2013 12:59:06 -0400 (EDT)
Subject: [PATCH 8/8] ARM: vexpress/dcscb: select multi-cluster SMP
 operations
In-Reply-To: <1369845421.3715.76.camel@linaro1.home>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
 <1369374311-21260-9-git-send-email-nicolas.pitre@linaro.org>
 <1369824504.3715.23.camel@linaro1.home>
 <alpine.LFD.2.03.1305291054150.1918@syhkavp.arg>
 <1369845421.3715.76.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1305291250240.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Jon Medhurst (Tixy) wrote:

> On Wed, 2013-05-29 at 11:17 -0400, Nicolas Pitre wrote:
> > On Wed, 29 May 2013, Jon Medhurst (Tixy) wrote:
> > 
> > > On Fri, 2013-05-24 at 01:45 -0400, Nicolas Pitre wrote:
> > > > When the DCSCB code is successfully probed and initialized, then the
> > > > generic MCPM SPM ops should be used as those operations need to be
> > > > arbitrated through the MCPM layer.
> > > > 
> > > > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > ---
> > > >  arch/arm/mach-vexpress/dcscb.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
> > > > index 1acc975360..ce3118dc05 100644
> > > > --- a/arch/arm/mach-vexpress/dcscb.c
> > > > +++ b/arch/arm/mach-vexpress/dcscb.c
> > > > @@ -239,6 +239,8 @@ static int __init dcscb_init(void)
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > +	mcpm_smp_set_ops();
> > > > +
> > > 
> > > This is going to change the platform's smp_ops after setup_arch() has
> > > already set them, is that OK and not too late?
> > 
> > Well...  The only methods being invoked before the booting of secondary 
> > CPUs are smp_init_cpus and smp_prepare_cpus.  In the MCPM case they're 
> > both no-ops.
> > 
> > > I ask, because for me, RTSM doesn't boot the secondary CPUs if we rely
> > > on this change to set the smp_ops, but having a hook in setup_arch() to
> > > select instead of the standard vexpress ops does work.
> > 
> > Strange.  That works for me both ways.
> 
> Actually, this patch series works for me if I take it on it's own but
> what should be the same changes in the IKS branch don't. I'll do more
> investigation...

After a closer look, I noticed that I only have 5 out of 8 CPUs online.

So as I suspected, the default prepare_cpus method is not empty and 
causing problems here.  In this case, vexpress_smp_prepare_cpus() is 
calling vexpress_flags_set() sending any waiting CPU into 
versatile_secondary_startup where they'll stay forever (the MCPM code 
expects every new born to go through mcpm_entry_point).

I'll revert to the previous arrangement and we could revisit the 
awkwardness of it later.


Nicolas
