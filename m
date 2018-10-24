From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2018 11:59:03 +0100
Subject: [PATCH v8 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
In-Reply-To: <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181024105903.GB4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:

> This commit adds PECI client MFD driver.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                   |  14 ++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel-peci-client.c       | 181 ++++++++++++++++++++++++++
>  include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>  4 files changed, 277 insertions(+)
>  create mode 100644 drivers/mfd/intel-peci-client.c
>  create mode 100644 include/linux/mfd/intel-peci-client.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11841f4b7b2b..e68ae5d820ba 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PECI_CLIENT
> +	bool "Intel PECI client"
> +	depends on (PECI || COMPILE_TEST)
> +	select MFD_CORE
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  multi-functional Intel PECI (Platform Environment Control Interface)

Remove 'multi-functional' from this sentence.

> +	  client. PECI is a one-wire bus interface that provides a communication
> +	  channel from PECI clients in Intel processors and chipset components
> +	  to external monitoring or control devices.
> +
> +	  Additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 5856a9489cbd..ed05583dc30e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT)	+= intel-peci-client.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
> new file mode 100644
> index 000000000000..507e4ac66dfa
> --- /dev/null
> +++ b/drivers/mfd/intel-peci-client.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Intel Corporation
> +
> +#include <linux/bitfield.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-peci-client.h>
> +#include <linux/module.h>
> +#include <linux/peci.h>
> +#include <linux/of_device.h>
> +
> +enum cpu_gens {
> +	CPU_GEN_HSX = 0, /* Haswell Xeon */
> +	CPU_GEN_BRX,     /* Broadwell Xeon */
> +	CPU_GEN_SKX,     /* Skylake Xeon */
> +};
> +
> +static struct mfd_cell peci_functions[] = {
> +	{
> +		.name = "peci-cputemp",
> +	},
> +	{
> +		.name = "peci-dimmtemp",
> +	},

	{ .name = "peci-cputemp", },
	{ .name = "peci-dimmtemp", },

Do these have 2 different drivers?  Where are you putting them?

> +	/* TODO: Add additional PECI sideband functions into here */

When will this be done?

> +};
> +
> +static const struct cpu_gen_info cpu_gen_info_table[] = {
> +	[CPU_GEN_HSX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_HASWELL_X,
> +		.core_max      = CORE_MAX_ON_HSX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_HSX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_HSX },
> +	[CPU_GEN_BRX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_BROADWELL_X,
> +		.core_max      = CORE_MAX_ON_BDX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_BDX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_BDX },
> +	[CPU_GEN_SKX] = {
> +		.family        = 6, /* Family code */
> +		.model         = INTEL_FAM6_SKYLAKE_X,
> +		.core_max      = CORE_MAX_ON_SKX,
> +		.chan_rank_max = CHAN_RANK_MAX_ON_SKX,
> +		.dimm_idx_max  = DIMM_IDX_MAX_ON_SKX },

The '},'s should go on the line below.

> +};
> +
> +static int peci_client_get_cpu_gen_info(struct peci_mfd *priv)

Remove all mention of 'mfd'.  It's not a thing.

> +{
> +	u32 cpu_id;
> +	int i, rc;
> +
> +	rc = peci_get_cpu_id(priv->adapter, priv->addr, &cpu_id);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ARRAY_SIZE(cpu_gen_info_table); i++) {
> +		if (FIELD_GET(CPU_ID_FAMILY_MASK, cpu_id) +
> +			FIELD_GET(CPU_ID_EXT_FAMILY_MASK, cpu_id) ==
> +				cpu_gen_info_table[i].family &&
> +		    FIELD_GET(CPU_ID_MODEL_MASK, cpu_id) ==
> +			FIELD_GET(LOWER_NIBBLE_MASK,
> +				  cpu_gen_info_table[i].model) &&
> +		    FIELD_GET(CPU_ID_EXT_MODEL_MASK, cpu_id) ==
> +			FIELD_GET(UPPER_NIBBLE_MASK,
> +				  cpu_gen_info_table[i].model)) {
> +			break;
> +		}
> +	}

This is really read.  Please reformat it, even if you have to use
local variables to make it more legible.

> +	if (i >= ARRAY_SIZE(cpu_gen_info_table))
> +		return -ENODEV;

Do you really want to fail silently?

> +	priv->gen_info = &cpu_gen_info_table[i];

If you do this in the for(), you can then test priv->gen_info instead
of seeing if the iterator maxed out.  Much nicer I think.

> +	return 0;
> +}
> +
> +bool peci_temp_need_update(struct temp_data *temp)
> +{
> +	if (temp->valid &&
> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(peci_temp_need_update);
> +
> +void peci_temp_mark_updated(struct temp_data *temp)
> +{
> +	temp->valid = 1;
> +	temp->last_updated = jiffies;
> +}
> +EXPORT_SYMBOL_GPL(peci_temp_mark_updated);

These are probably better suited as inline functions to be placed in
a header file.  No need to export them, since they only use their own
data.

> +int peci_client_command(struct peci_mfd *priv, enum peci_cmd cmd, void *vmsg)
> +{
> +	return peci_command(priv->adapter, cmd, vmsg);
> +}
> +EXPORT_SYMBOL_GPL(peci_client_command);

If you share the adaptor with the client, you can call peci_command()
directly.  There should also be some locking in here somewhere too.

> +int peci_client_rd_pkg_cfg_cmd(struct peci_mfd *priv, u8 mbx_idx,

This is gobbledegook.  What's rd?  Read?

> +			       u16 param, u8 *data)
> +{
> +	struct peci_rd_pkg_cfg_msg msg;
> +	int rc;
> +
> +	msg.addr = priv->addr;
> +	msg.index = mbx_idx;
> +	msg.param = param;
> +	msg.rx_len = 4;
> +
> +	rc = peci_command(priv->adapter, PECI_CMD_RD_PKG_CFG, &msg);
> +	if (!rc)
> +		memcpy(data, msg.pkg_config, 4);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(peci_client_rd_pkg_cfg_cmd);

This too should be set-up as an inline function, not an exported one.

> +static int peci_client_probe(struct peci_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct peci_mfd *priv;
> +	int rc;

'ret' is more common.

> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, priv);
> +	priv->client = client;
> +	priv->dev = dev;

> +	priv->adapter = client->adapter;
> +	priv->addr = client->addr;

You're already saving client.  No need to save its individual
attributes as well.

> +	priv->cpu_no = client->addr - PECI_BASE_ADDR;

This seems clunky.  Does the spec say that the addresses have to be in
numerical order with no gaps?  What if someone chooses to implement 4
CPUs at 0x30, 0x35, 0x45 and 0x60?

What do you then do with cpu_no?

> +	snprintf(priv->name, PECI_NAME_SIZE, "peci_client.cpu%d", priv->cpu_no);
> +
> +	rc = peci_client_get_cpu_gen_info(priv);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_mfd_add_devices(priv->dev, priv->cpu_no, peci_functions,
> +				  ARRAY_SIZE(peci_functions), NULL, 0, NULL);
> +	if (rc < 0) {
> +		dev_err(priv->dev, "devm_mfd_add_devices failed: %d\n", rc);

This to too specific.

  "Failed to register child devices"

> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id peci_client_of_table[] = {
> +	{ .compatible = "intel,peci-client" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, peci_client_of_table);
> +#endif
> +
> +static const struct peci_device_id peci_client_ids[] = {
> +	{ .name = "peci-client", .driver_data = 0 },

Remove .driver_data if you're not going to use it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(peci, peci_client_ids);
> +
> +static struct peci_driver peci_client_driver = {
> +	.probe    = peci_client_probe,
> +	.id_table = peci_client_ids,
> +	.driver   = {
> +			.name           = "peci-client",
> +			.of_match_table =
> +				of_match_ptr(peci_client_of_table),
> +	},
> +};

Odd tabbing.

> +module_peci_driver(peci_client_driver);
> +
> +MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
> +MODULE_DESCRIPTION("PECI client MFD driver");

Remove "MFD".

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/intel-peci-client.h b/include/linux/mfd/intel-peci-client.h
> new file mode 100644
> index 000000000000..7ec272cddceb
> --- /dev/null
> +++ b/include/linux/mfd/intel-peci-client.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Intel Corporation */
> +
> +#ifndef __LINUX_MFD_PECI_CLIENT_H
> +#define __LINUX_MFD_PECI_CLIENT_H
> +
> +#include <linux/peci.h>
> +
> +#if IS_ENABLED(CONFIG_X86)
> +#include <asm/intel-family.h>
> +#else
> +/**
> + * Architectures other than x86 cannot include the header file so define these
> + * at here. These are needed for detecting type of client x86 CPUs behind a PECI
> + * connection.
> + */
> +#define INTEL_FAM6_HASWELL_X   0x3F
> +#define INTEL_FAM6_BROADWELL_X 0x4F
> +#define INTEL_FAM6_SKYLAKE_X   0x55
> +#endif
> +
> +#define LOWER_NIBBLE_MASK      GENMASK(3, 0)
> +#define UPPER_NIBBLE_MASK      GENMASK(7, 4)
> +
> +#define CPU_ID_MODEL_MASK      GENMASK(7, 4)
> +#define CPU_ID_FAMILY_MASK     GENMASK(11, 8)
> +#define CPU_ID_EXT_MODEL_MASK  GENMASK(19, 16)
> +#define CPU_ID_EXT_FAMILY_MASK GENMASK(27, 20)
> +
> +#define CORE_MAX_ON_HSX        18 /* Max number of cores on Haswell */
> +#define CHAN_RANK_MAX_ON_HSX   8  /* Max number of channel ranks on Haswell */
> +#define DIMM_IDX_MAX_ON_HSX    3  /* Max DIMM index per channel on Haswell */
> +
> +#define CORE_MAX_ON_BDX        24 /* Max number of cores on Broadwell */
> +#define CHAN_RANK_MAX_ON_BDX   4  /* Max number of channel ranks on Broadwell */
> +#define DIMM_IDX_MAX_ON_BDX    3  /* Max DIMM index per channel on Broadwell */
> +
> +#define CORE_MAX_ON_SKX        28 /* Max number of cores on Skylake */
> +#define CHAN_RANK_MAX_ON_SKX   6  /* Max number of channel ranks on Skylake */
> +#define DIMM_IDX_MAX_ON_SKX    2  /* Max DIMM index per channel on Skylake */
> +
> +#define CORE_NUMS_MAX          CORE_MAX_ON_SKX
> +#define CHAN_RANK_MAX          CHAN_RANK_MAX_ON_HSX
> +#define DIMM_IDX_MAX           DIMM_IDX_MAX_ON_HSX
> +#define DIMM_NUMS_MAX          (CHAN_RANK_MAX * DIMM_IDX_MAX)
> +
> +#define TEMP_TYPE_PECI         6 /* Sensor type 6: Intel PECI */
> +
> +#define UPDATE_INTERVAL        HZ
> +
> +struct temp_data {
> +	uint  valid;
> +	s32   value;
> +	ulong last_updated;
> +};

This should not live in here.

> +struct cpu_gen_info {
> +	u16  family;
> +	u8   model;
> +	uint core_max;
> +	uint chan_rank_max;
> +	uint dimm_idx_max;
> +};
> +
> +struct peci_mfd {

Remove "_mfd".

> +	struct peci_client *client;
> +	struct device *dev;
> +	struct peci_adapter *adapter;
> +	char name[PECI_NAME_SIZE];

What is this used for?

> +	u8 addr;
> +	uint cpu_no;
> +	const struct cpu_gen_info *gen_info;

Where is this used?

> +};

Both of these structs need kerneldoc headers.

> +bool peci_temp_need_update(struct temp_data *temp);
> +void peci_temp_mark_updated(struct temp_data *temp);

These should live in a temperature driver.

> +int  peci_client_command(struct peci_mfd *mfd, enum peci_cmd cmd, void *vmsg);
> +int  peci_client_rd_pkg_cfg_cmd(struct peci_mfd *mfd, u8 mbx_idx,
> +				u16 param, u8 *data);
> +
> +#endif /* __LINUX_MFD_PECI_CLIENT_H */

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
