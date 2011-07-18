From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Jul 2011 17:00:50 +0900
Subject: [PATCH 2/2] ARM: EXYNOS4: Add more registers to be saved and
	restored for PM
In-Reply-To: <1309395085-22084-2-git-send-email-myungjoo.ham@samsung.com>
References: <1309395085-22084-1-git-send-email-myungjoo.ham@samsung.com>
	<1309395085-22084-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <04a601cc4520$d2d97b40$788c71c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> We need more registers to be saved and restored for PM of Exynos4210.
> Otherwise, with additional drivers running, suspend-to-RAM fails to wake
> up properly. This patch adds registers omitted in the initial PM
> patches.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos4/pm.c |   77
> +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 76 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
> index a103c13..24c9265 100644
> --- a/arch/arm/mach-exynos4/pm.c
> +++ b/arch/arm/mach-exynos4/pm.c
> @@ -27,6 +27,8 @@
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
>  #include <plat/pll.h>
> +#include <plat/regs-srom.h>
> +#include <plat/regs-timer.h>
> 
>  #include <mach/regs-irq.h>
>  #include <mach/regs-gpio.h>
> @@ -60,14 +62,20 @@ static struct sleep_save exynos4_vpll_save[] = {
> 
>  static struct sleep_save exynos4_core_save[] = {
>  	/* CMU side */
> +	SAVE_ITEM(S5P_CLKSRC_LEFTBUS),

I think, the reset/default value(0x0, SCLKMPLL) has no problem.

> +	SAVE_ITEM(S5P_CLKOUT_CMU_LEFTBUS),

This is for debugging? So I think no need this.

> +	SAVE_ITEM(S5P_CLKSRC_RIGHTBUS),

Same as 'CLKSRC_LEFTBUS'

> +	SAVE_ITEM(S5P_CLKOUT_CMU_RIGHTBUS),

Same as 'CMU_LEFTBUS'

> +	SAVE_ITEM(S5P_CLKOUT_CMU_TOP),

For debugging...

> +	SAVE_ITEM(S5P_CLKOUT_CMU_DMC),

Same as above.

(snip)

> +	SAVE_ITEM(S5P_APLL_LOCK),
> +	SAVE_ITEM(S5P_MPLL_LOCK),
> +	SAVE_ITEM(S5P_APLL_CON0),
> +	SAVE_ITEM(S5P_APLL_CON1),
> +	SAVE_ITEM(S5P_MPLL_CON0),
> +	SAVE_ITEM(S5P_MPLL_CON1),

Basically, these value should be set in boot-loader after wake up.

(snip)

> +	/* PMU */
> +	SAVE_ITEM(S5P_HDMI_PHY_CONTROL),
> +	SAVE_ITEM(S5P_USBOTG_PHY_CONTROL),
> +	SAVE_ITEM(S5P_USBHOST_PHY_CONTROL),
> +	SAVE_ITEM(S5P_DAC_CONTROL),
> +	SAVE_ITEM(S5P_MIPI_CONTROL0),
> +	SAVE_ITEM(S5P_MIPI_CONTROL1),
> +	SAVE_ITEM(S5P_ADC_CONTROL),
> +	SAVE_ITEM(S5P_PCIE_CONTROL),
> +	SAVE_ITEM(S5P_SATA_CONTROL),
> +	SAVE_ITEM(S5P_PMU_DEBUG),
> +	SAVE_ITEM(S5P_ARM_CORE0_CONFIGURATION),
> +	SAVE_ITEM(S5P_ARM_CORE1_CONFIGURATION),
> +	SAVE_ITEM(S5P_ARM_CPU_L2_0_CONFIGURATION),
> +	SAVE_ITEM(S5P_ARM_CPU_L2_1_CONFIGURATION),
> +	SAVE_ITEM(S5P_XUSBXTI_CONFIGURATION),
> +	SAVE_ITEM(S5P_XXTI_CONFIGURATION),
> +	SAVE_ITEM(S5P_PMU_CAM_CONF),
> +	SAVE_ITEM(S5P_PMU_TV_CONF),
> +	SAVE_ITEM(S5P_PMU_MFC_CONF),
> +	SAVE_ITEM(S5P_PMU_G3D_CONF),
> +	SAVE_ITEM(S5P_PMU_LCD0_CONF),
> +	SAVE_ITEM(S5P_PMU_LCD1_CONF),
> +	SAVE_ITEM(S5P_MAUDIO_CONFIGURATION),
> +	SAVE_ITEM(S5P_PMU_GPS_CONF),

Since PMU part is alive block, so no need.

> +
> +	/* System Controller side */
> +	SAVE_ITEM(S3C_VA_SYS + 0x0210),
> +	SAVE_ITEM(S3C_VA_SYS + 0x0214),
> +	SAVE_ITEM(S3C_VA_SYS + 0x0218),
> +	SAVE_ITEM(S3C_VA_SYS + 0x0220),
> +	SAVE_ITEM(S3C_VA_SYS + 0x0230),

Hmm..really need this?

> +
>  	/* GIC side */
>  	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
>  	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
> @@ -232,11 +286,32 @@ static struct sleep_save exynos4_core_save[] = {
>  	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC20),
>  	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC24),
> 
> -
>  	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
>  	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
>  	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
>  	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x040),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x050),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x060),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x070),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x080),
> +	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x090),

No need to save/restore external GIC part...

(snip)

> +	/* PWM Register */
> +	SAVE_ITEM(S3C2410_TCFG0),
> +	SAVE_ITEM(S3C2410_TCFG1),
> +	SAVE_ITEM(S3C64XX_TINT_CSTAT),
> +	SAVE_ITEM(S3C2410_TCON),
> +	SAVE_ITEM(S3C2410_TCNTB(0)),
> +	SAVE_ITEM(S3C2410_TCMPB(0)),
> +	SAVE_ITEM(S3C2410_TCNTO(0)),

PWM? I'm not sure why this is needed here.

(snip)

Others, ok.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
