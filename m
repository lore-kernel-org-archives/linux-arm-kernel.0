From: leoyang.li@nxp.com (Li Yang)
Date: Thu, 20 Sep 2018 13:54:28 -0500
Subject: [PATCH 2/4] soc/fsl/qbman: Add 64 bit DMA addressing requirement
 to QBMan
In-Reply-To: <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
 <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
Message-ID: <CADRPPNSz-x1uf98+cKUjj54sSxQbJOXWk7xn_ExhbcjdAYKUpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
> boundary so enabling 64 bit DMA addressing is needed for QBMan to
> be usable.
>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
> index d570cb5fd381..19d6f4621e23 100644
> --- a/drivers/soc/fsl/qbman/Kconfig
> +++ b/drivers/soc/fsl/qbman/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig FSL_DPAA
>         bool "QorIQ DPAA1 framework support"
> -       depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
> +       depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || ARM) && ARCH_DMA_ADDR_T_64BIT)

You also added ARM support here.  Actually the dependency on
ARCH_DMA_ADDR_T_64BIT is only explicitly needed by ARM(other platforms
already implies ARCH_DMA_ADDR_T_64BIT).  So I think the patch title
should be like: adding 32-bit ARM support.  The ARCH_DMA_ADDR_T_64BIT
is enabled by ARM_LPAE on ARM.  Probably we should make that
straightforward in the Kconfig, so that people better understand what
is needed for 32-bit ARM.

>         select GENERIC_ALLOCATOR
>         help
>           The Freescale Data Path Acceleration Architecture (DPAA) is a set of
> --
> 2.1.0
>
