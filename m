From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 19 Jan 2011 00:09:19 +0000
Subject: [PATCH V4 32/62] ST SPEAr 13xx : Adding support for SPEAr1310
In-Reply-To: <24e7a018145fb94f298ac620919ec4f0a1bf7517.1295333958.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<24e7a018145fb94f298ac620919ec4f0a1bf7517.1295333958.git.viresh.kumar@st.com>
Message-ID: <20110119000919.GB2209@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 18, 2011 at 12:41:59PM +0530, Viresh Kumar wrote:
> From: Bhupesh Sharma <bhupesh.sharma@st.com>
> 
> This patch adds support for SPEAr1310 Machine and evaluation board
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
[...]
> diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c 
> b/arch/arm/mach-spear13xx/spear1310_evb.c
> new file mode 100644
> index 0000000..1270b4d
> --- /dev/null
> +++ b/arch/arm/mach-spear13xx/spear1310_evb.c
> @@ -0,0 +1,133 @@
> +/*
> + * arch/arm/mach-spear13xx/spear1310_evb.c
> + *
> + * SPEAr1310 evaluation board source file
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Bhupesh Sharma <bhupesh.sharma@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/gpio.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/fsmc.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach-types.h>
> +#include <plat/fsmc.h>
> +#include <plat/keyboard.h>
> +#include <plat/spi.h>
> +#include <mach/generic.h>
> +#include <mach/spear.h>
> +#include <mach/pcie.h>
> +
> +static struct amba_device *amba_devs[] __initdata = {
> +	/* spear13xx specific devices */
> +	&spear13xx_gpio_device[0],
> +	&spear13xx_gpio_device[1],
> +	&spear13xx_ssp_device,
> +	&spear13xx_uart_device,
> +};
> +
> +static struct platform_device *plat_devs[] __initdata = {
> +	/* spear13xx specific devices */
> +	&spear13xx_ehci0_device,
> +	&spear13xx_ehci1_device,
> +	&spear13xx_i2c_device,
> +	&spear13xx_kbd_device,
> +	&spear13xx_nand_device,
> +	&spear13xx_ohci0_device,
> +	&spear13xx_ohci1_device,
> +	&spear13xx_rtc_device,
> +	&spear13xx_sdhci_device,
> +
> +	/* spear1310 specific devices */
> +	&spear1310_can0_device,
> +	&spear1310_can1_device,
> +};
> +
> +/* keyboard specific platform data */
> +static DECLARE_KEYMAP(keymap);
> +static struct matrix_keymap_data keymap_data = {
> +	.keymap = keymap,
> +	.keymap_size = ARRAY_SIZE(keymap),
> +};
> +
> +static struct kbd_platform_data kbd_data = {
> +	.keymap = &keymap_data,
> +	.rep = 1,
> +};
> +
> +static struct spi_board_info __initdata spi_board_info[] = {
> +};

AFAICT spi_register_board_info() doesn't do anything when passed this empty 
array so both the array and call could be removed.

> +
> +#ifdef CONFIG_PCIEPORTBUS
> +/* this function is needed for PCIE host and device driver. Same
> + * controller can not be programmed as host as well as device. So host
> + * driver must call this function and if this function returns 1 then
> + * only host should add that particular port as RC.
> + * A port to be added as device, one must also add device's information
> + * in plat_devs array defined in this file.
> + * it is the responsibility of calling function to not send port number
> + * greter than max no of controller(3)
> + */
> +int spear1310_pcie_port_is_host(int port)
> +{
> +	switch (port) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		return 1;
> +	case 2:
> +		return 1;
> +	}
> +	return -EINVAL;
> +}
> +#endif

It looks like this can be made static.  Also, given the comment, is it worth 
adding a BUG_ON(port > 3)?

> +static void __init spear1310_evb_init(void)
> +{
> +	unsigned int i;
> +
> +	/* set keyboard plat data */
> +	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
> +
> +	/* set nand device's plat data */
> +	fsmc_nand_set_plat_data(&spear13xx_nand_device, NULL, 0,
> +			NAND_SKIP_BBTSCAN, FSMC_NAND_BW8);
> +	nand_mach_init(FSMC_NAND_BW8);
> +
> +	/* call spear1310 machine init function */
> +	spear1310_init();
> +
> +	/* Register slave devices on the I2C buses */
> +	i2c_register_default_devices();
> +
> +#ifdef CONFIG_PCIEPORTBUS
> +	/* Enable PCIE0 clk */
> +	enable_pcie0_clk();
> +	pcie_init(&spear1310_pcie_port_is_host);

No '&' needed before function name.

Jamie
