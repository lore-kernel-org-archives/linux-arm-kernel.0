From: mmarek@suse.com (Michal Marek)
Date: Wed, 14 Dec 2016 00:31:16 +0100
Subject: [PATCH 2/2] kbuild: make modversion for exported asm symbols more
 convivial
In-Reply-To: <1481171047-333-3-git-send-email-nicolas.pitre@linaro.org>
References: <1481171047-333-1-git-send-email-nicolas.pitre@linaro.org>
 <1481171047-333-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <9b2f99ca-0ac6-12b0-e753-5ce6feec96e8@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 8.12.2016 v 05:24 Nicolas Pitre napsal(a):
> Rather than having an asm-prototypes.h file where C prototypes for exported
> asm symbols are centralized, let's have some macros that can be used
> directly in the code where those symbols are exported for genksyms
> consumption.  Either the prototype is provided directly if no include
> files has it, or the include file containing it is specified.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  include/asm-generic/export.h | 15 +++++++++++++++
>  scripts/Makefile.build       | 22 +++++++++++++++-------
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
> index 39a19dc366..83dda5f840 100644
> --- a/include/asm-generic/export.h
> +++ b/include/asm-generic/export.h
> @@ -84,11 +84,26 @@ KSYM(__kcrctab_\name):
>  #define __EXPORT_SYMBOL(sym, val, sec) ___EXPORT_SYMBOL sym, val, sec
>  #endif
>  
> +/* in the non genksyms case those are no-ops */
> +#define SYMBOL_CPROTO(expr)
> +#define SYMBOL_CPROTO_INCLUDE(file)

Do we really _need_ the SYMBOL_CPROTO macro? The exported functions are
called from C files presumably, so there ought to be headers with the
declarations. If these headers can't be included easily, we should fix
them, but having copies of the declarations in the asm files is no big
improvement over the asm-prototypes.h approach, IMO.

Michal
