From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jan 2014 17:56:42 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140107150631.GJ31886@sirena.org.uk>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <1387483575-11430-4-git-send-email-broonie@kernel.org>
 <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
 <20140107133829.GF31886@sirena.org.uk>
 <20140107142929.GB8090@e102568-lin.cambridge.arm.com>
 <20140107150631.GJ31886@sirena.org.uk>
Message-ID: <20140107175641.GA14603@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:06:31PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 02:29:29PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Jan 07, 2014 at 01:38:29PM +0000, Mark Brown wrote:
> > > On Tue, Jan 07, 2014 at 01:05:40PM +0000, Lorenzo Pieralisi wrote:
> 
> > > > It is time we defined what a "disabled" CPU means in ARM world, I need to
> > > > have a proper look into this since this topic has been brought up before.
> 
> > > What is the confusion here - why would there be something architecture
> > > specific going on?
> 
> > I think this check was added following this thread discussion:
> 
> > http://lkml.indiana.edu/hypermail/linux/kernel/1306.0/03663.html
> 
> > So my question is: what does "disabled" mean ? A CPU present in HW
> > that can't/must not be booted ?
> 
> Yes, that would seem to be the obvious meaning and consistent with ePAPR
> (in so far as we're paying a blind bit of notice to ePAPR, see other
> threads...).

Just playing devil's advocate and trying to reuse ePAPR bindings as much as
possible, provided they define what we need on ARM. In this case it seems they
do not.

> > ePAPR v1.1 page 43:
> 
> > "disabled". The CPU is in a quiescent state. A quiescent CPU is in a state
> > where it cannot interfere with the normal operation of other CPUs, nor can
> > its state be affected by the normal operation of other running CPUs, except
> > by an explicit method for enabling or reenabling the quiescent CPU (see the
> > enable-method property).
> 
> > This means that a "disabled" CPU can be booted with eg PSCI but that is
> > not what the thread in the link above wants to achieve. Furthermore, if
> 
> I think that's just another bit of ill considered wording from ePAPR
> that doesn't really reflect reality; it seems like what they're trying
> to shoot for there is administratively down.  
> 
> At the very least that means hot unplugged, and it seems reasonable to
> read that as being stronger than that.  The current ARM implementation
> is more conservative since it doesn't provide any way to put the core on
> line but it does seem more likely to match what a system integrator
> would be trying to achieve and it also matches the standard meaning of
> disabled.

What do you mean by ARM implementation ? The status property is currently
ignored on ARM. I'd agree with what you are saying but that should be
specified in DT bindings.

> > we add the check in topology.c, the check must be executed also when
> > building the cpu_logical_map, otherwise a "disabled" cpu would be marked
> > possible and then booted, am I wrong ?
> 
> Right, this is a separate issue in the SMP enumeration code - it should
> be paying attention to the property and at the very least defaulting the
> core to being unplugged, though like I say I do find the ARM meaning
> more sane.

Again, I tend to agree, since this means that the CPU is there but
simply is not a "possible" one. To be debated.

> In any case I don't vastly care, I guess I'll drop this for now.

Yes, I think dropping the check is fine for now, we can add it if/when
we achieve consensus, that should not be a big deal.

Lorenzo
