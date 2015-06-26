From: xi.wang@gmail.com (Xi Wang)
Date: Thu, 25 Jun 2015 18:39:15 -0700
Subject: [RFC PATCH] arm64: bpf: fix endianness conversion bugs
Message-ID: <1435282755-12011-1-git-send-email-xi.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upper bits should be zeroed in endianness conversion:

- even when there's no need to change endianness (i.e., BPF_FROM_BE
  on big endian or BPF_FROM_LE on little endian);

- after rev16.

This patch fixes such bugs by emitting extra instructions to clear
upper bits.

Cc: Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
The current testsuite catches the 16-bit bugs.  I'll send a separate
patch that extends test_bpf to catch the 32-bit ones.
---
 arch/arm64/net/bpf_jit.h      |  4 ++++
 arch/arm64/net/bpf_jit_comp.c | 22 ++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index de0a81a..98a26ce 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -110,6 +110,10 @@
 /* Rd = Rn >> shift; signed */
 #define A64_ASR(sf, Rd, Rn, shift) A64_SBFM(sf, Rd, Rn, shift, (sf) ? 63 : 31)
 
+/* Zero extend */
+#define A64_UXTH(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 15)
+#define A64_UXTW(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 31)
+
 /* Move wide (immediate) */
 #define A64_MOVEW(sf, Rd, imm16, shift, type) \
 	aarch64_insn_gen_movewide(Rd, imm16, shift, \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c81ddd4..c047598 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -289,23 +289,41 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
 #ifdef CONFIG_CPU_BIG_ENDIAN
 		if (BPF_SRC(code) == BPF_FROM_BE)
-			break;
+			goto emit_bswap_uxt;
 #else /* !CONFIG_CPU_BIG_ENDIAN */
 		if (BPF_SRC(code) == BPF_FROM_LE)
-			break;
+			goto emit_bswap_uxt;
 #endif
 		switch (imm) {
 		case 16:
 			emit(A64_REV16(is64, dst, dst), ctx);
+			/* zero-extend 16 bits into 64 bits */
+			emit(A64_UXTH(is64, dst, dst), ctx);
 			break;
 		case 32:
 			emit(A64_REV32(is64, dst, dst), ctx);
+			/* upper 32 bits already cleared */
 			break;
 		case 64:
 			emit(A64_REV64(dst, dst), ctx);
 			break;
 		}
 		break;
+emit_bswap_uxt:
+		switch (imm) {
+		case 16:
+			/* zero-extend 16 bits into 64 bits */
+			emit(A64_UXTH(is64, dst, dst), ctx);
+			break;
+		case 32:
+			/* zero-extend 32 bits into 64 bits */
+			emit(A64_UXTW(is64, dst, dst), ctx);
+			break;
+		case 64:
+			/* nop */
+			break;
+		}
+		break;
 	/* dst = imm */
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
-- 
2.1.4
