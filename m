From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:35:35 +0100
Subject: [PULL 7/8] arm64: kvm: avoid %p in __kvm_hyp_panic
In-Reply-To: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
References: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1448386536-30118-8-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

Currently __kvm_hyp_panic uses %p for values which are not pointers,
such as the ESR value. This can confusingly lead to "(null)" being
printed for the value.

Use %x instead, and only use %p for host pointers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index ff2e038..ce70817 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -914,7 +914,7 @@ __kvm_hyp_panic:
 ENDPROC(__kvm_hyp_panic)
 
 __hyp_panic_str:
-	.ascii	"HYP panic:\nPS:%08x PC:%p ESR:%p\nFAR:%p HPFAR:%p PAR:%p\nVCPU:%p\n\0"
+	.ascii	"HYP panic:\nPS:%08x PC:%016x ESR:%08x\nFAR:%016x HPFAR:%016x PAR:%016x\nVCPU:%p\n\0"
 
 	.align	2
 
-- 
2.1.2.330.g565301e.dirty
