From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Sun, 25 Feb 2018 21:21:18 +0900
Subject: [PATCH 2/2] arm: kprobes: Prohibit kprobes on get_user functions
In-Reply-To: <151945939903.11045.1486072728379559979.stgit@devbox>
References: <151945937038.11045.14421944772744094357.stgit@devbox>
 <151945939903.11045.1486072728379559979.stgit@devbox>
Message-ID: <20180225212118.ee09db43772a338151762730@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 24 Feb 2018 17:03:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since do_undefinstr() uses get_user to get the undefined
> instruction, it can be called before kprobes processes
> recursive check. This can cause an infinit recursive
> exception.
> Prohibit probing on get_user functions.
> 
> Fixes: 24ba613c9d6c ("ARM kprobes: core code")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/include/asm/assembler.h |    8 ++++++++
>  arch/arm/lib/getuser.S           |   10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index bc8d4bbd82e2..dd5e7f30eaed 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -536,4 +536,12 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +#ifdef CONFIG_KPROBES
> +# define _ASM_NOKPROBE(entry)				\
> +	.pushsection "_kprobe_blacklist", "aw" ;	\
> +	.balign 4 ;					\
> +	.long entry;					\
> +	.popsection

Oops, I missed #else block... which cause build error if !CONFIG_KPROBES.
I'll update it soon.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
