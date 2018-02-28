From: rogerq@ti.com (Roger Quadros)
Date: Wed, 28 Feb 2018 13:01:40 +0200
Subject: [PATCH v3] usb: host: ehci-platform: add support for optional
 external vbus supply
In-Reply-To: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
References: <1519393611-31367-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <0d16deee-1fa9-322e-4d6d-b1b023f5b2b9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amelie,

On 23/02/18 15:46, Amelie Delaunay wrote:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for optional external vbus supply per port in ehci-platform.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> ---
> Changes in v3:
>  * Address Felipe Balbi comments: reduce indentation in
>    ehci_platform_port_power.
>  * Address Roger Quadros and Alan Stern comments: platforms can have one
>    external vbus supply per port, so add support to get as many optional
>    regulator as implemented ports on the host controller.
> 
> Changes in v2:
>  * Address Roger Quadros comments: move regulator_enable/disable from
>    ehci_platform_power_on/off to ehci_platform_port_power.
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>  drivers/usb/host/ehci-platform.c                   | 52 +++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..cd576db 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
>  
>  Example (Sequoia 440EPx):
>      ehci at e0000300 {

Sorry for not pointing this out earlier but I think patch to DT bindings
should come separately (before the driver changes) with the following subject.

"dt-bindings: usb: ehci: <subject>"


> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..8e9f201 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>  	struct reset_control *rsts;
>  	struct phy **phys;
>  	int num_phys;
> +	struct regulator **vbus_supplies;
>  	bool reset_on_resume;
>  };
>  
> @@ -56,7 +58,8 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	struct platform_device *pdev = to_platform_device(hcd->self.controller);
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -	int retval;
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int portnum, n_ports, retval;
>  
>  	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
>  
> @@ -71,11 +74,57 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	if (retval)
>  		return retval;
>  
> +	n_ports = HCS_N_PORTS(ehci->hcs_params);
> +	priv->vbus_supplies = devm_kcalloc(&pdev->dev, n_ports,
> +					   sizeof(struct regulator *),
> +					   GFP_KERNEL);
> +	if (!priv->vbus_supplies)
> +		return -ENOMEM;
> +
> +	for (portnum = 0; portnum < n_ports; portnum++) {
> +		struct regulator *vbus_supply;
> +		char id[20];
> +
> +		sprintf(id, "port%d_vbus", portnum);
> +
> +		vbus_supply = devm_regulator_get_optional(&pdev->dev, id);
> +		if (IS_ERR(vbus_supply)) {
> +			retval = PTR_ERR(vbus_supply);
> +			if (retval == -ENODEV)
> +				priv->vbus_supplies[portnum] = NULL;
> +			else
> +				return retval;
> +		} else {
> +			priv->vbus_supplies[portnum] = vbus_supply;
> +		}
> +	}
> +
>  	if (pdata->no_io_watchdog)
>  		ehci->need_io_watchdog = 0;
>  	return 0;
>  }
>  
> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> +				    bool enable)
> +{
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int ret;
> +
> +	if (!priv->vbus_supplies[portnum])
> +		return 0;
> +
> +	if (enable)
> +		ret = regulator_enable(priv->vbus_supplies[portnum]);
> +	else
> +		ret = regulator_disable(priv->vbus_supplies[portnum]);

A newline could be used here.

> +	if (ret)
> +		dev_err(hcd->self.controller,
> +			"failed to %s vbus supply for port %d: %d\n",
> +			enable ? "enable" : "disable", portnum, ret);
> +
> +	return ret;
> +}
> +
>  static int ehci_platform_power_on(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
> @@ -134,6 +183,7 @@ static struct hc_driver __read_mostly ehci_platform_hc_driver;
>  static const struct ehci_driver_overrides platform_overrides __initconst = {
>  	.reset =		ehci_platform_reset,
>  	.extra_priv_size =	sizeof(struct ehci_platform_priv),
> +	.port_power =		ehci_platform_port_power,
>  };
>  
>  static struct usb_ehci_pdata ehci_platform_defaults = {
> 

Otherwise, looks good to me. So,

Reviewed-by: Roger Quadros <rogerq@ti.com>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
