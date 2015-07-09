From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  9 Jul 2015 10:23:55 +0100
Subject: [PATCH] ARM: kvm: prevent freeing boot_hyp_pgd when CPU_PM is selected
Message-ID: <1436433835-26030-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boot_hyp_pgd is required to install HYP context through
cpu_init_hyp_mode, on cold-boot for primary and secondary cpus, but
also on the warm-boot path for secondaries (ie when a CPU is hotplugged
in). On platforms with power management capabilities (eg suspend to RAM
or idle-states that allow the core to enter deep idle where core is
shutdown on power down entry), the boot_hyp_pgd is required to restore
HYP context too upon CPU_PM notification, so the boot_hyp_pgd must not be
freed to guarantee a proper HYP context restore, which in turn ensures
proper core resume from low-power.

This patch adds an additional guard to free_boot_hyp_pgd() to remove
its call from the kernel if CPU_PM is enabled, so that on platforms
where HOTPLUG_CPU is disabled (eg UP), CPU_PM operations (suspend and
CPUidle) are still guaranteed to function.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index bc738d2..5e050c2 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1068,7 +1068,7 @@ static int init_hyp_mode(void)
 	if (err)
 		goto out_free_mappings;
 
-#ifndef CONFIG_HOTPLUG_CPU
+#if !defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_CPU_PM)
 	free_boot_hyp_pgd();
 #endif
 
-- 
2.2.1
