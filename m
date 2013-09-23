From: rogerq@ti.com (Roger Quadros)
Date: Mon, 23 Sep 2013 16:11:30 +0300
Subject: [PATCH v7 09/10] usb: dwc3: omap: manage "usb_otg_ss_refclk960m"
 clock
In-Reply-To: <1379508542-22389-10-git-send-email-rogerq@ti.com>
References: <1379508542-22389-1-git-send-email-rogerq@ti.com>
 <1379508542-22389-10-git-send-email-rogerq@ti.com>
Message-ID: <52403E02.4070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On 09/18/2013 03:49 PM, Roger Quadros wrote:
> "usb_otg_ss_refclk960m" is an optional functional clock to the
> UBS_OTG_SS module. So manage it in the driver.
> 

Just realized that "usb_otg_ss_refclk960m" is in fact functional clock to the 
PHY and not USB_OTG_SS module. The name is misleading.

So please ignore patch 9 and 10.

cheers,
-roger


> Also update device tree binding information.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt |    4 ++++
>  drivers/usb/dwc3/dwc3-omap.c                       |   13 +++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index f67573c..47c8530 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -47,6 +47,8 @@ OMAP DWC3 GLUE
>   - #address-cells, #size-cells : Must be present if the device has sub-nodes
>   - utmi-mode : controls the source of UTMI/PIPE status for VBUS and OTG ID.
>     It should be set to "1" for HW mode and "2" for SW mode.
> + - clock : should refer to the clock node that provides 960MHz functional clock.
> + - clock-names : should be "usb_otg_ss_refclk960m"
>   - ranges: the child address space are mapped 1:1 onto the parent address space
>  
>  Optional Properties:
> @@ -68,6 +70,8 @@ omap_dwc3 {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  	utmi-mode = <2>;
> +	clocks = <&usb_otg_ss1_refclk960m>;
> +	clock-names = "usb_otg_ss_refclk960m";
>  	ranges;
>  };
>  
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 7f7ea62..c33b26c 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -32,6 +32,7 @@
>  #include <linux/extcon.h>
>  #include <linux/extcon/of_extcon.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/clk.h>
>  
>  #include <linux/usb/otg.h>
>  
> @@ -119,6 +120,8 @@
>  #define USBOTGSS_UTMI_OTG_STATUS_SESSVALID	(1 << 2)
>  #define USBOTGSS_UTMI_OTG_STATUS_VBUSVALID	(1 << 1)
>  
> +#define USBOTGSS_REFCLK "usb_otg_ss_refclk960m"
> +
>  struct dwc3_omap {
>  	/* device lock */
>  	spinlock_t		lock;
> @@ -144,6 +147,7 @@ struct dwc3_omap {
>  	struct notifier_block	id_nb;
>  
>  	struct regulator	*vbus_reg;
> +	struct clk		*refclk;
>  };
>  
>  enum omap_dwc3_vbus_id_status {
> @@ -449,6 +453,12 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	omap->refclk = devm_clk_get(dev, USBOTGSS_REFCLK);
> +	if (IS_ERR(omap->refclk)) {
> +		dev_err(dev, "couldn't get %s\n", USBOTGSS_REFCLK);
> +		return PTR_ERR(omap->refclk);
> +	}
> +
>  	spin_lock_init(&omap->lock);
>  
>  	omap->dev	= dev;
> @@ -464,6 +474,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  		goto err0;
>  	}
>  
> +	clk_prepare_enable(omap->refclk);
> +
>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_REVISION);
>  	omap->revision = reg;
>  	x_major = USBOTGSS_REVISION_XMAJOR(reg);
> @@ -593,6 +605,7 @@ static int dwc3_omap_remove(struct platform_device *pdev)
>  		extcon_unregister_interest(&omap->extcon_id_dev);
>  	dwc3_omap_disable_irqs(omap);
>  	pm_runtime_put_sync(&pdev->dev);
> +	clk_disable_unprepare(omap->refclk);
>  	pm_runtime_disable(&pdev->dev);
>  	device_for_each_child(&pdev->dev, NULL, dwc3_omap_remove_core);
>  
> 
