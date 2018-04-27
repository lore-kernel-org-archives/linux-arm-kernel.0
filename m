From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 17:13:20 +0200
Subject: [PATCH RFC PoC 1/2] earlydev: implement a new way to probe
 platform devices early
In-Reply-To: <20180426152920.21569-2-brgl@bgdev.pl>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426152920.21569-2-brgl@bgdev.pl>
Message-ID: <CAK8P3a13wiATdYDGXnmEMfpoKzXqWA-umKLgO7hFaJj3MF4w1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 5:29 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> +/*
> + * REVISIT: early_initcall may be still too late for some timers and critical
> + * clocks. We should probably have a separate section with callbacks that can
> + * be invoked at each architecture's discretion.
> + */
> +#define earlydev_platform_driver(_drv)                                 \
> +       static int _drv##_register(void)                                \
> +       {                                                               \
> +               earlydev_driver_register(&(_drv));                      \
> +               return 0;                                               \
> +       }                                                               \
> +       early_initcall(_drv##_register)
> +
> +#endif /* __EARLYDEV_H__ */

No full review, just one comment: this would really need to fit into the
existing callbacks for clk, timer, earlycon etc that we use with OF_DECLARE.
A lot of code makes assumptions about the order in which they are
called, and the current early_platform infrastructure does the same
thing using its "earlyprintk" and "earlytimer" classes.

       Arnd
