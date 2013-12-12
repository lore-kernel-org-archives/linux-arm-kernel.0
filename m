From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 12 Dec 2013 21:42:23 +0530
Subject: [PATCH] arm64: KVM: Force undefined exception for Guest SMC
 intructions
In-Reply-To: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
References: <1386864747-29006-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1386864747-29006-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMC-based PSCI emulation for Guest is going to be very different
from the in-kernel HVC-based PSCI emulation hence for now just inject
undefined exception when Guest executes SMC instruction.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm64/kvm/handle_exit.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 8da5606..df84d7b 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -39,9 +39,6 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (kvm_psci_call(vcpu))
-		return 1;
-
 	kvm_inject_undefined(vcpu);
 	return 1;
 }
-- 
1.7.9.5
