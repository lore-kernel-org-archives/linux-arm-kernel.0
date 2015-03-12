From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 12 Mar 2015 18:16:49 +0000
Subject: [PATCH v2 0/3] arm/arm64: KVM: Add support for page aging
Message-ID: <1426184212-29333-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, KVM/arm doesn't implement any support for page aging, leading
to rather bad performance when the system is swapping. This short
series implements the required hooks and fault handling to deal with
pages being marked old/young.

The three patches are fairly straightforward:

- First patch changes the range iterator to be able to return a value

- Second patch implements the actual page aging (clearing the AF bit
  in the page tables, and relying on the normal faulting code to set
  the bit again).

- Last patch optimizes the access fault path by only doing the minimum
  to satisfy the fault.

The end result is a system that behaves visibly better under load, as
VM pages don't get evicted that easily.

Based on 4.0-rc3, tested on Seattle and X-Gene.

Also at git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/page-aging

* From v1 [1]:
- Removed all TLBIs from kvm_age_hva_handler, as the core KVM code
  already does use quite a large hammer to nuke the TLBs on its own
- Don't mark old a page that is already old
- Rebased on top of 4.0-rc3

[1]: https://lists.cs.columbia.edu/pipermail/kvmarm/2015-January/013315.html

Marc Zyngier (3):
  arm/arm64: KVM: Allow handle_hva_to_gpa to return a value
  arm/arm64: KVM: Implement Stage-2 page aging
  arm/arm64: KVM: Optimize handling of Access Flag faults

 arch/arm/include/asm/kvm_arm.h    |   1 +
 arch/arm/include/asm/kvm_host.h   |  13 +---
 arch/arm/kvm/mmu.c                | 134 +++++++++++++++++++++++++++++++++++---
 arch/arm/kvm/trace.h              |  48 ++++++++++++++
 arch/arm64/include/asm/esr.h      |   1 +
 arch/arm64/include/asm/kvm_arm.h  |   1 +
 arch/arm64/include/asm/kvm_host.h |  13 +---
 7 files changed, 179 insertions(+), 32 deletions(-)

-- 
2.1.4
