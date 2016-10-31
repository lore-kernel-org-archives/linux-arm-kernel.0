From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 31 Oct 2016 14:23:08 +0000
Subject: [PATCH v1 2/3] nvmem: Add the Broadcom OTP controller driver
In-Reply-To: <1477336324-10543-3-git-send-email-jonathan.richardson@broadcom.com>
References: <1477336324-10543-1-git-send-email-jonathan.richardson@broadcom.com>
 <1477336324-10543-3-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <f51e98c8-af71-5722-ab30-a27e176ddd5f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 24/10/16 20:12, Jonathan Richardson wrote:
> From: Jonathan Richardson <jonathar@broadcom.com>
>
> Add support for 32 and 64-bit versions of Broadcom's On-Chip OTP
> controller. These controllers are used on SoC's such as Cygnus and
> Stingray.
>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Oza Pawandeep <oza@broadcom.com>
> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> ---
>  drivers/nvmem/Kconfig     |  12 ++
>  drivers/nvmem/Makefile    |   2 +
>  drivers/nvmem/bcm-ocotp.c | 335 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 349 insertions(+)
>  create mode 100644 drivers/nvmem/bcm-ocotp.c


I can pick this patch along with dt bindings document, but dts patch has 
to go via arm-soc tree.

Thanks,
srini


>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ba140ea..06935a7 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -80,6 +80,18 @@ config ROCKCHIP_EFUSE
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_rockchip_efuse.
>
> +config NVMEM_BCM_OCOTP
> +	tristate "Broadcom On-Chip OTP Controller support"
> +	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	default ARCH_BCM_IPROC
?
> +	help
> +	  Say y here to enable read/write access to the Broadcom OTP
> +	  controller.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-bcm-ocotp.
> +
>  config NVMEM_SUNXI_SID
>  	tristate "Allwinner SoCs SID support"
>  	depends on ARCH_SUNXI
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 8f942a0..71781ca 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -6,6 +6,8 @@ obj-$(CONFIG_NVMEM)		+= nvmem_core.o
>  nvmem_core-y			:= core.o
>
>  # Devices
> +obj-$(CONFIG_NVMEM_BCM_OCOTP)	+= nvmem-bcm-ocotp.o
> +nvmem-bcm-ocotp-y		:= bcm-ocotp.o
>  obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
>  nvmem-imx-ocotp-y		:= imx-ocotp.o
>  obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
> diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
> new file mode 100644
> index 0000000..646cadb
> --- /dev/null
> +++ b/drivers/nvmem/bcm-ocotp.c
> @@ -0,0 +1,335 @@
> +/*
> + * Copyright (C) 2016 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * # of tries for OTP Status. The time to execute a command varies. The slowest
> + * commands are writes which also vary based on the # of bits turned on. Writing
> + * 0xffffffff takes ~3800 us.
> + */
> +#define OTPC_RETRIES                 5000
> +
> +/* Sequence to enable OTP program */
> +#define OTPC_PROG_EN_SEQ             { 0xf, 0x4, 0x8, 0xd }
> +
> +/* OTPC Commands */
> +#define OTPC_CMD_READ                0x0
> +#define OTPC_CMD_OTP_PROG_ENABLE     0x2
> +#define OTPC_CMD_OTP_PROG_DISABLE    0x3
> +#define OTPC_CMD_PROGRAM             0xA
> +
> +/* OTPC Status Bits */
> +#define OTPC_STAT_CMD_DONE           BIT(1)
> +#define OTPC_STAT_PROG_OK            BIT(2)
> +
> +/* OTPC register definition */
> +#define OTPC_MODE_REG_OFFSET         0x0
> +#define OTPC_MODE_REG_OTPC_MODE      0
> +#define OTPC_COMMAND_OFFSET          0x4
> +#define OTPC_COMMAND_COMMAND_WIDTH   6
> +#define OTPC_CMD_START_OFFSET        0x8
> +#define OTPC_CMD_START_START         0
> +#define OTPC_CPU_STATUS_OFFSET       0xc
> +#define OTPC_CPUADDR_REG_OFFSET      0x28
> +#define OTPC_CPUADDR_REG_OTPC_CPU_ADDRESS_WIDTH 16
> +#define OTPC_CPU_WRITE_REG_OFFSET    0x2c
> +
> +#define OTPC_CMD_MASK  (BIT(OTPC_COMMAND_COMMAND_WIDTH) - 1)
> +#define OTPC_ADDR_MASK (BIT(OTPC_CPUADDR_REG_OTPC_CPU_ADDRESS_WIDTH) - 1)
> +
> +
> +struct otpc_map {
> +	/* in words. */
> +	u32 otpc_row_size;
> +	/* 128 bit row / 4 words support. */
> +	u16 data_r_offset[4];
> +	/* 128 bit row / 4 words support. */
> +	u16 data_w_offset[4];
> +};
> +
> +static struct otpc_map otp_map = {
> +	.otpc_row_size = 1,
> +	.data_r_offset = {0x10},
> +	.data_w_offset = {0x2c},
> +};
> +
> +static struct otpc_map otp_map_v2 = {
> +	.otpc_row_size = 2,
> +	.data_r_offset = {0x10, 0x5c},
> +	.data_w_offset = {0x2c, 0x64},
> +};
> +
> +struct otpc_priv {
> +	struct device       *dev;
> +	void __iomem        *base;
> +	struct otpc_map     *map;
> +	struct nvmem_config *config;
> +};
> +
> +static inline void set_command(void __iomem *base, u32 command)
> +{
> +	writel(command & OTPC_CMD_MASK, base + OTPC_COMMAND_OFFSET);
> +}
> +
> +static inline void set_cpu_address(void __iomem *base, u32 addr)
> +{
> +	writel(addr & OTPC_ADDR_MASK, base + OTPC_CPUADDR_REG_OFFSET);
> +}
> +
> +static inline void set_start_bit(void __iomem *base)
> +{
> +	writel(1 << OTPC_CMD_START_START, base + OTPC_CMD_START_OFFSET);
> +}
> +
> +static inline void reset_start_bit(void __iomem *base)
> +{
> +	writel(0, base + OTPC_CMD_START_OFFSET);
> +}
> +
> +static inline void write_cpu_data(void __iomem *base, u32 value)
> +{
> +	writel(value, base + OTPC_CPU_WRITE_REG_OFFSET);
> +}
> +
> +static int poll_cpu_status(void __iomem *base, u32 value)
> +{
> +	u32 status;
> +	u32 retries;
> +
> +	for (retries = 0; retries < OTPC_RETRIES; retries++) {
> +		status = readl(base + OTPC_CPU_STATUS_OFFSET);
> +		if (status & value)
> +			break;
> +		udelay(1);
> +	}
> +	if (retries == OTPC_RETRIES)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +static int enable_ocotp_program(void __iomem *base)
> +{
> +	static const u32 vals[] = OTPC_PROG_EN_SEQ;
> +	int i;
> +	int ret;
> +
> +	/* Write the magic sequence to enable programming */
> +	set_command(base, OTPC_CMD_OTP_PROG_ENABLE);
> +	for (i = 0; i < ARRAY_SIZE(vals); i++) {
> +		write_cpu_data(base, vals[i]);
> +		set_start_bit(base);
> +		ret = poll_cpu_status(base, OTPC_STAT_CMD_DONE);
> +		reset_start_bit(base);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return poll_cpu_status(base, OTPC_STAT_PROG_OK);
> +}
> +
> +static int disable_ocotp_program(void __iomem *base)
> +{
> +	int ret;
> +
> +	set_command(base, OTPC_CMD_OTP_PROG_DISABLE);
> +	set_start_bit(base);
> +	ret = poll_cpu_status(base, OTPC_STAT_PROG_OK);
> +	reset_start_bit(base);
> +
> +	return ret;
> +}
> +
> +static int bcm_otpc_read(void *context, unsigned int offset, void *val,
> +	size_t bytes)
> +{
> +	struct otpc_priv *priv = context;
> +	u32 *buf = val;
> +	u32 bytes_read;
> +	u32 address = offset / priv->config->word_size;
> +	int i, ret;
> +
> +	for (bytes_read = 0; bytes_read < bytes;) {
> +		set_command(priv->base, OTPC_CMD_READ);
> +		set_cpu_address(priv->base, address++);
> +		set_start_bit(priv->base);
> +		ret = poll_cpu_status(priv->base, OTPC_STAT_CMD_DONE);
> +		if (ret) {
> +			dev_err(priv->dev, "otp read error: 0x%x", ret);
> +			return -EIO;
> +		}
> +
> +		for (i = 0; i < priv->map->otpc_row_size; i++) {
> +			*buf++ = readl(priv->base +
> +					priv->map->data_r_offset[i]);
> +			bytes_read += sizeof(*buf);
> +		}
> +
> +		reset_start_bit(priv->base);
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm_otpc_write(void *context, unsigned int offset, void *val,
> +	size_t bytes)
> +{
> +	struct otpc_priv *priv = context;
> +	u32 *buf = val;
> +	u32 bytes_written;
> +	u32 address = offset / priv->config->word_size;
> +	int i, ret;
> +
> +	if (offset % priv->config->word_size)
> +		return -EINVAL;
> +
> +	ret = enable_ocotp_program(priv->base);
> +	if (ret)
> +		return -EIO;
> +
> +	for (bytes_written = 0; bytes_written < bytes;) {
> +		set_command(priv->base, OTPC_CMD_PROGRAM);
> +		set_cpu_address(priv->base, address++);
> +		for (i = 0; i < priv->map->otpc_row_size; i++) {
> +			writel(*buf, priv->base + priv->map->data_r_offset[i]);
> +			buf++;
> +			bytes_written += sizeof(*buf);
> +		}
> +		set_start_bit(priv->base);
> +		ret = poll_cpu_status(priv->base, OTPC_STAT_CMD_DONE);
> +		reset_start_bit(priv->base);
> +		if (ret) {
> +			dev_err(priv->dev, "otp write error: 0x%x", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	disable_ocotp_program(priv->base);
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config bcm_otpc_nvmem_config = {
> +	.name = "bcm-ocotp",
> +	.read_only = false,
> +	.word_size = 4,
> +	.stride = 4,
> +	.owner = THIS_MODULE,
> +	.reg_read = bcm_otpc_read,
> +	.reg_write = bcm_otpc_write,
> +};
> +
> +static const struct of_device_id bcm_otpc_dt_ids[] = {
> +	{ .compatible = "brcm,ocotp" },
> +	{ .compatible = "brcm,ocotp-v2" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
> +
> +static int bcm_otpc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node;
> +	struct resource *res;
> +	struct otpc_priv *priv;
> +	struct nvmem_device *nvmem;
> +	int err;
> +	u32 num_words;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_device_is_compatible(dev->of_node, "brcm,ocotp"))
> +		priv->map = &otp_map;
> +	else if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2"))
> +		priv->map = &otp_map_v2;
> +	else {
> +		dev_err(&pdev->dev,
> +			"%s otpc config map not defined\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/* Get OTP base address register. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base)) {
> +		dev_err(dev, "unable to map I/O memory\n");
> +		return PTR_ERR(priv->base);
> +	}
> +
> +	/* Enable CPU access to OTPC. */
> +	writel(readl(priv->base + OTPC_MODE_REG_OFFSET) |
> +		BIT(OTPC_MODE_REG_OTPC_MODE),
> +		priv->base + OTPC_MODE_REG_OFFSET);
> +	reset_start_bit(priv->base);
> +
> +	/* Read size of memory in words. */
> +	err = of_property_read_u32(dn, "brcm,ocotp-size", &num_words);
> +	if (err) {
> +		dev_err(dev, "size parameter not specified\n");
> +		return -EINVAL;
> +	} else if (num_words == 0) {
> +		dev_err(dev, "size must be > 0\n");
> +		return -EINVAL;
> +	}
> +
> +	bcm_otpc_nvmem_config.size = 4 * num_words;
> +	bcm_otpc_nvmem_config.dev = dev;
> +	bcm_otpc_nvmem_config.priv = priv;
> +
> +	if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2")) {
> +		bcm_otpc_nvmem_config.word_size = 8;
> +		bcm_otpc_nvmem_config.stride = 8;
> +	}
> +
> +	priv->config = &bcm_otpc_nvmem_config;
> +
> +	nvmem = nvmem_register(&bcm_otpc_nvmem_config);
> +	if (IS_ERR(nvmem)) {
> +		dev_err(dev, "error registering nvmem config\n");
> +		return PTR_ERR(nvmem);
> +	}
> +
> +	platform_set_drvdata(pdev, nvmem);
> +
> +	return 0;
> +}
> +
> +static int bcm_otpc_remove(struct platform_device *pdev)
> +{
> +	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
> +
> +	return nvmem_unregister(nvmem);
> +}
> +
> +static struct platform_driver bcm_otpc_driver = {
> +	.probe	= bcm_otpc_probe,
> +	.remove	= bcm_otpc_remove,
> +	.driver = {
> +		.name	= "brcm-otpc",
> +		.of_match_table = bcm_otpc_dt_ids,
> +	},
> +};
> +module_platform_driver(bcm_otpc_driver);
> +
> +MODULE_DESCRIPTION("Broadcom OTPC driver");
> +MODULE_LICENSE("GPL v2");
>
