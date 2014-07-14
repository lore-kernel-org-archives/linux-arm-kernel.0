From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jul 2014 15:33:18 +0200
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
Message-ID: <4458430.zQQyY0X6FH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 July 2014 14:28:31 Mollie Wu wrote:
> The MB86S7X is a bigLITTLE configuration of 2xCA7 & 2xCA15 under Linux.
> And the remote master firmware (called SCB) running on CM3. Linux asks
> for things to be done over Mailbox API, to SCB which controls most of
> the important things. variations S70 & S73 are supported.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof <olof@lixom.net>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
> Signed-off-by: Mollie Wu <mollie.wu@linaro.org>
> ---
>  .../bindings/arm/fujistu/power_domain.txt          |  22 +
>  arch/arm/Kconfig                                   |   2 +
>  arch/arm/Makefile                                  |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/mb86s70.dtsi                     | 635 ++++++++++++++
>  arch/arm/boot/dts/mb86s70eb.dts                    |  38 +
>  arch/arm/boot/dts/mb86s73.dtsi                     | 910 +++++++++++++++++++++
>  arch/arm/boot/dts/mb86s73eb.dts                    |  73 ++
>  arch/arm/configs/fujitsu_defconfig                 | 156 ++++
>  arch/arm/mach-mb86s7x/Kconfig                      |  18 +
>  arch/arm/mach-mb86s7x/Makefile                     |   2 +
>  arch/arm/mach-mb86s7x/board.c                      |  65 ++
>  arch/arm/mach-mb86s7x/iomap.h                      |  34 +
>  arch/arm/mach-mb86s7x/mcpm.c                       | 293 +++++++
>  arch/arm/mach-mb86s7x/pm_domains.c                 | 237 ++++++
>  arch/arm/mach-mb86s7x/scb_mhu.c                    | 447 ++++++++++
>  include/linux/platform_data/mb86s7x_mbox.h         | 249 ++++++

Better split out the dts additions into a separate patch, to make the actual code
easier to review. 

> diff --git a/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
> new file mode 100644
> index 0000000..44abfe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/fujistu/power_domain.txt
> @@ -0,0 +1,22 @@
> +* Fujitsu MB86S7x Power Domains
> +
> +Remote f/w on MB86S7x can enable/disable power to various IPs.
> +
> +Required Properties:
> +- compatible: Should be "fujitsu,mb86s7x-pd"
> +- index: Index of the power gate control for the block

Please always use actual part names in a compatible string, not wildcards
with 'x' in them. If two models are mutually compatible, use the string
for the older product (possibly the smaller number if they
are the same age). In C code, wildcards are fine/.

> +Example:
> +
> +	pd_cpu: genpd at 3 {
> +		compatible = "fujitsu,mb86s7x-pd";
> +		index = <3>;
> +	};
> +
> +Example of the node using power domain:
> +
> +	node {
> +		/* ... */
> +		fujitsu,power-domain = <&pd_cpu>;
> +		/* ... */
> +	};

I believe there has been a submission for a generic power domain binding
now. We really shouldn't use vendor specific power domain bindings
any more.

> --- /dev/null
> +++ b/arch/arm/configs/fujitsu_defconfig

Do you need your own defconfig, or can you just add this to the multi_v7_defconfig
file instead?

In either case, please also add an entry to multi_v7_defconfig and enable
all the drivers you need there.

> diff --git a/arch/arm/mach-mb86s7x/Kconfig b/arch/arm/mach-mb86s7x/Kconfig
> new file mode 100644
> index 0000000..44f5b0c
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/Kconfig
> @@ -0,0 +1,18 @@
> +config ARCH_MB86S7X
> +	bool "Fujitsu MB86S7x platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
> +	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE

Why the LPAE dependency? Is none of the RAM reachable by regular
kernels?

> +
> +bool __init mb86s7x_smp_init_ops(void)
> +{
> +	struct device_node *node;
> +
> +	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
> +	if (node && of_device_is_available(node)) {
> +		mcpm_smp_set_ops();
> +		return true;
> +	}
> +
> +	return false;
> +}

Can you use the CPU_METHOD_OF_DECLARE() macro to set your
SMP ops instead?

> +#define IOMAP_DEV(name) { \
> +		.virtual = (unsigned long) MB86S7X_##name##_VIRT, \
> +		.pfn = __phys_to_pfn(MB86S7X_##name##_PHYS), \
> +		.length = MB86S7X_##name##_SIZE, \
> +		.type = MT_DEVICE, \
> +	}
> +
> +static struct map_desc mb86s7x_io_desc[] = {
> +	IOMAP_DEV(MHU),
> +	IOMAP_DEV(ISRAM),
> +};

What do you need these entries for? You should be able to just ioremap
the registers where needed.

> diff --git a/arch/arm/mach-mb86s7x/iomap.h b/arch/arm/mach-mb86s7x/iomap.h
> new file mode 100644
> index 0000000..2b8db1d
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/iomap.h
> @@ -0,0 +1,34 @@
> +/*
> + * arch/arm/mach-mb86s7x/iomap.h
> + *
> + * Created by: Jassi Brar <jassisinghbrar@gmail.com>
> + * Copyright:	(C) 2013-2014 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __MB86S7X_IOMAP_H
> +#define __MB86S7X_IOMAP_H
> +
> +#include <linux/sizes.h>
> +
> +#define SEC_RSTADDR_OFF		0x3fc
> +
> +#define MB86S7X_MHU_PHYS	0x2b1f0000
> +#define MB86S7X_MHU_SIZE	SZ_4K
> +
> +/* Internal SRAM */
> +#define MB86S7X_ISRAM_PHYS	0x2e000000
> +#define MB86S7X_ISRAM_SIZE	SZ_16K
> +#define MB86S7X_TRAMPOLINE_PHYS	(MB86S7X_ISRAM_PHYS + 0x3c00)
> +
> +#define MB86S7X_ISRAM_VIRT	IOMEM(0xfe000000)
> +#define MB86S7X_MHU_VIRT	(MB86S7X_ISRAM_VIRT + MB86S7X_ISRAM_SIZE)
> +
> +/* Non-Secure High-Priority Channel is used */
> +#define MB86S7X_SHM_FROM_SCB_VIRT	(MB86S7X_ISRAM_VIRT + 0x3800)
> +#define MB86S7X_TRAMPOLINE_VIRT		(MB86S7X_ISRAM_VIRT + 0x3c00)
> +
> +#endif /* __MB86S7X_IOMAP_H */

None of the hardcoded register locations should really be needed, please
move them into the device tree.

For the SRAM, we now have a binding that is already shared between multiple
platforms, see rockchips for an example.

> +static __init int mb86s7x_pm_init_power_domain(void)
> +{
> +	struct platform_device *pdev, *master_pd_pdev;
> +	struct device_node *np, *master_node;
> +	struct mb86s7x_pmd_cmd cmd;
> +	struct completion got_rsp;
> +	int ret;
> +
> +	for_each_compatible_node(np, NULL, "fujitsu,mb86s7x-pd") {
> +		struct mb86s7x_pm_domain *pd, *master_pd;

Is it possible to turn this into a platform driver?

Also, we should probably find a better location for pm-domain code
outside of arch/arm.

> diff --git a/arch/arm/mach-mb86s7x/scb_mhu.c b/arch/arm/mach-mb86s7x/scb_mhu.c
> new file mode 100644
> index 0000000..fd5f034
> --- /dev/null
> +++ b/arch/arm/mach-mb86s7x/scb_mhu.c
> @@ -0,0 +1,447 @@
> +/*
> + * arch/arm/mach-mb86s7x/scb_mhu.c Shim 'server' for Mailbox clients
> + *
> + * Created by: Jassi Brar <jassisinghbrar@gmail.com>
> + * Copyright:	(C) 2013-2014 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

This should probably go into drivers/soc/

> +#define INTR_STAT_OFS	0x0
> +#define INTR_SET_OFS	0x8
> +#define INTR_CLR_OFS	0x10
> +
> +static int do_xfer(void);
> +static void try_xfer(struct work_struct *ignored);

Please remove the forward declarations by reordering the code.

> +static void __iomem *cmd_from_scb = MB86S7X_SHM_FROM_SCB_VIRT;
> +static void __iomem *rsp_from_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x100;
> +static void __iomem *cmd_to_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x200;
> +static void __iomem *rsp_to_scb = MB86S7X_SHM_FROM_SCB_VIRT + 0x300;
> +
> +static LIST_HEAD(free_xfers);
> +static LIST_HEAD(pending_xfers);
> +static DEFINE_SPINLOCK(fsm_lock);
> +static struct mbox_client mhu_cl;
> +static struct mbox_chan *mhu_chan;
> +static DECLARE_WORK(scb_work, try_xfer);
> +static mhu_handler_t handler[MHU_NUM_CMDS];
> +
> +static enum {
> +	MHU_PARK = 0,
> +	MHU_WRR, /* Waiting to get Remote's Reply */
> +	MHU_WRL, /* Waiting to send Reply */
> +	MHU_WRRL, /* WAIT_Ra && WAIT_Rb */
> +	MHU_INVLD,
> +} fsm_state;

Ideally, these should all be part of a per-device data structure
referenced from pdev_get_drvdata().

> +static void got_data(u32 code)
> +{
> +	struct completion *c = NULL;
> +	mhu_handler_t hndlr = NULL;
> +	unsigned long flags;
> +	int ev;
> +
> +	if (code & RESP_BIT)
> +		ev = EV_RR;
> +	else
> +		ev = EV_RC;
> +
> +	spin_lock_irqsave(&fsm_lock, flags);
> +
> +	if (mhu_fsm[fsm_state][ev] == MHU_INVLD) {
> +		spin_unlock_irqrestore(&fsm_lock, flags);
> +		pr_err("State-%d EV-%d FSM Broken!\n", fsm_state, ev);
> +		return;
> +	}
> +	fsm_state = mhu_fsm[fsm_state][ev];
> +
> +	if (code & RESP_BIT) {
> +		c = ax->c;
> +		memcpy_fromio(ax->buf, rsp_from_scb, ax->len);
> +		list_move(&ax->node, &free_xfers);
> +		ax = NULL;
> +	} else {
> +		/* Find and dispatch relevant registered handler */
> +		if (code < MHU_NUM_CMDS)
> +			hndlr = handler[code];
> +		if (!hndlr)
> +			pr_err("No handler for CMD_%u\n", code);
> +	}
> +
> +	spin_unlock_irqrestore(&fsm_lock, flags);
> +
> +	if (hndlr)
> +		hndlr(code, cmd_from_scb);
> +	if (c)
> +		complete(c);
> +}
> +
> +static void mhu_recv(struct mbox_client *cl, void *data)
> +{
> +	got_data((u32)data);
> +	schedule_work(&scb_work);
> +}

Why the cast between integer and pointer?

> +			do {
> +retry:
> +				/* Wait until we get reply */
> +				count = 0x1000000;
> +				do {
> +					cpu_relax();
> +					val = readl_relaxed(
> +						rx_reg + INTR_STAT_OFS);
> +				} while (--count && !val);
> +
> +				if (!val) {
> +					pr_err("%s:%d SCB didn't reply\n",
> +					       __func__, __LINE__);
> +					goto retry;

It seems like this loop is unbounded and will just print an error every
16M loops but never give up or re-enable interrupts if called with
interrupts disabled.

It should probably be changed to either enforce being called with interrupts
enabled so you can call msleep() inbetween, or you should add error-handling
in case the remote side does not reply.

> +int mhu_hndlr_set(u32 cmd, mhu_handler_t hndlr)
> +{
> +	unsigned long flags;
> +	int ret = -EINVAL;
> +
> +	spin_lock_irqsave(&fsm_lock, flags);
> +	if (cmd < MHU_NUM_CMDS && !handler[cmd]) {
> +		ret = 0;
> +		handler[cmd] = hndlr;
> +	}
> +	spin_unlock_irqrestore(&fsm_lock, flags);
> +
> +	if (!mhu_chan) {
> +		struct mbox_chan *_ch;
> +
> +		_ch = mbox_request_channel(&mhu_cl);
> +		if (!IS_ERR(_ch))
> +			mhu_chan = _ch;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(mhu_hndlr_set);

This is a rather generic name for an exported symbol, can you prefix
it with the platform name or something appropriate?

> +static const struct of_device_id scb_dt_ids[] = {
> +	{ .compatible = "fujitsu,scb" },
> +	{ /* sentinel */ }
> +};

I don't see a binding for "fujitsu,scb", and it seems like a far too generic
string. Fujitsu is a large company, I wouldn't be surprised if some other
product besides MB87S7X also came with something called an "scb".

> diff --git a/include/linux/platform_data/mb86s7x_mbox.h b/include/linux/platform_data/mb86s7x_mbox.h
> new file mode 100644
> index 0000000..4f4287e
> --- /dev/null
> +++ b/include/linux/platform_data/mb86s7x_mbox.h
> @@ -0,0 +1,249 @@
> +/*
> + * include/linux/platform_data/mb86s7x_mbox.h
> + *
> + * Created by: Jassi Brar <jassisinghbrar@gmail.com>
> + * Copyright:	(C) 2013-2014 Linaro Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

None of the contents in here are actually platform data, and it seems
they should not be shared across drivers. Most of the data structures
in this file look like they should only be used by one mailbox client
and get moved into the respective driver.

> +struct mb86s7x_peri_clk {
> +	u32 payload_size;
> +	u32 cntrlr;
> +	u32 domain;
> +	u32 port;
> +	u32 en;
> +	u64 freqency;
> +} __packed;

Just mark the last member by itself __packed. I assume you didn't
actually mean to change the alignment of the data structure to one
byte, but just want to say that the last one is misaligned.

> +struct mb86s7x_peri_power {
> +	u32 payload_size;
> +	u32 peri_id;
> +	u32 en;
> +} __packed;

This one doesn't need to be packed at all, same for most of the
others.

> +int mhu_send_packet(int cmd, void *buf, int len, struct completion *c);
> +void mb86s7x_reboot(u32 delay);
> +
> +/* This function must not sleep */
> +typedef void (*mhu_handler_t)(u32 cmd, u8 rcbuf[]);
> +
> +int mhu_hndlr_set(u32 cmd, mhu_handler_t);
> +void mhu_hndlr_clr(u32 cmd, mhu_handler_t);

Doesn't belong here.

	Arnd
