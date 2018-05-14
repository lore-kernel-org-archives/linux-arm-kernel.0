From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 May 2018 23:29:53 +0200
Subject: [PATCH 09/12] platform/early: add an init section for early
 driver data
In-Reply-To: <20180511162028.20616-10-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <20180511162028.20616-10-brgl@bgdev.pl>
Message-ID: <CAMuHMdUnG0YLg=HXMrUVJ34sZEDuuZRYxnrPPC45-KpAkO3bcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Provide a separate section in which pointers to early platform driver
> structs will be stored.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for your patch!

> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -214,6 +214,16 @@
>  #define CPU_METHOD_OF_TABLES() OF_TABLE(CONFIG_SMP, cpu_method)
>  #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
>
> +#ifdef CONFIG_EARLY_PLATFORM
> +#define EARLY_PLATFORM_DRIVERS_TABLE()                                 \
> +       . = ALIGN(8);                                                   \

Should this use STRUCT_ALIGN() instead?

> +       VMLINUX_SYMBOL(__early_platform_drivers_table) = .;             \
> +       KEEP(*(__early_platform_drivers_table))                         \
> +       VMLINUX_SYMBOL(__early_platform_drivers_table_end) = .;
> +#else
> +#define EARLY_PLATFORM_DRIVERS_TABLE()
> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
