From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:14:06 -0700
Subject: [PATCH v3 14/14] ARM64: KVM: fix big endian issue in access_vm_reg
 for 32bit guest
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix isssue with 32bit guests running on top of BE KVM host. Guest
state is retored with double word read operations. Within the high
and low word data is already byteswap. This code effectively swaps
two words within 64bit value.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 060c3a9..4438b47 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -51,6 +51,16 @@ static u32 cache_levels;
 /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
 #define CSSELR_MAX 12
 
+/* Word access indexes for 64bit vm accessor */
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define CP15_REG_MSW_INDEX 0
+#define CP15_REG_LSW_INDEX 1
+#else
+#define CP15_REG_MSW_INDEX 1
+#define CP15_REG_LSW_INDEX 0
+#endif
+
+
 /* Which cache CCSIDR represents depends on CSSELR value. */
 static u32 get_ccsidr(u32 csselr)
 {
@@ -137,9 +147,9 @@ static bool access_vm_reg(struct kvm_vcpu *vcpu,
 	if (!p->is_aarch32) {
 		vcpu_sys_reg(vcpu, r->reg) = val;
 	} else {
-		vcpu_cp15(vcpu, r->reg) = val & 0xffffffffUL;
+		vcpu_cp15(vcpu, r->reg + CP15_REG_LSW_INDEX) = val & 0xffffffffUL;
 		if (!p->is_32bit)
-			vcpu_cp15(vcpu, r->reg + 1) = val >> 32;
+			vcpu_cp15(vcpu, r->reg + CP15_REG_MSW_INDEX) = val >> 32;
 	}
 	return true;
 }
-- 
1.8.1.4
