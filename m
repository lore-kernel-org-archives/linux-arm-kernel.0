From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  8 Feb 2016 11:40:14 +0000
Subject: [PATCH 0/8] KVM/ARM: Guest Entry/Exit optimizations
Message-ID: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've recently been looking at our entry/exit costs, and profiling
figures did show some very low hanging fruits.

The most obvious cost is that accessing the GIC HW is slow. As in
"deadly slow", specially when GICv2 is involved. So not hammering the
HW when there is nothing to write is immediately beneficial, as this
is the most common cases (whatever people seem to think, interrupts
are a *rare* event).

Another easy thing to fix is the way we handle trapped system
registers. We do insist on (mostly) sorting them, but we do perform a
linear search on trap. We can switch to a binary search for free, and
get immediate benefits (the PMU code, being extremely trap-happy,
benefits immediately from this).

With these in place, I see an improvement of 20 to 30% (depending on
the platform) on our world-switch cycle count when running a set of
hand-crafted guests that are designed to only perform traps.

Methodology:

* NULL-hypercall guest: Perform 65536 PSCI_0_2_FN_PSCI_VERSION calls,
and then a power-off:

__start:
	mov	x19, #(1 << 16)
1:	mov	x0, #0x84000000
	hvc	#0
	sub	x19, x19, #1
	cbnz	x19, 1b
	mov	x0, #0x84000000
	add	x0, x0, #9
	hvc	#0
	b	.

* sysreg trap guest: Perform 2^20 PMSELR_EL0 accesses, and power-off:

__start:
	mov	x19, #(1 << 20)
1:	mrs	x0, PMSELR_EL0
	sub	x19, x19, #1
	cbnz	x19, 1b
	mov	x0, #0x84000000
	add	x0, x0, #9
	hvc	#0
	b	.

* These guests are profiled using perf and kvmtool:

taskset -c 1 perf stat -e cycles:kh lkvm run -c1 --kernel do_sysreg.bin 2>&1 >/dev/null| grep cycles

The result is then divided by the number of iterations (2^16 or 2^20).

These tests have been run on Seattle, Mustang, and LS2085, and shown
significant improvements in all cases. I've only touched the arm64
GIC code, but obviously the 32bit code should use it as well once
we've migrated it to C.

I've pushed out a branch (kvm-arm64/suck-less) to the usual location.

Thanks,

	M.

Marc Zyngier (8):
  arm64: KVM: Switch the sys_reg search to be a binary search
  ARM: KVM: Properly sort the invariant table
  ARM: KVM: Enforce sorting of all CP tables
  ARM: KVM: Rename struct coproc_reg::is_64 to is_64bit
  ARM: KVM: Switch the CP reg search to be a binary search
  KVM: arm/arm64: timer: Add active state caching
  KVM: arm/arm64: Avoid accessing GICH registers
  KVM: arm64: Avoid accessing ICH registers

 arch/arm/kvm/arm.c              |   1 +
 arch/arm/kvm/coproc.c           |  74 ++++++-----
 arch/arm/kvm/coproc.h           |   8 +-
 arch/arm64/kvm/hyp/vgic-v2-sr.c |  71 +++++++---
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 288 ++++++++++++++++++++++++----------------
 arch/arm64/kvm/sys_regs.c       |  40 +++---
 include/kvm/arm_arch_timer.h    |   5 +
 include/kvm/arm_vgic.h          |   8 +-
 virt/kvm/arm/arch_timer.c       |  31 +++++
 virt/kvm/arm/vgic-v3.c          |   4 +-
 10 files changed, 334 insertions(+), 196 deletions(-)

-- 
2.1.4
