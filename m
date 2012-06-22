From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Jun 2012 14:04:56 +0800
Subject: [PATCH 4/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <1339681407-28721-5-git-send-email-s.hauer@pengutronix.de>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120622060454.GF21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:43:26PM +0200, Sascha Hauer wrote:
...
> +#include <linux/module.h>
> +#include <linux/export.h>
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/list.h>
> +#include <linux/irq.h>
> +#include <mach/common.h>

This seems not needed at all.

> +#include <drm/imx-ipu-v3.h>
> +#include <linux/of_device.h>
> +#include <asm/mach/irq.h>

...

> +void ipu_ch_param_set_field(struct ipu_ch_param __iomem *base, u32 wbs, u32 v)

Rename it to ipu_ch_param_write_field ...

> +{
> +	u32 bit = (wbs >> 8) % 160;
> +	u32 size = wbs & 0xff;
> +	u32 word = (wbs >> 8) / 160;
> +	u32 i = bit / 32;
> +	u32 ofs = bit % 32;
> +	u32 mask = (1 << size) - 1;
> +	u32 val;
> +
> +	pr_debug("%s %d %d %d\n", __func__, word, bit , size);
> +
> +	val = readl(&base->word[word].data[i]);
> +	val &= ~(mask << ofs);
> +	val |= v << ofs;
> +	writel(val, &base->word[word].data[i]);
> +
> +	if ((bit + size - 1) / 32 > i) {
> +		val = readl(&base->word[word].data[i + 1]);
> +		val &= ~(mask >> (mask ? (32 - ofs) : 0));
> +		val |= v >> (ofs ? (32 - ofs) : 0);
> +		writel(val, &base->word[word].data[i + 1]);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ipu_ch_param_set_field);
> +
> +u32 ipu_ch_param_read_field(struct ipu_ch_param __iomem *base, u32 wbs)

... or rename this to ipu_ch_param_get_field for a better couple?

> +{
> +	u32 bit = (wbs >> 8) % 160;
> +	u32 size = wbs & 0xff;
> +	u32 word = (wbs >> 8) / 160;
> +	u32 i = bit / 32;
> +	u32 ofs = bit % 32;
> +	u32 mask = (1 << size) - 1;
> +	u32 val = 0;
> +
> +	pr_debug("%s %d %d %d\n", __func__, word, bit , size);
> +
> +	val = (readl(&base->word[word].data[i]) >> ofs) & mask;
> +
> +	if ((bit + size - 1) / 32 > i) {
> +		u32 tmp;
> +		tmp = readl(&base->word[word].data[i + 1]);
> +		tmp &= mask >> (ofs ? (32 - ofs) : 0);
> +		val |= tmp << (ofs ? (32 - ofs) : 0);
> +	}
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(ipu_ch_param_read_field);

...

> +static int ipu_reset(struct ipu_soc *ipu)
> +{
> +	int timeout = 10000;

We may want to use a better timeout mechanism.

> +
> +	ipu_cm_write(ipu, 0x807FFFFF, IPU_MEM_RST);
> +
> +	while (ipu_cm_read(ipu, IPU_MEM_RST) & 0x80000000) {
> +		if (!timeout--)
> +			return -ETIME;
> +		udelay(100);
> +	}
> +
> +	mdelay(300);
> +
> +	return 0;
> +}

...

> +static int ipu_irq_init(struct ipu_soc *ipu)
> +{
> +	int i;
> +
> +	ipu->irq_start = irq_alloc_descs(-1, 0, IPU_NUM_IRQS, 0);

We may want to give a try on linear irqdomain, so that irqdesc will
only be allocated for those in-use irqs, and we do not have to maintain
irq_base.

> +	if (ipu->irq_start < 0)
> +		return ipu->irq_start;
> +
> +	for (i = ipu->irq_start; i < ipu->irq_start + IPU_NUM_IRQS; i++) {
> +		irq_set_chip_and_handler(i, &ipu_irq_chip, handle_level_irq);
> +		set_irq_flags(i, IRQF_VALID);
> +		irq_set_chip_data(i, ipu);
> +	}
> +
> +	irq_set_chained_handler(ipu->irq_sync, ipu_irq_handler);
> +	irq_set_handler_data(ipu->irq_sync, ipu);
> +	irq_set_chained_handler(ipu->irq_err, ipu_err_irq_handler);
> +	irq_set_handler_data(ipu->irq_err, ipu);
> +
> +	return 0;
> +}

...

> +static int __devinit ipu_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_id =
> +			of_match_device(imx_ipu_dt_ids, &pdev->dev);
> +	struct ipu_soc *ipu;
> +	struct resource *res;
> +	unsigned long ipu_base;
> +	int i, ret, irq_sync, irq_err;
> +	struct ipu_devtype *devtype;
> +
> +	devtype = of_id->data;
> +
> +	dev_info(&pdev->dev, "Initializing %s\n", devtype->name);
> +
> +	irq_sync = platform_get_irq(pdev, 0);
> +	irq_err = platform_get_irq(pdev, 1);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	dev_info(&pdev->dev, "irq_sync: %d irq_err: %d\n",
> +			irq_sync, irq_err);
> +
> +	if (!res || irq_sync < 0 || irq_err < 0)
> +		return -ENODEV;
> +
> +	ipu_base = res->start;
> +
> +	ipu = devm_kzalloc(&pdev->dev, sizeof(*ipu), GFP_KERNEL);
> +	if (!ipu)
> +		return -ENODEV;
> +
> +	for (i = 0; i < 64; i++)
> +		ipu->channel[i].ipu = ipu;
> +	ipu->devtype = devtype;
> +	ipu->ipu_type = devtype->type;
> +
> +	spin_lock_init(&ipu->lock);
> +	mutex_init(&ipu->channel_lock);
> +
> +	dev_info(&pdev->dev, "cm_reg:   0x%08lx\n",
> +			ipu_base + devtype->cm_ofs);
> +	dev_info(&pdev->dev, "idmac:    0x%08lx\n",
> +			ipu_base + devtype->cm_ofs + IPU_CM_IDMAC_REG_OFS);
> +	dev_info(&pdev->dev, "cpmem:    0x%08lx\n",
> +			ipu_base + devtype->cpmem_ofs);
> +	dev_info(&pdev->dev, "disp0:    0x%08lx\n",
> +			ipu_base + devtype->disp0_ofs);
> +	dev_info(&pdev->dev, "disp1:    0x%08lx\n",
> +			ipu_base + devtype->disp1_ofs);
> +	dev_info(&pdev->dev, "srm:      0x%08lx\n",
> +			ipu_base + devtype->srm_ofs);
> +	dev_info(&pdev->dev, "tpm:      0x%08lx\n",
> +			ipu_base + devtype->tpm_ofs);
> +	dev_info(&pdev->dev, "dc:       0x%08lx\n",
> +			ipu_base + devtype->cm_ofs + IPU_CM_DC_REG_OFS);
> +	dev_info(&pdev->dev, "ic:       0x%08lx\n",
> +			ipu_base + devtype->cm_ofs + IPU_CM_IC_REG_OFS);
> +	dev_info(&pdev->dev, "dmfc:     0x%08lx\n",
> +			ipu_base + devtype->cm_ofs + IPU_CM_DMFC_REG_OFS);
> +
> +	ipu->cm_reg = devm_ioremap(&pdev->dev,
> +			ipu_base + devtype->cm_ofs, PAGE_SIZE);
> +	ipu->idmac_reg = devm_ioremap(&pdev->dev,
> +			ipu_base + devtype->cm_ofs + IPU_CM_IDMAC_REG_OFS,
> +			PAGE_SIZE);
> +	ipu->cpmem_base = devm_ioremap(&pdev->dev,
> +			ipu_base + devtype->cpmem_ofs, PAGE_SIZE);
> +
> +	if (!ipu->cm_reg || !ipu->idmac_reg || !ipu->cpmem_base) {
> +		ret = -ENOMEM;
> +		goto failed_ioremap;
> +	}
> +
> +	ipu->clk = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(ipu->clk)) {
> +		ret = PTR_ERR(ipu->clk);
> +		dev_err(&pdev->dev, "clk_get failed with %d", ret);
> +		goto failed_clk_get;
> +	}
> +
> +	platform_set_drvdata(pdev, ipu);
> +
> +	clk_prepare_enable(ipu->clk);
> +
> +	ipu->dev = &pdev->dev;
> +	ipu->irq_sync = irq_sync;
> +	ipu->irq_err = irq_err;
> +
> +	ret = ipu_irq_init(ipu);
> +	if (ret)
> +		goto out_failed_irq;
> +
> +	ipu_reset(ipu);
> +
> +	/* Set MCU_T to divide MCU access window into 2 */
> +	ipu_cm_write(ipu, 0x00400000L | (IPU_MCU_T_DEFAULT << 18),
> +			IPU_DISP_GEN);
> +
> +	ret = ipu_submodules_init(ipu, pdev, ipu_base, ipu->clk);
> +	if (ret)
> +		goto failed_submodules_init;
> +
> +	ret = ipu_add_client_devices(ipu);
> +	if (ret) {
> +		dev_err(&pdev->dev, "adding client devices failed with %d\n",
> +				ret);
> +		goto failed_add_clients;
> +	}
> +
> +	return 0;
> +
> +failed_add_clients:
> +	ipu_submodules_exit(ipu);
> +failed_submodules_init:
> +	ipu_irq_exit(ipu);
> +out_failed_irq:

clk_disable_unprepare(ipu->clk);

> +failed_clk_get:
> +failed_ioremap:
> +	return ret;
> +}

-- 
Regards,
Shawn
