From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 Aug 2012 15:05:53 -0700
Subject: [PATCH v5 1/2] ARM: Make a compile firmware conditionally
In-Reply-To: <20120824083351.GA25369@july>
References: <20120824083351.GA25369@july>
Message-ID: <20120827220553.GB7431@lumpy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 24, 2012 at 05:33:51PM +0900, Kyungmin Park wrote:
> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index 283fa1d..5b097ca 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -21,6 +21,9 @@ config ARM_VIC_NR
>  	  The maximum number of VICs available in the system, for
>  	  power management.
>  
> +config ARM_FIRMWARE
> +	bool
> +

I don't think you need a config option for this now, it only adds 12
bytes of data to the kernel and it makes the below simpler.

> diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
> new file mode 100644
> index 0000000..99c97ff
> --- /dev/null
> +++ b/arch/arm/include/asm/firmware.h
> @@ -0,0 +1,27 @@
> +/*
> + *  Copyright (C) 2012 Samsung Electronics.
> + *  Kyungmin Park <kyungmin.park@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_ARM_FIRMWARE_H
> +#define __ASM_ARM_FIRMWARE_H
> +
> +struct firmware_ops {
> +	int	(*do_idle)(void);
> +	void	(*cpu_boot)(int cpu);
> +};
> +
> +extern struct firmware_ops *firmware_ops;
> +
> +#ifdef CONFIG_ARM_FIRMWARE
> +#define call_firmware_op(op, ...)					\
> +	((firmware_ops->op) ? firmware_ops->op(__VA_ARGS__) : 0)
> +#else
> +#define call_firmware_op(op, ...)		do { } while (0)
> +#endif

If you always include the firmware.c file, then you don't need the ifdef
above either, since the default version fills in dummy versions.


-Olof
