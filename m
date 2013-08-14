From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:44:24 -0700
Subject: [PATCH v6 2/4] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130814064424.GI19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Fri, Jul 26, 2013 at 12:32:13PM +0800, Haojian Zhuang wrote:
> Support UART0 debug ll on hisilicon Hi3620 SoC.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

By the way, I ended up doing two fixups:

> ---
>  arch/arm/Kconfig.debug             | 15 +++++++++++++++
>  arch/arm/include/debug/hisilicon.S | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 arch/arm/include/debug/hisilicon.S
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e401a76..289a248 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -272,6 +272,20 @@ choice
>  		  Say Y here if you want the debug print routines to direct
>  		  their output to UART1 serial port on KEYSTONE2 devices.
>  
> +	config DEBUG_HI3620_UART
> +		bool "Hisilicon HI3620 Debug UART"
> +		depends on ARCH_HI3xxx
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on HI3620 UART.
> +
> +	config DEBUG_HI3716_UART
> +		bool "Hisilicon Hi3716 Debug UART"
> +		depends on ARCH_HI3xxx
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on HI3716 UART.
> +
>  	config DEBUG_MMP_UART2

These are out of alphabetical order, not good. I moved them up right before
highbank where they should be.

> diff --git a/arch/arm/include/debug/hisilicon.S b/arch/arm/include/debug/hisilicon.S
> new file mode 100644
> index 0000000..47ad019
> --- /dev/null
> +++ b/arch/arm/include/debug/hisilicon.S
> @@ -0,0 +1,30 @@
> +/*
> + * Early serial output macro for Hisilicon SoC
> + *
> + * Copyright (C) 2012-2013 Hisilicon Technologies Co., Ltd.
> + * Copyright (C) 2012-2013 Linaro Ltd.
> + *
> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#if defined(CONFIG_DEBUG_HI3620_UART)
> +#define HS_UART_PHYS_BASE	0xfcb00000
> +#define HS_UART_VIRT_BASE	0xfeb00000
> +#elif defined(CONFIG_DEBUG_HI3716_UART)
> +#define HS_UART_PHYS_BASE	0xf8b00000
> +#define HS_UART_VIRT_BASE	0xfeb00000
> +#endif

HS_UART_VIRT_BASE is the same, so I moved it outside the ifdef.


-Olof
