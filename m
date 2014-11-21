From: nm@ti.com (Nishanth Menon)
Date: Fri, 21 Nov 2014 07:04:31 -0600
Subject: [PATCH] ARM: common: edma: edma_pm_resume may be unused
In-Reply-To: <4363971.teBOlf16kG@wuerfel>
References: <4363971.teBOlf16kG@wuerfel>
Message-ID: <CAGo_u6o+avxzbJtxeYxoAh3PDd5oxk7GgURxt0+mtVoZ-68eRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 4:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The recently introduced resume hook in the edma driver
> is not referenced when CONFIG_PM_SLEEP is not set, which
> results in a compile warning in keystone_defconfig builds.
>
> This adds an appropriate #ifdef.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Joel Fernandes <joelf@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Fixes: a2b1175131: ("ARM: common: edma: add suspend resume hook")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm applying this as the obvious fixup on top of the next/drivers
> branch.
>
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 24a2857f2285..5662a872689b 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1810,6 +1810,7 @@ static int edma_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
>  static int edma_pm_resume(struct device *dev)
>  {
>         int i, j;
> @@ -1849,6 +1850,7 @@ static int edma_pm_resume(struct device *dev)
>
>         return 0;
>  }
> +#endif

Uggh.. sorry about that..
Acked-by: Nishanth Menon <nm@ti.com>
---
Regards,
Nishanth Menon
