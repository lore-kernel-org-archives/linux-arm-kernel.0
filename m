From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 24 Apr 2017 11:10:22 +0100
Subject: [PATCH 0/2] kvm: Fixes for race conditions
Message-ID: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The two patches here fixes race conditions in the KVM hypervisor code
dealing with the shadow MMU.

The first one applies to core KVM code where mmu_notifier->ops.release()
could be called twice with one instance possibily accessing a free'd KVM
instance. Reported here :

 http://lkml.kernel.org/r/CAAeHK+x8udHKq9xa1zkTO6ax5E8Dk32HYWfaT05FMchL2cr48g at mail.gmail.com

The second patch is specific to arm/arm64 stage2 PGD, where there are issues
with modifications to the PGD pointer outside the mmu_lock, leading to crashes.
Reported here :
 http://lkml.kernel.org/r/febea966-3767-21ff-3c40-1a76d1399138 at suse.de


Suzuki K Poulose (2):
  kvm: Fix mmu_notifier release race
  kvm: arm/arm64: Fix race in resetting stage2 PGD

 arch/arm/kvm/mmu.c       | 14 +++++++-----
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 59 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 13 deletions(-)

-- 
2.7.4
