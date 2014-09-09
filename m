From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 08 Sep 2014 23:15:36 -0700
Subject: [PATCH v9 2/6] clk: Move all drivers to use internal API
In-Reply-To: <20140908061355.19023.47997@quantum>
References: <1409758148-20104-2-git-send-email-tomeu.vizoso@collabora.com>
 <1409758317-20564-1-git-send-email-tomeu.vizoso@collabora.com>
 <20140908061355.19023.47997@quantum>
Message-ID: <20140909061536.19023.90796@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mike Turquette (2014-09-07 23:13:55)
> Quoting Tomeu Vizoso (2014-09-03 08:31:57)
> > In preparation to change the public API to return a per-user clk structure,
> > remove any usage of this public API from the clock implementations.
> > 
> > The reason for having this in a separate commit from the one that introduces
> > the implementation of the new functions is to separate the changes generated
> > with Coccinelle from the rest, and keep the patches' size reasonable.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Tested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Hi Tomeu,
> 
> Looks like the Coccinelle script had a false-positive.
> asm-generic/clkdev.h was converted from clk->clk_core and this blowed up
> clock drivers for architectures that don't provide an asm-specific
> clkdev.h implementation. This fixes x86's LPSS and a Microblaze driver.
> 
> I've rolled the following fix into your 2/9 patch. No action is
> necessary.
> 
> Regards,
> Mike
> 
> 
> 
> diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
> index 4320225..90a32a6 100644
> --- a/include/asm-generic/clkdev.h
> +++ b/include/asm-generic/clkdev.h
> @@ -15,10 +15,10 @@
> 
>  #include <linux/slab.h>
> 
> -struct clk_core;
> +struct clk;
> 
> -static inline int __clk_get(struct clk_core *clk) { return 1; }
> -static inline void __clk_put(struct clk_core *clk) { }
> +static inline int __clk_get(struct clk *clk) { return 1; }
> +static inline void __clk_put(struct clk *clk) { }
> 
>  static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
>  {

Please disregard the above patch. I might have jumped the gun on this
one. I've posted an alternative (and hopefully correct) fix here:

http://lkml.kernel.org/r/<1410242868-14750-1-git-send-email-mturquette@linaro.org>

Regards,
Mike
