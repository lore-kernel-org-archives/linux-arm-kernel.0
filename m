From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 30 Jul 2012 04:58:12 -0700
Subject: [PATCH 03/11] kdb: Implement disable_nmi command
In-Reply-To: <20120730115719.GA5742@lizard>
References: <20120730115719.GA5742@lizard>
Message-ID: <1343649500-18491-3-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This command disables NMI-entry. If NMI source was previously shared with
a serial console ("debug port"), this effectively releases the port from
KDB exclusive use, and makes the console available for normal use.

Of course, NMI can be reenabled, enable_nmi modparam is used for that:

	echo 1 > /sys/module/kdb/parameters/enable_nmi

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 kernel/debug/kdb/kdb_main.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 3ee92a1..1e9f20e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2131,6 +2131,24 @@ static int kdb_dmesg(int argc, const char **argv)
 	return 0;
 }
 #endif /* CONFIG_PRINTK */
+
+static int kdb_disable_nmi(int argc, const char *argv[])
+{
+	kgdb_arch_enable_nmi(0);
+	return 0;
+}
+
+static int kdb_param_enable_nmi(const char *val, const struct kernel_param *kp)
+{
+	kgdb_arch_enable_nmi(1);
+	return 0;
+}
+
+static const struct kernel_param_ops kdb_param_ops_enable_nmi = {
+	.set = kdb_param_enable_nmi,
+};
+module_param_cb(enable_nmi, &kdb_param_ops_enable_nmi, NULL, 0600);
+
 /*
  * kdb_cpu - This function implements the 'cpu' command.
  *	cpu	[<cpunum>]
@@ -2873,6 +2891,8 @@ static void __init kdb_inittab(void)
 	kdb_register_flags("dmesg", kdb_dmesg, "[lines]",
 	  "Display syslog buffer", 0, KDB_SAFE);
 #endif
+	kdb_register_flags("disable_nmi", kdb_disable_nmi, "",
+	  "Disable NMI entry to KDB", 0, KDB_SAFE);
 	kdb_register_flags("defcmd", kdb_defcmd, "name \"usage\" \"help\"",
 	  "Define a set of commands, down to endefcmd", 0, KDB_SAFE);
 	kdb_register_flags("kill", kdb_kill, "<-signal> <pid>",
-- 
1.7.10.4
