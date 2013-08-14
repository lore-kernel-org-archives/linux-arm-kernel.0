From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Aug 2013 17:20:23 +0100
Subject: [PATCHv3 0/5] arm64: initial CPU hotplug support
Message-ID: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches add basic HOTPLUG_CPU support to arm64, which
combined with appropriate firmware (e.g. [1]) can be used to power CPUs
up and down dynamically.

I've tested this series with the bootwrapper PSCI implementation I've
placed on linux-arm.org [1] and a modified foundation model dts with a
psci node and each CPU's enable-method set to "psci", using a shell
while repeatedly cycling all cpus off and on:

for C in $(seq 0 3); do
	./cyclichotplug.sh $C >/dev/null 2>&1 &
done

---->8----
#!/bin/sh
# cyclichotplug.sh

CPU=$1;

if [ -z "$CPU" ]; then
	printf "Usage: $0 <cpu id>\n";
	exit 1;
fi

ONLINEFILE=/sys/devices/system/cpu/cpu$CPU/online;

while true; do
	echo 0 > $ONLINEFILE;
	echo 1 > $ONLINEFILE;
done
---->8----

Since v1 [2]:
* Rebased to v3.11-rc2 to solve cpuinit removal conflicts.
* Removed failure path for cpu_die, it causes more problems than it solves.
* Removed cpu_kill, we don't currently need it.
* Test for cpu_die in op_cpu_disable to fail early and survive when there's no
  mechanism for hot unplug.
* Change pr_err on failed cpu_die to a pr_crit.
* Removed dependency on HOTPLUG, which has been obliterated.

Since v2 [3]:
* Rebased to v3.11-rc4 to prevent clash with Xen [4].
* Added proper kerneldoc comments to smp_operations.
* Removed harmful RCU_NONIDLE from cpu_die as per arm
  implementation (aa03381046: ARM: smp: Drop RCU_NONIDLE usage in cpu_die()).
* Expanded cpu_die comments.
* Added missing newline to pr_crit in smp_psci_cpu_die().

Thanks,
Mark.

[1] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/heads/psci
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/182880.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185351.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185437.html

Mark Rutland (5):
  arm64: reorganise smp_enable_ops
  arm64: factor out spin-table boot method
  arm64: read enable-method for CPU0
  arm64: add CPU_HOTPLUG infrastructure
  arm64: add PSCI CPU_OFF-based hotplug support

 arch/arm64/Kconfig                 |   7 ++
 arch/arm64/include/asm/irq.h       |   1 +
 arch/arm64/include/asm/smp.h       |  43 ++++++--
 arch/arm64/kernel/cputable.c       |   2 +-
 arch/arm64/kernel/head.S           |  12 ++-
 arch/arm64/kernel/irq.c            |  61 +++++++++++
 arch/arm64/kernel/process.c        |   7 ++
 arch/arm64/kernel/smp.c            | 201 ++++++++++++++++++++++---------------
 arch/arm64/kernel/smp_psci.c       |  54 ++++++++--
 arch/arm64/kernel/smp_spin_table.c |  85 +++++++++++++++-
 arch/arm64/kernel/vmlinux.lds.S    |   1 -
 11 files changed, 367 insertions(+), 107 deletions(-)

-- 
1.8.1.1
