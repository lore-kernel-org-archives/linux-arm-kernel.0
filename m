From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 May 2015 09:38:57 +0100
Subject: [PATCH] arm64: bpf: fix signedness bug in loading 64-bit immediate
In-Reply-To: <1431063591-16668-1-git-send-email-xi.wang@gmail.com>
References: <1431063591-16668-1-git-send-email-xi.wang@gmail.com>
Message-ID: <20150508083856.GA2125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 06:39:51AM +0100, Xi Wang wrote:
> Consider "(u64)insn1.imm << 32 | imm" in the arm64 JIT.  Since imm is
> signed 32-bit, it is sign-extended to 64-bit, losing the high 32 bits.
> The fix is to convert imm to u32 first and zero-extend it to u64.
> 
> Also extend test_bpf to catch this JIT bug; the interpreter is correct.
> 
> Before:
> test_bpf: #58 load 64-bit immediate ret -1 != 1 FAIL (1 times)
> 
> After:
> test_bpf: #58 load 64-bit immediate 74 PASS
> 
> Fixes: 30d3d94cc3d5 ("arm64: bpf: add 'load 64-bit immediate' instruction")
> Cc: Zi Shen Lim <zlim.lnx@gmail.com>
> Cc: Alexei Starovoitov <ast@plumgrid.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 2 +-
>  lib/test_bpf.c                | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index edba042b2325..14cdc099fda0 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -487,7 +487,7 @@ emit_cond_jmp:
>  			return -EINVAL;
>  		}
>  
> -		imm64 = (u64)insn1.imm << 32 | imm;
> +		imm64 = ((u64)(u32)insn1.imm) << 32 | (u64)(u32)imm;

This seems a bit convoluted to me. Don't you just need to add a (u32)
cast to imm and that's it? The (u64)(u32) looks redundant.

>  		emit_a64_mov_i64(dst, imm64, ctx);
>  
>  		return 1;
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index 80d78c51f65f..9f6849891b5f 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -1755,7 +1755,8 @@ static struct bpf_test tests[] = {
>  			BPF_EXIT_INSN(),
>  			BPF_JMP_IMM(BPF_JEQ, R3, 0x1234, 1),
>  			BPF_EXIT_INSN(),
> -			BPF_ALU64_IMM(BPF_MOV, R0, 1),
> +			BPF_LD_IMM64(R0, 0x1ffffffffLL),
> +			BPF_ALU64_IMM(BPF_RSH, R0, 32), /* R0 = 1 */
>  			BPF_EXIT_INSN(),

This hunk should probably be a separate patch, unless you get Alexei's ack
for me to take it via the arm64 tree too.

Will
