From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 23 Oct 2018 10:06:04 +0900
Subject: [PATCH] ARM: kprobes: Fix false positive with FORTIFY_SOURCE
In-Reply-To: <20181022093023.GA8920@beast>
References: <20181022093023.GA8920@beast>
Message-ID: <20181023100604.ea7a1a9b5c1c8904aab1b36b@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2018 02:30:23 -0700
Kees Cook <keescook@chromium.org> wrote:

> The arm compiler internally interprets an inline assembly label
> as an unsigned long value, not a pointer. As a result, under
> CONFIG_FORTIFY_SOURCE, the size of the array pointed to by an address
> of a label is 4 bytes, which was tripping the runtime checks. Instead,
> we can just cast the label (as done with the size calculations earlier)
> to avoid the problem.
> 
> Reported-by: William Cohen <wcohen@redhat.com>
> Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
> Cc: stable at vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> ---
>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index b2aa9b32bff2..2c118a6ab358 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, &optprobe_template_entry,
> +	memcpy(code, (unsigned char *)optprobe_template_entry,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security


-- 
Masami Hiramatsu <mhiramat@kernel.org>
