From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 May 2015 16:17:04 +0100
Subject: [PATCH] arm64: bpf: fix signedness bug in loading 64-bit immediate
In-Reply-To: <CAKU6vybvWvoF2Om0D-tPp0N-_4Oj3o44hnbmrnEtyNN8XeBAHg@mail.gmail.com>
References: <1431063591-16668-1-git-send-email-xi.wang@gmail.com>
 <20150508083856.GA2125@arm.com>
 <CAKU6vybvWvoF2Om0D-tPp0N-_4Oj3o44hnbmrnEtyNN8XeBAHg@mail.gmail.com>
Message-ID: <20150508151704.GF25587@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 09:45:59AM +0100, Xi Wang wrote:
> On Fri, May 8, 2015 at 1:38 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> -             imm64 = (u64)insn1.imm << 32 | imm;
> >> +             imm64 = ((u64)(u32)insn1.imm) << 32 | (u64)(u32)imm;
> >
> > This seems a bit convoluted to me. Don't you just need to add a (u32)
> > cast to imm and that's it? The (u64)(u32) looks redundant.
> 
> You're right -  the second (u64) is redundant; the hope was to make
> the code easier to understand.  It's from the interpreter code in
> kernel/core/bpf.c, which uses (u64)(u32) as well.
> 
> >> -                     BPF_ALU64_IMM(BPF_MOV, R0, 1),
> >> +                     BPF_LD_IMM64(R0, 0x1ffffffffLL),
> >> +                     BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
> >>                       BPF_EXIT_INSN(),
> >
> > This hunk should probably be a separate patch, unless you get Alexei's ack
> > for me to take it via the arm64 tree too.
> 
> I would be happy to split this into a separate patch if that works
> better, or simply drop this part.

Ok, I plan to apply the patch below for 4.1.

Will

--->8

>From 1e4df6b7208140f3c49f316d33a409d3a161f350 Mon Sep 17 00:00:00 2001
From: Xi Wang <xi.wang@gmail.com>
Date: Fri, 8 May 2015 06:39:51 +0100
Subject: [PATCH] arm64: bpf: fix signedness bug in loading 64-bit immediate

Consider "(u64)insn1.imm << 32 | imm" in the arm64 JIT.  Since imm is
signed 32-bit, it is sign-extended to 64-bit, losing the high 32 bits.
The fix is to convert imm to u32 first, which will be zero-extended to
u64 implicitly.

Cc: Zi Shen Lim <zlim.lnx@gmail.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>
Fixes: 30d3d94cc3d5 ("arm64: bpf: add 'load 64-bit immediate' instruction")
Signed-off-by: Xi Wang <xi.wang@gmail.com>
[will: removed non-arm64 bits and redundant casting]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index edba042b2325..dc6a4842683a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -487,7 +487,7 @@ emit_cond_jmp:
 			return -EINVAL;
 		}
 
-		imm64 = (u64)insn1.imm << 32 | imm;
+		imm64 = (u64)insn1.imm << 32 | (u32)imm;
 		emit_a64_mov_i64(dst, imm64, ctx);
 
 		return 1;
-- 
2.1.4
