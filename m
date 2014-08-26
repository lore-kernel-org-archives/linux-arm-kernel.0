From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 15:21:51 +0200
Subject: [PATCH v2] arm/arm64: KVM: Complete WFI/WFE instructions
Message-ID: <1409059311-31452-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The architecture specifies that when the processor wakes up from a WFE
or WFI instruction, the instruction is considered complete, however we
currrently return to EL1 (or EL0) at the WFI/WFE instruction itself.

While Linux guests may not be affected by this because their local
exception handler performs an exception returning setting the event bit
and has a separate context for the idle thread calling WFI, some guests like
UEFI will get wedged due this little mishap.

Simply skip the instruction when we have completed the emulation.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Changes [v2]:
 - Also fix this for arm64

 arch/arm/kvm/handle_exit.c   | 2 ++
 arch/arm64/kvm/handle_exit.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
index 4c979d4..a96a804 100644
--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -93,6 +93,8 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	else
 		kvm_vcpu_block(vcpu);
 
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+
 	return 1;
 }
 
diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e28be51..34b8bd0 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -66,6 +66,8 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	else
 		kvm_vcpu_block(vcpu);
 
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+
 	return 1;
 }
 
-- 
2.0.0
