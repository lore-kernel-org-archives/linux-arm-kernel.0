From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Jun 2011 09:42:59 +0200
Subject: [PATCH] ARM: mach-mx5/mx53_ard: Add support for i.MX53 ARD board
In-Reply-To: <1307457470-23221-1-git-send-email-andre.silva@freescale.com>
References: <1307457470-23221-1-git-send-email-andre.silva@freescale.com>
Message-ID: <20110610074259.GU23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Tue, Jun 07, 2011 at 11:37:50AM -0300, Andre Silva wrote:
> Signed-off-by: Andre Silva <andre.silva@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> In order to boot via NFS the following patch is needed:
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=903131f2894295947f2fe49d850b538127b2f64b
> this allows the i.MX53 IRQ to work with smsc911x driver.

Looks ok. Can you please rebase your patch onto

git://git.pengutronix.de/git/imx/linux-2.6.git imx-for-3.0

You'll need a imx53_soc_init() in your board setup.

I think the mentioned interrupt problem got fixed on the
fly in this branch. Can you confirm this?

Sascha


> 
>  arch/arm/mach-mx5/Kconfig                   |    8 ++
>  arch/arm/mach-mx5/Makefile                  |    1 +
>  arch/arm/mach-mx5/board-mx53_ard.c          |  175 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
>  4 files changed, 185 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-mx53_ard.c
> 
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 3c98455..695cdf0 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -209,6 +209,14 @@ config MACH_MX53_LOCO
>  	  Include support for MX53 LOCO platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> +config MACH_MX53_ARD
> +	bool "Support MX53 ARD platforms"
> +	select SOC_IMX53
> +	select IMX_HAVE_PLATFORM_IMX_UART
> +	help
> +	  Include support for MX53 ARD platform. This includes specific
> +	  configurations for the board and its peripherals.
> +
>  endif # ARCH_MX53_SUPPORTED
>  
>  endif
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index 0b9338c..df67fef 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_MACH_MX51_3DS) += board-mx51_3ds.o
>  obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
>  obj-$(CONFIG_MACH_MX53_SMD) += board-mx53_smd.o
>  obj-$(CONFIG_MACH_MX53_LOCO) += board-mx53_loco.o
> +obj-$(CONFIG_MACH_MX53_ARD) += board-mx53_ard.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX51) += board-cpuimx51.o
>  obj-$(CONFIG_MACH_EUKREA_MBIMX51_BASEBOARD) += eukrea_mbimx51-baseboard.o
>  obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += board-cpuimx51sd.o
> diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
> new file mode 100644
> index 0000000..1a57500
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-mx53_ard.c
> @@ -0,0 +1,175 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/smsc911x.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/iomux-mx53.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include "crm_regs.h"
> +#include "devices-imx53.h"
> +
> +#define ARD_ETHERNET_INT_B	IMX_GPIO_NR(2, 31)
> +
> +static iomux_v3_cfg_t mx53_ard_pads[] = {
> +	/* UART1 */
> +	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
> +	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
> +	/* WEIM for CS1 */
> +	MX53_PAD_EIM_EB3__GPIO2_31, /* ETHERNET_INT_B */
> +	MX53_PAD_EIM_D16__EMI_WEIM_D_16,
> +	MX53_PAD_EIM_D17__EMI_WEIM_D_17,
> +	MX53_PAD_EIM_D18__EMI_WEIM_D_18,
> +	MX53_PAD_EIM_D19__EMI_WEIM_D_19,
> +	MX53_PAD_EIM_D20__EMI_WEIM_D_20,
> +	MX53_PAD_EIM_D21__EMI_WEIM_D_21,
> +	MX53_PAD_EIM_D22__EMI_WEIM_D_22,
> +	MX53_PAD_EIM_D23__EMI_WEIM_D_23,
> +	MX53_PAD_EIM_D24__EMI_WEIM_D_24,
> +	MX53_PAD_EIM_D25__EMI_WEIM_D_25,
> +	MX53_PAD_EIM_D26__EMI_WEIM_D_26,
> +	MX53_PAD_EIM_D27__EMI_WEIM_D_27,
> +	MX53_PAD_EIM_D28__EMI_WEIM_D_28,
> +	MX53_PAD_EIM_D29__EMI_WEIM_D_29,
> +	MX53_PAD_EIM_D30__EMI_WEIM_D_30,
> +	MX53_PAD_EIM_D31__EMI_WEIM_D_31,
> +	MX53_PAD_EIM_DA0__EMI_NAND_WEIM_DA_0,
> +	MX53_PAD_EIM_DA1__EMI_NAND_WEIM_DA_1,
> +	MX53_PAD_EIM_DA2__EMI_NAND_WEIM_DA_2,
> +	MX53_PAD_EIM_DA3__EMI_NAND_WEIM_DA_3,
> +	MX53_PAD_EIM_DA4__EMI_NAND_WEIM_DA_4,
> +	MX53_PAD_EIM_DA5__EMI_NAND_WEIM_DA_5,
> +	MX53_PAD_EIM_DA6__EMI_NAND_WEIM_DA_6,
> +	MX53_PAD_EIM_OE__EMI_WEIM_OE,
> +	MX53_PAD_EIM_RW__EMI_WEIM_RW,
> +	MX53_PAD_EIM_CS1__EMI_WEIM_CS_1,
> +};
> +
> +static struct resource ard_smsc911x_resources[] = {
> +	{
> +		.start = MX53_CS1_64MB_BASE_ADDR,
> +		.end = MX53_CS1_64MB_BASE_ADDR + SZ_32M - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start =  gpio_to_irq(ARD_ETHERNET_INT_B),
> +		.end =  gpio_to_irq(ARD_ETHERNET_INT_B),
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +struct smsc911x_platform_config ard_smsc911x_config = {
> +	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
> +	.flags = SMSC911X_USE_32BIT,
> +};
> +
> +static struct platform_device ard_smsc_lan9220_device = {
> +	.name = "smsc911x",
> +	.id = -1,
> +	.num_resources = ARRAY_SIZE(ard_smsc911x_resources),
> +	.resource = ard_smsc911x_resources,
> +	.dev = {
> +		.platform_data = &ard_smsc911x_config,
> +	},
> +};
> +
> +static void __init mx53_ard_io_init(void)
> +{
> +	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
> +				ARRAY_SIZE(mx53_ard_pads));
> +
> +	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
> +	gpio_direction_input(ARD_ETHERNET_INT_B);
> +}
> +
> + /* Config CS1 settings for ethernet controller */
> +static int weim_cs_config(void)
> +{
> +	u32 reg;
> +	void __iomem *weim_base, *iomuxc_base;
> +
> +	weim_base = ioremap(MX53_WEIM_BASE_ADDR, SZ_4K);
> +	if (!weim_base)
> +		return -ENOMEM;
> +
> +	iomuxc_base = ioremap(MX53_IOMUXC_BASE_ADDR, SZ_4K);
> +	if (!iomuxc_base)
> +		return -ENOMEM;
> +
> +	/* CS1 timings for LAN9220 */
> +	writel(0x20001, (weim_base + 0x18));
> +	writel(0x0, (weim_base + 0x1C));
> +	writel(0x16000202, (weim_base + 0x20));
> +	writel(0x00000002, (weim_base + 0x24));
> +	writel(0x16002082, (weim_base + 0x28));
> +	writel(0x00000000, (weim_base + 0x2C));
> +	writel(0x00000000, (weim_base + 0x90));
> +
> +	/* specify 64 MB on CS1 and CS0 on GPR1 */
> +	reg = readl(iomuxc_base + 0x4);
> +	reg &= ~0x3F;
> +	reg |= 0x1B;
> +	writel(reg, (iomuxc_base + 0x4));
> +
> +	iounmap(iomuxc_base);
> +	iounmap(weim_base);
> +
> +	return 0;
> +}
> +
> +static struct platform_device *devices[] __initdata = {
> +	&ard_smsc_lan9220_device,
> +};
> +
> +static void __init mx53_ard_board_init(void)
> +{
> +	imx53_add_imx_uart(0, NULL);
> +
> +	mx53_ard_io_init();
> +	weim_cs_config();
> +	platform_add_devices(devices, ARRAY_SIZE(devices));
> +}
> +
> +static void __init mx53_ard_timer_init(void)
> +{
> +	mx53_clocks_init(32768, 24000000, 22579200, 0);
> +}
> +
> +static struct sys_timer mx53_ard_timer = {
> +	.init	= mx53_ard_timer_init,
> +};
> +
> +MACHINE_START(MX53_ARD, "Freescale MX53 ARD Board")
> +	.map_io = mx53_map_io,
> +	.init_early = imx53_init_early,
> +	.init_irq = mx53_init_irq,
> +	.timer = &mx53_ard_timer,
> +	.init_machine = mx53_ard_board_init,
> +MACHINE_END
> diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
> index d85e2d1..88fd404 100644
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -117,6 +117,7 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
>  	case MACH_TYPE_MX53_EVK:
>  	case MACH_TYPE_MX53_LOCO:
>  	case MACH_TYPE_MX53_SMD:
> +	case MACH_TYPE_MX53_ARD:
>  		uart_base = MX53_UART1_BASE_ADDR;
>  		break;
>  	default:
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
