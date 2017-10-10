From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 10 Oct 2017 19:38:21 +0100
Subject: [PATCH v3 04/28] arm64: Port deprecated instruction emulation to new
 sysctl interface
In-Reply-To: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1507660725-7986-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, armv8_deprected.c takes charge of the "abi" sysctl
directory, which makes life difficult for other code that wants to
register sysctls in the same directory.

There is a "new" [1] sysctl registration interface that removes the
need to define ctl_tables for parent directories explicitly, which
is ideal here.

This patch ports register_insn_emulation_sysctl() over to the
register_sysctl() interface and removes the redundant ctl_table for
"abi".

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

[1] fea478d4101a (sysctl: Add register_sysctl for normal sysctl
users)
The commit message notes an intent to port users of the
pre-existing interfaces over to register_sysctl(), though the
number of users of the new interface currently appears negligible.
---
 arch/arm64/kernel/armv8_deprecated.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index d06fbe4..f6e828d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -228,15 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-static struct ctl_table ctl_abi[] = {
-	{
-		.procname = "abi",
-		.mode = 0555,
-	},
-	{ }
-};
-
-static void __init register_insn_emulation_sysctl(struct ctl_table *table)
+static void __init register_insn_emulation_sysctl(void)
 {
 	unsigned long flags;
 	int i = 0;
@@ -262,8 +254,7 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
 	}
 	raw_spin_unlock_irqrestore(&insn_emulation_lock, flags);
 
-	table->child = insns_sysctl;
-	register_sysctl_table(table);
+	register_sysctl("abi", insns_sysctl);
 }
 
 /*
@@ -644,7 +635,7 @@ static int __init armv8_deprecated_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_AP_ARM64_ISNDEP_STARTING,
 				  "arm64/isndep:starting",
 				  run_all_insn_set_hw_mode, NULL);
-	register_insn_emulation_sysctl(ctl_abi);
+	register_insn_emulation_sysctl();
 
 	return 0;
 }
-- 
2.1.4
