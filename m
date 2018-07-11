From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 11 Jul 2018 10:32:22 +0100
Subject: [PATCH net-next v2 11/14] ARM: net: bpf: avoid reloading 'index'
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <E1fdBTy-0001Ja-VI@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid reloading 'index' after we have validated it - it remains in
tmp2[1] up to the point that we begin the code to index the pointer
array, so with a little rearrangement of the registers, we can use
the already loaded value.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index e22dc828420c..0a8b3d0903c4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1073,6 +1073,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(ARM_CMP_R(r_index, tmp[1]), ctx);
 	_emit(ARM_COND_CS, ARM_B(jmp_offset), ctx);
 
+	/* tmp2[1] = index */
+
 	/* if (tail_call_cnt > MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 * tail_call_cnt++;
@@ -1093,9 +1095,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 */
 	BUILD_BUG_ON(imm8m(offsetof(struct bpf_array, ptrs)) < 0);
 	off = imm8m(offsetof(struct bpf_array, ptrs));
-	r_array = arm_bpf_get_reg32(r2[1], tmp2[1], ctx);
+	r_array = arm_bpf_get_reg32(r2[1], tmp2[0], ctx);
 	emit(ARM_ADD_I(tmp[1], r_array, off), ctx);
-	r_index = arm_bpf_get_reg32(r3[1], tmp2[1], ctx);
 	emit(ARM_LDR_R_SI(tmp[1], tmp[1], r_index, SRTYPE_ASL, 2), ctx);
 	emit(ARM_CMP_I(tmp[1], 0), ctx);
 	_emit(ARM_COND_EQ, ARM_B(jmp_offset), ctx);
-- 
2.7.4
