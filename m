From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 05 Dec 2012 10:07:05 -0500 (EST)
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <CAHkRjk5HgM=kL5Li_9qrwXfD+vJGvLLoha_ns6KFdxZW7gLwbA@mail.gmail.com>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
 <20121204123001.GL23368@mudshark.cambridge.arm.com>
 <50BE04C6.4070602@gmail.com> <alpine.LFD.2.02.1212041142490.6589@xanadu.home>
 <20121204171129.GE5314@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1212041252290.6589@xanadu.home>
 <20121204181446.GJ5314@mudshark.cambridge.arm.com>
 <CAHkRjk5HgM=kL5Li_9qrwXfD+vJGvLLoha_ns6KFdxZW7gLwbA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1212051001140.6589@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Dec 2012, Catalin Marinas wrote:

> On 4 December 2012 18:14, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Dec 04, 2012 at 06:02:13PM +0000, Nicolas Pitre wrote:
> >> On Tue, 4 Dec 2012, Will Deacon wrote:
> >> > On Tue, Dec 04, 2012 at 05:00:07PM +0000, Nicolas Pitre wrote:
> >> > > on the topic of a para-virtualised machine, I think that it should
> >> > > simply implement the PSCI calls to bring up CPUs _without_ any holding
> >> > > pen nor spinning tables.  You issue the appropriate PSCI call with the
> >> > > physical address for secondary_startup() as argument and you're done.
> >> > > The host intercepts that call and free a new CPU instance in response.
> >> > > That's all.
> >> >
> >> > I'd be happy to go with this suggestion if it wasn't for one thing:
> >> > platforms that do not implement a secure mode. For these platforms, smc will
> >> > be an undefined instruction at the exception level where it is executed and
> >> > therefore cannot be trapped by the hypervisor.
> >>
> >> Really?  I thought the hypervisor could virtualize SMC calls.  Or is
> >> that considered a security hazard?
> >
> > If the security extensions aren't implemented, the hypervisor can't trap the
> > smc instruction.
> >
> >> I don't remember all the PSCI spec details, but I think there was some
> >> provision for this case i.e. the SMC call could be a HYP call instead.
> >> And if that's not in the spec, then it probably should be added and
> >> implemented as if it was.
> >
> > Well, this depends on the guest taking an undefined instruction exception on
> > the smc, then deciding to issue an hvc instead and *then* having the
> > hypervisor somehow translate that into a PSCI invocation. It could work, but
> > it sounds easy to mess up and relies on the PSCI firmware co-existing with
> > things like kvm.
> 
> We can have enable-method DT entries independent of the SoC and one of
> them can be psci-hvc.
> 
> Just for clarification, AArch32 with virtualisation mandates the
> security extensions, so the SMC can be trapped.

Good. Therefore this one is settled.

> On AArch64 it is a bit
> tricky since the presence of EL3 is not mandate, in which case SMC
> would undef (don't as why ;). That's where we can have different
> enable methods specified via the DT.

In that case, sure.  But do you expect such a configuration to be 
common?  Especially with all this secure booting being and cie enforced 
across the board?  I bet it won't.

So it is probably best to presume PSCI by default, and have a DT 
specified method only when it is necessary to override the default.


Nicolas
