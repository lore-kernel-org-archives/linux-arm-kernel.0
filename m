From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Oct 2013 18:19:02 +0100
Subject: [PATCH 0/4] ARM: KVM: allow VMs with more than 4 CPUs
Message-ID: <1382116746-8757-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, KVM/ARM is limited to 4 A7 or A15 per VM. This is due to
the fact that KVM doesn't know about clusters, and puts all CPUs at
affinity level 0.

This patch series removes this limitation by allowing additionnal CPUs
to be part of a separate cluster (affinity level 1).

This also requires a patch to kvmtool so the generated DT matches the
expectations of the guest (posted separately).

Tested on TC2 and arm64 model.

Patches based on Christoffer's next tree as of today.

Marc Zyngier (4):
  arm/arm64: KVM: PSCI: use MPIDR to identify a target CPU
  ARM: KVM: Fix MPIDR computing to support virtual clusters
  ARM: KVM: fix L2CTLR to be per-cluster
  ARM: KVM: drop limitation to 4 CPU VMs

 arch/arm/include/asm/kvm_emulate.h   |  5 +++++
 arch/arm/kvm/coproc.c                | 14 ++++++++++----
 arch/arm/kvm/psci.c                  | 17 +++++++++++++----
 arch/arm/kvm/reset.c                 |  4 ----
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 5 files changed, 33 insertions(+), 12 deletions(-)

-- 
1.8.2.3
