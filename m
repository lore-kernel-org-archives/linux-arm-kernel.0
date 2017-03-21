From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 19:20:36 +0000
Subject: [PATCH v4 06/28] arm64: KVM: Implement HVC_GET_VECTORS in the init
 code
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170321192058.9300-7-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have an infrastructure to handle hypercalls in the KVM
init code, let's implement HVC_GET_VECTORS there.

Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp-init.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 6cf98ccd10f2..1d89995378e9 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -124,7 +124,12 @@ __do_hyp_init:
 ENDPROC(__kvm_hyp_init)
 
 ENTRY(__kvm_handle_stub_hvc)
-	cmp	x0, #HVC_RESET_VECTORS
+	cmp	x0, #HVC_GET_VECTORS
+	b.ne	1f
+	mrs	x0, vbar_el2
+	b	exit
+
+1:	cmp	x0, #HVC_RESET_VECTORS
 	b.ne	1f
 	/*
 	 * Reset kvm back to the hyp stub.
-- 
2.11.0
