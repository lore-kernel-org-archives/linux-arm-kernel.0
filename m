From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 22 Mar 2016 09:19:34 +0100
Subject: [PULL 1/3] KVM: arm/arm64: disable preemption when calling
 smp_call_function_many
In-Reply-To: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
References: <1458634776-18388-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1458634776-18388-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@linaro.org>

Preemption must be disabled when calling smp_call_function_many

Reported-by: bartosz.wawrzyniak at tieto.com
Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 3e0fb66..6accd66 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -373,7 +373,9 @@ static void exit_vm_noop(void *info)
 
 void force_vm_exit(const cpumask_t *mask)
 {
+	preempt_disable();
 	smp_call_function_many(mask, exit_vm_noop, NULL, true);
+	preempt_enable();
 }
 
 /**
-- 
2.1.2.330.g565301e.dirty
