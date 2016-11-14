From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Nov 2016 12:56:24 +0100
Subject: [PATCH 04/16] ARM: realview: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-5-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <3587281.4kOCcW9Ryd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 14, 2016 10:31:59 AM CET Pankaj Dubey wrote:
>  static const struct of_device_id realview_scu_match[] = {
>         { .compatible = "arm,arm11mp-scu", },
> -       { .compatible = "arm,cortex-a9-scu", },
> -       { .compatible = "arm,cortex-a5-scu", },
>         { }
>  };
>  
> @@ -41,27 +39,18 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
>         struct device_node *np;
>         void __iomem *scu_base;
>         struct regmap *map;
> -       unsigned int ncores;
>         int i;
>  
> -       np = of_find_matching_node(NULL, realview_scu_match);
> -       if (!np) {
> -               pr_err("PLATSMP: No SCU base address\n");
> -               return;
> +       if (of_scu_enable()) {
> +               np = of_find_matching_node(NULL, realview_scu_match);
> +               scu_base = of_iomap(np, 0);
> +               of_node_put(np);
> +               if (!scu_base) {
> +                       pr_err("PLATSMP: No SCU remap\n");
> +                       return;
> +               }
> +               scu_enable(scu_base);
>         }
> 

The only difference here seems to be that realview also needs to handle
"arm,arm11mp-scu". Why not move that into the generic implementation?

	Arnd
