From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2018 14:14:13 +0200
Subject: [PATCH] include/linux/compiler-clang.h: define __naked
In-Reply-To: <20180910060455.20409-1-stefan@agner.ch>
References: <20180910060455.20409-1-stefan@agner.ch>
Message-ID: <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 8:05 AM Stefan Agner <stefan@agner.ch> wrote:
>
> ARM32 arch code uses the __naked attribute. This has previously been
> defined in include/linux/compiler-gcc.h, which is no longer included
> for Clang. Define __naked for Clang. Conservatively add all attributes
> previously used (and supported by Clang).
>
> This fixes compile errors when building ARM32 using Clang:
>   arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
>   static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>               ^
>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

> +/*
> + * ARM32 is currently the only user of __naked supported by Clang. Follow
> + * gcc: Do not trace naked functions and make sure they don't get inlined.
> + */
> +#define __naked __attribute__((naked)) noinline notrace
> +

Please see patches 5 and 6 of the series that Miguel posted:

https://lore.kernel.org/lkml/20180908212459.19736-6-miguel.ojeda.sandonis at gmail.com/

I suppose we want the patch to fix clang build as soon as possible though,
and follow up with the cleanup for the next merge window, right?

       Arnd
