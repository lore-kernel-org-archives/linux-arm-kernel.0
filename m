From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 27 Jun 2014 19:12:14 -0600
Subject: [PATCH 2/2] arm64: kernel: update cpuinfo to print all online CPUs
 features
In-Reply-To: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140628011214.9839.32281.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the /proc/cpuinfo show function so that it shows the CPU ID of each
CPU instead of using the ID of the CPU that happens to be running the code.

Based on b4b8f770eb10 ("ARM: kernel: update cpuinfo to print all online
CPUs features").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/setup.c |   33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 37cc2bb9f3ae..dd301ceaa655 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -448,10 +448,8 @@ static const char *hwcap_str[] = {
 
 static int c_show(struct seq_file *m, void *v)
 {
-	int i;
-
-	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
+	int i, j;
+	u32 cpuid;
 
 	for_each_online_cpu(i) {
 		/*
@@ -461,23 +459,24 @@ static int c_show(struct seq_file *m, void *v)
 		 */
 #ifdef CONFIG_SMP
 		seq_printf(m, "processor\t: %d\n", i);
+		cpuid = per_cpu(cpu_data, i).cpuid;
+#else
+		cpuid = read_cpuid_id();
 #endif
-	}
 
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
+		/* dump out the processor features */
+		seq_puts(m, "Features\t: ");
 
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
+		for (i = 0; hwcap_str[i]; i++)
+			if (elf_hwcap & (1 << i))
+				seq_printf(m, "%s ", hwcap_str[i]);
 
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: AArch64\n");
-	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
-	seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
-	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
-
-	seq_puts(m, "\n");
+		seq_printf(m, "\nCPU implementer\t: 0x%02x\n", cpuid >> 24);
+		seq_printf(m, "CPU architecture: AArch64\n");
+		seq_printf(m, "CPU variant\t: 0x%x\n", (cpuid >> 20) & 15);
+		seq_printf(m, "CPU part\t: 0x%03x\n", (cpuid >> 4) & 0xfff);
+		seq_printf(m, "CPU revision\t: %d\n\n", cpuid & 15);
+	}
 
 	seq_printf(m, "Hardware\t: %s\n", machine_name);
 
