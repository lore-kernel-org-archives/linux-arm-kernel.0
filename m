From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 12:08:55 -0500
Subject: [PATCH] ARM: OF implies OF_FLATTREE
In-Reply-To: <61301019.TKW9ocJ2jm@wuerfel>
References: <61301019.TKW9ocJ2jm@wuerfel>
Message-ID: <CAL_JsqK5Yym9BbUQuGxAZkDyAmaQCPriKZQQwjR1fY7ypNoQpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 9:06 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On the ARM architecture, individual platforms select CONFIG_USE_OF if they
> need it, but all device tree code is keyed off CONFIG_OF. When building
> a platform without DT support and manually enabling CONFIG_OF, we now
> get a number of build errors, e.g.
>
> arch/arm/kernel/devtree.c: In function 'setup_machine_fdt':
> arch/arm/kernel/devtree.c:215:19: error: implicit declaration of function 'early_init_dt_verify' [-Werror=implicit-function-declaration]
>
> We could now try to separate the use case of booting from DT vs. the
> case of using the dynamic implementation, but that seems more complicated
> than it can gain us.

Agreed. It will only/mostly save init section code at that.

> This simply changes the ARM Kconfig file to always enable OF_RESERVED_MEM
> and OF_EARLY_FLATTREE when CONFIG_OF is enabled. These options add a little
> extra code when we just want the dynamic OF implementation, but that seems
> like a rather obscure case, and this version solves all CONFIG_OF related
> randconfig regressions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0166dc11be91 ("of: make CONFIG_OF user selectable")

Acked-by: Rob Herring <robh@kernel.org>

>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ee104950b30c..da71de8bba4f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -75,6 +75,8 @@ config ARM
>         select IRQ_FORCED_THREADING
>         select MODULES_USE_ELF_REL
>         select NO_BOOTMEM
> +       select OF_EARLY_FLATTREE if OF
> +       select OF_RESERVED_MEM if OF
>         select OLD_SIGACTION
>         select OLD_SIGSUSPEND3
>         select PERF_USE_VMALLOC
> @@ -1695,8 +1697,6 @@ config USE_OF
>         bool "Flattened Device Tree support"
>         select IRQ_DOMAIN
>         select OF
> -       select OF_EARLY_FLATTREE
> -       select OF_RESERVED_MEM
>         help
>           Include support for flattened device tree machine descriptions.
>
