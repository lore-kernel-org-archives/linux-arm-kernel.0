From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:28 +0100
Subject: [PATCH net-next v2 12/14] ARM: net: bpf: avoid reloading 'array'
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBU4-0001Jh-2m@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rearranging the order of the initial tail call code a little allows is
to avoid reloading the 'array' pointer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 0a8b3d0903c4..f0cad9692952 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1064,16 +1064,16 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
@@ -1095,7 +1095,6 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	BUILD_BUG_ON(imm8m(offsetof(struct bpf_array, ptrs)) < 0);
 	off = imm8m(offsetof(struct bpf_array, ptrs));
-	r_array = arm_bpf_get_reg32(r2[1], tmp2[0], ctx);
 	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
 	emit(ARM_LDR_R_SI(tmp[1], tmp[1], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_CMP_I(tmp[1], 0), ctx);
-- 
2.7.4
