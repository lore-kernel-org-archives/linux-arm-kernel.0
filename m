From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Dec 2012 18:14:46 +0000
Subject: [RFC PATCH 0/2] Add support for a fake, para-virtualised machine
In-Reply-To: <alpine.LFD.2.02.1212041252290.6589@xanadu.home>
References: <1354557160-20144-1-git-send-email-will.deacon@arm.com>
 <50BD1F81.9080304@gmail.com>
 <20121204123001.GL23368@mudshark.cambridge.arm.com>
 <50BE04C6.4070602@gmail.com>
 <alpine.LFD.2.02.1212041142490.6589@xanadu.home>
 <20121204171129.GE5314@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1212041252290.6589@xanadu.home>
Message-ID: <20121204181446.GJ5314@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 06:02:13PM +0000, Nicolas Pitre wrote:
> On Tue, 4 Dec 2012, Will Deacon wrote:
> 
> > Hi Nicolas,
> > 
> > On Tue, Dec 04, 2012 at 05:00:07PM +0000, Nicolas Pitre wrote:
> > > on the topic of a para-virtualised machine, I think that it should 
> > > simply implement the PSCI calls to bring up CPUs _without_ any holding 
> > > pen nor spinning tables.  You issue the appropriate PSCI call with the 
> > > physical address for secondary_startup() as argument and you're done.  
> > > The host intercepts that call and free a new CPU instance in response.  
> > > That's all.
> > 
> > I'd be happy to go with this suggestion if it wasn't for one thing:
> > platforms that do not implement a secure mode. For these platforms, smc will
> > be an undefined instruction at the exception level where it is executed and
> > therefore cannot be trapped by the hypervisor.
> 
> Really?  I thought the hypervisor could virtualize SMC calls.  Or is 
> that considered a security hazard?

If the security extensions aren't implemented, the hypervisor can't trap the
smc instruction.

> I don't remember all the PSCI spec details, but I think there was some 
> provision for this case i.e. the SMC call could be a HYP call instead.  
> And if that's not in the spec, then it probably should be added and 
> implemented as if it was.

Well, this depends on the guest taking an undefined instruction exception on
the smc, then deciding to issue an hvc instead and *then* having the
hypervisor somehow translate that into a PSCI invocation. It could work, but
it sounds easy to mess up and relies on the PSCI firmware co-existing with
things like kvm.

> > If that situation requires a pen, I see no benefit from having two boot
> > schemes where one of them would work in every case.
> 
> We always have the choice between several schemes in device drivers for 
> example, depending on the hardware generation.  Yet we always implement 
> the better scheme for the newest hardware for performance reasons, even 
> if an older one could work in all cases.

Again, I totally agree when it comes to things like poweroff and hotplug but
for booting I don't think we gain much from having multiple implementations
for a single platform. Hopefully this is moot -- see below.

> A holding pen is a rather stupid scheme.  Please let's try to do without 
> it if possible.

I've just hacked up Rob's suggestion and it seems to be working, so I'll
post a pen-less v2 tomorrow. The hotplug/reboot code can come later when we
have something host-side that we can use (could be PSCI).

Will
