From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 13:37:00 +0100
Subject: [PATCH net-next 11/13] ARM: net: bpf: avoid reloading 'array'
In-Reply-To: <20180710123340.GK17271@n2100.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
Message-ID: <E1fcrt6-0005VT-5J@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rearranging the order of the initial tail call code a little allows is
to avoid reloading the 'array' pointer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 8264cac1322c..926e81c15505 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1015,16 +1015,16 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) >
 		     ARM_INST_LDST__IMM12);
 	off = offsetof(struct bpf_array, map.max_entries);
-	/* array->map.max_entries */
-	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
-	emit(ARM_LDR_I(tmp[1], r_array, off), ctx);
+	r_array = arm_bpf_get_reg32(r2[1], tmp2[0], ctx);
 	/* index is 32-bit for arrays */
 	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
+	/* array->map.max_entries */
+	emit(ARM_LDR_I(tmp[1], r_array, off), ctx);
 	/* index >= array->map.max_entries */
 	emit(ARM_CMP_R(r_index, tmp[1]), ctx);
 	_emit(ARM_COND_CS, ARM_B(jmp_offset), ctx);
 
-	/* tmp2[1] = index */
+	/* tmp2[0] = array, tmp2[1] = index */
 
 	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *	goto out;
@@ -1046,7 +1046,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > ARM_ALU_IMM);
 	off = offsetof(struct bpf_array, ptrs);
-	r_array = arm_bpf_get_reg32(r2[1], tmp2[0], ctx);
 	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
 	emit(ARM_LDR_R_SI(tmp[1], tmp[1], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_CMP_I(tmp[1], 0), ctx);
-- 
2.7.4
