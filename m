From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Mar 2014 15:30:23 -0500
Subject: [PATCH 04/44] ARM: l2c: add helper for L2 cache controller DT IDs
In-Reply-To: <E1WPLBf-0002bz-9b@rmk-PC.arm.linux.org.uk>
References: <20140317001302.GY21483@n2100.arm.linux.org.uk>
 <E1WPLBf-0002bz-9b@rmk-PC.arm.linux.org.uk>
Message-ID: <CAL_JsqJNxHsaD13SQEuS7mriVmK+7QhUX-gPqzjU2UXWbF3+eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 7:13 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Make it easier to declare L2 cache controller DT IDs by using a macro.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mm/cache-l2x0.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index f9985e5a208c..ac410b21edfb 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -946,20 +946,17 @@ static const struct l2x0_of_data bcm_l2x0_data = {
>         },
>  };
>
> +#define L2C_ID(name, fns) { .compatible = name, .data = (void *)&fns }

This would useful globally. It probably needs to be without the & in that case.

Rob

>  static const struct of_device_id l2x0_ids[] __initconst = {
> -       { .compatible = "arm,l210-cache", .data = (void *)&l2x0_data },
> -       { .compatible = "arm,l220-cache", .data = (void *)&l2x0_data },
> -       { .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
> -       { .compatible = "bcm,bcm11351-a2-pl310-cache", /* deprecated name */
> -         .data = (void *)&bcm_l2x0_data},
> -       { .compatible = "brcm,bcm11351-a2-pl310-cache",
> -         .data = (void *)&bcm_l2x0_data},
> -       { .compatible = "marvell,aurora-outer-cache",
> -         .data = (void *)&aurora_with_outer_data},
> -       { .compatible = "marvell,aurora-system-cache",
> -         .data = (void *)&aurora_no_outer_data},
> -       { .compatible = "marvell,tauros3-cache",
> -         .data = (void *)&tauros3_data },
> +       L2C_ID("arm,l210-cache", l2x0_data),
> +       L2C_ID("arm,l220-cache", l2x0_data),
> +       L2C_ID("arm,pl310-cache", pl310_data),
> +       L2C_ID("brcm,bcm11351-a2-pl310-cache", bcm_l2x0_data),
> +       L2C_ID("marvell,aurora-outer-cache", aurora_with_outer_data),
> +       L2C_ID("marvell,aurora-system-cache", aurora_no_outer_data),
> +       L2C_ID("marvell,tauros3-cache", tauros3_data),
> +       /* Deprecated IDs */
> +       L2C_ID("bcm,bcm11351-a2-pl310-cache", bcm_l2x0_data),
>         {}
>  };
>
> --
> 1.8.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
