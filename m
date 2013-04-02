From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Apr 2013 12:11:25 -0400 (EDT)
Subject: [PATCH v4 2/2] arm: prefer PSCI for SMP bringup
In-Reply-To: <alpine.DEB.2.02.1304021522230.5078@kaball.uk.xensource.com>
References: <1364575371-8926-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1303291320580.1372@syhkavp.arg>
 <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1303291349150.1372@syhkavp.arg> <5155EC28.8050608@gmail.com>
 <alpine.DEB.2.02.1304011541010.5078@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304011412030.1171@syhkavp.arg>
 <alpine.DEB.2.02.1304021522230.5078@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1304021202520.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Apr 2013, Stefano Stabellini wrote:

> On Mon, 1 Apr 2013, Nicolas Pitre wrote:
> > On Mon, 1 Apr 2013, Stefano Stabellini wrote:
> > > What are the platforms that are going to use smp_init? Do we know how do
> > > they intend to use it?
> > 
> > VExpress for one.  When booting on a big.LITTLE system such as TC2 on 
> > VExpress, the MCPM layer needs to arbitrate power management operations 
> > on a per cluster basis.  In that case there is a MCPM specific set of 
> > SMP ops to be used, even if it may end up calling into PSCI.
> > 
> > But the important point is that we don't know beforehand what to use, 
> > especially with a kernel that can boot on multiple different VExpress 
> > configurations.  The decision has to be made at run time, and therefore 
> > a static default or mdesc->smp ops doesn't cut it.
> 
> I certainly like the principle and I am in favor of anything that moves
> the decisions at runtime. I have pulled the patch in the series, it's
> going to be in the next version.
> 
> However I am concerned that these platform specific operations won't
> work with Xen at all.
> I am getting increasingly certain that we need a Xen specific check in
> setup_arch to bump up of the priority of PSCI over anything else if Xen
> is running. 

I'm concerned about mixing big.LITTLE and Xen as well.  I don't think 
this is going to make an easy match.  KVM might have an easier fit here.

But, in any case, even if the MCPM layer gets involved, if Xen is there 
then PSCI will end up being the ultimate interface anyway.

But let's cross that bridge when we get to it.  For now this is still a 
non existing problem.


Nicolas
