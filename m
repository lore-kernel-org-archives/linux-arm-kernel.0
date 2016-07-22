From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Jul 2016 22:50:51 +0200
Subject: [PATCH v3 1/7] firmware: rockchip: sip: Add rockchip SIP runtime
 service
In-Reply-To: <1469178440-4668-2-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-2-git-send-email-hl@rock-chips.com>
Message-ID: <1497407.KruMAzy5tb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

one bigger thing I noticed only now.

Am Freitag, 22. Juli 2016, 17:07:14 schrieben Sie:
> diff --git a/drivers/firmware/rockchip_sip.c
> b/drivers/firmware/rockchip_sip.c new file mode 100644
> index 0000000..7756af9
> --- /dev/null
> +++ b/drivers/firmware/rockchip_sip.c
> @@ -0,0 +1,64 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2016 ARM Limited
> + */
> +#include <linux/errno.h>
> +#include <linux/linkage.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/printk.h>
> +#include "rockchip_sip.h"
> +
> +typedef unsigned long (psci_fn)(unsigned long, unsigned long,
> +				unsigned long, unsigned long);
> +asmlinkage psci_fn __invoke_psci_fn_smc;
> +
> +#define CONFIG_DRAM_INIT	0x00
> +#define CONFIG_DRAM_SET_RATE	0x01
> +#define CONFIG_DRAM_ROUND_RATE	0x02
> +#define CONFIG_DRAM_SET_AT_SR	0x03
> +#define CONFIG_DRAM_GET_BW	0x04
> +#define CONFIG_DRAM_GET_RATE	0x05
> +#define CONFIG_DRAM_CLR_IRQ	0x06
> +#define CONFIG_DRAM_SET_PARAM   0x07
> +
> +uint64_t sip_smc_ddr_init(void)
> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0,
> +				    0, CONFIG_DRAM_INIT);

I don't think that is legal to use. For one this function itself is declared 
static in the psci code - most likely for a specific reason.

And also if anything invoke_psci_fn would hold the correct pointer depending 
on the calling method.

But as said above, accessing psci static stuff is most likely wrong. Maybe the 
two psci people I've included can tell us how this is to be accessed.


Heiko

> +}
> +
> +uint64_t sip_smc_set_ddr_param(uint64_t param)
> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, param,
> +				    0, CONFIG_DRAM_SET_PARAM);
> +}
> +
> +uint64_t sip_smc_set_ddr_rate(uint64_t rate)
> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, rate, 0,
> +				    CONFIG_DRAM_SET_RATE);
> +}
> +
> +uint64_t sip_smc_get_ddr_rate(void)
> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_GET_RATE);
> +}
> +
> +uint64_t sip_smc_clr_ddr_irq(void)
> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0, 0, CONFIG_DRAM_CLR_IRQ);
> +}
> +
> +uint64_t sip_smc_get_call_count(void)
> +{
> +	return __invoke_psci_fn_smc(SIP_SVC_CALL_COUNT, 0, 0, 0);
> +}
