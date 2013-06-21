From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jun 2013 13:08:45 +0100
Subject: [PATCH v2 0/3] A handful of KVM/ARM fixes
Message-ID: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a small patch series that I accumulated while tracking what
turned out to be an unrelated issue.

The first patch has already been posted a while ago and included here
for completeness. The others are fairly simple missing barriers/clear
exclusives that are actually required.

This has been tested on TC2, and is also available in my tree:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/fixes-3.10-rc6

>From v1:
- Dropped two barrier related patches after Will convinced me that they
  were not required at all.
- Changed dsb to "dsb ishst" in the second patch to reflect that we only
  care about stores.

Marc Zyngier (3):
  ARM: KVM: perform save/restore of PAR
  ARM: KVM: add missing dsb before invalidating Stage-2 TLBs
  ARM: KVM: clear exclusive monitor on all exception returns

 arch/arm/include/asm/kvm_asm.h | 22 ++++++++++++----------
 arch/arm/kvm/coproc.c          |  4 ++++
 arch/arm/kvm/interrupts.S      | 16 +++++++++++++++-
 arch/arm/kvm/interrupts_head.S | 10 ++++++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

-- 
1.8.2.3
