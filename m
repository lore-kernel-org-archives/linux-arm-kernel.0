From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Nov 2015 13:55:51 +0000
Subject: [PATCH] arm64: kvm: avoid %p in __kvm_hyp_panic
Message-ID: <1447682151-5827-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently __kvm_hyp_panic uses %p for values which are not pointers,
such as the ESR value. This can confusingly lead to "(null)" being
printed for the value.

Use %x instead, and only use %p for host pointers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 1599701..11183ce 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -914,7 +914,7 @@ __kvm_hyp_panic:
 ENDPROC(__kvm_hyp_panic)
 
 __hyp_panic_str:
-	.ascii	"HYP panic:\nPS:%08x PC:%p ESR:%p\nFAR:%p HPFAR:%p PAR:%p\nVCPU:%p\n\0"
+	.ascii	"HYP panic:\nPS:%08x PC:%016x ESR:%08x\nFAR:%016x HPFAR:%016x PAR:%016x\nVCPU:%p\n\0"
 
 	.align	2
 
-- 
1.9.1
