From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 10 Dec 2016 21:47:11 +0100
Subject: [RFC PATCH 6/7] KVM: arm/arm64: Remove unnecessary timer BUG_ON
 operations
In-Reply-To: <20161210204712.21830-1-christoffer.dall@linaro.org>
References: <20161210204712.21830-1-christoffer.dall@linaro.org>
Message-ID: <20161210204712.21830-7-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need BUG_ON operations for the timer code here anymore as this
is not a likely case to get wrong and they are in the critical path so
may potentially add overhead.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index beede1b..242728a 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -367,8 +367,6 @@ void kvm_timer_sync_hwstate(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 
-	BUG_ON(timer_is_armed(timer));
-
 	/*
 	 * If we entered the guest with the timer output asserted we have to
 	 * check if the guest has modified the timer so that we should lower
-- 
2.9.0
