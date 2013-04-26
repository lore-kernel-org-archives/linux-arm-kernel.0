From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Apr 2013 16:04:44 +0200
Subject: [PATCH V3 2/3] ARM: net: bpf_jit: make code generation less
 dependent on struct sk_filter.
In-Reply-To: <1366824429-26652-3-git-send-email-nschichan@freebox.fr>
References: <1366824429-26652-1-git-send-email-nschichan@freebox.fr>
 <1366824429-26652-3-git-send-email-nschichan@freebox.fr>
Message-ID: <3592414.M8kQZLCXlW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 April 2013 19:27:08 Nicolas Schichan wrote:
> @@ -858,7 +858,7 @@ b_epilogue:
>  }
>  
>  
> -void bpf_jit_compile(struct sk_filter *fp)
> +static void __bpf_jit_compile(struct jit_ctx *out_ctx)
>  {
>         struct jit_ctx ctx;
>         unsigned tmp_idx;
> @@ -867,11 +867,10 @@ void bpf_jit_compile(struct sk_filter *fp)
>         if (!bpf_jit_enable)
>                 return;
>  
> -       memset(&ctx, 0, sizeof(ctx));
> -       ctx.skf         = fp;
> +       ctx = *out_ctx;
>         ctx.ret0_fp_idx = -1;
>  
> -       ctx.offsets = kzalloc(4 * (ctx.skf->len + 1), GFP_KERNEL);
> +       ctx.offsets = kzalloc(4 * (ctx.prog_len + 1), GFP_KERNEL);
>         if (ctx.offsets == NULL)
>                 return;
>  
> @@ -921,13 +920,26 @@ void bpf_jit_compile(struct sk_filter *fp)
>                 print_hex_dump(KERN_INFO, "BPF JIT code: ",
>                                DUMP_PREFIX_ADDRESS, 16, 4, ctx.target,
>                                alloc_size, false);
> -
> -       fp->bpf_func = (void *)ctx.target;
>  out:
>         kfree(ctx.offsets);
> +
> +       *out_ctx = ctx;
>         return;

This part of the patch, in combination with 79617801e "filter: bpf_jit_comp:
refactor and unify BPF JIT image dump output" is now causing build errors
in linux-next:

arch/arm/net/bpf_jit_32.c: In function '__bpf_jit_compile':
arch/arm/net/bpf_jit_32.c:930:16: error: 'fp' undeclared (first use in this function)
   bpf_jit_dump(fp->len, alloc_size, 2, ctx.target);
                ^


	Arnd
