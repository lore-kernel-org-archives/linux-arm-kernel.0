From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 19 Oct 2015 14:02:27 +0800
Subject: [PATCH v10 2/3] xhci: mediatek: support MTK xHCI host controller
In-Reply-To: <1445140279-18121-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1445140279-18121-1-git-send-email-chunfeng.yun@mediatek.com>
 <1445140279-18121-3-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1445234547.28324.17.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-10-18 at 11:51 +0800, Chunfeng Yun wrote:
> There some vendor quirks for MTK xhci host controller:
> 1. It defines some extra SW scheduling parameters for HW
>   to minimize the scheduling effort for synchronous and
>   interrupt endpoints. The parameters are put into reseved
>   DWs of slot context and endpoint context.
> 2. Its IMODI unit for Interrupter Moderation register is
>   8 times as much as that defined in xHCI spec.
> 3. Its TDS in  Normal TRB defines a number of packets that
>   remains to be transferred for a TD after processing all
>   Max packets in all previous TRBs.
...
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/usb/phy.h>
> +#include <linux/usb/xhci_pdriver.h>
above three header files no need anymore

> +
> +#include "xhci.h"
> +#include "xhci-mtk.h"
> +
> +/* ip_pw_ctrl0 register */
> +#define CTRL0_IP_SW_RST	BIT(0)
> +
> +/* ip_pw_ctrl1 register */
> +#define CTRL1_IP_HOST_PDN	BIT(0)
> +
...
> +/* called during probe() after chip reset completes */
> +static int xhci_mtk_setup(struct usb_hcd *hcd)
> +{
> +	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
> +	int ret;
> +
> +	if (usb_hcd_is_primary_hcd(hcd)) {
> +		ret = xhci_mtk_ssusb_config(mtk);
> +		if (ret)
> +			return ret;
> +		ret = xhci_mtk_sch_init(mtk);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return xhci_gen_setup(hcd, xhci_mtk_quirks);
> +}
> +
> +static int xhci_mtk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct xhci_hcd_mtk *mtk;
> +	const struct hc_driver *driver;
> +	struct xhci_hcd *xhci;
> +	struct resource *res;
> +	struct usb_hcd *hcd;
> +	struct phy *phy;
> +	int phy_num;
> +	int ret = -ENODEV;
...
> +
> +	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> +		xhci->shared_hcd->can_do_streams = 1;
> +
> +	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
> +	if (ret)
> +		goto put_usb3_hcd;
> +
> +	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> +	if (ret)
> +		goto dealloc_usb2_hcd;
> +
> +	return 0;
> +
> +dealloc_usb2_hcd:
> +	xhci_mtk_sch_exit(mtk);
> +	usb_remove_hcd(hcd);
> +
> +put_usb3_hcd:
> +	usb_put_hcd(xhci->shared_hcd);
need call xhci_mtk_sch_exit() for some fail cases

> +
> +power_off_phys:
> +	xhci_mtk_phy_power_off(mtk);
> +	device_init_wakeup(dev, 0);
use false instead of 0

> +
> +exit_phys:
> +	xhci_mtk_phy_exit(mtk);
> +
> +put_usb2_hcd:
> +	usb_put_hcd(hcd);
> +
> +disable_clk:
> +	xhci_mtk_clks_disable(mtk);
> +
> +disable_ldos:
> +	xhci_mtk_ldos_disable(mtk);
> +
> +disable_pm:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +
> +static int xhci_mtk_remove(struct platform_device *dev)
> +{
> +	struct xhci_hcd_mtk *mtk = platform_get_drvdata(dev);
> +	struct usb_hcd	*hcd = mtk->hcd;
> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +
> +	usb_remove_hcd(xhci->shared_hcd);
> +	xhci_mtk_phy_power_off(mtk);
> +	xhci_mtk_phy_exit(mtk);
> +	device_init_wakeup(&dev->dev, 0);
use false instead of 0

I will send v11 to fix up the problems caused by my carelessness.

Sorry.

> +
> +	usb_remove_hcd(hcd);
> +	usb_put_hcd(xhci->shared_hcd);
> +	usb_put_hcd(hcd);
> +	xhci_mtk_sch_exit(mtk);
> +	xhci_mtk_clks_disable(mtk);
> +	xhci_mtk_ldos_disable(mtk);
> +	pm_runtime_put_sync(&dev->dev);
> +	pm_runtime_disable(&dev->dev);
> +
> +	return 0;
> +}
> +
