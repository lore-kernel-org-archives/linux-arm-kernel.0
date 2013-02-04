From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 04 Feb 2013 09:54:50 -0800
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20130202232740.f337dc3a00741a224a4a0e4f@canb.auug.org.au>
References: <20130202232740.f337dc3a00741a224a4a0e4f@canb.auug.org.au>
Message-ID: <20130204175450.6375.8494@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Rothwell (2013-02-02 04:27:40)
> Hi Mike,
> 
> Today's linux-next merge of the clk tree got a conflict in
> include/asm-generic/vmlinux.lds.h between commit ae278a935f08
> ("clocksource: add common of_clksrc_init() function") from the arm-soc
> tree and commit f2f6c2556dcc ("clk: add common of_clk_init() function")
> from the clk tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 

Looks correct to me.  Thanks Stephen.

Regards,
Mike

> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc include/asm-generic/vmlinux.lds.h
> index fc62ac5,c1fe60a..0000000
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@@ -149,25 -149,16 +149,34 @@@
>   #define TRACE_SYSCALLS()
>   #endif
>   
>  +#ifdef CONFIG_CLKSRC_OF
>  +#define CLKSRC_OF_TABLES() . = ALIGN(8);                              \
>  +                         VMLINUX_SYMBOL(__clksrc_of_table) = .;       \
>  +                         *(__clksrc_of_table)                         \
>  +                         *(__clksrc_of_table_end)
>  +#else
>  +#define CLKSRC_OF_TABLES()
>  +#endif
>  +
>  +#ifdef CONFIG_IRQCHIP
>  +#define IRQCHIP_OF_MATCH_TABLE()                                      \
>  +      . = ALIGN(8);                                                   \
>  +      VMLINUX_SYMBOL(__irqchip_begin) = .;                            \
>  +      *(__irqchip_of_table)                                           \
>  +      *(__irqchip_of_end)
>  +#else
>  +#define IRQCHIP_OF_MATCH_TABLE()
>  +#endif
>   
> + #ifdef CONFIG_COMMON_CLK
> + #define CLK_OF_TABLES() . = ALIGN(8);                         \
> +                       VMLINUX_SYMBOL(__clk_of_table) = .;     \
> +                       *(__clk_of_table)                       \
> +                       *(__clk_of_table_end)
> + #else
> + #define CLK_OF_TABLES()
> + #endif
> + 
>   #define KERNEL_DTB()                                                  \
>         STRUCT_ALIGN();                                                 \
>         VMLINUX_SYMBOL(__dtb_start) = .;                                \
> @@@ -511,9 -502,8 +520,10 @@@
>         DEV_DISCARD(init.rodata)                                        \
>         CPU_DISCARD(init.rodata)                                        \
>         MEM_DISCARD(init.rodata)                                        \
>  +      CLKSRC_OF_TABLES()                                              \
> +       CLK_OF_TABLES()                                                 \
>  -      KERNEL_DTB()
>  +      KERNEL_DTB()                                                    \
>  +      IRQCHIP_OF_MATCH_TABLE()
>   
>   #define INIT_TEXT                                                     \
>         *(.init.text)                                                   \
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
