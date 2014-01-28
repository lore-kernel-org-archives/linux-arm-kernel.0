From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Mon, 27 Jan 2014 17:23:41 -0800
Subject: [PATCH] arm64: setup: report non-optional CPU features
Message-ID: <alpine.DEB.2.02.1401271712340.10177@avanbrunt-dt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a large number of popular applications compiled for ARMv7-A that read
/proc/cpuinfo to find out what features the CPU has. But, when they are run
on an arm64 kernel, they fail to run. This is because features that were
optional on ARMv7 or earlier but are not optional on ARMv8-A like Thumb are not
listed as a CPU feature using the arm64 kernel. To make those applications run,
the kernel still needs to print the features in the list.

This patch changes "cat /proc/cpuinfo" from printing:

Features        : fp asimd

To printing:

Features        : fp asimd wp half thumb fastmult vfp edsp neon vfpv3d16 tlsi vfpv4 idiva idivt

Subject: [PATCH] arm64: setup: report non-optional CPU features

Many ARM applications read the CPU features list provided by the
kernel in /proc/cpuinfo to determine which features to use. If a
feature is not listed, the application with either run slower or will
not run at all.

CPU features that are no longer optional in ARMv8-A, but were
optional in previous architectures still need to be printed. To
achieve this, always report these features.

Change-Id: I0a8092ee07926ae5410d7863a270a76fa224297d
Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
---
 arch/arm64/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bd9bbd0..7f8e9bd 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -302,6 +302,8 @@ static int c_show(struct seq_file *m, void *v)
 	for (i = 0; hwcap_str[i]; i++)
 		if (elf_hwcap & (1 << i))
 			seq_printf(m, "%s ", hwcap_str[i]);
+	/* Print non-optional features in ARMv8 */
+	seq_printf(m, "half thumb fastmult vfp neon vfpv3 vfpv4 idiva");
 
 	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
 	seq_printf(m, "CPU architecture: AArch64\n");
-- 
1.8.1.5
