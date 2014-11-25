From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Nov 2014 11:48:04 +0000
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <54746C74.8020400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/14 12:35, Vincent Yang wrote:
> The remote firmware(SCB) owns the SMP control. This MCPM driver gets
> CPU/CLUSTER power up/down done by SCB over mailbox.
>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
> ---
>   arch/arm/mach-mb86s7x/Makefile |   2 +-
>   arch/arm/mach-mb86s7x/mcpm.c   | 360 +++++++++++++++++++++++++++++++++++++++++
>   arch/arm/mach-mb86s7x/smc.S    |  27 ++++
>   3 files changed, 388 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
>   create mode 100644 arch/arm/mach-mb86s7x/smc.S
>

[...]

> +asmlinkage void mb86s70evb_outer_flush_all(void)
> +{
> +       outer_flush_all();
> +}
> +
> +#define mb86s70evb_exit_coherency_flush(level) { \

You are duplicating the generic macro just to add outer cache, I was
thinking of extending the generic macro to add outer cache support, but
IMO it might be bit tricky for below mentioned reasons.

> +       asm volatile( \
> +       "stmfd  sp!, {fp, ip}\n\t" \
> +       "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR\n\t" \
> +       "bic    r0, r0, #"__stringify(CR_C)"\n\t" \
> +       "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR\n\t" \
> +       "isb\n\t" \
> +       "bl     v7_flush_dcache_"__stringify(level)"\n\t" \
> +       "bl     mb86s70evb_outer_flush_all\n\t" \

IIUC, this seem to be broken IMO, you are doing the outer cache flush
unconditionally which means:

1. You do this for every CPU power down(i.e. when level = louis) which
    is incorrect.
2. You do this for every cluster powerdown, again is that required if
    the other cluster is active. You may have to trace last cluster in
    the system.

> diff --git a/arch/arm/mach-mb86s7x/smc.S b/arch/arm/mach-mb86s7x/smc.S
> new file mode 100644
> index 0000000..a14330b
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/smc.S
> @@ -0,0 +1,27 @@
> +/*
> + * SMC command interface to set secondary entry point
> + * Copyright: (C) 2013-2014 Fujitsu Semiconductor Limited
> + * Copyright: (C) 2014 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +
> +.arch_extension sec
> +
> +/* void mb86s7x_cpu_entry(unsigned long secondary_entry); */
> +ENTRY(mb86s7x_cpu_entry)
> +       stmfd   sp!, {r1-r11, lr}
> +       mov r1, r0
> +       ldr r0, =1
> +       mrc p15, 0, r3, c1, c0, 0
> +       mov r4, r3
> +       and r3, #0xbfffffff
> +       mcr p15, 0, r3, c1, c0, 0
> +       smc #0

Interesting, it looks like you have some secure entity running on your
platform.
1. While the CPU is powered down who is taking care of saving it's
    state as you are doing it in the Linux itself ?
2. Is Linux running in Secure or Non-secure mode ?
3. Why do you need this smc call for secondary boot only ?

Regards,
Sudeep
