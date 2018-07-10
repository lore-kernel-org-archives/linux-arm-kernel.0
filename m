From: james.morse@arm.com (James Morse)
Date: Tue, 10 Jul 2018 17:49:48 +0100
Subject: [PATCH v7 0/4] support exception state migration and set VSESR_EL2 by
 user space
Message-ID: <20180710164952.23736-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

This is GengDongjiu's get/set events series[0], with additional plumbing for
32bit.

This series adds the get/set events API to KVM for arm/arm64 so that
user-space can migrate pending SError, (which KVM may have made pending
as part of its device emulation), and for RAS make a new SError with a
specific ESR value pending. (Only systems with the v8.2 RAS Extensions
can specify an ESR, KVM advertises this capability with a new cap:
KVM_CAP_ARM_INJECT_SERROR_ESR)

User-space can use this for emulation of the v8.2 CPU RAS features
(using error nodes backed by mmio) or as part of NOTIFY_SEI which
extends a v8.2 RAS SError to also have firmware-first CPER records.


Thanks,

James

[0] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032010.html

Dongjiu Geng (2):
  arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
  arm64: KVM: export the capability to set guest SError syndrome

James Morse (2):
  KVM: arm64: Share the parts of get/set events useful to 32bit
  KVM: arm: Add 32bit get/set events support

 Documentation/virtual/kvm/api.txt    | 44 +++++++++++++++++++++++---
 arch/arm/include/asm/kvm_host.h      |  5 +++
 arch/arm/include/uapi/asm/kvm.h      | 13 ++++++++
 arch/arm/kvm/guest.c                 | 23 ++++++++++++++
 arch/arm64/include/asm/kvm_emulate.h |  5 +++
 arch/arm64/include/asm/kvm_host.h    |  7 +++++
 arch/arm64/include/uapi/asm/kvm.h    | 13 ++++++++
 arch/arm64/kvm/guest.c               | 33 +++++++++++++++++++
 arch/arm64/kvm/inject_fault.c        |  6 ++--
 arch/arm64/kvm/reset.c               |  4 +++
 include/uapi/linux/kvm.h             |  1 +
 virt/kvm/arm/arm.c                   | 47 ++++++++++++++++++++++++++++
 12 files changed, 194 insertions(+), 7 deletions(-)

-- 
2.18.0
