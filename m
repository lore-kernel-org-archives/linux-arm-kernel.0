From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 9 Jul 2018 15:23:08 -0300
Subject: [PATCH v2 2/2] ARM: imx51: Configure M4IF to avoid visual
 artifacts
In-Reply-To: <1531160355-12384-3-git-send-email-festevam@gmail.com>
References: <1531160355-12384-1-git-send-email-festevam@gmail.com>
 <1531160355-12384-3-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5BibegcNaY0a78_m3Rd8=TuCx+NTL7jX_h1TL20rRb7hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Subject here should be [PATCH v2 3/3], sorry.

On Mon, Jul 9, 2018 at 3:19 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Configure the M4IF registers as per the vendor bootloader
> to avoid visual artifacts during video playback.
>
> This way we don't need to rely on the bootloader configuration for
> optimal IPU/VPU bus priorities.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Tested-by: Sergey Lapin <sergey.lapin@cogentembedded.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Changes since v1:
> - None
>
>  arch/arm/mach-imx/mach-imx51.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
> index 3835b6a..37ffdfa 100644
> --- a/arch/arm/mach-imx/mach-imx51.c
> +++ b/arch/arm/mach-imx/mach-imx51.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <asm/mach/arch.h>
> @@ -48,11 +49,37 @@ static void __init imx51_ipu_mipi_setup(void)
>         iounmap(hsc_addr);
>  }
>
> +static void __init imx51_m4if_setup(void)
> +{
> +       void __iomem *m4if_base;
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx51-m4if");
> +       if (!np)
> +               return;
> +
> +       m4if_base = of_iomap(np, 0);
> +       if (!m4if_base) {
> +               pr_err("Unable to map M4IF registers\n");
> +               return;
> +       }
> +
> +       /*
> +        * Configure VPU and IPU with higher priorities
> +        * in order to avoid artifacts during video playback
> +        */
> +       writel_relaxed(0x00000203, m4if_base + 0x40);
> +       writel_relaxed(0x00000000, m4if_base + 0x44);
> +       writel_relaxed(0x00120125, m4if_base + 0x9c);
> +       writel_relaxed(0x001901A3, m4if_base + 0x48);
> +       iounmap(m4if_base);
> +}
> +
>  static void __init imx51_dt_init(void)
>  {
>         imx51_ipu_mipi_setup();
>         imx_src_init();
> -
> +       imx51_m4if_setup();
>         imx_aips_allow_unprivileged_access("fsl,imx51-aipstz");
>  }
>
> --
> 2.7.4
>
