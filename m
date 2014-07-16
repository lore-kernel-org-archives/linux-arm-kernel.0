From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Jul 2014 16:32:47 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently reading /proc/cpuinfo will result in information being read
out of the MIDR_EL1 of the current CPU, and the information is not
associated with any particular logical CPU number.

This is problematic for systems with heterogeneous CPUs (i.e.
big.LITTLE) where MIDR fields will vary across CPUs, and the output will
differ depending on the executing CPU.

This patch reorganises the code responsible for /proc/cpuinfo to print
information per-cpu. In the process, we perform several cleanups:

* Property names are coerced to lower-case (to match "processor" as per
  glibc's expectations).
* Property names are simplified and made to match the MIDR field names.
* Revision is changed to hex as with every other field.
* The meaningless Architecture property is removed.
* The ripe-for-abuse Machine field is removed.

The features are printed per-cpu to match the format used by other
architectures, and are derived from the (globally uniform) hwcaps. In
cases where this may report incorrect information, rework is required
elsewhere to function with varying instruction set support, and the
sanity checks should provide us with some advance notice (warnings and
TAINT_CPU_OUT_OF_SPEC). If we're lucky, such systems will never exist.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marcus Shawcroft <marcus.shawcroft@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index edb146d..aa1b4f7 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -448,39 +448,34 @@ static const char *hwcap_str[] = {
 
 static int c_show(struct seq_file *m, void *v)
 {
-	int i;
+	int c, i;
 
-	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
+	for_each_online_cpu(c) {
+		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, c);
+		u32 midr = cpuinfo->reg_midr;
 
-	for_each_online_cpu(i) {
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
 		 * online processors, looking for lines beginning with
 		 * "processor".  Give glibc what it expects.
 		 */
 #ifdef CONFIG_SMP
-		seq_printf(m, "processor\t: %d\n", i);
+		seq_printf(m, "processor\t: %d\n", c);
 #endif
+		seq_printf(m, "implementer\t: 0x%02x\n",
+			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "variant\t\t: 0x%x\n", MIDR_VARIANT(midr));
+		seq_printf(m, "partnum\t\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "revision\t: 0x%x\n", MIDR_REVISION(midr));
+
+		/* dump out the processor features */
+		seq_puts(m, "features\t: ");
+		for (i = 0; hwcap_str[i]; i++)
+			if (elf_hwcap & (1 << i))
+				seq_printf(m, "%s ", hwcap_str[i]);
+		seq_puts(m, "\n\n");
 	}
 
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
-
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
-
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: AArch64\n");
-	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
-	seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
-	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
-
-	seq_puts(m, "\n");
-
-	seq_printf(m, "Hardware\t: %s\n", machine_name);
-
 	return 0;
 }
 
-- 
1.9.1
