From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Jul 2018 20:53:42 -0700
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part strings
Message-ID: <20180715035342.11371-1-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's some use in printing out what the implementer and part numbers
decode to for cases where they're known.

I filled in the table based on public information; mostly from ARM TRMs
and other tools (and some of the SSBD tables in the kernel, etc).

Apple IDs came from
https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index e9ab7b3..9a7c25d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -121,6 +121,67 @@ static const char *const compat_hwcap2_str[] = {
 };
 #endif /* CONFIG_COMPAT */
 
+struct midr_info {
+	unsigned int mask;
+	unsigned int val;
+	char *id;
+};
+
+static const struct midr_info midr_part[] = {
+	// ARM
+	{ .mask = 0xff00fff0, .val = 0x4100d030, .id = "Cortex-A53" },
+	{ .mask = 0xff00fff0, .val = 0x4100d040, .id = "Cortex-A35" },
+	{ .mask = 0xff00fff0, .val = 0x4100d070, .id = "Cortex-A57" },
+	{ .mask = 0xff00fff0, .val = 0x4100d080, .id = "Cortex-A72" },
+	{ .mask = 0xff00fff0, .val = 0x4100d090, .id = "Cortex-A73" },
+	{ .mask = 0xff00fff0, .val = 0x4100d0a0, .id = "Cortex-A75" },
+	{ .mask = 0xff00fff0, .val = 0x4100d0f0, .id = "Cortex-A55" },
+	// Broadcom
+	{ .mask = 0xff00fff0, .val = 0x42001000, .id = "Brahma-B53" },
+	{ .mask = 0xff00fff0, .val = 0x42005160, .id = "ThunderX2" },
+	// Cavium
+	{ .mask = 0xff00fff0, .val = 0x43000a00, .id = "ThunderX" },
+	{ .mask = 0xff00fff0, .val = 0x43000a10, .id = "ThunderX 88xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000a20, .id = "ThunderX 81xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000a30, .id = "ThunderX 83xx" },
+	{ .mask = 0xff00fff0, .val = 0x43000af0, .id = "ThunderX2 99xx" },
+	// Nvidia
+	{ .mask = 0xff00fff0, .val = 0x4e000000, .id = "Denver" },
+	{ .mask = 0xff00fff0, .val = 0x4e000030, .id = "Denver 2" },
+	// Applied Micro
+	{ .mask = 0xff00fff0, .val = 0x50000000, .id = "X-Gene" },
+	// Qualcomm
+	{ .mask = 0xff00fff0, .val = 0x51002010, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51002050, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51002110, .id = "Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51008000, .id = "Falkor V1/Kryo" },
+	{ .mask = 0xff00fff0, .val = 0x51008010, .id = "Kryo V2" },
+	{ .mask = 0xff00fff0, .val = 0x5100c000, .id = "Falkor" },
+	{ .mask = 0xff00fff0, .val = 0x5100c010, .id = "Saphira" },
+	// Samsung
+	{ .mask = 0xff00fff0, .val = 0x53000010, .id = "M1" },
+	// Apple
+	{ .mask = 0xff00fff0, .val = 0x61000010, .id = "Cyclone" },
+	{ .mask = 0xff00fff0, .val = 0x61000020, .id = "Typhoon" },
+	{ .mask = 0xff00fff0, .val = 0x61000030, .id = "Typhoon/Capri" },
+	{ .mask = 0xff00fff0, .val = 0x61000040, .id = "Twister" },
+	{ .mask = 0xff00fff0, .val = 0x61000050, .id = "Twister/Elba/Malta" },
+	{ .mask = 0xff00fff0, .val = 0x61000060, .id = "Hurricane" },
+	{ .mask = 0xff00fff0, .val = 0x61000070, .id = "Hurricane/Myst" },
+};
+
+static const struct midr_info midr_impl[] = {
+	{ .mask = 0xff000000, .val = 0x41000000, .id = "ARM" },
+	{ .mask = 0xff000000, .val = 0x42000000, .id = "Broadcom" },
+	{ .mask = 0xff000000, .val = 0x43000000, .id = "Cavium" },
+	{ .mask = 0xff000000, .val = 0x4d000000, .id = "Motorola" },
+	{ .mask = 0xff000000, .val = 0x4e000000, .id = "Nvidia" },
+	{ .mask = 0xff000000, .val = 0x50000000, .id = "Applied Micro" },
+	{ .mask = 0xff000000, .val = 0x51000000, .id = "Qualcomm" },
+	{ .mask = 0xff000000, .val = 0x53000000, .id = "Samsung" },
+	{ .mask = 0xff000000, .val = 0x61000000, .id = "Apple" },
+};
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
@@ -129,6 +190,16 @@ static int c_show(struct seq_file *m, void *v)
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
 		u32 midr = cpuinfo->reg_midr;
+		char *impl = NULL;
+		char *part = NULL;
+
+		for (j = 0; !impl && j < ARRAY_SIZE(midr_impl); j++)
+			if ((midr & midr_impl[j].mask) == midr_impl[j].val)
+				impl = midr_impl[j].id;
+
+		for (j = 0; !part && j < ARRAY_SIZE(midr_part); j++)
+			if ((midr & midr_part[j].mask) == midr_part[j].val)
+				part = midr_part[j].id;
 
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
@@ -168,11 +239,12 @@ static int c_show(struct seq_file *m, void *v)
 		}
 		seq_puts(m, "\n");
 
-		seq_printf(m, "CPU implementer\t: 0x%02x\n",
-			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "CPU implementer\t: 0x%02x (%s)\n",
+			   MIDR_IMPLEMENTOR(midr), impl ? : "unknown");
 		seq_printf(m, "CPU architecture: 8\n");
 		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
-		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "CPU part\t: 0x%03x (%s)\n", MIDR_PARTNUM(midr),
+			   part ? : "unknown");
 		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
 	}
 
@@ -300,6 +372,7 @@ static int __init cpuinfo_regs_init(void)
 	}
 	return 0;
 }
+
 static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 {
 	unsigned int cpu = smp_processor_id();
-- 
2.8.6
