From: ast@plumgrid.com (Alexei Starovoitov)
Date: Thu, 25 Jun 2015 06:34:12 -0700
Subject: [PATCH] arm64: bpf: fix out-of-bounds read in bpf2a64_offset()
In-Reply-To: <1435236459-15141-1-git-send-email-xi.wang@gmail.com>
References: <1435236459-15141-1-git-send-email-xi.wang@gmail.com>
Message-ID: <558C0354.4080809@plumgrid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/25/15 5:47 AM, Xi Wang wrote:
> Problems occur when bpf_to or bpf_from has value prog->len - 1 (e.g.,
> "Very long jump backwards" in test_bpf where the last instruction is a
> jump): since ctx->offset has length prog->len, ctx->offset[bpf_to + 1]
> or ctx->offset[bpf_from + 1] will cause an out-of-bounds read, leading
> to a bogus jump offset and kernel panic.
>
> This patch moves updating ctx->offset to after calling build_insn(),
> and changes indexing to use bpf_to and bpf_from without + 1.
>
> Cc: Zi Shen Lim<zlim.lnx@gmail.com>
> Cc: Alexei Starovoitov<ast@plumgrid.com>
> Cc: Will Deacon<will.deacon@arm.com>
> Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
> Signed-off-by: Xi Wang<xi.wang@gmail.com>

Nice catch! Looks good to me.
Acked-by: Alexei Starovoitov <ast@plumgrid.com>
