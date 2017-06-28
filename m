From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 28 Jun 2017 16:58:03 +0200
Subject: [PATCH] arm64: fix endianness annotation for 'struct jit_ctx' and
 friends
Message-ID: <20170628145803.24543-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct jit_ctx::image is used the store a pointer to the jitted
intructions, which are always little-endian. These instructions
are thus correctly converted from native order to little-endian
before being stored but the pointer 'image' is declared as for
native order values.

Fix this by declaring the field as __le32* instead of u32*.
Same for the pointer used in jit_fill_hole() to initialize
the image.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c870d6f01..8860bb9c3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -70,7 +70,7 @@ struct jit_ctx {
 	int idx;
 	int epilogue_offset;
 	int *offset;
-	u32 *image;
+	__le32 *image;
 };
 
 static inline void emit(const u32 insn, struct jit_ctx *ctx)
@@ -130,7 +130,7 @@ static inline int bpf2a64_offset(int bpf_to, int bpf_from,
 
 static void jit_fill_hole(void *area, unsigned int size)
 {
-	u32 *ptr;
+	__le32 *ptr;
 	/* We are guaranteed to have aligned memory. */
 	for (ptr = area; size >= sizeof(u32); size -= sizeof(u32))
 		*ptr++ = cpu_to_le32(AARCH64_BREAK_FAULT);
@@ -874,7 +874,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	/* 2. Now, the actual pass. */
 
-	ctx.image = (u32 *)image_ptr;
+	ctx.image = (__le32 *)image_ptr;
 	ctx.idx = 0;
 
 	build_prologue(&ctx);
-- 
2.13.0
