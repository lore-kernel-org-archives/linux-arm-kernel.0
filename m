From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 03:47:35 +0000
Subject: [PATCH 19/29] arm64: KVM: Plug the arch timer
In-Reply-To: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1362455265-24165-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shouldn't be needed - a complete duplicate from arch/arm.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arch_timer.c               |  1 +
 arch/arm64/include/asm/kvm_arch_timer.h | 58 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/include/asm/kvm_arch_timer.h

diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index 6ac938d..ca04a99 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -194,6 +194,7 @@ static struct notifier_block kvm_timer_cpu_nb = {
 
 static const struct of_device_id arch_timer_of_match[] = {
 	{ .compatible	= "arm,armv7-timer",	},
+	{ .compatible	= "arm,armv8-timer",	},
 	{},
 };
 
diff --git a/arch/arm64/include/asm/kvm_arch_timer.h b/arch/arm64/include/asm/kvm_arch_timer.h
new file mode 100644
index 0000000..eb02273
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_arch_timer.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ARM64_KVM_ARCH_TIMER_H
+#define __ARM64_KVM_ARCH_TIMER_H
+
+#include <linux/clocksource.h>
+#include <linux/hrtimer.h>
+#include <linux/workqueue.h>
+
+struct arch_timer_kvm {
+	/* Is the timer enabled */
+	bool			enabled;
+
+	/* Virtual offset, restored only */
+	cycle_t			cntvoff;
+};
+
+struct arch_timer_cpu {
+	/* Background timer used when the guest is not running */
+	struct hrtimer			timer;
+
+	/* Work queued with the above timer expires */
+	struct work_struct		expired;
+
+	/* Background timer active */
+	bool				armed;
+
+	/* Timer IRQ */
+	const struct kvm_irq_level	*irq;
+
+	/* Registers: control register, timer value */
+	u32				cntv_ctl;	/* Saved/restored */
+	cycle_t				cntv_cval;	/* Saved/restored */
+};
+
+int kvm_timer_hyp_init(void);
+int kvm_timer_init(struct kvm *kvm);
+void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
+void kvm_timer_flush_hwstate(struct kvm_vcpu *vcpu);
+void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu);
+void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu);
+
+#endif
-- 
1.7.12.4
