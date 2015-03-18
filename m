From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Mar 2015 19:58:15 +0100
Subject: [PATCH v2 6/8] asm-generic: introduce .text.fixup input section
In-Reply-To: <1426248452-4773-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <201503181958.15752.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015, Ard Biesheuvel wrote:
> This introduces a new .text.fixup input section that gets emitted
> together with the .text section for each input object file.
> 
> Note that
> 
>   *(.text)
>   *(.text.fixup)
> 
> is not the same as
> 
>   *(.text .text.fixup)
> 
> and we are looking for the latter, to ensure that fixup snippets that
> are assembled into a separate section in the object file do not end
> up out of range for the relative branch instructions it contains if
> the .text section itself grows very large.
> 
> This helps prevent linker failures on large ARM kernels.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Let's merge this together with the other patches rather than using 
the asm-generic git.

> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index ac78910d7416..463231d5bfc7 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -401,7 +401,7 @@
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
>  		*(.text.hot)						\
> -		*(.text)						\
> +		*(.text .text.fixup)					\
>  		*(.ref.text)						\
>  	MEM_KEEP(init.text)						\
>  	MEM_KEEP(exit.text)						\
> -- 
> 1.8.3.2
> 
> 
