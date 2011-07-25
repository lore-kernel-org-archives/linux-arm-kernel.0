From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Jul 2011 14:57:24 -0600
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <1311606467-28985-3-git-send-email-shawn.guo@linaro.org>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110725205724.GE26735@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 11:07:47PM +0800, Shawn Guo wrote:
> It adds device tree support for imx53 boards.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/fsl/boards.txt         |   15 +
>  arch/arm/boot/dts/imx53-ard.dts                    |  365 +++++++
>  arch/arm/boot/dts/imx53-evk.dts                    |  354 +++++++
>  arch/arm/boot/dts/imx53-qsb.dts                    |  358 +++++++
>  arch/arm/boot/dts/imx53-smd.dts                    |  444 +++++++++
>  arch/arm/boot/dts/imx53.dtsi                       | 1044 ++++++++++++++++++++
>  arch/arm/mach-mx5/Kconfig                          |    8 +
>  arch/arm/mach-mx5/Makefile                         |    1 +
>  arch/arm/mach-mx5/imx53-dt.c                       |  128 +++
>  9 files changed, 2717 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/fsl/boards.txt
>  create mode 100644 arch/arm/boot/dts/imx53-ard.dts
>  create mode 100644 arch/arm/boot/dts/imx53-evk.dts
>  create mode 100644 arch/arm/boot/dts/imx53-qsb.dts
>  create mode 100644 arch/arm/boot/dts/imx53-smd.dts
>  create mode 100644 arch/arm/boot/dts/imx53.dtsi
>  create mode 100644 arch/arm/mach-mx5/imx53-dt.c
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl/boards.txt b/Documentation/devicetree/bindings/arm/fsl/boards.txt
> new file mode 100644
> index 0000000..7603905
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/fsl/boards.txt
> @@ -0,0 +1,15 @@
> +i.MX53 Automotive Reference Design Board
> +Required root node properties:
> +    - compatible = "fsl,mx53-ard", "fsl,mx53";
> +
> +i.MX53 Evaluation Kit
> +Required root node properties:
> +    - compatible = "fsl,mx53-evk", "fsl,mx53";
> +
> +i.MX53 Quick Start Board
> +Required root node properties:
> +    - compatible = "fsl,mx53-qsb", "fsl,mx53";
> +
> +i.MX53 Smart Mobile Reference Design Board
> +Required root node properties:
> +    - compatible = "fsl,mx53-smd", "fsl,mx53";

w00t!  Documentation!  :-)

[...]

> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 53422d2..9f60dc1 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -173,6 +173,14 @@ endif # ARCH_MX51
>  if ARCH_MX53_SUPPORTED
>  comment "i.MX53 machines:"
>  
> +config MACH_IMX53_DT
> +	bool "Support i.MX53 platforms from device tree"
> +	select SOC_IMX53
> +	select USE_OF
> +	help
> +	  Include support for Freescale i.MX53 based platforms
> +	  using the device tree for discovery
> +
>  config MACH_MX53_EVK
>  	bool "Support MX53 EVK platforms"
>  	select SOC_IMX53
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 71379f6..a1fd712 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
>  obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
>  
>  obj-$(CONFIG_OF) += iomuxc-dt.o
> +obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
> diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
> new file mode 100644
> index 0000000..ac06f04
> --- /dev/null
> +++ b/arch/arm/mach-mx5/imx53-dt.c
> @@ -0,0 +1,128 @@
> +/*
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
> +#include <linux/irq.h>
> +#include <linux/of_platform.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/mx53.h>
> +
> +/*
> + * Lookup table for attaching a specific name and platform_data pointer to
> + * devices as they get created by of_platform_populate().  Ideally this table
> + * would not exist, but the current clock implementation depends on some devices
> + * having a specific name.
> + */
> +static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
> +	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART1_BASE_ADDR, "imx21-uart.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART2_BASE_ADDR, "imx21-uart.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART3_BASE_ADDR, "imx21-uart.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART4_BASE_ADDR, "imx21-uart.3", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART5_BASE_ADDR, "imx21-uart.4", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-fec", MX53_FEC_BASE_ADDR, "imx25-fec.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx53.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx53.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx53.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx53.3", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-cspi", MX53_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C3_BASE_ADDR, "imx-i2c.2", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-sdma", MX53_SDMA_BASE_ADDR, "imx35-sdma", NULL),
> +	OF_DEV_AUXDATA("fsl,imx53-wdt", MX53_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
> +	{ /* sentinel */ }
> +};
> +
> +static const struct of_device_id imx53_tzic_of_match[] __initconst = {
> +	{ .compatible = "fsl,imx53-tzic", },
> +	{ /* sentinel */ }
> +};
> +
> +static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
> +	{ .compatible = "fsl,imx53-iomuxc", },
> +	{ /* sentinel */ }
> +};
> +
> +/* Configure EIM for SMSC LAN9220 */
> +static void __init imx53_ard_eim_config(void)
> +{
> +	u32 val;
> +	void __iomem *eim_base, *iomuxc_base;
> +
> +	eim_base = ioremap(MX53_WEIM_BASE_ADDR, SZ_4K);
> +	iomuxc_base = ioremap(MX53_IOMUXC_BASE_ADDR, SZ_4K);
> +	if (!eim_base || !iomuxc_base) {
> +		pr_warn("%s: ioremap failed\n", __func__);
> +		return;
> +	}
> +
> +	/* CS1 timings for LAN9220 */
> +	writel(0x20001, (eim_base + 0x18));
> +	writel(0x0, (eim_base + 0x1c));
> +	writel(0x16000202, (eim_base + 0x20));
> +	writel(0x00000002, (eim_base + 0x24));
> +	writel(0x16002082, (eim_base + 0x28));
> +	writel(0x00000000, (eim_base + 0x2c));
> +	writel(0x00000000, (eim_base + 0x90));
> +
> +	/* specify 64 MB on CS1 and CS0 on GPR1 */
> +	val = readl(iomuxc_base + 0x4);
> +	val &= ~0x3f;
> +	val |= 0x1b;
> +	writel(val, (iomuxc_base + 0x4));
> +
> +	iounmap(eim_base);
> +	iounmap(iomuxc_base);
> +}
> +
> +static void __init imx53_dt_init(void)
> +{
> +	if (of_machine_is_compatible("fsl,imx53-ard"))
> +		imx53_ard_eim_config();

Create a separate DT_MACHINE_START section for the fsl,imx53-ard, and
create it's own init function that does the eim config before calling
imx53_dt_init().  In the long run it is cleaner to use a separate
DT_MACHINE_START for the special cases; at least until they can be
generalized away.  Multiple DT_MACHINE_START sections can exist in
this file.

> +
> +	mxc_iomuxc_dt_init(imx53_iomuxc_of_match);
> +
> +	irq_domain_generate_simple(imx53_tzic_of_match, MX53_TZIC_BASE_ADDR, 0);
> +
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			     imx53_auxdata_lookup, NULL);
> +}
> +
> +static void __init imx53_timer_init(void)
> +{
> +	mx53_clocks_init(32768, 24000000, 22579200, 0);
> +}
> +
> +static struct sys_timer imx53_timer = {
> +	.init = imx53_timer_init,
> +};
> +
> +static const char *imx53_dt_board_compat[] __initdata = {
> +	"fsl,imx53-ard",
> +	"fsl,imx53-evk",
> +	"fsl,imx53-qsb",
> +	"fsl,imx53-smd",
> +	NULL
> +};
> +
> +DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
> +	.map_io		= mx53_map_io,
> +	.init_early	= imx53_init_early,
> +	.init_irq	= mx53_init_irq,
> +	.timer		= &imx53_timer,
> +	.init_machine	= imx53_dt_init,
> +	.dt_compat	= imx53_dt_board_compat,
> +MACHINE_END

Overall, looks pretty good.  Feel free to add my Acked-by tag
(contingent on taking another look at the pinmux api, but my only
objection there is that I think the proposed binding will be unwieldy
to use).

g.
