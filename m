From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:01:58 +0100
Subject: [PATCH 00/19] Handle guest-generated SErrors/Aborts
Message-ID: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little known "feature" of giving guest access to real memory mapped
HW is that it could trigger asynchronous aborts (SError on ARMv8) if
the guest accesses it in a non-conventional way (and depending on how
HW and firmware have been integrated). So far, KVM lacks any support
to handle this gracefully.

This series introduces a set of mechanisms to catch such a fault and
deliver a vSError (or Virtual Abort for 32bit) to the offending vcpu.

These aborts can either trigger at EL1 (whilst the guest is running),
or at EL2 (during the handling of an exit). The first case is pretty
easy to handle (use the ad-hoc vectors on arm64, or decode the EA bit
on arm), but the second one is a bit more fiddly, as we need to ensure
that the exception is pending by the time we unmask it. This is
achived by using some heavy DSBs on the hot path, with the following
caveats:

- I've only been able to trigger the EL2 handling on A57 (Seatle,
  Juno).
- I've measured a 40/50 cycles hit on Juno (A57), but I haven't
  measured the impact on bigger systems

The last patch of this series adds a missing feature to the
GICV-proxying series, delivering a vSError to a guest that performed
an illegal access to the GIC.

Patches on top of current kvmarm/queue + the GICV przying series.

Marc Zyngier (19):
  arm64: KVM: Rename HCR_VA to HCR_VSE
  arm64: KVM: Preserve pending vSError in world switch
  arm64: KVM: Add Virtual Abort injection helper
  arm64: KVM: Add exception code to report EL1 asynchronous aborts
  arm64: KVM: Add EL1 async abort handler
  arm64: KVM: Route asynchronous aborts
  arm64: KVM: Allow an exit code to be tagged with an SError
  arm64: KVM: Inject a Virtual SError if it was pending
  arm64: KVM: Handle async aborts delivered while at EL2
  arm: KVM: Preserve pending Virtual Abort in world switch
  arm: KVM: Add Virtual Abort injection helper
  arm: KVM: Add HYP async abort handler
  arm: KVM: Allow an exit code to be tagged with a Virtual Abort
  arm: KVM: Handle async aborts delivered while at HYP
  arm: KVM: Inject a Virtual Abort if it was pending
  arm: KVM: Drop unreachable HYP abort handlers
  arm/arm64: KVM: Inject virtual abort when guest exits on external
    abort
  arm/arm64: KVM: Remove external abort test from MMIO handling
  arm64: KVM: Inject a vSerror if detecting a bad GICV access at EL2

 arch/arm/include/asm/kvm_asm.h       |  4 +++
 arch/arm/include/asm/kvm_emulate.h   |  1 +
 arch/arm/kvm/emulate.c               | 12 +++++++++
 arch/arm/kvm/handle_exit.c           | 49 ++++++++++++++++--------------------
 arch/arm/kvm/hyp/entry.S             | 31 +++++++++++++++++++++++
 arch/arm/kvm/hyp/hyp-entry.S         | 16 +++++++++++-
 arch/arm/kvm/hyp/switch.c            |  9 +++++++
 arch/arm/kvm/mmio.c                  |  6 -----
 arch/arm/kvm/mmu.c                   |  5 ++++
 arch/arm64/include/asm/kvm_arm.h     |  4 +--
 arch/arm64/include/asm/kvm_asm.h     |  9 +++++--
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/asm/kvm_hyp.h     |  2 +-
 arch/arm64/kvm/handle_exit.c         | 23 +++++++++++++++++
 arch/arm64/kvm/hyp/entry.S           | 33 +++++++++++++++++++++++-
 arch/arm64/kvm/hyp/hyp-entry.S       | 36 ++++++++++++++++++++++----
 arch/arm64/kvm/hyp/switch.c          | 33 +++++++++++++++++++++---
 arch/arm64/kvm/inject_fault.c        | 12 +++++++++
 virt/kvm/arm/hyp/vgic-v2-sr.c        | 21 ++++++++++++----
 19 files changed, 254 insertions(+), 53 deletions(-)

-- 
2.1.4
