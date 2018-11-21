From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 22 Nov 2018 00:20:02 +0100
Subject: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
In-Reply-To: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
 <20181121131733.14910-3-ard.biesheuvel@linaro.org>
Message-ID: <945415e1-0ff8-65ce-15fa-33cea0a7d1c9@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2018 02:17 PM, Ard Biesheuvel wrote:
> The arm64 module region is a 128 MB region that is kept close to
> the core kernel, in order to ensure that relative branches are
> always in range. So using the same region for programs that do
> not have this restriction is wasteful, and preferably avoided.
> 
> Now that the core BPF JIT code permits the alloc/free routines to
> be overridden, implement them by simple vmalloc_exec()/vfree()
> calls, which can be served from anywere. This also solves an
> issue under KASAN, where shadow memory is needlessly allocated for
> all BPF programs (which don't require KASAN shadow pages since
> they are not KASAN instrumented)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6fdaea07c63..f91b7c157841 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  					   tmp : orig_prog);
>  	return prog;
>  }
> +
> +void *bpf_jit_alloc_exec(unsigned long size)
> +{
> +	return vmalloc_exec(size);
> +}
> +
> +void bpf_jit_free_exec(const void *addr)
> +{
> +	return vfree(size);
> +}

Hmm, could you elaborate in the commit log on the potential performance
regression for JITed progs on arm64 after this change?

I think this change would also break JITing of BPF to BPF calls. You might
have the same issue as ppc64 folks where the offset might not fit into imm
anymore and would have to transfer it via fp->aux->func[off]->bpf_func
instead.
