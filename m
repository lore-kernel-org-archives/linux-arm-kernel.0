From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 14 Jul 2016 13:19:34 +0300
Subject: [patch] arm64: KVM: clean up a condition
Message-ID: <20160714101934.GD18175@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My static checker complains that this condition looks like it should be
== instead of =.  This isn't a fast path, so we don't need to be fancy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a57d650..b0b225c 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1546,7 +1546,7 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 				struct sys_reg_params *params)
 {
 	u8 hsr_ec = kvm_vcpu_trap_get_class(vcpu);
-	int cp;
+	int cp = -1;
 
 	switch(hsr_ec) {
 	case ESR_ELx_EC_CP15_32:
@@ -1558,7 +1558,7 @@ static void unhandled_cp_access(struct kvm_vcpu *vcpu,
 		cp = 14;
 		break;
 	default:
-		WARN_ON((cp = -1));
+		WARN_ON(1);
 	}
 
 	kvm_err("Unsupported guest CP%d access at: %08lx\n",
