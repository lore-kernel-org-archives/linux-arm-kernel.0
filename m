From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 23 Jan 2018 15:12:36 +0200
Subject: [PATCH 2/4] usb: dwc3: add dwc3 glue layer for UniPhier SoCs
In-Reply-To: <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1516712454-2915-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1516712454-2915-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <87o9lklnwb.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Kunihiko Hayashi <hayashi.kunihiko@socionext.com> writes:
> Add a specific glue layer for UniPhier SoC platform to support
> USB host mode. It manages hardware operating sequences to enable multiple
> clock gates and assert resets, and to prepare to use dwc3 controller
> on the SoC.
>
> This patch also handles the physical layer that has same register space
> as the glue layer, because it needs to integrate initialziation sequence
> between glue and phy.
>
> In case of some SoCs, since some initialization values for PHY are
> included in nvmem, this patch includes the way to get the values from nvmem.
>
> It supports PXs2 and LD20 SoCs.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
> Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
> ---
>  drivers/usb/dwc3/Kconfig         |   9 +
>  drivers/usb/dwc3/Makefile        |   1 +
>  drivers/usb/dwc3/dwc3-uniphier.c | 554 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 564 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-uniphier.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index ab8c0e0..a5cadc6 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -106,4 +106,13 @@ config USB_DWC3_ST
>  	  inside (i.e. STiH407).
>  	  Say 'Y' or 'M' if you have one such device.
>  
> +config USB_DWC3_UNIPHIER
> +	tristate "Socionext UniPhier Platforms"
> +	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
> +	default USB_DWC3
> +	help
> +	  Support USB2/3 functionality in UniPhier platforms.
> +	  Say 'Y' or 'M' if your system that UniPhier SoC is implemented
> +	  has USB controllers based on DWC USB3 IP.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 7ac7250..31e82b3 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -48,3 +48,4 @@ obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
>  obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+= dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)		+= dwc3-st.o
> +obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
> diff --git a/drivers/usb/dwc3/dwc3-uniphier.c b/drivers/usb/dwc3/dwc3-uniphier.c
> new file mode 100644
> index 0000000..58e84cd
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-uniphier.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * dwc3-uniphier.c - Socionext UniPhier DWC3 specific glue layer
> + *
> + * Copyright 2015-2018 Socionext Inc.
> + *
> + * Author:
> + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + * Contributors:
> + *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
> + *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +#define RESET_CTL		0x000
> +#define LINK_RESET		BIT(15)
> +
> +#define VBUS_CONTROL(n)		(0x100 + 0x10 * (n))
> +#define DRVVBUS_REG		BIT(4)
> +#define DRVVBUS_REG_EN		BIT(3)
> +
> +#define U2PHY_CFG0(n)		(0x200 + 0x10 * (n))
> +#define U2PHY_CFG0_HS_I_MASK	GENMASK(31, 28)
> +#define U2PHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
> +#define U2PHY_CFG0_SWING_MASK	GENMASK(17, 16)
> +#define U2PHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
> +#define U2PHY_CFG0_RTERM_MASK	GENMASK(7, 6)
> +#define U2PHY_CFG0_TRIMMASK	(U2PHY_CFG0_HS_I_MASK \
> +				 | U2PHY_CFG0_SEL_T_MASK \
> +				 | U2PHY_CFG0_RTERM_MASK)
> +
> +#define U2PHY_CFG1(n)		(0x204 + 0x10 * (n))
> +#define U2PHY_CFG1_DAT_EN	BIT(29)
> +#define U2PHY_CFG1_ADR_EN	BIT(28)
> +#define U2PHY_CFG1_ADR_MASK	GENMASK(27, 16)
> +#define U2PHY_CFG1_DAT_MASK	GENMASK(23, 16)
> +
> +#define U3PHY_TESTI(n)		(0x300 + 0x10 * (n))
> +#define U3PHY_TESTO(n)		(0x304 + 0x10 * (n))
> +#define TESTI_DAT_MASK		GENMASK(13, 6)
> +#define TESTI_ADR_MASK		GENMASK(5, 1)
> +#define TESTI_WR_EN		BIT(0)
> +
> +#define HOST_CONFIG0		0x400
> +#define NUM_U3_MASK		GENMASK(13, 11)
> +#define NUM_U2_MASK		GENMASK(10, 8)
> +
> +#define PHY_MAX_PARAMS	32
> +
> +struct dwc3u_phy_param {
> +	u32 addr;
> +	u32 mask;
> +	u32 val;
> +};
> +
> +struct dwc3u_trim_param {
> +	u32 rterm;
> +	u32 sel_t;
> +	u32 hs_i;
> +};
> +
> +#define trim_param_is_valid(p)	((p)->rterm || (p)->sel_t || (p)->hs_i)
> +
> +struct dwc3u_priv {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct clk		**clks;
> +	int			nclks;
> +	struct reset_control	*rst;
> +	int			nvbus;
> +	const struct dwc3u_soc_data	*data;
> +};
> +
> +struct dwc3u_soc_data {
> +	int ss_nparams;
> +	struct dwc3u_phy_param ss_param[PHY_MAX_PARAMS];
> +	int hs_nparams;
> +	struct dwc3u_phy_param hs_param[PHY_MAX_PARAMS];
> +	u32 hs_config0;
> +	u32 hs_config1;
> +	void (*trim_func)(struct dwc3u_priv *priv, u32 *pconfig,
> +			  struct dwc3u_trim_param *trim);
> +};
> +
> +static inline u32 dwc3u_read(struct dwc3u_priv *priv, off_t offset)
> +{
> +	return readl(priv->base + offset);
> +}
> +
> +static inline void dwc3u_write(struct dwc3u_priv *priv,
> +			       off_t offset, u32 val)
> +{
> +	writel(val, priv->base + offset);
> +}
> +
> +static inline void dwc3u_maskwrite(struct dwc3u_priv *priv,
> +				   off_t offset, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = dwc3u_read(priv, offset);
> +	dwc3u_write(priv, offset, (tmp & ~mask) | (val & mask));
> +}
> +
> +static int dwc3u_get_hsport_num(struct dwc3u_priv *priv)
> +{
> +	return FIELD_GET(NUM_U2_MASK, dwc3u_read(priv, HOST_CONFIG0));
> +}
> +
> +static int dwc3u_get_ssport_num(struct dwc3u_priv *priv)
> +{
> +	return FIELD_GET(NUM_U3_MASK, dwc3u_read(priv, HOST_CONFIG0));
> +}
> +
> +static int dwc3u_get_nvparam(struct dwc3u_priv *priv,
> +			     const char *basename, int index, u8 *dst,
> +			     int maxlen)
> +{
> +	struct nvmem_cell *cell;
> +	char name[16];
> +	size_t len;
> +	u8 *buf;
> +
> +	snprintf(name, sizeof(name) - 1, "%s%d", basename, index);
> +	memset(dst, 0, maxlen);
> +
> +	cell = nvmem_cell_get(priv->dev, name);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	nvmem_cell_put(cell);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	len = min_t(u32, len, maxlen);
> +	memcpy(dst, buf, len);
> +	kfree(buf);
> +
> +	return 0;
> +}
> +
> +static int dwc3u_get_nvparam_u32(struct dwc3u_priv *priv,
> +				 const char *basename, int index, u32 *p_val)
> +{
> +	return dwc3u_get_nvparam(priv, basename, index, (u8 *)p_val,
> +				 sizeof(u32));
> +}
> +
> +static void dwc3u_ssphy_testio_write(struct dwc3u_priv *priv, int port,
> +				     u32 data)

anything with sshphy or hsphy in the name should probably be part of a
PHY driver using drivers/phy/ framework.

> +static void dwc3u_vbus_enable(struct dwc3u_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->nvbus; i++) {
> +		dwc3u_maskwrite(priv, VBUS_CONTROL(i),
> +				DRVVBUS_REG_EN | DRVVBUS_REG,
> +				DRVVBUS_REG_EN | DRVVBUS_REG);
> +	}
> +}
> +
> +static void dwc3u_vbus_disable(struct dwc3u_priv *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->nvbus; i++) {
> +		dwc3u_maskwrite(priv, VBUS_CONTROL(i),
> +				DRVVBUS_REG_EN | DRVVBUS_REG,
> +				DRVVBUS_REG_EN | 0);
> +	}
> +}

drivers/regulator maybe?

> +static void dwc3u_reset_init(struct dwc3u_priv *priv)
> +{
> +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> +	usleep_range(1000, 2000);
> +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, LINK_RESET);
> +}
> +
> +static void dwc3u_reset_clear(struct dwc3u_priv *priv)
> +{
> +	dwc3u_maskwrite(priv, RESET_CTL, LINK_RESET, 0);
> +}

drivers/reset ?

> +static int dwc3u_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node;
> +	struct dwc3u_priv *priv;
> +	struct resource	*res;
> +	struct clk *clk;
> +	int i, nr_clks;
> +	int ret = 0;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->data = of_device_get_match_data(dev);
> +	if (WARN_ON(!priv->data))
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->dev = dev;
> +
> +	node = dev->of_node;
> +	nr_clks = of_clk_get_parent_count(node);
> +	if (!nr_clks) {
> +		dev_err(dev, "failed to get clock property\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->clks = devm_kcalloc(priv->dev, nr_clks, sizeof(struct clk *),
> +				  GFP_KERNEL);
> +	if (!priv->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_clks; i++) {
> +		clk = of_clk_get(node, i);
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			goto out_clk_disable;
> +		}
> +		ret = clk_prepare_enable(clk);
> +		if (ret < 0) {
> +			clk_put(clk);
> +			goto out_clk_disable;
> +		}
> +		priv->clks[i] = clk;
> +		priv->nclks = i;
> +	}
> +
> +	priv->rst = devm_reset_control_array_get_optional_shared(priv->dev);
> +	if (IS_ERR(priv->rst)) {
> +		ret = PTR_ERR(priv->rst);
> +		goto out_clk_disable;
> +	}
> +	ret = reset_control_deassert(priv->rst);
> +	if (ret)
> +		goto out_clk_disable;
> +
> +	ret = dwc3u_init(priv);
> +	if (ret)
> +		goto out_rst_assert;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = of_platform_populate(node, NULL, NULL, priv->dev);
> +	if (ret)
> +		goto out_exit;

with the stuff that should be using generic frameworks removed, this
looks like dwc3-of-simple.c, which you should be using.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180123/23fdfc15/attachment.sig>
