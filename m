From: lho@apm.com (Loc Ho)
Date: Mon, 1 Jun 2015 10:04:51 -0700
Subject: [PATCH] edac: xgene: fix cpuid abuse
In-Reply-To: <4966310.Xu4URPyl4o@wuerfel>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150601151131.GD14192@e104818-lin.cambridge.arm.com>
 <20150601151757.GD7443@leverpostej> <4966310.Xu4URPyl4o@wuerfel>
Message-ID: <CAPw-ZT=591MT3HZcZ7TsfD_13mEJQ5swsw3kV2BoVxYUaYADCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the changes, some minor change requested below.

> The new x-gene EDAC driver incorrectly tried to figure out the version of
> one of its IP blocks by looking at the version of the CPU core, which is
> only vagely related.
>
> This removes the incorrect code and instead uses the version of the IP
> block in the compatible string where it belongs.
>
> Found using build testing on x86, which does not provide the arm64
> cpuid interface.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> How about this one? We should make sure this gets fixed before the binding
> gets set in stone with a kernel release.
>
> Loc, do you know if some of the other blocks might also have versions
> associated with them? Normally we try to use more specific product names,
> but in case of APM there don't seem to be any more specific names
> than X-Gene and  X-Gene2 any more.
>

I already asked the designer. There is no version register in the PMD block.


> diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> index 480911c38ff9..e31b696ba939 100644
> --- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> +++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
> @@ -25,7 +25,7 @@ Required properties for memory controller subnode:
>  - memory-controller    : Instance number of the memory controller.
>
>  Required properties for PMD subnode:
> -- compatible           : Shall be "apm,xgene-edac-pmd".
> +- compatible           : Shall be "apm,xgene-edac-pmd" or "apm,xgene-v2-edac-pmd"

Can we change to "apm,xgene-edac-pmd-v2". I would like to associate
with the PMD instead with the family name. The PMD (processor module)
might be re-use in future chip as is such as Gen3, Gen4, and etc.

>  - reg                  : First resource shall be the PMD resource.
>  - pmd-controller       : Instance number of the PMD controller.
>
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index b5158572f6ab..8071c2223f92 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -523,6 +523,7 @@ struct xgene_edac_pmd_ctx {
>         struct edac_device_ctl_info *edac_dev;
>         void __iomem            *pmd_csr;
>         u32                     pmd;
> +       int                     version;
>  };
>
>  static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
> @@ -784,50 +785,6 @@ static void xgene_edac_pmd_cpu_hw_cfg(struct edac_device_ctl_info *edac_dev,
>         writel(0x00000101, pg_f + MEMERR_CPU_MMUECR_PAGE_OFFSET);
>  }
>
> -static bool xgene_edac_pmd_l2c_version1(void)
> -{
> -       /* Check all chips with PMD L2C version 1 HW */
> -       #define REVIDR_MINOR_REV(revidr)        ((revidr) & 0x00000007)
> -
> -       switch (MIDR_VARIANT(read_cpuid_id())) {
> -       case 0:
> -               switch (MIDR_REVISION(read_cpuid_id())) {
> -               case 0:
> -
> -                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> -                       case 1:
> -                       case 2:
> -                               return true;
> -                       };
> -                       break;
> -               case 1:
> -                       if (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1)) == 1)
> -                               return true;
> -                       break;
> -               }
> -               break;
> -       case 1:
> -               switch (MIDR_REVISION(read_cpuid_id())) {
> -               case 0:
> -                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> -                       case 1:
> -                               return true;
> -                       };
> -                       break;
> -               case 1:
> -                       switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
> -                       case 1:
> -                       case 0:
> -                               return true;
> -                       };
> -                       break;
> -               }
> -               break;
> -       }
> -
> -       return false;
> -}
> -
>  static void xgene_edac_pmd_hw_cfg(struct edac_device_ctl_info *edac_dev)
>  {
>         struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
> @@ -837,7 +794,7 @@ static void xgene_edac_pmd_hw_cfg(struct edac_device_ctl_info *edac_dev)
>         /* Enable PMD memory error - MEMERR_L2C_L2ECR and L2C_L2RTOCR */
>         writel(0x00000703, pg_e + MEMERR_L2C_L2ECR_PAGE_OFFSET);
>         /* Configure L2C HW request time out feature if supported */
> -       if (!xgene_edac_pmd_l2c_version1())
> +       if (ctx->version == 1)

The correct changes would be ctx->version > 1. So:

          if (ctx->version > 1)

>                 writel(0x00000119, pg_d + CPUX_L2C_L2RTOCR_PAGE_OFFSET);
>  }
>
> @@ -956,7 +913,7 @@ static int xgene_edac_pmd_available(u32 efuse, int pmd)
>         return (efuse & (1 << pmd)) ? 0 : 1;
>  }
>
> -static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np)
> +static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np, int version)
>  {
>         struct edac_device_ctl_info *edac_dev;
>         struct xgene_edac_pmd_ctx *ctx;
> @@ -998,6 +955,7 @@ static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np)
>         ctx->edac = edac;
>         ctx->edac_dev = edac_dev;
>         ctx->ddev = *edac->dev;
> +       ctx->version = version;
>         edac_dev->dev = &ctx->ddev;
>         edac_dev->ctl_name = ctx->name;
>         edac_dev->dev_name = ctx->name;
> @@ -1169,7 +1127,9 @@ static int xgene_edac_probe(struct platform_device *pdev)
>                 if (of_device_is_compatible(child, "apm,xgene-edac-mc"))
>                         xgene_edac_mc_add(edac, child);
>                 if (of_device_is_compatible(child, "apm,xgene-edac-pmd"))
> -                       xgene_edac_pmd_add(edac, child);
> +                       xgene_edac_pmd_add(edac, child, 1);
> +               if (of_device_is_compatible(child, "apm,xgene-v2-edac-pmd"))

Change to "apm,xgene-edac-pmd-v2"


> +                       xgene_edac_pmd_add(edac, child, 2);
>         }
>
>         return 0;

Again... Thanks for the changes.

-Loc
