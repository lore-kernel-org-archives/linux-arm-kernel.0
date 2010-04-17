From: xiaoxianghua@gmail.com (Xianghua Xiao)
Date: Sat, 17 Apr 2010 11:00:03 -0500
Subject: [RFC PATCH 10/10] mx5: Add MX53 EVK board support
In-Reply-To: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
References: <1271446524-26450-11-git-send-email-r.herring@freescale.com>
Message-ID: <l2xe6bf505b1004170900of2300635va0457cd61780bd11@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a dumb question here, I know Freescale has evk for i.mx51, what's this
mx53 evk here? I did not find anything related at freescale.com
either.
thanks,

On Fri, Apr 16, 2010 at 2:35 PM, Rob Herring <r.herring@freescale.com> wrote:
> Signed-off-by: Rob Herring <r.herring@freescale.com>
> ---
> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ?| ? ?7 +++
> ?arch/arm/mach-mx5/Makefile ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mx5/board-mx53_evk.c | ? 88 ++++++++++++++++++++++++++++++++++++
> ?3 files changed, 96 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-mx5/board-mx53_evk.c
>
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 12e9ce7..cc08120 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -20,4 +20,11 @@ config MACH_MX51_BABBAGE
> ? ? ? ? ?u-boot. This includes specific configurations for the board and its
> ? ? ? ? ?peripherals.
>
> +config MACH_MX53_EVK
> + ? ? ? bool "Support MX53 EVK platform"
> + ? ? ? select ARCH_MX53
> + ? ? ? help
> + ? ? ? ? Include support for MX53 EVK platform. This includes specific
> + ? ? ? ? configurations for the board and its peripherals.
> +
> ?endif
> diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
> index e4cf91f..201f01b 100644
> --- a/arch/arm/mach-mx5/Makefile
> +++ b/arch/arm/mach-mx5/Makefile
> @@ -6,4 +6,5 @@
> ?obj-y ? := cpu.o mm.o clock.o devices.o
>
> ?obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
> +obj-$(CONFIG_MACH_MX53_EVK) += board-mx53_evk.o
>
> diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
> new file mode 100644
> index 0000000..b9d3b55
> --- /dev/null
> +++ b/arch/arm/mach-mx5/board-mx53_evk.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (C) 2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/common.h>
> +#include <mach/hardware.h>
> +#include <mach/imx-uart.h>
> +#include <mach/iomux-mx53.h>
> +
> +#include <asm/irq.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/time.h>
> +
> +#include "devices.h"
> +
> +static struct pad_desc mx51evk_pads[] = {
> + ? ? ? /* UART1 */
> + ? ? ? MX53_PAD_CSI0_D11__UART1_RXD,
> + ? ? ? MX53_PAD_CSI0_D10__UART1_TXD,
> +};
> +
> +/* Serial ports */
> +#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
> +static struct imxuart_platform_data uart_pdata = {
> +// ? ? .flags = IMXUART_HAVE_RTSCTS,
> +};
> +
> +static inline void mxc_init_imx_uart(void)
> +{
> + ? ? ? mxc_register_device(&mxc_uart_device0, &uart_pdata);
> + ? ? ? mxc_register_device(&mxc_uart_device1, &uart_pdata);
> + ? ? ? mxc_register_device(&mxc_uart_device2, &uart_pdata);
> +}
> +#else /* !SERIAL_IMX */
> +static inline void mxc_init_imx_uart(void)
> +{
> +}
> +#endif /* SERIAL_IMX */
> +
> +/*
> + * Board specific initialization.
> + */
> +static void __init mxc_board_init(void)
> +{
> +// ? ? mxc_iomux_v3_setup_multiple_pads(mx51evk_pads,
> +// ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(mx51evk_pads));
> + ? ? ? mxc_init_imx_uart();
> + ? ? ? mxc_register_device(&mxc_fec_device, NULL);
> +}
> +
> +static void __init mx53_evk_timer_init(void)
> +{
> + ? ? ? mx53_clocks_init(32768, 24000000, 22579200, 0);
> +}
> +
> +static struct sys_timer mxc_timer = {
> + ? ? ? .init ? = mx53_evk_timer_init,
> +};
> +
> +MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
> + ? ? ? /* Maintainer: Rob Herring <r.herring@freescale.com> */
> + ? ? ? .phys_io = MX51_AIPS1_BASE_ADDR - 0x20000000,
> + ? ? ? .io_pg_offst = ((MX51_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
> + ? ? ? .map_io = mx5_map_io,
> + ? ? ? .init_irq = mx5x_init_irq,
> + ? ? ? .init_machine = mxc_board_init,
> + ? ? ? .timer = &mxc_timer,
> +MACHINE_END
> --
> 1.6.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
