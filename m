From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Feb 2017 11:47:28 +0000
Subject: [PATCH 8/8] arm64: KVM: Do not corrupt registers on failed 64bit CP
 read
In-Reply-To: <20170222114728.2472-1-marc.zyngier@arm.com>
References: <20170222114728.2472-1-marc.zyngier@arm.com>
Message-ID: <20170222114728.2472-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we fail to emulate a mrrc instruction, we:
1) deliver an exception,
2) spit a nastygram on the console,
3) write back some garbage to Rt/Rt2

While 1) and 2) are perfectly acceptable, 3) is out of the scope of
the architecture... Let's mimick the code in kvm_handle_cp_32 and
be more cautious.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 44b7a7325229..abda10476a04 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1687,20 +1687,18 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 		params.regval |= vcpu_get_reg(vcpu, Rt2) << 32;
 	}
 
-	if (!emulate_cp(vcpu, &params, target_specific, nr_specific))
-		goto out;
-	if (!emulate_cp(vcpu, &params, global, nr_global))
-		goto out;
-
-	unhandled_cp_access(vcpu, &params);
+	if (!emulate_cp(vcpu, &params, target_specific, nr_specific) ||
+	    !emulate_cp(vcpu, &params, global, nr_global)) {
+		/* Split up the value between registers for the read side */
+		if (!params.is_write) {
+			vcpu_set_reg(vcpu, Rt, lower_32_bits(params.regval));
+			vcpu_set_reg(vcpu, Rt2, upper_32_bits(params.regval));
+		}
 
-out:
-	/* Split up the value between registers for the read side */
-	if (!params.is_write) {
-		vcpu_set_reg(vcpu, Rt, lower_32_bits(params.regval));
-		vcpu_set_reg(vcpu, Rt2, upper_32_bits(params.regval));
+		return 1;
 	}
 
+	unhandled_cp_access(vcpu, &params);
 	return 1;
 }
 
-- 
2.11.0
