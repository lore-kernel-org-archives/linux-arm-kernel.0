From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 17 Oct 2009 16:41:41 +0200
Subject: [PATCH v3 3/7] [ARM]: U8500 core machine support
In-Reply-To: <1255300060.21542.407.camel@vinay-desktop>
References: <1255300048.21542.406.camel@vinay-desktop>
	<1255300060.21542.407.camel@vinay-desktop>
Message-ID: <20091017144141.GB14673@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +#include <mach/hardware.h>
> +#include <mach/setup.h>
> +
> +#define __MEM_4K_RESOURCE(x) \
> +	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
> +
> +/* These are active devices on this board */
> +static struct amba_device uart0_device = {
> +	.dev = { .init_name = "uart0" },
> +	__MEM_4K_RESOURCE(U8500_UART0_BASE),
> +	.irq = {IRQ_UART0, NO_IRQ},
> +};
> +
> +static struct amba_device uart1_device = {
> +	.dev = { .init_name = "uart1" },
> +	__MEM_4K_RESOURCE(U8500_UART1_BASE),
> +	.irq = {IRQ_UART1, NO_IRQ},
> +};
> +
> +static struct amba_device uart2_device = {
> +	.dev = { .init_name = "uart2" },
> +	__MEM_4K_RESOURCE(U8500_UART2_BASE),
> +	.irq = {IRQ_UART2, NO_IRQ},
> +};
> +
> +static struct amba_device *amba_devs[] __initdata = {
> +	&uart0_device,
> +	&uart1_device,
> +	&uart2_device,
> +};
here you specify the uart ressources which are socs specific
It will be better to create a common socs devices file as done on at91

so you can create a common function to register for earch board the uart you
want and also other devices
> +
> +/* add any platform devices here - TODO */
> +static struct platform_device *platform_devs[] __initdata = {
> +	/* yet to be added, add i2c0, gpio.. */
> +};
> +
> +static void __init u8500_init_machine(void)
> +{
> +	int i;
> +	/* Register the active AMBA devices*/
> +	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
> +		amba_device_register(amba_devs[i], &iomem_resource);
> +
> +	/* Register the platform devices */
> +	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
> +
> +	u8500_init_devices();
> +}
> +
> +MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
> +	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
> +	.phys_io	= U8500_UART2_BASE,
> +	.io_pg_offst	= (IO_ADDRESS(U8500_UART2_BASE) >> 18) & 0xfffc,
> +	.boot_params	= 0x100,
> +	.map_io		= u8500_map_io,
> +	.init_irq	= u8500_init_irq,
> +	.timer		= &u8500_timer,
> +	.init_machine	= u8500_init_machine,
> +MACHINE_END
> diff --git a/arch/arm/mach-ux500/include/mach/mtu.h b/arch/arm/mach-ux500/include/mach/mtu.h
> new file mode 100644
> index 0000000..32380be
> --- /dev/null
> +++ b/arch/arm/mach-ux500/include/mach/mtu.h
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2009 ST-Ericsson
> + * MultiTimerUnit register definitions, copied from Nomadik 8815
instead of copying stuff it will be better to put every think under
mach-nomadik

Best Regards,
J.
