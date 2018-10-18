From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:37:48 +0100
Subject: [KVMTOOL][PATCH v2 9/9] kvmtool: Allow standard size specifiers for
 memory bank
In-Reply-To: <20181018133748.32577-1-julien.grall@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
Message-ID: <20181018133748.32577-10-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Allow standard suffixes, K, M, G, T & P suffixes for sizes and addresses for
memory bank parameters. By default, the size is specified in MB.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

---

    Changes in v2:
        - Patch added
---
 builtin-run.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/builtin-run.c b/builtin-run.c
index 568af5c..c907295 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -49,9 +49,11 @@
 #include <ctype.h>
 #include <stdio.h>
 
-#define MB_SHIFT		(20)
 #define KB_SHIFT		(10)
+#define MB_SHIFT		(20)
 #define GB_SHIFT		(30)
+#define TB_SHIFT		(40)
+#define PB_SHIFT		(50)
 
 __thread struct kvm_cpu *current_kvm_cpu;
 
@@ -87,6 +89,37 @@ void kvm_run_set_wrapper_sandbox(void)
 	kvm_run_wrapper = KVM_RUN_SANDBOX;
 }
 
+static int __parse_size_spec(char **next)
+{
+	int shift = 0;
+
+	switch(**next) {
+	case 'K': shift = KB_SHIFT; break;
+	case 'M': shift = MB_SHIFT; break;
+	case 'G': shift = GB_SHIFT; break;
+	case 'T': shift = TB_SHIFT; break;
+	case 'P': shift = PB_SHIFT; break;
+	}
+	if (shift)
+		(*next)++;
+	return shift;
+}
+
+static u64 parse_mem_size_spec(char **next)
+{
+	int shift = __parse_size_spec(next);
+
+	/* By default the size is in MB, if none is specified */
+	if (!shift)
+		shift = 20;
+	return ((u64)1) << shift;
+}
+
+static u64 parse_addr_spec(char **next)
+{
+	return ((u64)1) << __parse_size_spec(next);
+}
+
 static int mem_parser(const struct option *opt, const char *arg, int unset)
 {
 	struct kvm_config *cfg = opt->value;
@@ -101,6 +134,8 @@ static int mem_parser(const struct option *opt, const char *arg, int unset)
 	if (next == p)
 		die("mem: no size specified.\n");
 
+	size *= parse_mem_size_spec(&next);
+
 	if (*next != '@' && *next != '\0')
 		die("mem: unexpected chars after size.\n");
 
@@ -122,6 +157,8 @@ static int mem_parser(const struct option *opt, const char *arg, int unset)
 		if (cfg->nr_ram > 0)
 			die("mem: <addr> must be specified\n");
 		addr = INVALID_RAM_ADDR;
+	} else {
+		addr *= parse_addr_spec(&next);
 	}
 
 	if ( cfg->nr_ram == MAX_RAM_BANKS )
@@ -322,7 +359,7 @@ static u64 host_ram_size(void)
 		return 0;
 	}
 
-	return (nr_pages * page_size) >> MB_SHIFT;
+	return (nr_pages * page_size);
 }
 
 /*
@@ -336,11 +373,11 @@ static u64 get_ram_size(int nr_cpus)
 	u64 available;
 	u64 ram_size;
 
-	ram_size	= 64 * (nr_cpus + 3);
+	ram_size	= (64 * (nr_cpus + 3)) << MB_SHIFT;
 
 	available	= host_ram_size() * RAM_SIZE_RATIO;
 	if (!available)
-		available = MIN_RAM_SIZE_MB;
+		available = MIN_RAM_SIZE_MB << MB_SHIFT;
 
 	if (ram_size > available)
 		ram_size	= available;
@@ -594,11 +631,8 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 		kvm->cfg.nr_ram = 1;
 	}
 
-	for (i = 0; i < kvm->cfg.nr_ram; i++) {
+	for (i = 0; i < kvm->cfg.nr_ram; i++)
 		total_ram += kvm->cfg.ram[i].size;
-		/* The user input is in MB, but the internal deals with bytes */
-		kvm->cfg.ram[i].size <<= MB_SHIFT;
-	}
 
 	if (total_ram > host_ram_size())
 		pr_warning("Guest memory size %lluMB exceeds host physical RAM size %lluMB",
-- 
2.11.0
