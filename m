From: james.morse@arm.com (James Morse)
Date: Mon, 30 Oct 2017 15:58:35 +0000
Subject: [PATCH v4 14/13] firmware: arm_sdei: Move cpuhotplug registration
 later
In-Reply-To: <20171017174432.1684-1-james.morse@arm.com>
References: <20171017174432.1684-1-james.morse@arm.com>
Message-ID: <20171030155835.20622-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will points out the sdei_probe() code may be pre-empted to bring a CPU
online. If this happens between registering the cpu-hotplug callbacks
and the okay-we're-ready cross call, the new CPU may be left unmasked
even if we failed for some other reason.

Move the cpuhotplug callback registration last and switch to the
vanilla version that makes the call for all online CPUs. Add a call
to forcibly mask CPUs in the error path.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f764f48144c2..14b6d170518c 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -964,17 +964,10 @@ static int sdei_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	err = cpuhp_setup_state_nocalls(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
-				&sdei_cpuhp_up, &sdei_cpuhp_down);
-	if (err) {
-		pr_warn("Failed to register CPU hotplug notifier...\n");
-		return err;
-	}
-
 	err = cpu_pm_register_notifier(&sdei_pm_nb);
 	if (err) {
 		pr_warn("Failed to register CPU PM notifier...\n");
-		goto remove_cpuhp;
+		goto error;
 	}
 
 	err = register_reboot_notifier(&sdei_reboot_nb);
@@ -983,16 +976,23 @@ static int sdei_probe(struct platform_device *pdev)
 		goto remove_cpupm;
 	}
 
-	on_each_cpu(&_ipi_unmask_cpu, NULL, false);
+	err = cpuhp_setup_state(CPUHP_AP_ARM_SDEI_STARTING, "SDEI",
+				&sdei_cpuhp_up, &sdei_cpuhp_down);
+	if (err) {
+		pr_warn("Failed to register CPU hotplug notifier...\n");
+		goto remove_reboot;
+	}
 
 	return 0;
 
+remove_reboot:
+	unregister_reboot_notifier(&sdei_reboot_nb);
+
 remove_cpupm:
 	cpu_pm_unregister_notifier(&sdei_pm_nb);
 
-remove_cpuhp:
-	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_SDEI_STARTING);
-
+error:
+	sdei_mark_interface_broken();
 	return err;
 }
 
-- 
2.15.0.rc2
