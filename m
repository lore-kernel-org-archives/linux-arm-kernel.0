From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Thu, 12 Jul 2018 21:50:46 +0100
Subject: [PATCH net-next 2/4] ARM: net: bpf: improve 64-bit sign-extended
 immediate load
In-Reply-To: <20180712205003.GU17271@n2100.armlinux.org.uk>
References: <20180712205003.GU17271@n2100.armlinux.org.uk>
Message-ID: <E1fdiY2-0002P0-OF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the 64-bit sign-extended immediate from:

  mov     r6, #1
  str     r6, [fp, #-52]  ; 0xffffffcc
  mov     r6, #0
  str     r6, [fp, #-48]  ; 0xffffffd0

to:

  mov     r6, #1
  mov     r7, #0
  strd    r6, [fp, #-52]  ; 0xffffffcc

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6558bd73bbb9..3a182e618441 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -613,12 +613,11 @@ static void emit_a32_mov_i64(const s8 dst[], u64 val, struct jit_ctx *ctx)
 /* Sign extended move */
 static inline void emit_a32_mov_se_i64(const bool is64, const s8 dst[],
 				       const u32 val, struct jit_ctx *ctx) {
-	u32 hi = 0;
+	u64 val64 = val;
 
 	if (is64 && (val & (1<<31)))
-		hi = (u32)~0;
-	emit_a32_mov_i(dst_lo, val, ctx);
-	emit_a32_mov_i(dst_hi, hi, ctx);
+		val64 |= 0xffffffff00000000ULL;
+	emit_a32_mov_i64(dst, val64, ctx);
 }
 
 static inline void emit_a32_add_r(const u8 dst, const u8 src,
-- 
2.7.4
