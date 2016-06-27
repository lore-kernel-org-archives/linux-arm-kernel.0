From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jun 2016 18:28:09 +0100
Subject: [PATCH 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1466339944-602-2-git-send-email-carlo@caione.org>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
 <1466339944-602-2-git-send-email-carlo@caione.org>
Message-ID: <20160627172805.GA30514@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 19, 2016 at 02:38:59PM +0200, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Introduce a driver to provide calls into secure monitor mode.
> 
> In the Amlogic SoCs these calls are used for multiple reasons: access to
> NVMEM, set USB boot, enable JTAG, etc...
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/firmware/Kconfig                |   1 +
>  drivers/firmware/Makefile               |   1 +
>  drivers/firmware/meson/Kconfig          |   8 +
>  drivers/firmware/meson/Makefile         |   1 +
>  drivers/firmware/meson/meson_sm.c       | 266 ++++++++++++++++++++++++++++++++
>  include/linux/firmware/meson/meson_sm.h |  32 ++++
>  6 files changed, 309 insertions(+)
>  create mode 100644 drivers/firmware/meson/Kconfig
>  create mode 100644 drivers/firmware/meson/Makefile
>  create mode 100644 drivers/firmware/meson/meson_sm.c
>  create mode 100644 include/linux/firmware/meson/meson_sm.h
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 6664f11..686e395 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -199,5 +199,6 @@ config HAVE_ARM_SMCCC
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> +source "drivers/firmware/meson/Kconfig"
>  
>  endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 474bada..fc4bb09 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
>  CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQUIRES_SEC=1) -march=armv7-a
>  
>  obj-y				+= broadcom/
> +obj-y				+= meson/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
>  obj-$(CONFIG_EFI)		+= efi/
>  obj-$(CONFIG_UEFI_CPER)		+= efi/
> diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
> new file mode 100644
> index 0000000..fff11a3
> --- /dev/null
> +++ b/drivers/firmware/meson/Kconfig
> @@ -0,0 +1,8 @@
> +#
> +# Amlogic Secure Monitor driver
> +#
> +config MESON_SM
> +	bool
> +	default ARCH_MESON
> +	help
> +	  Say y here to enable the Amlogic secure monitor driver
> diff --git a/drivers/firmware/meson/Makefile b/drivers/firmware/meson/Makefile
> new file mode 100644
> index 0000000..9ab3884
> --- /dev/null
> +++ b/drivers/firmware/meson/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MESON_SM) +=	meson_sm.o
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> new file mode 100644
> index 0000000..8e6b9dc
> --- /dev/null
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -0,0 +1,266 @@
> +/*
> + * Amlogic Secure Monitor driver
> + *
> + * Copyright (C) 2016 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <stdarg.h>
> +#include <asm/cacheflush.h>
> +#include <asm/compiler.h>

As far as I can see, these aren't necessary. There aren't any variadic
functions, there's no cache maintenance. I'm guessing compiler.h is left
over from pre-SMCCCC code that used __asmeq().

> +#include <linux/arm-smccc.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>

Likewise for ioport.h and module.h. All the io accessors we use are in
io.h, and we only need export.h for EXPORT_SYMBOL().

> +#include <linux/platform_device.h>

This isn't a platform_driver. Was it meant to be? It would be nicer if
so, using builtin_platform_driver and having the usual infrastrucutre
drive the matching.

> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/smp.h>

We don't appear to use anything from smp.h any more, so I beleive that
can go too.

> +#include <linux/firmware/meson/meson_sm.h>

You also need <linux/printk.h>, and <linux/bug.h> for pr_* and WARN_ON
respectively. I believe that <linux/types.h> is mean to be included for
u32 and friends, though they're defined through some magic in transitive
includes.

> +
> +struct meson_sm_cmd {
> +	unsigned int index;
> +	u32 smc_id;
> +};
> +#define CMD(d, s) { .index = (d), .smc_id = (s), }
> +
> +struct meson_sm_chip {
> +	unsigned int shmem_size;
> +	u32 cmd_shmem_in_base;
> +	u32 cmd_shmem_out_base;
> +	struct meson_sm_cmd cmd[];
> +};
> +
> +struct meson_sm_chip gxbb_chip = {
> +	.shmem_size		= 0x1000,
> +	.cmd_shmem_in_base	= 0x82000020,
> +	.cmd_shmem_out_base	= 0x82000021,
> +	.cmd = {
> +		CMD(SM_EFUSE_READ,	0x82000030),
> +		CMD(SM_EFUSE_WRITE,	0x82000031),
> +		CMD(SM_EFUSE_USER_MAX,	0x82000033),
> +		{ /* sentinel */ },
> +	},
> +};
> +
> +struct meson_sm_firmware {
> +	const struct meson_sm_chip *chip;
> +	void __iomem *sm_shmem_in_base;
> +	void __iomem *sm_shmem_out_base;
> +};
> +
> +static struct meson_sm_firmware fw;
> +
> +static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip, unsigned int cmd_index)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; chip->cmd[i].smc_id; i++)
> +		if (chip->cmd[i].index == cmd_index)
> +			return chip->cmd[i].smc_id;
> +
> +	return 0;
> +}

Given that the sentinel has index == 0 and smc_id == 0, you could
simplify this to something like:

	struct meson_sm_cmd *cmd = chip->cmd;

	while (cmd->smc_id && cmd->index != cmd_index)
		cmd++;

	return cmd->smc_id;

> +
> +static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res);
> +	return res.a0;
> +}
> +
> +static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
> +{
> +	u32 sm_phy_base;
> +
> +	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
> +	if (!sm_phy_base)
> +		return 0;
> +
> +	return ioremap_cache(sm_phy_base, size);
> +}

Does this work on !4K page kernels?

Above I saw that for GXBB the shmem_size was 0x1000. I can imagine that
mapping an extra 60K with cacheable attributes isn't going to be safe,
even if the kernel happens to do that.

Either we need to handle that, or rule out working for !4K kernels
(either with a Kconfig dependency, or some runtime detection).

> +/**
> + * meson_sm_call - generic SMC32 call to the secure-monitor
> + *
> + * @fw:		Meson secure-monitor firmware pointer
> + * @cmd_index:	Index of the SMC32 function ID
> + * @ret:	Returned value
> + * @arg0:	SMC32 Argument 0
> + * @arg1:	SMC32 Argument 1
> + * @arg2:	SMC32 Argument 2
> + * @arg3:	SMC32 Argument 3
> + * @arg4:	SMC32 Argument 4
> + *
> + * Return:	0 on success, a negative value on error
> + */
> +int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
> +		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> +{
> +	u32 cmd, lret;
> +
> +	if (!fw)
> +		return -EINVAL;
> +
> +	cmd = meson_sm_get_cmd(fw->chip, cmd_index);
> +	if (!cmd)
> +		return -EINVAL;
> +
> +	lret = __meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
> +
> +	if (ret)
> +		*ret = lret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(meson_sm_call);
> +
> +/**
> + * meson_sm_call_read - retrieve data from secure-monitor
> + *
> + * @fw:		Meson secure-monitor firmware pointer
> + * @buffer:	Buffer to store the retrieved data
> + * @cmd_index:	Index of the SMC32 function ID
> + * @arg0:	SMC32 Argument 0
> + * @arg1:	SMC32 Argument 1
> + * @arg2:	SMC32 Argument 2
> + * @arg3:	SMC32 Argument 3
> + * @arg4:	SMC32 Argument 4
> + *
> + * Return:	size of read data on success, a negative value on error
> + */
> +int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
> +		       unsigned int cmd_index, u32 arg0, u32 arg1,
> +		       u32 arg2, u32 arg3, u32 arg4)
> +{
> +	u32 size;
> +
> +	if (!fw->chip->cmd_shmem_out_base)
> +		return -EINVAL;
> +
> +	if (meson_sm_call(fw, cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
> +		return -EINVAL;
> +
> +	if (!size || size > fw->chip->shmem_size)
> +		return -EINVAL;
> +
> +	if (buffer)
> +		memcpy(buffer, fw->sm_shmem_out_base, size);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(meson_sm_call_read);
> +
> +/**
> + * meson_sm_call_write - send data to secure-monitor
> + *
> + * @fw:		Meson secure-monitor firmware pointer
> + * @buffer:	Buffer containing data to send
> + * @b_size:	Size of the data to send
> + * @cmd_index:	Index of the SMC32 function ID
> + * @arg0:	SMC32 Argument 0
> + * @arg1:	SMC32 Argument 1
> + * @arg2:	SMC32 Argument 2
> + * @arg3:	SMC32 Argument 3
> + * @arg4:	SMC32 Argument 4
> + *
> + * Return:	size of sent data on success, a negative value on error
> + */
> +int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
> +			unsigned int b_size, unsigned int cmd_index,
> +			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> +{
> +	u32 size;

The b_size vs size thing is somewhat confusing.

could we s/size/written/ and s/b_size/size/ ?

> +
> +	if (b_size > fw->chip->shmem_size)
> +		return -EINVAL;
> +
> +	if (!fw->chip->cmd_shmem_in_base)
> +		return -EINVAL;
> +
> +	memcpy(fw->sm_shmem_in_base, buffer, b_size);
> +
> +	if (meson_sm_call(fw, cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
> +		return -EINVAL;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(meson_sm_call_write);
> +
> +/**
> + * meson_sm_get_fw - get Meson firmware struct
> + *
> + * Return:		Meson secure-monitor firmware struct on success, NULL on error
> + */
> +struct meson_sm_firmware *meson_sm_get_fw(void)
> +{
> +	/*
> +	 * Returns NULL is the firmware device is not ready.
> +	 */
> +	if (!fw.chip)
> +		return NULL;
> +
> +	return &fw;
> +}
> +EXPORT_SYMBOL(meson_sm_get_fw);

Do any external callers actually need direct access to the fw struct
fields? Or is this just so they can pass this to meson_sm_call and
friends?

Given we have a singleton anyway, can't we just have the meson_sm_call*
functions check whether fw is initialised, and return -ENOENT/-ENXIO if
not?

> +
> +static const struct of_device_id meson_sm_ids[] = {
> +	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
> +	{ /* sentinel */ },
> +};
> +
> +int __init meson_sm_init(void)
> +{
> +	const struct meson_sm_chip *chip;
> +	const struct of_device_id *matched_np;
> +	struct device_node *np;
> +
> +	np = of_find_matching_node_and_match(NULL, meson_sm_ids, &matched_np);
> +	if (!np) {
> +		pr_err("no matching node\n");
> +		return -EINVAL;
> +	}
> +

This is going to be pointlessly noisy on every non-amlogic board out
there.

Please make this a platform driver, such that this is only called when a
node is present, avoiding some mess there.

> +	chip = matched_np->data;
> +	if (!chip) {
> +		pr_err("unable to setup secure-monitor data\n");
> +		return -EINVAL;
> +	}

Using a platform driver would also avoid the necessity of this check, so
long as you know each of_device_id entry has a valid data field.

> +
> +	if (chip->cmd_shmem_in_base) {
> +		fw.sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
> +							 chip->shmem_size);
> +		if (WARN_ON(!fw.sm_shmem_in_base))
> +			goto out;
> +	}

As above, I'm worried this may explode on !4K kernels (and also somewhat
worried that it might not blow up here, but rather elsewhere at
runtime).

> +
> +	if (chip->cmd_shmem_out_base) {
> +		fw.sm_shmem_out_base = meson_sm_map_shmem(chip->cmd_shmem_out_base,
> +							  chip->shmem_size);
> +		if (WARN_ON(!fw.sm_shmem_out_base))
> +			goto out;
> +	}
> +
> +	fw.chip = chip;
> +	pr_info("secure-monitor enabled\n");

This may be ambiguous to those not familiar with this driver. It would
be worth having:

#define pr_fmt(fmt) "meson-sm: " fmt

before the include of <linux/printk.h>, which would make it clear that
the log messages came from this particular secure monitor driver.

> +
> +	return 0;
> +
> +out:
> +	if (fw.sm_shmem_in_base)
> +		iounmap(fw.sm_shmem_in_base);
> +
> +	return -EINVAL;

It would be nicer to have:

out_in_base:
	iounmap(fw.sm_shmem_in_base);
out:
	return -EINVAL

With the earlier gotos fixed up appropriately.

> +}
> +device_initcall(meson_sm_init);
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> new file mode 100644
> index 0000000..81136b0
> --- /dev/null
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 2016 Endless Mobile, Inc.
> + * Author: Carlo Caione <carlo@endlessm.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _MESON_SM_FW_H_
> +#define _MESON_SM_FW_H_
> +
> +#define SM_EFUSE_READ		0
> +#define SM_EFUSE_WRITE		1
> +#define SM_EFUSE_USER_MAX	2

This looks like enum material, even if only for the definitions here.

> +
> +struct meson_sm_firmware;
> +
> +int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
> +		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> +int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
> +			unsigned int b_size, unsigned int cmd_index,
> +			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> +int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
> +		       unsigned int cmd_index, u32 arg0, u32 arg1,
> +		       u32 arg2, u32 arg3, u32 arg4);
> +struct meson_sm_firmware *meson_sm_get_fw(void);

As above, I'm not sure if it makes sense for meson_sm_firmware to leak
into drivers, though you may have a use-case for that describe in a
previous bit of reply.

Thanks,
Mark.
