From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 02 May 2014 19:39:01 +0200
Subject: [PATCH v5 3/4] usb: ohci-exynos: Add facility to use phy provided
 by the generic phy framework
In-Reply-To: <1399034855-9686-4-git-send-email-gautam.vivek@samsung.com>
References: <1399034855-9686-1-git-send-email-gautam.vivek@samsung.com>
 <1399034855-9686-4-git-send-email-gautam.vivek@samsung.com>
Message-ID: <5363D835.7010804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

This looks much better, but there still are some issues. Please see my 
comments inline.

On 02.05.2014 14:47, Vivek Gautam wrote:
> Add support to consume phy provided by Generic phy framework.
> Keeping the support for older usb-phy intact right now, in order
> to prevent any functionality break in absence of relevant
> device tree side change for ohci-exynos.
> Once we move to new phy in the device nodes for ohci, we can
> remove the support for older phys.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>
> Changes from v4:
>   - Removed 'phy-names' property from the bindings since we don't need it.
>   - Restructured exynos_ohci_get_phy() function to handle error codes as
>     well as return relevant error codes effectively.
>   - Added IS_ERR() check for PHYs in exynos_ohci_phy_enable()/disable().
>
> Changes from v3:
>   - Calling usb_phy_shutdown() when exynos_ohci_phy_enable() is failing.
>   - Made exynos_ohci_phy_disable() return void, since its return value
>     did not serve any purpose.
>   - Calling clk_disable_unprepare() in exynos_ohci_resume() when
>     exynos_ohci_phy_enable() is failed.
>
>   .../devicetree/bindings/usb/exynos-usb.txt         |   16 +++
>   drivers/usb/host/ohci-exynos.c                     |  120 +++++++++++++++++---
>   2 files changed, 120 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> index d967ba1..49a9c6f 100644
> --- a/Documentation/devicetree/bindings/usb/exynos-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -38,6 +38,13 @@ Required properties:
>    - interrupts: interrupt number to the cpu.
>    - clocks: from common clock binding: handle to usb clock.
>    - clock-names: from common clock binding: Shall be "usbhost".
> + - port: if in the SoC there are OHCI phys, they should be listed here.
> +   One phy per port. Each port should have following entries:
> +	- reg: port number on OHCI controller, e.g
> +	       On Exynos5250, port 0 is USB2.0 otg phy
> +			      port 1 is HSIC phy0
> +			      port 2 is HSIC phy1
> +	- phys: from the *Generic PHY* bindings, specifying phy used by port.
>
>   Example:
>   	usb at 12120000 {
> @@ -47,6 +54,15 @@ Example:
>
>   		clocks = <&clock 285>;
>   		clock-names = "usbhost";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port at 0 {
> +		    reg = <0>;
> +		    phys = <&usb2phy 1>;
> +		    status = "disabled";
> +		};
> +
>   	};
>
>   DWC3
> diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> index 05f00e3..e66d391 100644
> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -18,6 +18,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>   #include <linux/usb/phy.h>
>   #include <linux/usb/samsung_usb_phy.h>
>   #include <linux/usb.h>
> @@ -33,28 +34,112 @@ static struct hc_driver __read_mostly exynos_ohci_hc_driver;
>
>   #define to_exynos_ohci(hcd) (struct exynos_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
>
> +#define PHY_NUMBER 3
> +
>   struct exynos_ohci_hcd {
>   	struct clk *clk;
>   	struct usb_phy *phy;
>   	struct usb_otg *otg;
> +	struct phy *phy_g[PHY_NUMBER];
>   };
>
> -static void exynos_ohci_phy_enable(struct device *dev)
> +static int exynos_ohci_get_phy(struct device *dev,
> +				struct exynos_ohci_hcd *exynos_ohci)
> +{
> +	struct device_node *child;
> +	struct phy *phy;
> +	int phy_number;
> +	int ret = 0;
> +
> +	exynos_ohci->phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (IS_ERR(exynos_ohci->phy)) {
> +		ret = PTR_ERR(exynos_ohci->phy);
> +		if (ret != -ENXIO && ret != -ENODEV) {
> +			dev_err(dev, "no usb2 phy configured\n");
> +			return ret;
> +		}
> +		dev_dbg(dev, "Failed to get usb2 phy\n");
> +		exynos_ohci->phy = ERR_PTR(-ENODEV);

Here you already have exynos_ohci->phy set to an ERR_PTR() value, which 
was returned by devm_usb_get_phy(). There is no need to overwrite it.

> +	} else {
> +		exynos_ohci->otg = exynos_ohci->phy->otg;
> +	}
> +
> +	/*
> +	 * Getting generic phy:
> +	 * We are keeping both types of phys as a part of transiting OHCI
> +	 * to generic phy framework, so as to maintain backward compatibilty
> +	 * with old DTB.
> +	 * If there are existing devices using DTB files built from them,
> +	 * to remove the support for old bindings in this driver,
> +	 * we need to make sure that such devices have their DTBs
> +	 * updated to ones built from new DTS.
> +	 */
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		ret = of_property_read_u32(child, "reg", &phy_number);
> +		if (ret) {
> +			dev_err(dev, "Failed to parse device tree\n");
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		if (phy_number >= PHY_NUMBER) {
> +			dev_err(dev, "Invalid number of PHYs\n");
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +
> +		phy = devm_of_phy_get(dev, child, 0);
> +		of_node_put(child);
> +		if (IS_ERR(phy)) {
> +			ret = PTR_ERR(phy);
> +			if (ret != -ENXIO && ret != -ENODEV) {

Shouldn't this be -ENOSYS instead of -ENXIO? At least this is the error 
code I can see in the stubs provided in include/linux/phy/phy.h.

> +				dev_err(dev, "no usb2 phy configured\n");
> +				return ret;
> +			}
> +			dev_dbg(dev, "Failed to get usb2 phy\n");
> +			phy = ERR_PTR(-ENODEV);

phy is already an ERR_PTR() here, as returned by devm_of_phy_get().

I guess the same comments apply to patch 4/4.

Best regards,
Tomasz
