From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 18:30:37 +0100
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <53FF6668.4080502@arm.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
 <20140828094846.GD14650@leverpostej>
 <CAOesGMjY8wfAcq2fLgs=ZWHdiWtFqxr+ncUKTje0SnXqO-CCgQ@mail.gmail.com>
 <20140828170306.GQ14650@leverpostej> <53FF6668.4080502@arm.com>
Message-ID: <20140828173037.GA18005@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 06:27:04PM +0100, Marc Zyngier wrote:
> On 28/08/14 18:03, Mark Rutland wrote:
> 
> > From 67104ad5a56e4c18f9c41f06af028b7561740afd Mon Sep 17 00:00:00 2001
> > From: Mark Rutland <mark.rutland@arm.com>
> > Date: Thu, 28 Aug 2014 17:41:03 +0100
> > Subject: [PATCH] Doc: dt: arch_timer: discourage clock-frequency use
> > 
> > The ARM Generic Timer (AKA the architected timer, arm_arch_timer)
> > features a CPU register (CNTFRQ) which firmware is intended to
> > initialize, and non-secure software can read to determine the frequency
> > of the timer. On CPUs with secure state, this register cannot be written
> > from non-secure states.
> > 
> > The firmware of early SoCs featuring the timer did not correctly
> > initialize CNTFRQ correctly on all CPUs, requiring the frequency to be
> > described in DT as a workaround. This workaround is not complete however
> > as CNTFRQ is exposed to all software in a privileged non-secure mode,
> > including KVM guests. The firmware and DTs for recent SoCs have followed
> 
> I believe Xen is also affected by this.

True.

s/KVM/KVM\/Xen/, then?

> > the example set by these early SoCs.
> > 
> > This patch updates the arch timer binding documentation to make it
> > clearer that the use of the clock-frequency property is a poor
> > work-around. The MMIO generic timer binding is similarly updated, though
> > this is less of a concern as there is generally no need to expose the
> > MMIO timers to guest OSs.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
> Short of more explicit threats:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Cheers.

Mark.

> 
> > ---
> >  Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> > index 37b2caf..5ca3f95 100644
> > --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> > +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> > @@ -17,7 +17,10 @@ to deliver its interrupts via SPIs.
> >  - interrupts : Interrupt list for secure, non-secure, virtual and
> >    hypervisor timers, in that order.
> >  
> > -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> > +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> > +  only where necessary to work around BROKEN firmware which does not configure
> > +  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
> > +  STRONGLY DISCOURAGED; fix your firmware unless absolutely impossible.
> >  
> >  - always-on : a boolean property. If present, the timer is powered through an
> >    always-on power domain, therefore it never loses context.
> > @@ -38,7 +41,8 @@ Example:
> >  
> >  - compatible : Should at least contain "arm,armv7-timer-mem".
> >  
> > -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> > +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> > +  only when firmware has not configured the MMIO CNTFRQ registers.
> >  
> >  - reg : The control frame base address.
> >  
> > 
> 
> 
> -- 
> Jazz is not dead. It just smells funny...
