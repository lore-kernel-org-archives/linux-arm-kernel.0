From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:09 +0100
Subject: [PATCH 0/5] arm64: Fix behavior of maxcpus=n
Message-ID: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
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
which, we kill the CPU.

(3) is ignored and will not be fixed as there is no reliable way of
knowing if there would be a CPU that will be online to support the
PMU.

In the process, also restores the capability to check GIC interface settings
by the firmware on individual CPUs.

Tested on Juno with maxcpus=2 (enables A57 cores and A57-PMU) and
maxcpus=1 (disables the A57 cores and A57-PMU).

This series applies on 4.6-rc2 + "arm64: Support for systems without AArch32 state" [1].

The tree is available here :
	git://linux-arm.org/linux-skp.git maxcpus/v1

Marc Zyngier (2):
  arm64: Allow a capability to be checked on a single CPU
  irqchip/gic: Restore CPU interface checking

Suzuki K Poulose (3):
  arm64: cpufeature: Add scope for capability check
  arm64: Verify CPU errata work arounds on hotplugged CPU
  arm64: Fix behavior of maxcpus=N

 arch/arm64/include/asm/cpufeature.h |   12 +++++++--
 arch/arm64/kernel/cpu_errata.c      |   24 ++++++++++++++++-
 arch/arm64/kernel/cpufeature.c      |   49 +++++++++++++++++++++++------------
 arch/arm64/kernel/smp.c             |   10 -------
 drivers/irqchip/irq-gic.c           |    5 ++--
 5 files changed, 67 insertions(+), 33 deletions(-)

-- 
1.7.9.5
