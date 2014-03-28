From: robherring2@gmail.com (Rob Herring)
Date: Fri, 28 Mar 2014 15:41:46 -0500
Subject: [PATCH 32/75] ARM: l2c: implement L2C-310 erratum 588369 as a
 method override
In-Reply-To: <E1WTYWp-0007F1-Tq@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYWp-0007F1-Tq@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqJc83QhK2zpYdT9XoU0_wOv7Dm31Ew0Mh6e68f9YU8O7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:17 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Implement L2C-310 erratum 588369 by overriding the invalidate range
> and flush range methods in the outer_cache operations structure.
> This allows us to sensibly contain the erratum code in one place
> without affecting other locations/implemetations.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

[snip]

> @@ -600,9 +659,19 @@ static void __init l2c310_fixup(void __iomem *base, u32 cache_id,
>         const char *errata[4];
>         unsigned n = 0;
>
> +       /* For compatibility */

Compatibility of what?  This needs a better comment.

>         if (revision <= L310_CACHE_ID_RTL_R3P0)
>                 fns->set_debug = l2c310_set_debug;
>
> +       if (IS_ENABLED(CONFIG_PL310_ERRATA_588369) &&
> +           revision < L310_CACHE_ID_RTL_R2P0 &&
> +           /* For compatibility */

same here.

> +           fns->inv_range == l2x0_inv_range) {
> +               fns->inv_range = l2c310_inv_range_erratum;
> +               fns->flush_range = l2c310_flush_range_erratum;
> +               errata[n++] = "533369";

s/533369/588369/

> +       }
> +
>         if (IS_ENABLED(CONFIG_PL310_ERRATA_727915) &&
>             revision >= L310_CACHE_ID_RTL_R2P0 &&
>             revision < L310_CACHE_ID_RTL_R3P1) {
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
