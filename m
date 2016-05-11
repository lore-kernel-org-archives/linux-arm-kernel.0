From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 May 2016 15:30:13 +0200
Subject: [PULL 20/29] clocksource: arm_arch_timer: Extend arch_timer_kvm_info
 to get the virtual IRQ
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1462973422-10021-21-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julien Grall <julien.grall@arm.com>

Currently, the firmware table is parsed by the virtual timer code in
order to retrieve the virtual timer interrupt. However, this is already
done by the arch timer driver.

To avoid code duplication, extend arch_timer_kvm_info to get the virtual
IRQ.

Note that the KVM code will be modified in a subsequent patch.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 include/clocksource/arm_arch_timer.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 62bdfe7..bb58224 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -750,6 +750,8 @@ static void __init arch_timer_init(void)
 
 	arch_timer_register();
 	arch_timer_common_init();
+
+	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[VIRT_PPI];
 }
 
 static void __init arch_timer_of_init(struct device_node *np)
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
2.1.2.330.g565301e.dirty
