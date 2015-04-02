From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 02 Apr 2015 20:54:19 +0200
Subject: [GIT PULL] KVM/ARM updates for v4.1
In-Reply-To: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
References: <1427969131-8445-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <551D905B.8000108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/04/2015 12:05, Marc Zyngier wrote:
> Paolo, Marcelo,
> 
> This is the pull request for the KVM/ARM updates targeting v4.1. It
> contains a number of important updates bringing the port much closer
> to feature completeness.
> 
> Note that merging this will generate a small conflict in
> virt/kvm/arm/vgic.c, which should be resolved as per linux-next.
> 
> Thanks,
> 
> 	M.
> 
> The following changes since commit 4ff6f8e61eb7f96d3ca535c6d240f863ccd6fb7d:
> 
>   KVM: emulate: fix CMPXCHG8B on 32-bit hosts (2015-02-23 22:28:48 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.1
> 
> for you to fetch changes up to d44758c0dfc5993a4b9952935a7eae4c91ebb6b4:
> 
>   KVM: arm/arm64: enable KVM_CAP_IOEVENTFD (2015-03-30 17:07:24 +0100)
> 
> ----------------------------------------------------------------
> KVM/ARM changes for v4.1:
> 
> - fixes for live migration
> - irqfd support
> - kvm-io-bus & vgic rework to enable ioeventfd
> - page ageing for stage-2 translation
> - various cleanups
> 
> ----------------------------------------------------------------
> Alex Benn?e (2):
>       arm/arm64: KVM: export VCPU power state via MP_STATE ioctl
>       arm/arm64: KVM: add a common vgic_queue_irq_to_lr fn
> 
> Andre Przywara (10):
>       KVM: move iodev.h from virt/kvm/ to include/kvm
>       KVM: arm/arm64: remove now unneeded include directory from Makefile
>       KVM: x86: remove now unneeded include directory from Makefile
>       KVM: arm/arm64: rename struct kvm_mmio_range to vgic_io_range
>       KVM: arm/arm64: simplify vgic_find_range() and callers
>       KVM: arm/arm64: implement kvm_io_bus MMIO handling for the VGIC
>       KVM: arm/arm64: prepare GICv2 emulation to be handled by kvm_io_bus
>       KVM: arm/arm64: merge GICv3 RD_base and SGI_base register frames
>       KVM: arm/arm64: prepare GICv3 emulation to use kvm_io_bus MMIO handling
>       KVM: arm/arm64: rework MMIO abort handling to use KVM MMIO bus
> 
> Christoffer Dall (3):
>       arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}
>       arm/arm64: KVM: support for un-queuing active IRQs
>       arm/arm64: KVM: Fix migration race in the arch timer
> 
> Eric Auger (5):
>       KVM: arm/arm64: unset CONFIG_HAVE_KVM_IRQCHIP
>       KVM: introduce kvm_arch_intc_initialized and use it in irqfd
>       KVM: arm/arm64: implement kvm_arch_intc_initialized
>       KVM: arm/arm64: remove coarse grain dist locking at kvm_vgic_sync_hwstate
>       KVM: arm/arm64: add irqfd support
> 
> Marc Zyngier (3):
>       arm/arm64: KVM: Allow handle_hva_to_gpa to return a value
>       arm/arm64: KVM: Implement Stage-2 page aging
>       arm/arm64: KVM: Optimize handling of Access Flag faults
> 
> Mark Rutland (1):
>       KVM: vgic: add virt-capable compatible strings
> 
> Nikolay Nikolaev (2):
>       KVM: Redesign kvm_io_bus_ API to pass VCPU structure to the callbacks.
>       KVM: arm/arm64: enable KVM_CAP_IOEVENTFD
> 
> Paolo Bonzini (1):
>       KVM: arm/arm64: prefer IS_ENABLED to a static variable
> 
>  Documentation/virtual/kvm/api.txt |  22 +-
>  arch/arm/include/asm/kvm_arm.h    |   1 +
>  arch/arm/include/asm/kvm_host.h   |  15 +-
>  arch/arm/include/asm/kvm_mmio.h   |  22 --
>  arch/arm/include/uapi/asm/kvm.h   |   3 +
>  arch/arm/kernel/asm-offsets.c     |   4 -
>  arch/arm/kvm/Kconfig              |  30 +--
>  arch/arm/kvm/Makefile             |  12 +-
>  arch/arm/kvm/arm.c                |  45 ++--
>  arch/arm/kvm/guest.c              |  18 --
>  arch/arm/kvm/interrupts_head.S    |   8 -
>  arch/arm/kvm/mmio.c               |  64 ++---
>  arch/arm/kvm/mmu.c                | 134 ++++++++++-
>  arch/arm/kvm/trace.h              |  48 ++++
>  arch/arm64/include/asm/esr.h      |   1 +
>  arch/arm64/include/asm/kvm_arm.h  |   1 +
>  arch/arm64/include/asm/kvm_host.h |  15 +-
>  arch/arm64/include/asm/kvm_mmio.h |  22 --
>  arch/arm64/include/uapi/asm/kvm.h |   3 +
>  arch/arm64/kvm/Kconfig            |  18 +-
>  arch/arm64/kvm/Makefile           |  20 +-
>  arch/powerpc/kvm/mpic.c           |  12 +-
>  arch/powerpc/kvm/powerpc.c        |   4 +-
>  arch/s390/kvm/diag.c              |   2 +-
>  arch/x86/kvm/Makefile             |   2 +-
>  arch/x86/kvm/i8254.c              |  14 +-
>  arch/x86/kvm/i8254.h              |   2 +-
>  arch/x86/kvm/i8259.c              |  12 +-
>  arch/x86/kvm/ioapic.c             |   8 +-
>  arch/x86/kvm/ioapic.h             |   2 +-
>  arch/x86/kvm/irq.h                |   2 +-
>  arch/x86/kvm/lapic.c              |   4 +-
>  arch/x86/kvm/lapic.h              |   2 +-
>  arch/x86/kvm/vmx.c                |   2 +-
>  arch/x86/kvm/x86.c                |  13 +-
>  include/kvm/arm_arch_timer.h      |  31 +--
>  include/kvm/arm_vgic.h            | 117 ++--------
>  {virt => include}/kvm/iodev.h     |  28 ++-
>  include/linux/kvm_host.h          |  24 +-
>  virt/kvm/arm/arch_timer.c         |  45 +++-
>  virt/kvm/arm/vgic-v2-emul.c       |  71 +++---
>  virt/kvm/arm/vgic-v3-emul.c       | 246 ++++++++++----------
>  virt/kvm/arm/vgic.c               | 476 ++++++++++++++++++++++++++++----------
>  virt/kvm/arm/vgic.h               |  37 ++-
>  virt/kvm/coalesced_mmio.c         |   7 +-
>  virt/kvm/eventfd.c                |   9 +-
>  virt/kvm/kvm_main.c               |  34 +--
>  47 files changed, 1011 insertions(+), 701 deletions(-)
>  rename {virt => include}/kvm/iodev.h (66%)
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 

Pulled, thanks.

Paolo
