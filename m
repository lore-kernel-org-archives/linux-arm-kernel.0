From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 19 Apr 2013 10:52:31 +0100
Subject: [Xen-devel] [PATCH v6 1/4] arm: introduce psci_smp_ops
In-Reply-To: <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130418161341.GB14496@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1304181714560.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181237480.17375@syhkavp.arg>
 <alpine.DEB.2.02.1304181749260.7254@kaball.uk.xensource.com>
 <alpine.LFD.2.03.1304181336280.17375@syhkavp.arg>
Message-ID: <1366365151.19111.80.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-18 at 18:38 +0100, Nicolas Pitre wrote:
> On Thu, 18 Apr 2013, Stefano Stabellini wrote:
> 
> > On Thu, 18 Apr 2013, Nicolas Pitre wrote:
> > > On Thu, 18 Apr 2013, Stefano Stabellini wrote:
> > > 
> > > > On Thu, 18 Apr 2013, Russell King - ARM Linux wrote:
> > > > > This should allow the Xen problem to be resolved, because Xen will
> > > > > provide the PSCI operations, and it's correct in that case to override
> > > > > the platform's SMP operations.
> > > > 
> > > > Yes, increasing the priority of PSCI helps Xen a lot.
> > > > In order to completely solve the issue for Xen though, another patch is
> > > > needed (http://marc.info/?l=linux-kernel&m=136630106201968&w=2) because
> > > > of the introduction of smp_init.
> > > 
> > > Please look at the latest smp_init patch version I sent to you.  It 
> > > shouldn't conflict with Xen any longer.  It now returns a bool result 
> > > depending on whether it did set up smp_ops or not.
> > 
> > CPUs are virtualized by Xen and do not reflect or expose the underlying
> > SMP hardware and firmware features, so an hardware specific smp_init
> > cannot run.
> > 
> > So the smp_init patch still breaks Xen because even if smp_init can fail
> > graciously, executing a platform specific smp_init function that tries
> > to access registers and memory regions that are not present is going to
> > cause an undefined behaviour.
> 
> It won't access hardware but just look into the DT and return false if 
> nothing interesting is found.  At which point the next attempt in the 
> priority list is PSCI by default.

I think there might be some confusion about the semantics of smp_init,
since it is in mdesc I had interpreted it as a per-platform hook to
allow "magic" SMP setup, which I at least had assumed would (be
permitted to) involve hardware specific frobbing, including touching
platform specific devices etc.

Is that not the case?

Can we guarantee that this hook won't be used by hardware platforms to
e.g. probe NVRAM for SMP topology information or other activities which
touch hardware?

If it isn't hardware specific then does this hook really belong in
mdesc? Or if it is purely driven by DT can we not implement it in terms
of DT at the top level rather than abstracting via a hardware specific
hook?

Ian.
