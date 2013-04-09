From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Apr 2013 14:34:25 -0400 (EDT)
Subject: [PATCH v4 2/2] arm: prefer PSCI for SMP bringup
In-Reply-To: <20130409122133.GA2233@linaro.org>
References: <1364575371-8926-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.LFD.2.03.1303291320580.1372@syhkavp.arg>
 <alpine.DEB.2.02.1303291735080.4430@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1303291349150.1372@syhkavp.arg> <5155EC28.8050608@gmail.com>
 <alpine.DEB.2.02.1304011541010.5078@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304011412030.1171@syhkavp.arg>
 <alpine.DEB.2.02.1304021522230.5078@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304021202520.1171@syhkavp.arg>
 <20130409122133.GA2233@linaro.org>
Message-ID: <alpine.LFD.2.03.1304091421370.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Apr 2013, Dave Martin wrote:

> On Tue, Apr 02, 2013 at 12:11:25PM -0400, Nicolas Pitre wrote:
> > I'm concerned about mixing big.LITTLE and Xen as well.  I don't think 
> > this is going to make an easy match.  KVM might have an easier fit here.
> > 
> > But, in any case, even if the MCPM layer gets involved, if Xen is there 
> > then PSCI will end up being the ultimate interface anyway.
> 
> Note that big.LITTLE != MCPM.  Virtualisation hosts might be large multi-
> cluster systems, but the CPUs might be all of the same type.  MCPM or
> similar would me needed for the multi-cluster power management even
> though there is no big.LITTLE mix of CPUs.

Absolutely!  But in this case, there is no need for Xen to learn about 
the computing capacity differences between different CPU sets.

What I wanted to emphasize is the fact that, if Xen decides to expose a 
b.L topology to guests, then those guests must be b.L aware to make good 
scheduling decisions, etc.  Initially I suspect that guests will be 
confined to the same sets of CPUs to simplify things.  Or it could even 
migrate a guest between little and big CPUs like the switcher does.  
But a single guest probably won't span different CPU classes 
simultaneously initially.  And therefore it is unlikely that MCPM will 
be active inside a Xen guest for quite a while.

> > But let's cross that bridge when we get to it.  For now this is still a 
> > non existing problem.
> 
> That's a big open question.  Either the host or hypervisor needs to be
> very clever about scheduling guests, or you need to bind each guest virtual
> CPU to a specific class of physical CPUs -- so, for example you provide
> a guest with an explicit mix of bigs and littles.
> 
> All we can say about that for now is that it's a potential research area...

Absolutely.


Nicolas
