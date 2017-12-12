From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 12 Dec 2017 11:12:58 +0000
Subject: [RFC] KVM API extensions for SVE
In-Reply-To: <20171211192432.GL910@cbox>
References: <20171121134913.GI22781@e103592.cambridge.arm.com>
 <20171122195230.GT28855@cbox>
 <20171123184050.GM22781@e103592.cambridge.arm.com>
 <20171124144538.GG28855@cbox>
 <20171211145135.GK22781@e103592.cambridge.arm.com>
 <20171211192432.GL910@cbox>
Message-ID: <20171212111258.GM22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 08:24:32PM +0100, Christoffer Dall wrote:
> On Mon, Dec 11, 2017 at 02:51:36PM +0000, Dave Martin wrote:
> > On Fri, Nov 24, 2017 at 03:45:38PM +0100, Christoffer Dall wrote:

[...]

> > > So you're saying even if we try the "expose full width and read back
> > > hidden values" approach, those hidden values may be changed when
> > > executing the guest, due to the KVM implementation or the way hardware
> > > works, is that the point?
> > 
> > Basically yes.
> > 
> > > I think the KVM interface should be designed similarly to being able to
> > > probe a hardware CPU's register state at various stages of execution.
> > > 
> > > So, for example, if you write content to hidden bits in the SVE
> > > registers from EL2 on real hardware and limit the length using ZCR_EL2,
> > > and then run a bunch of code in EL1/0, and then come back to EL2 and
> > > examine the registers again, then we should model that behavior in
> > > software.
> > > 
> > > In other words, I think we have to model this more closely to what
> > > guarantees ZCR_EL2 gives us, and not ZCR_EL1, and choose something
> > > architecturally compliant which is reasonable to implement.
> > 
> > So, we imagine that provided the vcpu is not run in the meantime,
> > all accesses to SVE regs via the KVM reg API act like they are executed
> > at EL2?
> 
> Yes, userspace probing virtual EL1 state should be like EL2 probing EL1
> state on hardware.
> 
> > 
> > That doesn't seem unreasonable, and it removes any ordering requirement
> > between ZCR_EL1 and the SVE regs providing that the vcpu isn't set
> > running in the meantime.  There is no userspace access to ZCR_EL2 at
> > all, if we go with the model of configuring that via attributes that
> > must be configured before vcpu startup -- in which case there is no
> > ordering requirement there.
> > 
> > The extra bits beyond ZCR_EL1.LEN may disappear as soon as the vcpu
> > is run, but that is architecturally consistent behaviour at least.
> > 
> 
> Yes, I think we agree here.  It will all be interesting with nested
> virtualization where we have to start exposing ZCR_EL2, but that's not
> for today.

OK, that sounds reasonable.  There are a couple of options open for the
nested virt case, but we don't need to worry about it now in any case.

Cheers
---Dave
