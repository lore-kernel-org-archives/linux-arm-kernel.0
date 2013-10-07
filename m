From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  7 Oct 2013 16:40:28 +0100
Subject: [PATCH 0/2] ARM/arm64: KVM: Yield CPU when vcpu executes a WFE
Message-ID: <1381160430-11790-1-git-send-email-marc.zyngier@arm.com>
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

Marc Zyngier (2):
  ARM: KVM: Yield CPU when vcpu executes a WFE
  arm64: KVM: Yield CPU when vcpu executes a WFE

 arch/arm/include/asm/kvm_arm.h   |  4 +++-
 arch/arm/kvm/handle_exit.c       |  6 +++++-
 arch/arm64/include/asm/kvm_arm.h |  8 ++++++--
 arch/arm64/kvm/handle_exit.c     | 18 +++++++++++++-----
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
1.8.2.3
