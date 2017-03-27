From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 27 Mar 2017 17:03:36 +0100
Subject: [PATCH v2 0/9] arm64: KVM: Fix PMU exception generation
Message-ID: <20170327160345.12402-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Running the following code:

root at zomby-woof:~# cat test-pmu.c
int main(int argc, char *argv[])
{
	unsigned int val;
	asm ("mrc p15, 0, %0, c9, c13, 0\n" : "=r" (val));
	return val;
}

in a 32bit guest (or a 64bit guest with a 32bit userspace) results in
this surprising result:

[  120.347497] kvm [1150]: Unsupported guest CP15 access at: ab0945ae
[  120.353689] kvm [1142]:  { Op0( 0), Op1( 0), CRn( 9), CRm(13), Op2( 0), func_read },

which is weird, because the guest behaves correctly:
root at zomby-woof:~# ./test-pmu 
[   16.184422] test-pmu[740]: undefined instruction: pc=00000000ab0945ae
[   16.186043] Code: 00340001 b4800000 af00b085 60396078 (3f1dee19) 
Illegal instruction

It gets the expected UNDEF, and all is fine. So what?

It turns out that the PMU emulation code is a bit lazy, and tells the
rest of KVM that the emulation has failed, so that an exception gets
delivered. Subtle differences in the 32bit vs 64bit handling make it
spit an "Unsupported..." error.

This series tries to set things straight:
- Make all PMU illegal accesses inject an UNDEF
- Make these illegal accesses a successful emulation w.r.t the rest of KVM.

In the process, we also squash an interesting bug in the 64bit CP
access. Similar treatment is applied to the 32bit kernel, except that
we don't ever inject an exception there (no PMU support yet).

* From v1:
  - Got rid of the original sideband information, and declared that an emulation
    can never fail. The return value now indicates whether or not we should advance the PC.
  - Sanitized read_from_write_only/write_to_read_only.
  - Implemented similar semantics on 32bit (although unaffected so far).

Marc Zyngier (9):
  arm64: KVM: PMU: Refactor pmu_*_el0_disabled
  arm64: KVM: PMU: Inject UNDEF exception on illegal register access
  arm64: KVM: PMU: Inject UNDEF on non-privileged accesses
  arm64: KVM: Make unexpected reads from WO registers inject an undef
  arm64: KVM: PMU: Inject UNDEF on read access to PMSWINC_EL0
  arm64: KVM: Treat sysreg accessors returning false as successful
  arm64: KVM: Do not corrupt registers on failed 64bit CP read
  arm: KVM: Make unexpected register accesses inject an undef
  arm: KVM: Treat CP15 accessors returning false as successful

 arch/arm/kvm/coproc.c     |  24 +++++++--
 arch/arm/kvm/coproc.h     |  18 -------
 arch/arm64/kvm/sys_regs.c | 131 ++++++++++++++++++++++++----------------------
 arch/arm64/kvm/sys_regs.h |  18 -------
 4 files changed, 88 insertions(+), 103 deletions(-)

-- 
2.11.0
