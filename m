From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 3 Dec 2014 11:33:56 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: add init entry to VGIC KVM device
In-Reply-To: <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
References: <1417541251-20761-1-git-send-email-eric.auger@linaro.org>
 <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
Message-ID: <20141203103356.GD17502@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 05:50:00PM +0000, Peter Maydell wrote:
> On 2 December 2014 at 17:27, Eric Auger <eric.auger@linaro.org> wrote:
> > Since the advent of dynamic initialization of VGIC, this latter is
> > initialized very late, on the first vcpu run. This initialization
> > could be initiated much earlier by the user, as soon as it has
> > provided the requested dimensioning parameters:
> > - number of IRQs and number of vCPUs,
> > - DIST and CPU interface base address.
> >
> > One motivation behind being able to initialize the VGIC sooner is
> > related to the setup of IRQ injection in VFIO use case. The VFIO
> > signaling, especially when used along with irqfd must be set *after*
> > vgic initialization to prevent any virtual IRQ injection before
> > VGIC initialization. If virtual IRQ injection occurs before the VGIC
> > init, the IRQ cannot be injected and subsequent injection is blocked
> > due to VFIO completion mechanism (unmask/mask or forward/unforward).
> 
> This implies that you're potentially injecting virtual IRQs
> (and changing the state of the VGIC) before we actually
> start running the VM (ie before userspace calls KVM_RUN).
> Is that right? It seems odd, but maybe vfio works that way?
> 
Yeah, I can't think of a cleaner way to do this.  VFIO doesn't know
anything about KVM or whether a machine is running or not.  QEMU has to
configure all this before starting a VM (wiring up IRQs after the VM is
running is even more weird imho, when would you even do that?) so
interrupts from the real hardware are bound to hit VFIO just
before/during/after VCPUs are started, and VFIO doesn't have any caching
mechanism for this state, it really has to go to the consumer of the
interrupt, which is KVM in the case of forwarded interrupts.

Did I miss something obvious here?

-Christoffer
