From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 12:46:16 +0000
Subject: [PATCH] ARM: smp: improve CPU bringup failure diagnostics
Message-ID: <E1PTwAy-0000ua-2R@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to print a bland error message which gave no clue as to the
failure when we failed to bring up a secondary CPU.  Resolve this by
separating the two failure cases.

If boot_secondary() fails, we print a message indicating the returned
error code from boot_secondary():
	"CPU%u: failed to boot: %d\n", cpu, ret.

However, if boot_secondary() succeeded, but the CPU did not appear to
mark itself online within the timeout, indicate that it failed to come
online:
	"CPU%u: failed to come online\n", cpu

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bba1e96..ef2438f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -164,8 +164,12 @@ int __cpuinit __cpu_up(unsigned int cpu)
 			barrier();
 		}
 
-		if (!cpu_online(cpu))
+		if (!cpu_online(cpu)) {
+			pr_crit("CPU%u: failed to come online\n", cpu);
 			ret = -EIO;
+		}
+	} else {
+		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
 	secondary_data.stack = NULL;
@@ -181,14 +185,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	pgd_free(&init_mm, pgd);
 
-	if (ret) {
-		printk(KERN_CRIT "CPU%u: processor failed to boot\n", cpu);
-
-		/*
-		 * FIXME: We need to clean up the new idle thread. --rmk
-		 */
-	}
-
 	return ret;
 }
 
-- 
1.6.2.5
