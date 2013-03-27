From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 27 Mar 2013 11:15:23 +0000
Subject: [PATCH v2 6/6] [RFC] arm: use PSCI if available
In-Reply-To: <alpine.LFD.2.03.1303261201530.1372@syhkavp.arg>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1303261509080.4430@kaball.uk.xensource.com>
 <20130326153730.GA22368@mudshark.cambridge.arm.com>
 <201303261546.50194.arnd@arndb.de>
 <alpine.LFD.2.03.1303261201530.1372@syhkavp.arg>
Message-ID: <alpine.DEB.2.02.1303271109080.4430@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013, Nicolas Pitre wrote:
> On Tue, 26 Mar 2013, Arnd Bergmann wrote:
> 
> > On Tuesday 26 March 2013, Will Deacon wrote:
> > > > They can even base the implementation of their smp_ops on the current
> > > > psci code, in order to facilitate that I could get rid of psci_ops
> > > > (which initialization is based on device tree) and export the psci_cpu_*
> > > > functions instead, so that they can be called directly by other smp_ops.
> > > 
> > > Again, I think this destroys the layering. The whole point is that the PSCI
> > > functions are called from within something that understands precisely how to
> > > talk to the firmware and what it is capable of.
> > 
> > Right, we probably the psci smp ops to be separate from the rest of the psci
> > code, but I also think that Stefano is right that we should let any platform
> > use the psci smp ops if possible, rather than having to implement their own.
> 
> Oh absolutely.  It is always best to use an existing standard.  But PSCI 
> probably won't be the only firmware interface standard.  It therefore 
> shouldn't be used as the Linux internal interface model.

I am not proposing to use PSCI as an interal Linux API.

I am proposing to use a set of PSCI based smp_ops (instead of the ones
that come with machine_desc, if any) if a PSCI node is available on
device tree.

smp_ops remains the internal Linux API.

I am also saying that we should let people reuse the PSCI functions in
their own machine-specific smp_ops, if they want to.
