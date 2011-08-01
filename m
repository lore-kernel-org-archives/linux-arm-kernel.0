From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 1 Aug 2011 23:01:39 +0100
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
	<1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACxGe6vvL=xGCGMR0yhyJ8r2zLvBgYhYS1b9_VF3dg5hRNhNzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 1, 2011 at 8:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> From: Shawn Guo <shawn.guo@freescale.com>
>
> It adds device tree support for imx53 boards.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

It's *really* close, but I see a problem...

> +static const char *imx53_dt_board_compat[] __initdata = {
> + ? ? ? "fsl,imx53-ard",
> + ? ? ? "fsl,imx53-evk",
> + ? ? ? "fsl,imx53-qsb",
> + ? ? ? "fsl,imx53-smd",
> + ? ? ? NULL
> +};
> +
> +DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
> + ? ? ? .map_io ? ? ? ? = mx53_map_io,
> + ? ? ? .init_early ? ? = imx53_init_early,
> + ? ? ? .init_irq ? ? ? = mx53_init_irq,
> + ? ? ? .timer ? ? ? ? ?= &imx53_timer,
> + ? ? ? .init_machine ? = imx53_dt_init,
> + ? ? ? .dt_compat ? ? ?= imx53_dt_board_compat,
> +MACHINE_END
> +
> +DT_MACHINE_START(IMX53_DT_ARD, "Freescale i.MX53 ARD (Device Tree Support)")
> + ? ? ? .map_io ? ? ? ? = mx53_map_io,
> + ? ? ? .init_early ? ? = imx53_init_early,
> + ? ? ? .init_irq ? ? ? = mx53_init_irq,
> + ? ? ? .timer ? ? ? ? ?= &imx53_timer,
> + ? ? ? .init_machine ? = imx53_ard_init,
> + ? ? ? .dt_compat ? ? ?= imx53_dt_board_compat,
> +MACHINE_END

These two machine_descs will match on exactly the same boards because
they use the same dt_compat table.  So the ard variant will probably
never get matched since it will be picked up by the IMX53_DT variant
first.  Each machine_desc must have a different match table.

However, today when we were talking you asked if it would be better to
use a callback into board-specific code instead of the iomux table
that is implemented in this patch.  I was fine either way, but my
opinion was that the table would probably result in less code.  Well,
combined with the above problem, I think I was wrong.  Since the only
difference in the ard variant is the call to
imx53_ard_weim_cs_config(), both the cs config and the iomux setup
will be simpler if both are handled in a callback.  You're original
instinct was correct.

g.

> diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
> index 4e3d978..32c24a4 100644
> --- a/arch/arm/plat-mxc/include/mach/common.h
> +++ b/arch/arm/plat-mxc/include/mach/common.h
> @@ -72,4 +72,6 @@ extern void mxc_arch_reset_init(void __iomem *);
> ?extern void mx51_efikamx_reset(void);
> ?extern int mx53_revision(void);
> ?extern int mx53_display_revision(void);
> +extern int imx53_ard_weim_cs_config(void);
> +
> ?#endif
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 9440b9e..adcf2c0 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -21,6 +21,11 @@
>
> ?#include <mach/iomux-v3.h>
>
> +extern struct iomux_v3_pad_data imx53_ard_pad_data;
> +extern struct iomux_v3_pad_data imx53_evk_pad_data;
> +extern struct iomux_v3_pad_data imx53_loco_pad_data;
> +extern struct iomux_v3_pad_data imx53_smd_pad_data;
> +
> ?/* These 2 defines are for pins that may not have a mux register, but could
> ?* have a pad setting register, and vice-versa. */
> ?#define NON_PAD_I ? ? ?0x00
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> index ebbce33..5689965 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
> @@ -55,6 +55,11 @@
>
> ?typedef u64 iomux_v3_cfg_t;
>
> +struct iomux_v3_pad_data {
> + ? ? ? iomux_v3_cfg_t *pads;
> + ? ? ? int num;
> +};
> +
> ?#define MUX_CTRL_OFS_SHIFT ? ? 0
> ?#define MUX_CTRL_OFS_MASK ? ? ?((iomux_v3_cfg_t)0xfff << MUX_CTRL_OFS_SHIFT)
> ?#define MUX_PAD_CTRL_OFS_SHIFT 12
> --
> 1.7.4.1
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
