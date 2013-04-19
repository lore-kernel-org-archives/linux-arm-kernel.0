From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Apr 2013 12:33:22 -0400 (EDT)
Subject: [Xen-devel] [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <1366388166.29403.2.camel@dagon.hellion.org.uk>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181237480.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181749260.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304191035360.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304191146230.17375@syhkavp.arg>
 <1366388166.29403.2.camel@dagon.hellion.org.uk>
Message-ID: <alpine.LFD.2.03.1304191223280.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Apr 2013, Ian Campbell wrote:

> On Fri, 2013-04-19 at 16:47 +0100, Nicolas Pitre wrote:
> > No one should be probing registers without making sure it is safe to do 
> > so.  Even on non virtualized hardware this can be a dangerous thing to 
> > do.
> 
> Won't people writing per machine code consider, not unreasonably, that
> having been called through a mdesc machine specific hook constitutes
> enough "making sure" that they think it is safe to touch registers which
> are specific to that machine?

Remember that this hook was introduced to decide at run time between 
different possibilities for SMP ops on the _same_ machine configuration.  
That machine shouldn't do things which is not permitted on either 
possible alternatives already.  So far the actual usage of that hook 
only looks in the DT to make a decision.  But even if it were to touch 
the hardware, that means it has to be safe to do so on all the possible 
hardware variations this mdesc is associated to.

And if Xen wants to emulate one of those hardware alternatives, then it 
better be ready to emulate it properly, or manage for _another_ mdesc to 
be selected instead.  That's why mach-virt was introduced.

So in my opinion there is just no issue here.


Nicolas
