From: robherring2@gmail.com (Rob Herring)
Date: Sun, 3 Nov 2013 21:16:52 -0600
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
Message-ID: <CAL_Jsq+Uon4QBU0wUYvWib4AYg=m0EFEBm7i03Zzy=bxU4c_zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 3, 2013 at 6:13 PM,  <gerg@uclinux.org> wrote:
> From: Greg Ungerer <gerg@uclinux.org>
>
> Add machine support code for the Freescale IMX50 SoC.
>
> The IMX50 is quite similar to the Freescale IMX53, and contains many of the
> same periperhal hardware modules, at the same address offsets as the IMX53.
> (Notable exceptions are that the IMX50 contains no CAN bus hardware, less
> GPIO, no VPU, it does contain an Electrophoretic display controller though).
>
> This support code uses some of the IMX53 setup code to reduce duplication
> of what would be identical init IO setup.
>
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/Makefile     |  1 +
>  arch/arm/mach-imx/common.h     |  1 +
>  arch/arm/mach-imx/mach-imx50.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
>  create mode 100644 arch/arm/mach-imx/mach-imx50.c
>
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index bbe1f5b..924e117 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -112,6 +112,7 @@ obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
>
>  obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
> +obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
>  obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
>
>  obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index 7cbe22d..9b67672 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -108,6 +108,7 @@ void tzic_handle_irq(struct pt_regs *);
>  #define imx27_handle_irq avic_handle_irq
>  #define imx31_handle_irq avic_handle_irq
>  #define imx35_handle_irq avic_handle_irq
> +#define imx50_handle_irq tzic_handle_irq

Has no one converted AVIC and TZIC to use IRQCHIP_DECLARE? This and
the corresponding handle_irq hook would not be needed if that was
done.

>  #define imx51_handle_irq tzic_handle_irq
>  #define imx53_handle_irq tzic_handle_irq
>
> diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
> new file mode 100644
> index 0000000..dc93bbb
> --- /dev/null
> +++ b/arch/arm/mach-imx/mach-imx50.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2013 Greg Ungerer <gerg@uclinux.org>
> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +
> +#include "common.h"
> +
> +static void __init imx50_dt_init(void)
> +{
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

This is the default operation now if init_machine is NULL.

> +}
> +
> +static const char *imx50_dt_board_compat[] __initdata = {
> +       "fsl,imx50",
> +       NULL
> +};
> +
> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
> +       .map_io         = mx53_map_io,
> +       .init_irq       = mx53_init_irq,
> +       .handle_irq     = imx50_handle_irq,
> +       .init_machine   = imx50_dt_init,
> +       .dt_compat      = imx50_dt_board_compat,
> +       .restart        = mxc_restart,
> +MACHINE_END

I still think any mx53 clean-up should be done first to enable mx50
rather than adding a mx50 machine first and then trying to consolidate
mx50 and mx53.

Rob
