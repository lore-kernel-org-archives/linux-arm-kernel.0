From: julien.grall@arm.com (Julien Grall)
Date: Tue,  8 Mar 2016 11:29:26 +0000
Subject: [PATCH v3 2/9] clocksource: arm_arch_timer: Extend
 arch_timer_kvm_info to get the virtual IRQ
In-Reply-To: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
Message-ID: <1457436573-6180-3-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the firmware table is parsed by the virtual timer code in
order to retrieve the virtual timer interrupt. However, this is already
done by the arch timer driver.

To avoid code duplication, extend arch_timer_kvm_info to get the virtual
IRQ.

Note that the KVM code will be modified in a subsequent patch.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>

    Changes in v3:
        - Move the KVM changes in a separate patch and rename the patch
        - Move the initialization of the virtual_irq to
        arch_timer_common_init
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 include/clocksource/arm_arch_timer.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b7ab588..d8887f3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -701,6 +701,8 @@ static void __init arch_timer_common_init(void)
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
 	arch_timer_arch_init();
+
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
 }
 
 static void __init arch_timer_init(void)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 9101ed6b..9dd996a 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -51,6 +51,7 @@ enum arch_timer_reg {
 
 struct arch_timer_kvm_info {
 	struct timecounter timecounter;
+	int virtual_irq;
 };
 
 #ifdef CONFIG_ARM_ARCH_TIMER
-- 
1.9.1
