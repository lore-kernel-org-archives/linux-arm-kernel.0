From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 30 Jan 2014 17:21:15 +0000
Subject: [PATCH] arm: document "mach-virt" platform.
In-Reply-To: <52EA8853.8080709@arm.com>
References: <1391098262-15944-1-git-send-email-ian.campbell@citrix.com>
 <52EA8853.8080709@arm.com>
Message-ID: <1391102475.9495.44.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-30 at 17:13 +0000, Marc Zyngier wrote:
> Hi Ian,
> 
> On 30/01/14 16:11, Ian Campbell wrote:
> > mach-virt has existed for a while but it is not written down what it actually
> > consists of. Although it seems a bit unusual to document a binding for an
> > entire platform since mach-virt is entirely virtual it is helpful to have
> > something to refer to in the absence of a single concrete implementation.
> > 
> > I've done my best to capture the requirements based on the git log and my
> > memory/understanding.
> > 
> > While here remove the xenvm dts example, the Xen tools will now build a
> > suitable mach-virt compatible dts when launching the guest.
> > 
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > Cc: devicetree at vger.kernel.org
> > Cc: linux-kernel at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > ---
> > I'm not sure which tree this sort of thing should go though, sorry for the
> > huge Cc.
> > ---
> >  .../devicetree/bindings/arm/mach-virt.txt          |   32 ++++++++
> >  arch/arm/boot/dts/xenvm-4.2.dts                    |   81 --------------------
> >  2 files changed, 32 insertions(+), 81 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mach-virt.txt
> >  delete mode 100644 arch/arm/boot/dts/xenvm-4.2.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mach-virt.txt b/Documentation/devicetree/bindings/arm/mach-virt.txt
> > new file mode 100644
> > index 0000000..562bcda
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mach-virt.txt
> > @@ -0,0 +1,32 @@
> > +* Mach-virt "Dummy Virtual Machine" platform
> > +
> > +"mach-virt" is the smallest, dumbest platform possible, to be used as
> > +a guest for Xen, KVM and other hypervisors. It has no
> > +properties/functionality of its own and is driven entirely by device
> > +tree.
> > +
> > +This document defines the requirements for such a platform.
> > +
> > +* Required properties:
> > +
> > +- compatible: should be one of:
> > +	"linux,dummy-virt"
> > +	"xen,xenvm"
> > +
> > +In addition to the standard nodes (chosen, cpus, memory etc) the
> > +platform is required to provide certain other basic functionality
> > +which must be described in the device tree:
> > +
> > +    The platform must provide an ARM Generic Interrupt Controller
> > +    (GIC), defined in Documentation/devicetree/bindings/arm/gic.txt.
> > +
> > +    The platform must provide ARM architected timer, defined in
> > +    Documentation/devicetree/bindings/arm/arch_timer.txt.
> > +
> > +    If the platform is SMP then it must provide the Power State
> > +    Coordination Interface (PSCI) described in
> > +    Documentation/devicetree/bindings/arm/psci.txt.
> 
> I'm afraid I disagree with most of the above. The whole point of
> mach-virt is to provide a shell for DT platforms. None of this hardware
> is mandated. Instead, all the necessary information should be described
> in DT.

"Add support for the smallest, dumbest possible platform, to be
 used as a guest for KVM or other hypervisors.

 It only mandates a GIC and architected timers"

(your original commit message :-P)

> Actually, mach-virt doesn't really stand for Virtual Machine. It stands
> for virtual mach-* directory! Eventually, mach-virt should become the
> default platform, the one we use when we don't match anything else in
> the kernel

I can word it more like that for sure, along with the alternative
wording suggested by Christopher/Stefano to clarify the intent that
everything comes from DTB and removal of the specific requirements for
GIC/timer/PSCI I think that suit the (new) intention better?

> What you've described here are requirements for a hypervisor like Xen or
> KVM. mach-virt itself shouldn't have any of that.
> 
> Cheers,
> 
> 	M.
