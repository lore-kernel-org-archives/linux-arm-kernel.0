From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Apr 2016 15:48:55 +0100
Subject: [PATCH v5 0/5] arm64: Fix behavior of maxcpus=n
Message-ID: <1461682140-7131-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt at fixing the maxcpus=n behavior
on arm64. So far we have disabled hotplugging a CPU > n,
when maxcpus=n is in effect, due to following reasons.

 1) Possible cpu feature incompatibilities with the new CPU
    in heterogeneous systems.
 2) New CPU requiring an errata work around which was not detected
    (and the code patched in) at boot time.
 3) Failure to initialise the PMU in case the supported CPUs are
    not online while probing the PMU.

(1) has been mostly solved with our early CPU feature verification
support. This series tries to address (2) & (3).

(2) is solved by iterating over the known erratas and checking if
the new CPU requires an errata not set in the cpu_hwcaps, failing
which, we kill the CPU. We plan to fix this properly by retaining
the CPU errata work arounds and apply the required at runtime.

(3) is ignored and will not be fixed as there is no reliable way of
knowing if there would be a CPU that will be online to support the
PMU.

In the process, also restores the capability to check GIC interface settings
by the firmware on individual CPUs.

Tested on Juno with maxcpus=2 (enables A57 cores and A57-PMU) and
maxcpus=1 (disables both A57 cores and A57-PMU).

This series applies on aarch64/for-next/core :

The tree is available here :
	git://linux-arm.org/linux-skp.git maxcpus/v5

Changes since V4:
 - Address Catalin's comments
 - Rebased to aarch64 for-next/core
 - Add Reviewed/Acked bys.


Marc Zyngier (2):
  arm64: Allow a capability to be checked on a single CPU
  irqchip/gic: Restore CPU interface checking

Suzuki K Poulose (3):
  arm64: cpufeature: Add scope for capability check
  arm64: Verify CPU errata work arounds on hotplugged CPU
  arm64: Fix behavior of maxcpus=N

 arch/arm64/include/asm/cpufeature.h |   12 ++-
 arch/arm64/kernel/cpu_errata.c      |   24 +++++-
 arch/arm64/kernel/cpufeature.c      |  150 +++++++++++++++++++++--------------
 arch/arm64/kernel/smp.c             |   18 +----
 drivers/irqchip/irq-gic.c           |    5 +-
 5 files changed, 128 insertions(+), 81 deletions(-)

-- 
1.7.9.5
