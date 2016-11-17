From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 17 Nov 2016 19:35:35 +0100
Subject: [PATCH 14/20] arm/bL_switcher: Convert to hotplug state machine
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
Message-ID: <20161117183541.8588-15-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Install the callbacks via the state machine.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/common/bL_switcher.c | 34 ++++++++++++++++++++--------------
 include/linux/cpuhotplug.h    |  1 +
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 37dc0fe1093f..46730017b3c5 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -757,19 +757,18 @@ EXPORT_SYMBOL_GPL(bL_switcher_put_enabled);
  * while the switcher is active.
  * We're just not ready to deal with that given the trickery involved.
  */
-static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
-					unsigned long action, void *hcpu)
+static int bL_switcher_cpu_pre(unsigned int cpu)
 {
-	if (bL_switcher_active) {
-		int pairing = bL_switcher_cpu_pairing[(unsigned long)hcpu];
-		switch (action & 0xf) {
-		case CPU_UP_PREPARE:
-		case CPU_DOWN_PREPARE:
-			if (pairing == -1)
-				return NOTIFY_BAD;
-		}
-	}
-	return NOTIFY_DONE;
+	int pairing;
+
+	if (!bL_switcher_active)
+		return 0;
+
+	pairing = bL_switcher_cpu_pairing[cpu];
+
+	if (pairing == -1)
+		return -EINVAL;
+	return 0;
 }
 
 static bool no_bL_switcher;
@@ -782,8 +781,15 @@ static int __init bL_switcher_init(void)
 	if (!mcpm_is_available())
 		return -ENODEV;
 
-	cpu_notifier(bL_switcher_hotplug_callback, 0);
-
+	cpuhp_setup_state_nocalls(CPUHP_ARM_BL_PREPARE, "arm/bl:prepare",
+				  bL_switcher_cpu_pre, NULL);
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "arm/bl:predown",
+					NULL, bL_switcher_cpu_pre);
+	if (ret < 0) {
+		cpuhp_remove_state_nocalls(CPUHP_ARM_BL_PREPARE);
+		pr_err("bL_switcher: Failed to allocate a hotplug state\n");
+		return ret;
+	}
 	if (!no_bL_switcher) {
 		ret = bL_switcher_enable();
 		if (ret)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 69abf2c09f6c..4b99b79c16e5 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -64,6 +64,7 @@ enum cpuhp_state {
 	CPUHP_X86_CPUID_PREPARE,
 	CPUHP_X86_MSR_PREPARE,
 	CPUHP_NET_IUCV_PREPARE,
+	CPUHP_ARM_BL_PREPARE,
 	CPUHP_TIMERS_DEAD,
 	CPUHP_NOTF_ERR_INJ_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
-- 
2.10.2
