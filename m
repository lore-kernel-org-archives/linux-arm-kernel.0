From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Jul 2016 12:00:24 +0200
Subject: [PATCH v3 1/7] firmware: rockchip: sip: Add rockchip SIP runtime
 service
In-Reply-To: <1469178440-4668-2-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-2-git-send-email-hl@rock-chips.com>
Message-ID: <1742973.lJ4EpAnn7j@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 22. Juli 2016, 17:07:14 schrieb Lin Huang:
> From: Shengfei xu <xsf@rock-chips.com>
> 
> This patch adds support for the SiP interface, we can pass dram
> paramtert to bl31, and control ddr frequency scaling in bl31.
> 
> Signed-off-by: Shengfei xu <xsf@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

[...]

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

if I'm reading the ATF writers guide [0] correctly, the SiP calls are soc-
specific things:
"For example, two SoC providers can use the same Function ID within the SiP
Service calls OEN range to mean different things - as these calls should be
specific to the SoC. "

So I guess the function calls, as well as the constants should have a prefix.
ROCKCHIP_SIP_DDR_FREQ, rockchip_sip_smc_set_ddr_param(), etc.

Looking at Zynq in the ATF [1] seems to strengthen that theory with the 
similar constants having the ZYNQMP_ prefix.

I guess it doesn't matter to much on the ATF side, as you build a soc-specific 
image, but on the kernel-side I think it should unambiguos, especially as 
functions and constants are part of a public header.

I think the code itself looks fine though :-)


Heiko

[0] https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/rt-svc-writers-guide.md
[1] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/xilinx/zynqmp/sip_svc_setup.c



> +{
> +	return __invoke_psci_fn_smc(SIP_DDR_FREQ, 0,
> +				    0, CONFIG_DRAM_INIT);
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
> diff --git a/drivers/firmware/rockchip_sip.h
> b/drivers/firmware/rockchip_sip.h new file mode 100644
> index 0000000..6487734
> --- /dev/null
> +++ b/drivers/firmware/rockchip_sip.h
> @@ -0,0 +1,59 @@
> +/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef __SIP_INT_H
> +#define __SIP_INT_H
> +
> +/* SMC function IDs for SiP Service queries */
> +#define SIP_SVC_CALL_COUNT		0x8200ff00
> +#define SIP_SVC_UID			0x8200ff01
> +#define SIP_SVC_VERSION			0x8200ff03
> +#define SIP_DDR_FREQ			0xC2000008
> +
> +#if IS_ENABLED(CONFIG_ROCKCHIP_SIP)
> +uint64_t sip_smc_set_ddr_rate(uint64_t rate);
> +uint64_t sip_smc_get_ddr_rate(void);
> +uint64_t sip_smc_clr_ddr_irq(void);
> +uint64_t sip_smc_get_call_count(void);
> +uint64_t sip_smc_ddr_init(void);
> +uint64_t sip_smc_set_ddr_param(uint64_t param);
> +#else
> +static inline uint64_t sip_smc_set_ddr_rate(uint64_t rate)
> +{
> +	return 0;
> +}
> +
> +static inline uint64_t sip_smc_get_ddr_rate(void)
> +{
> +	return 0;
> +}
> +
> +static inline uint64_t sip_smc_clr_ddr_irq(void)
> +{
> +	return 0;
> +}
> +
> +static inline uint64_t sip_smc_get_call_count(void)
> +{
> +	return 0;
> +}
> +
> +static inline uint64_t sip_smc_ddr_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline uint64_t sip_smc_set_ddr_param(uint64_t param)
> +{
> +	return 0;
> +}
> +#endif
> +#endif
