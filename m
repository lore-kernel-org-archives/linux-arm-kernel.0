From: daniel@iogearbox.net (Daniel Borkmann)
Date: Sat, 14 Nov 2015 01:16:18 +0100
Subject: [PATCH] bpf, arm64: start flushing icache range from header
Message-ID: <41c4a481eb665a492c3b2df16af219b1250224a0.1447446460.git.daniel@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While recently going over ARM64's BPF code, I noticed that the icache
range we're flushing should start at header already and not at ctx.image.

Reason is that after b569c1c622c5 ("net: bpf: arm64: address randomize
and write protect JIT code"), we also want to make sure to flush the
random-sized trap in front of the start of the actual program (analogous
to x86). No operational differences from user side.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 ( As arm64 jit fixes seem to go via arm64 tree, sending them here. )

 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a44e529..ee06570 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -740,7 +740,7 @@ void bpf_int_jit_compile(struct bpf_prog *prog)
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, image_size, 2, ctx.image);
 
-	bpf_flush_icache(ctx.image, ctx.image + ctx.idx);
+	bpf_flush_icache(header, ctx.image + ctx.idx);
 
 	set_memory_ro((unsigned long)header, header->pages);
 	prog->bpf_func = (void *)ctx.image;
-- 
1.9.3
