From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Mar 2013 15:55:55 +0000
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <201303261546.50194.arnd@arndb.de>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1303261509080.4430@kaball.uk.xensource.com>
 <20130326153730.GA22368@mudshark.cambridge.arm.com>
 <201303261546.50194.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1303261553120.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Will Deacon wrote:
> > > They can even base the implementation of their smp_ops on the current
> > > psci code, in order to facilitate that I could get rid of psci_ops
> > > (which initialization is based on device tree) and export the psci_cpu_*
> > > functions instead, so that they can be called directly by other smp_ops.
> > 
> > Again, I think this destroys the layering. The whole point is that the PSCI
> > functions are called from within something that understands precisely how to
> > talk to the firmware and what it is capable of.
> 
> Right, we probably the psci smp ops to be separate from the rest of the psci
> code, but I also think that Stefano is right that we should let any platform
> use the psci smp ops if possible, rather than having to implement their own.

[...]
 
> The part that I'm most interested in is making it possible for a platform
> to kill off its native smp ops in the kernel by implementing the psci
> ops. I think it's a good strategy to use psci by default if both 
> platform and psci implementations are available.

I fully agree, and Xen would use it as is.

If the psci node on DT only signifies the presence of psci, not that it
should be used for smp_ops, then we need another DT node or property to
say "this machine uses smp_psci_ops".
