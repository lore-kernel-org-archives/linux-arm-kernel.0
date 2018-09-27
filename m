From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Sep 2018 12:27:10 -0700
Subject: [PATCH 2/3] ARM: psci: Fix secondary core boot with THUMB2_KERNEL
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Message-ID: <20180927192711.26455-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When THUMB2_KERNEL is enabled, we would be setting the secondary core's
entry point to secondary_startup() which is already Thumb2 code, utilize
secondary_startup_arm() which takes care of doing the mode switching for
us.

Fixes: 05774088391c ("arm: introduce psci_smp_ops")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/psci_smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index cb3fcaeb2233..547a11b065d2 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -47,13 +47,13 @@
  *
  */
 
-extern void secondary_startup(void);
+extern void secondary_startup_arm(void);
 
 static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
-					virt_to_idmap(&secondary_startup));
+					virt_to_idmap(&secondary_startup_arm));
 	return -ENODEV;
 }
 
-- 
2.17.1
