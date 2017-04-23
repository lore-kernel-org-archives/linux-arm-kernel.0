From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:43 +0200
Subject: [PULL 33/79] arm64: KVM: Do not corrupt registers on failed 64bit CP
 read
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-34-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we fail to emulate a mrrc instruction, we:
1) deliver an exception,
2) spit a nastygram on the console,
3) write back some garbage to Rt/Rt2

While 1) and 2) are perfectly acceptable, 3) is out of the scope of
the architecture... Let's mimick the code in kvm_handle_cp_32 and
be more cautious.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2f4418e..582d68e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1678,20 +1678,25 @@ static int kvm_handle_cp_64(struct kvm_vcpu *vcpu,
 		params.regval |= vcpu_get_reg(vcpu, Rt2) << 32;
 	}
 
-	if (!emulate_cp(vcpu, &params, target_specific, nr_specific))
-		goto out;
-	if (!emulate_cp(vcpu, &params, global, nr_global))
-		goto out;
-
-	unhandled_cp_access(vcpu, &params);
+	/*
+	 * Try to emulate the coprocessor access using the target
+	 * specific table first, and using the global table afterwards.
+	 * If either of the tables contains a handler, handle the
+	 * potential register operation in the case of a read and return
+	 * with success.
+	 */
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
2.9.0
