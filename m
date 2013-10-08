From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Oct 2013 18:38:12 +0100
Subject: [PATCH v2 0/2] KVM: Yield CPU when vcpu executes a WFE
Message-ID: <1381253894-18114-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a respin of a patch I posted a long while ago, this time with
numbers that I hope to be convincing enough.

The basic idea is that spinning on WFE in a guest is a waste of
resource, and that we're better of running another vcpu instead. This
specially shows when the system is oversubscribed. The guest vcpus can
be seen spinning, waiting for a lock to be released while the lock
holder is nowhere near a physical CPU.

This patch series just enables WFE trapping on both ARM and arm64, and
calls kvm_vcpu_on_spin(). This is enough to boost other vcpus, and
dramatically reduce the overhead.

Branch available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/wfe-trap

Changes from v1:
- Added CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT, as it seems to give
  slightly better results (Thanks to Raghavendra K T)
- Updated commit message with results of 8x configuration

Marc Zyngier (2):
  ARM: KVM: Yield CPU when vcpu executes a WFE
  arm64: KVM: Yield CPU when vcpu executes a WFE

 arch/arm/include/asm/kvm_arm.h   |  4 +++-
 arch/arm/kvm/Kconfig             |  1 +
 arch/arm/kvm/handle_exit.c       |  6 +++++-
 arch/arm64/include/asm/kvm_arm.h |  8 ++++++--
 arch/arm64/kvm/Kconfig           |  1 +
 arch/arm64/kvm/handle_exit.c     | 18 +++++++++++++-----
 6 files changed, 29 insertions(+), 9 deletions(-)

-- 
1.8.2.3
