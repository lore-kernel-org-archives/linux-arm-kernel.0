From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Jan 2018 18:47:14 -0500 (EST)
Subject: [PATCH v7 02/10] module: allow symbol exports to be disabled
In-Reply-To: <20180102200549.22984-3-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-3-ard.biesheuvel@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Jan 2018, Ard Biesheuvel wrote:

> To allow existing C code to be incorporated into the decompressor or
> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
> declarations into nops, and #define it in places where such exports
> are undesirable. Note that this gets rid of a rather dodgy redefine
> of linux/export.h's header guard.
[...]

> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -83,6 +83,15 @@ extern struct module __this_module;
>   */
>  #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
>  
> +#elif defined(__DISABLE_EXPORTS)
> +
> +/*
> + * Allow symbol exports to be disabled completely so that C code may
> + * be reused in other execution contexts such as the UEFI stub or the
> + * decompressor.
> + */
> +#define __EXPORT_SYMBOL(sym, sec)
> +

I think you should rather put this first thing in the #if sequence so to 
override the defined(__KSYM_DEPS__) case too.  No need to create build 
dependencies for module symbols that you're going to stub out 
afterwards anyway.


Nicolas
