From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 21 Dec 2013 09:54:24 -0800
Subject: [PATCH v5 00/10] Support VGIC save/restore using device control
 API
In-Reply-To: <010feb6c1a84a5e63b8643c340eb1cf1@www.loen.fr>
References: <1387258201-8738-1-git-send-email-christoffer.dall@linaro.org>
 <010feb6c1a84a5e63b8643c340eb1cf1@www.loen.fr>
Message-ID: <20131221175424.GB9753@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 11:15:30AM +0000, Marc Zyngier wrote:
> On 2013-12-17 05:29, Christoffer Dall wrote:
> >Implement save/restore of the VGIC state using the newer KVM Device
> >Control API.  This requries some number of changes to existing
> >code in
> >addition to actually supporting save/restore of the necessary state.
> >
> >The first patches (01-03) support creating the VGIC using the Device
> >Control API.  This change is necessary because there are no other
> >suitable KVM APIs that we can leverage to access the VGIC state from
> >user space and the device control API was crafted exactly for this
> >purpose.
> >
> >Subsequent patches add the missing infrastructure and user space API
> >pieces necessary to actually save and restore the VGIC state.  The
> >GIC
> >v2.0 architecture specification already specifies registers that
> >can be
> >used to save and restore the complete VGIC state for suspend/resume
> >purposes on real hardware, and we can reuse this interface for the
> >VGIC.  The API is therefore based on the memory-mapped register
> >accesses
> >defined in the specs.  See the individual patches for details.
> >
> >The patches are based on kvm-arm-next with the arch timers
> >save/restore
> >patches applied:
> >git://git.linaro.org/people/cdall/linux-kvm-arm.git timer-migrate-v4
> >
> >This patch series based on the above can be cloned from:
> >git://git.linaro.org/people/cdall/linux-kvm-arm.git vgic-migrate-v5
> >
> >User space patches for QEMU have also been posted on the list, but an
> >updated version is underway.  Tested on Versatile Express TC2.
> 
> Hi Christoffer,
> 
> I believe this is now good to go, assuming the userspace interface
> is stable.
> If it is, I'll merge the above branch for 3.14.
> 

Thanks, the userspace interface is stable.  It would be great to get
this in kvm-next asap, because then we can start merging the
corresponding qemu patches.

I'll send you a pull request as promised.

-Christoffer

> 
> >Changelogs in the individual patches.
> >
> >Christoffer Dall (10):
> >  ARM: KVM: Allow creating the VGIC after VCPUs
> >  KVM: arm-vgic: Support KVM_CREATE_DEVICE for VGIC
> >  KVM: arm-vgic: Set base addr through device API
> >  irqchip: arm-gic: Define additional MMIO offsets and masks
> >  KVM: arm-vgic: Make vgic mmio functions more generic
> >  arm/arm64: kvm: Set vcpu->cpu to -1 on vcpu_put
> >  KVM: arm-vgic: Add vgic reg access from dev attr
> >  KVM: arm-vgic: Support unqueueing of LRs to the dist
> >  KVM: arm-vgic: Add GICD_SPENDSGIR and GICD_CPENDSGIR handlers
> >  KVM: arm-vgic: Support CPU interface reg access
> >
> > Documentation/virtual/kvm/api.txt              |   7 +-
> > Documentation/virtual/kvm/devices/arm-vgic.txt |  73 ++++
> > arch/arm/include/uapi/asm/kvm.h                |   8 +
> > arch/arm/kvm/arm.c                             |  17 +-
> > include/kvm/arm_vgic.h                         |   2 +-
> > include/linux/irqchip/arm-gic.h                |  12 +
> > include/linux/kvm_host.h                       |   1 +
> > include/uapi/linux/kvm.h                       |   1 +
> > virt/kvm/arm/vgic.c                            | 583
> >+++++++++++++++++++++++--
> > virt/kvm/kvm_main.c                            |   5 +
> > 10 files changed, 672 insertions(+), 37 deletions(-)
> > create mode 100644 Documentation/virtual/kvm/devices/arm-vgic.txt
> 
> -- 
> Fast, cheap, reliable. Pick two.

-- 
Christoffer
