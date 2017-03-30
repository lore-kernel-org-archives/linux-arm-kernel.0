From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Mar 2017 16:01:42 +0200
Subject: [PATCH v9 12/12] ARM: EXYNOS: refactor of mach-exynos to use
 chipid information
In-Reply-To: <1490879826-16754-13-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131444epcas5p45051cf7e6ec7a993c2c9f84254b89a19@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-13-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAK8P3a2oK1MvWe4B-4r2Rt7Q87juNJd3MsetN8-OeDYhBmKyUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:

>   * register the standard cpu IO areas
>   */
> -static void __init exynos_map_io(void)
> +static int __init exynos_fdt_map_scu(unsigned long node, const char *uname,
> +               int depth, void *data)
>  {
> -       if (soc_is_exynos4())
> -               iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
> +       if (!of_flat_dt_is_compatible(node, "samsung,exynos4210") &&
> +                       !of_flat_dt_is_compatible(node, "samsung,exynos4212") &&
> +                       !of_flat_dt_is_compatible(node, "samsung,exynos4412"))
> +               return 0;
> +
> +       iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
> +       return 1;
>  }

This seems really overcomplicated. From what I can tell, this is only needed
to find the SCU address, but there are better ways to do that, either by
looking up the SCU in the DT at the time you actually need it,
or by calling scu_a9_get_base().

      Arnd
