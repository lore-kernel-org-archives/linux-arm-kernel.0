From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sat, 14 Nov 2015 14:12:07 -0800
Subject: [PATCH v4 0/3] KVM/arm/arm64: enhance armv7/8 fp/simd lazy switch
Message-ID: <1447539130-4613-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series combines the previous armv7 and armv8 versions.
For an FP and lmbench load it reduces fp/simd context switch from 30-50% down
to 2%. Results will vary with load but is no worse then current
approach.

In summary current lazy vfp/simd implementation switches hardware context only
on guest access and again on exit to host, otherwise hardware context is
skipped. This patch set builds on that functionality and executes a hardware
context switch only when  vCPU is scheduled out or returns to user space.

Patches were tested on FVP and Foundation Model sw platforms running floating 
point applications comparing outcome against known results. A bad FP/SIMDcontext
switch should result FP errors. Artificially skipping a fp/simd context switch
(1 in 1000) causes the applications to report errors.

The test can be found here, https://github.com/mjsmar/arm-arm64-fpsimd-test

Tests Ran:
armv7:
- On host executed 12 fp applications - evently pinned to cpus
- Two guests - with 12 fp crunching processes - also pinned to vpus.
- half ran with 1ms sleep, remaining with no sleep

armv8:
- same as above except used mix of armv7 and armv8 guests.

These patches are based on earlier arm64 fp/simd optimization work -
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-July/015748.html

And subsequent fixes by Marc and Christoffer at KVM Forum hackathon to handle
32-bit guest on 64 bit host - 
https://lists.cs.columbia.edu/pipermail/kvmarm/2015-August/016128.html

Changes since v3->v4:
- Followup on Christoffers comments 
  - Move fpexc handling to vcpu_load and vcpu_put
  - Enable and restore fpexc in EL2 mode when running a 32 bit guest on 
    64bit EL2
  - rework hcptr handling

Changes since v2->v3:
- combined arm v7 and v8 into one short patch series
- moved access to fpexec_el2 back to EL2
- Move host restore to EL1 from EL2 and call directly from host
- optimize trap enable code 
- renamed some variables to match usage

Changes since v1->v2:
- Fixed vfp/simd trap configuration to enable trace trapping
- Removed set_hcptr branch label
- Fixed handling of FPEXC to restore guest and host versions on vcpu_put
- Tested arm32/arm64
- rebased to 4.3-rc2
- changed a couple register accesses from 64 to 32 bit


Mario Smarduch (3):
  add hooks for armv7 fp/simd lazy switch support
  enable enhanced armv7 fp/simd lazy switch
  enable enhanced armv8 fp/simd lazy switch

 arch/arm/include/asm/kvm_host.h   | 42 ++++++++++++++++++++
 arch/arm/kernel/asm-offsets.c     |  2 +
 arch/arm/kvm/arm.c                | 24 +++++++++++
 arch/arm/kvm/interrupts.S         | 58 ++++++++++++++++-----------
 arch/arm/kvm/interrupts_head.S    | 26 ++++++++----
 arch/arm64/include/asm/kvm_asm.h  |  2 +
 arch/arm64/include/asm/kvm_host.h | 19 +++++++++
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kvm/hyp.S              | 83 +++++++++++++++++++++++++--------------
 9 files changed, 196 insertions(+), 61 deletions(-)

-- 
1.9.1
