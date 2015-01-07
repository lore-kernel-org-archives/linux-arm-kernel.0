From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:20 +0000
Subject: [PATCH 7/7] arm64: kvm: decode ESR_ELx.EC when reporting exceptions
In-Reply-To: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1420632260-8798-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid the developer when something triggers an unexpected exception,
decode the ESR_ELx.EC field when logging an ESR_ELx value using the
newly introduced esr_get_class_string. This doesn't tell the developer
the specifics of the exception encoded in the remaining IL and ISS bits,
but it can be helpful to distinguish between exception classes (e.g.
SError and a data abort) without having to manually decode the field,
which can be tiresome.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kvm/handle_exit.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index bcbc923..29b184a 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -91,12 +91,13 @@ static exit_handle_fn arm_exit_handlers[] = {
 
 static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 {
-	u8 hsr_ec = kvm_vcpu_trap_get_class(vcpu);
+	u32 hsr = kvm_vcpu_get_hsr(vcpu);
+	u8 hsr_ec = hsr >> ESR_ELx_EC_SHIFT;
 
 	if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers) ||
 	    !arm_exit_handlers[hsr_ec]) {
-		kvm_err("Unknown exception class: hsr: %#08x\n",
-			(unsigned int)kvm_vcpu_get_hsr(vcpu));
+		kvm_err("Unknown exception class: hsr: %#08x -- %s\n",
+			hsr, esr_get_class_string(hsr));
 		BUG();
 	}
 
-- 
1.9.1
