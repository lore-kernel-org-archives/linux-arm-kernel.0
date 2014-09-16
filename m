From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Tue, 16 Sep 2014 11:37:35 -0700
Subject: [PATCH] arm64: bpf: add 'shift by register' instructions
Message-ID: <1410892655-17818-1-git-send-email-zlim.lnx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

Please consider applying this after -rc1.

A new commit in net-next 72b603ee8cfc introduced a new test case for
"shift by register" in lib/test_bpf.c, and arm64 JIT is currently
failing that (in linux-next). This patch enables support in arm64 JIT
and now passes the test.

Just FYI, a later commit 02ab695bb37e in net-next introduced a new eBPF
"load 64-bit immediate" instruction and arm64 JIT is also failing that
in linux-next. I'll take a look at it later, but am more than happy if
someone else beats me to it :)

BTW, none of these failures are fatal. When something is not supported
by our JIT compiler, we gracefully fallback to the core interpreter.

Thanks,
z
>8------------------------------------------------------8<

Commit 72b603ee8cfc ("bpf: x86: add missing 'shift by register'
instructions to x64 eBPF JIT") noted support for 'shift by register'
in eBPF and added support for it for x64. Let's enable this for arm64
as well.

The arm64 eBPF JIT compiler now passes the new 'shift by register'
test case introduced in the same commit 72b603ee8cfc.

Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@plumgrid.com>
---
 arch/arm64/net/bpf_jit.h      |  8 ++++++--
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 2134f7e..de0a81a 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -144,8 +144,12 @@
 
 /* Data-processing (2 source) */
 /* Rd = Rn OP Rm */
-#define A64_UDIV(sf, Rd, Rn, Rm) aarch64_insn_gen_data2(Rd, Rn, Rm, \
-	A64_VARIANT(sf), AARCH64_INSN_DATA2_UDIV)
+#define A64_DATA2(sf, Rd, Rn, Rm, type) aarch64_insn_gen_data2(Rd, Rn, Rm, \
+	A64_VARIANT(sf), AARCH64_INSN_DATA2_##type)
+#define A64_UDIV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, UDIV)
+#define A64_LSLV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSLV)
+#define A64_LSRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, LSRV)
+#define A64_ASRV(sf, Rd, Rn, Rm) A64_DATA2(sf, Rd, Rn, Rm, ASRV)
 
 /* Data-processing (3 source) */
 /* Rd = Ra + Rn * Rm */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7108895..80cc769 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -261,6 +261,18 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit(A64_MUL(is64, tmp, tmp, src), ctx);
 		emit(A64_SUB(is64, dst, dst, tmp), ctx);
 		break;
+	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU64 | BPF_LSH | BPF_X:
+		emit(A64_LSLV(is64, dst, dst, src), ctx);
+		break;
+	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU64 | BPF_RSH | BPF_X:
+		emit(A64_LSRV(is64, dst, dst, src), ctx);
+		break;
+	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU64 | BPF_ARSH | BPF_X:
+		emit(A64_ASRV(is64, dst, dst, src), ctx);
+		break;
 	/* dst = -dst */
 	case BPF_ALU | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
-- 
1.9.1
