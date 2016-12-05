From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  5 Dec 2016 10:32:11 +0100
Subject: [PATCH] arm/arm64: KVM: Check for properly initialized timer on init
Message-ID: <20161205093211.11870-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the arch timer code fails to initialize (for example because the
memory mapped timer doesn't work, which is currently seen with the AEM
model), then KVM just continues happily with a final result that KVM
eventually does a NULL pointer dereference of the uninitialized cycle
counter.

Check directly for this in the init path and give the user a reasonable
error in this case.

Cc: Shih-Wei Li <shihwei@cs.columbia.edu>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 27a1f63..5c12f53 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -425,6 +425,11 @@ int kvm_timer_hyp_init(void)
 	info = arch_timer_get_kvm_info();
 	timecounter = &info->timecounter;
 
+	if (!timecounter->cc) {
+		kvm_err("arch_timer: uninitialized timecounter\n");
+		return -ENODEV;
+	}
+
 	if (info->virtual_irq <= 0) {
 		kvm_err("kvm_arch_timer: invalid virtual timer IRQ: %d\n",
 			info->virtual_irq);
-- 
2.9.0
