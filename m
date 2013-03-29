From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 29 Mar 2013 13:53:35 -0400 (EDT)
Subject: [PATCH v4 2/2] arm: prefer PSCI for SMP bringup
In-Reply-To: <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
References: <1364575371-8926-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1303291320580.1372@syhkavp.arg>
 <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1303291349150.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Mar 2013, Stefano Stabellini wrote:

> On Fri, 29 Mar 2013, Nicolas Pitre wrote:
> > On Fri, 29 Mar 2013, Stefano Stabellini wrote:
> > 
> > > If PSCI initializes correctly and PSCI SMP operations are available, use them.
> > > This is required for SMP support in Dom0 on Xen.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > CC: will.deacon at arm.com
> > > CC: arnd at arndb.de
> > > CC: marc.zyngier at arm.com
> > > CC: linux at arm.linux.org.uk
> > > CC: nico at linaro.org
> > 
> > I'd suggest you also include in your series the patch I posted earlier 
> > providing a runtime mdesc->smp_init method as well.
> 
> OK.
> 
> 
> > This way the 
> > priority order would be:
> > 
> > - If mdesc->smp_init is non null then use that.
> > 
> > - Otherwise, if PSCI is available then use that.
> > 
> > - Otherwise use mdesc->smp.
> > 
> > This way, if the PSCI default has to be overriden (like in the MCPM case 
> > because it needs to wrap PSCI itself, or to cover Rob's concern) then 
> > this can be achieved at run time on a per mdesc basis.
> 
> Actually that's not a bad idea, it could make everybody happy.
> What about the following, in this precise order:
> 
> - if a xen hypervisor node is present on device tree, use PSCI;
> - otherwise if mdesc->smp_init is non null then use it;
> - otherwise if PSCI is available then use it;
> - otherwise use mdesc->smp.
> 
> It's the most practical solution to satisfy everybody's needs.

Maybe I'm missing something obvious, but why can't xen declare a mdesc 
of its own?  Given it is going to tweak the DT passed to the kernel 
anyway that shouldn't be a problem.

That would be more eleguant than adding xen exception hooks in generic 
code.


Nicolas
