From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Oct 2013 19:24:00 +0100
Subject: [PATCHv4 0/6] arm64: initial CPU hotplug support
Message-ID: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
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
	./cyclichotplug.sh $C&
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
	sleep 0.0$RANDOM;
	echo 1 > $ONLINEFILE;
done
---->8----

Nico, Santosh,
Due to rearranging smp_operations to cpu_operations, I've dropped the
Acks you provided for v3. Other than the changes to accomodate this or
the logical consequences (folding smp_psci.c and psci.c) I hope I
haven't made too major a change to not be Ack-worthy again :)

Thanks,
Mark.

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

Since v3 [5]:
* Rebased all the way to v3.12-rc4
* Split cpu_operations from SMP, per Catalin's comments.
* Read CPU0's enable-method even on UP kernels.
* Folded smp_psci.c into psci.c.
* Updated test scripts per Nico's comments.

[1] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/heads/psci
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/182880.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185351.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185437.html
[5] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/192091.html

Mark Rutland (6):
  arm64: unify smp_psci.c and psci.c
  arm64: reorganise smp_enable_ops
  arm64: factor out spin-table boot method
  arm64: add CPU_HOTPLUG infrastructure
  arm64: add PSCI CPU_OFF-based hotplug support
  arm64: read enable-method for CPU0

 arch/arm64/Kconfig                 |   7 ++
 arch/arm64/include/asm/cpu_ops.h   |  59 +++++++++++
 arch/arm64/include/asm/irq.h       |   1 +
 arch/arm64/include/asm/psci.h      |  19 ----
 arch/arm64/include/asm/smp.h       |  15 +--
 arch/arm64/kernel/Makefile         |   4 +-
 arch/arm64/kernel/cpu_ops.c        |  94 +++++++++++++++++
 arch/arm64/kernel/cputable.c       |   2 +-
 arch/arm64/kernel/head.S           |  12 ++-
 arch/arm64/kernel/irq.c            |  61 +++++++++++
 arch/arm64/kernel/process.c        |   7 ++
 arch/arm64/kernel/psci.c           |  87 ++++++++++++++-
 arch/arm64/kernel/setup.c          |   2 +
 arch/arm64/kernel/smp.c            | 209 +++++++++++++++++++------------------
 arch/arm64/kernel/smp_psci.c       |  53 ----------
 arch/arm64/kernel/smp_spin_table.c |  86 ++++++++++++++-
 arch/arm64/kernel/vmlinux.lds.S    |   1 -
 17 files changed, 522 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpu_ops.h
 create mode 100644 arch/arm64/kernel/cpu_ops.c
 delete mode 100644 arch/arm64/kernel/smp_psci.c

-- 
1.8.1.1
