From: carlo@caione.org (Carlo Caione)
Date: Tue, 28 Jun 2016 10:10:57 +0200
Subject: [PATCH 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <20160627172805.GA30514@leverpostej>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
 <1466339944-602-2-git-send-email-carlo@caione.org>
 <20160627172805.GA30514@leverpostej>
Message-ID: <20160628081057.GA3171@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/16 18:28, Mark Rutland wrote:
> Hi,
> 
> On Sun, Jun 19, 2016 at 02:38:59PM +0200, Carlo Caione wrote:

[...]
> > +#include <stdarg.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/compiler.h>
> 
> As far as I can see, these aren't necessary. There aren't any variadic
> functions, there's no cache maintenance. I'm guessing compiler.h is left
> over from pre-SMCCCC code that used __asmeq().

Also I forgot to clean-up the headers list from the previous iterations.

> > +#include <linux/arm-smccc.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/module.h>
> 
> Likewise for ioport.h and module.h. All the io accessors we use are in
> io.h, and we only need export.h for EXPORT_SYMBOL().

ok

> > +#include <linux/platform_device.h>
> 
> This isn't a platform_driver. Was it meant to be? It would be nicer if
> so, using builtin_platform_driver and having the usual infrastrucutre
> drive the matching.

It was a platform driver in the first versions but I changed to this
form after Rob suggested to have it in the /firmware node and without
compatibility to the "simple-bus".

> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/smp.h>
> 
> We don't appear to use anything from smp.h any more, so I beleive that
> can go too.

ok

> > +#include <linux/firmware/meson/meson_sm.h>
> 
> You also need <linux/printk.h>, and <linux/bug.h> for pr_* and WARN_ON
> respectively. I believe that <linux/types.h> is mean to be included for
> u32 and friends, though they're defined through some magic in transitive
> includes.

ok

[...]
> > +static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip, unsigned int cmd_index)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; chip->cmd[i].smc_id; i++)
> > +		if (chip->cmd[i].index == cmd_index)
> > +			return chip->cmd[i].smc_id;
> > +
> > +	return 0;
> > +}
> 
> Given that the sentinel has index == 0 and smc_id == 0, you could
> simplify this to something like:
> 
> 	struct meson_sm_cmd *cmd = chip->cmd;
> 
> 	while (cmd->smc_id && cmd->index != cmd_index)
> 		cmd++;
> 
> 	return cmd->smc_id;

yeah, better I think

> > +
> > +static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res);
> > +	return res.a0;
> > +}
> > +
> > +static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
> > +{
> > +	u32 sm_phy_base;
> > +
> > +	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
> > +	if (!sm_phy_base)
> > +		return 0;
> > +
> > +	return ioremap_cache(sm_phy_base, size);
> > +}
> 
> Does this work on !4K page kernels?
> 
> Above I saw that for GXBB the shmem_size was 0x1000. I can imagine that
> mapping an extra 60K with cacheable attributes isn't going to be safe,
> even if the kernel happens to do that.

Agree

> Either we need to handle that, or rule out working for !4K kernels
> (either with a Kconfig dependency, or some runtime detection).

Probably it's better to stay on the safe side and just to rule !4K
kernels out with Kconfig

[...]
> > + * Return:	size of sent data on success, a negative value on error
> > + */
> > +int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
> > +			unsigned int b_size, unsigned int cmd_index,
> > +			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> > +{
> > +	u32 size;
> 
> The b_size vs size thing is somewhat confusing.
> 
> could we s/size/written/ and s/b_size/size/ ?

ok

> > +
> > +	if (b_size > fw->chip->shmem_size)
> > +		return -EINVAL;
> > +
> > +	if (!fw->chip->cmd_shmem_in_base)
> > +		return -EINVAL;
> > +
> > +	memcpy(fw->sm_shmem_in_base, buffer, b_size);
> > +
> > +	if (meson_sm_call(fw, cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
> > +		return -EINVAL;
> > +
> > +	if (!size)
> > +		return -EINVAL;
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(meson_sm_call_write);
> > +
> > +/**
> > + * meson_sm_get_fw - get Meson firmware struct
> > + *
> > + * Return:		Meson secure-monitor firmware struct on success, NULL on error
> > + */
> > +struct meson_sm_firmware *meson_sm_get_fw(void)
> > +{
> > +	/*
> > +	 * Returns NULL is the firmware device is not ready.
> > +	 */
> > +	if (!fw.chip)
> > +		return NULL;
> > +
> > +	return &fw;
> > +}
> > +EXPORT_SYMBOL(meson_sm_get_fw);
> 
> Do any external callers actually need direct access to the fw struct
> fields? Or is this just so they can pass this to meson_sm_call and
> friends?
> 
> Given we have a singleton anyway, can't we just have the meson_sm_call*
> functions check whether fw is initialised, and return -ENOENT/-ENXIO if
> not?

Yes, the meson_sm_get_fw() was used to enforce probe ordering when the
driver was a platform driver. Since this is now probed on
device_initcall() I think we can safely remove this.

> > +
> > +static const struct of_device_id meson_sm_ids[] = {
> > +	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +int __init meson_sm_init(void)
> > +{
> > +	const struct meson_sm_chip *chip;
> > +	const struct of_device_id *matched_np;
> > +	struct device_node *np;
> > +
> > +	np = of_find_matching_node_and_match(NULL, meson_sm_ids, &matched_np);
> > +	if (!np) {
> > +		pr_err("no matching node\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> This is going to be pointlessly noisy on every non-amlogic board out
> there.

ouch, right

> Please make this a platform driver, such that this is only called when a
> node is present, avoiding some mess there.

Since Rob required this to be under /firmware (and using no "simple-bus"
compatible to trigger the automatic creation) making it a platform
driver just adds a lot of boilerplate code. If this doesn't mean a NACK
on your side, I still would leave the code as is with the
device_initcall() calling the init.

> > +	chip = matched_np->data;
> > +	if (!chip) {
> > +		pr_err("unable to setup secure-monitor data\n");
> > +		return -EINVAL;
> > +	}
> 
> Using a platform driver would also avoid the necessity of this check, so
> long as you know each of_device_id entry has a valid data field.
> 
> > +
> > +	if (chip->cmd_shmem_in_base) {
> > +		fw.sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
> > +							 chip->shmem_size);
> > +		if (WARN_ON(!fw.sm_shmem_in_base))
> > +			goto out;
> > +	}
> 
> As above, I'm worried this may explode on !4K kernels (and also somewhat
> worried that it might not blow up here, but rather elsewhere at
> runtime).

ok

> > +
> > +	if (chip->cmd_shmem_out_base) {
> > +		fw.sm_shmem_out_base = meson_sm_map_shmem(chip->cmd_shmem_out_base,
> > +							  chip->shmem_size);
> > +		if (WARN_ON(!fw.sm_shmem_out_base))
> > +			goto out;
> > +	}
> > +
> > +	fw.chip = chip;
> > +	pr_info("secure-monitor enabled\n");
> 
> This may be ambiguous to those not familiar with this driver. It would
> be worth having:
> 
> #define pr_fmt(fmt) "meson-sm: " fmt
> 
> before the include of <linux/printk.h>, which would make it clear that
> the log messages came from this particular secure monitor driver.

good idea

> > +
> > +	return 0;
> > +
> > +out:
> > +	if (fw.sm_shmem_in_base)
> > +		iounmap(fw.sm_shmem_in_base);
> > +
> > +	return -EINVAL;
> 
> It would be nicer to have:
> 
> out_in_base:
> 	iounmap(fw.sm_shmem_in_base);
> out:
> 	return -EINVAL
> 
> With the earlier gotos fixed up appropriately.

agreed

> > +}
> > +device_initcall(meson_sm_init);
> > diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> > new file mode 100644
> > index 0000000..81136b0
> > --- /dev/null
> > +++ b/include/linux/firmware/meson/meson_sm.h
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Copyright (C) 2016 Endless Mobile, Inc.
> > + * Author: Carlo Caione <carlo@endlessm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef _MESON_SM_FW_H_
> > +#define _MESON_SM_FW_H_
> > +
> > +#define SM_EFUSE_READ		0
> > +#define SM_EFUSE_WRITE		1
> > +#define SM_EFUSE_USER_MAX	2
> 
> This looks like enum material, even if only for the definitions here.

ok

> > +
> > +struct meson_sm_firmware;
> > +
> > +int meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
> > +		  u32 *ret, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> > +int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
> > +			unsigned int b_size, unsigned int cmd_index,
> > +			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
> > +int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
> > +		       unsigned int cmd_index, u32 arg0, u32 arg1,
> > +		       u32 arg2, u32 arg3, u32 arg4);
> > +struct meson_sm_firmware *meson_sm_get_fw(void);
> 
> As above, I'm not sure if it makes sense for meson_sm_firmware to leak
> into drivers, though you may have a use-case for that describe in a
> previous bit of reply.

Not really, as written before that was used to enforce probe ordering.
I'll take that out in the next revision.

Thank you for your review,

-- 
Carlo Caione
