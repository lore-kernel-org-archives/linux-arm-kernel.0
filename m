From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 16:25:36 +0200
Subject: [PATCH v2 8/8] staging: fsl-mc: allow the driver compile
 multi-arch
In-Reply-To: <20170718133723.12709-9-laurentiu.tudor@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <20170718133723.12709-9-laurentiu.tudor@nxp.com>
Message-ID: <CAK8P3a0WvNgk5eXQoPpXiLwOS_wB1NdfCyPtiKMys3qqEwHjDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 3:37 PM,  <laurentiu.tudor@nxp.com> wrote:

> --- a/drivers/staging/fsl-dpaa2/Kconfig
> +++ b/drivers/staging/fsl-dpaa2/Kconfig
> @@ -4,7 +4,7 @@
>
>  config FSL_DPAA2
>         bool "Freescale DPAA2 devices"
> -       depends on FSL_MC_BUS
> +       depends on FSL_MC_BUS && ARCH_LAYERSCAPE
>         ---help---
>           Build drivers for Freescale DataPath Acceleration
>           Architecture (DPAA2) family of SoCs.

I would probably leave the dependency in there conditionally, like

         depends on ARCH_LAYERSCAPE || COMPILE_TEST

That way, we can build the driver on all architectures with "make allmodconfig"
or "make randconfig", but regular users that disable COMPILE_TEST
won't be bothered by the extra config options unless they have the
right hardware.

       Arnd
