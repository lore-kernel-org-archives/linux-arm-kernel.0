From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Jun 2011 12:25:07 +0300
Subject: [RFC][PATCH 1/5] USB: DWC OTG: Modification in DWC OTG driver
	for ARM based SoCs.
In-Reply-To: <1308639827-2121-2-git-send-email-p.paneri@samsung.com>
References: <1308639827-2121-1-git-send-email-p.paneri@samsung.com>
	<1308639827-2121-2-git-send-email-p.paneri@samsung.com>
Message-ID: <20110621092506.GK28225@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 21, 2011 at 12:33:43PM +0530, p.paneri at samsung.com wrote:
> From: Praveen Paneri <p.paneri@samsung.com>
> 
> This patch modifies DWC OTG for ARM based SoCs. Currently it has
> been tested for Samsung S5P6440. Can easily be built for others
> as well.
> 
> Following features are tested for basic functions on SMDK6440
> board after modifications:
> OTG HOST: HID and mass-storage
> OTG DEVICE: mass-storage and adb
> 
> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>

this is wrong is so many levels... We shouldn't be adding ifdefs to
allow the driver to be compiled for multiple architectures. The correct
way to handle this, is to phase out the core driver from the SoC- or
PCI-specific parts and make that a glue layer that bridges to the core
driver.

I'm writing the driver for a similar core, the DWC USB3, take a look at
my dwc3 branch [1] to see how this should be done.

> diff --git a/drivers/usb/dwc/apmppc.c b/drivers/usb/dwc/apmppc.c
> index ffbe6dd..b0dcae9 100644
> --- a/drivers/usb/dwc/apmppc.c
> +++ b/drivers/usb/dwc/apmppc.c
> @@ -50,9 +50,6 @@
>   * this file system to perform diagnostics on the driver components or the
>   * device.
>   */
> -
> -#include <linux/of_platform.h>
> -
>  #include "driver.h"
>  
>  #define DWC_DRIVER_VERSION		"1.05"
> @@ -110,6 +107,9 @@ static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev)
>  {
>  	struct device *dev = &ofdev->dev;
>  	struct dwc_otg_device *dwc_dev = dev_get_drvdata(dev);
> +#ifdef CONFIG_CPU_S5P6440
> +	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
> +#endif

NAK

> @@ -152,6 +152,11 @@ static int __devexit dwc_otg_driver_remove(struct platform_device *ofdev)
>  
>  	/* Clear the drvdata pointer. */
>  	dev_set_drvdata(dev, NULL);
> +#ifdef CONFIG_CPU_S5P6440
> +	/* OTG Phy off */
> +	if (pdata && pdata->phy_exit)
> +		pdata->phy_exit(ofdev, S5P_USB_PHY_DEVICE);
> +#endif

NAK

> @@ -169,12 +174,14 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>  	int retval;
>  	struct dwc_otg_device *dwc_dev;
>  	struct device *dev = &ofdev->dev;
> +#ifdef CONFIG_CPU_S5P6440
> +	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
> +#endif

NAK

> @@ -182,15 +189,24 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>  		goto fail_dwc_dev;
>  	}
>  
> +#ifdef CONFIG_CPU_S5P6440
> +	/* OTG Phy init */
> +	if (pdata && pdata->phy_init)
> +		pdata->phy_init(ofdev, S5P_USB_PHY_DEVICE);
> +#endif
>  	/* Retrieve the memory and IRQ resources. */
> +#ifdef CONFIG_ARM
> +	dwc_dev->irq = ofdev->resource[1].start;
> +#else
>  	dwc_dev->irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +#endif

NAK

> +#ifndef CONFIG_ARM

NAK

> @@ -200,8 +216,14 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>  	dev_dbg(dev, "OTG - ioresource_mem start0x%llx: end:0x%llx\n",
>  		(unsigned long long)res.start, (unsigned long long)res.end);
>  
> +
>  	dwc_dev->phys_addr = res.start;
>  	dwc_dev->base_len = res.end - res.start + 1;
> +#else
> +	dwc_dev->phys_addr = ofdev->resource[0].start;
> +	dwc_dev->base_len = ofdev->resource[0].end -
> +				ofdev->resource[0].start + 1;
> +#endif

NAK

> @@ -296,6 +318,7 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>  			dwc_dev->hcd = NULL;
>  			goto fail_hcd;
>  		}
> +#ifndef CONFIG_ARM

NAK

> @@ -316,6 +339,7 @@ static int __devinit dwc_otg_driver_probe(struct platform_device *ofdev)
>  				dwc_dev->hcd->cp_irq_installed = 1;
>  			}
>  		}
> +#endif

NAK

> diff --git a/drivers/usb/dwc/cil.h b/drivers/usb/dwc/cil.h
> index 80b7da5..c1a11f1 100644
> --- a/drivers/usb/dwc/cil.h
> +++ b/drivers/usb/dwc/cil.h
> @@ -37,6 +37,15 @@
>  #if !defined(__DWC_CIL_H__)
>  #define __DWC_CIL_H__
>  #include <linux/io.h>
> +#ifdef CONFIG_ARM
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <plat/otg.h>
> +#include <plat/usb-phy.h>
> +#else
> +#include <linux/of_platform.h>
> +#endif

I can't even say how ugly this is.

> diff --git a/drivers/usb/dwc/param.c b/drivers/usb/dwc/param.c
> index 523f0db..b48c510 100644
> --- a/drivers/usb/dwc/param.c
> +++ b/drivers/usb/dwc/param.c
> @@ -116,8 +116,12 @@ static int set_valid_tx_fifo_sizes(struct core_if *core_if)
>   * This function is called during module intialization to verify that
>   * the module parameters are in a valid state.
>   */
> -int __devinit check_parameters(struct core_if *core_if)
> +int __devinit check_parameters(struct core_if *core_if,
> +						struct platform_device *ofdev)
>  {
> +#ifdef CONFIG_CPU_S5P6440
> +	struct s5p_otg_platdata *pdata = ofdev->dev.platform_data;
> +#endif

NAK.

> @@ -145,6 +149,23 @@ int __devinit check_parameters(struct core_if *core_if)
>  	 */
>  	dwc_otg_module_params.enable_dynamic_fifo =
>  	    DWC_HWCFG2_DYN_FIFO_RD(core_if->hwcfg2);
> +#ifdef CONFIG_CPU_S5P6440
> +	if (pdata && pdata->dev_rx_fifo_size)
> +		dwc_otg_module_params.dev_rx_fifo_size =
> +						pdata->dev_rx_fifo_size;
> +	if (pdata && pdata->dev_nptx_fifo_size)
> +		dwc_otg_module_params.dev_nperio_tx_fifo_size =
> +						pdata->dev_nptx_fifo_size;
> +
> +	if (pdata && pdata->host_rx_fifo_size)
> +		dwc_otg_module_params.host_rx_fifo_size =
> +						pdata->host_rx_fifo_size;
> +	if (pdata && pdata->host_nptx_fifo_size)
> +		dwc_otg_module_params.host_nperio_tx_fifo_size =
> +						pdata->host_nptx_fifo_size;
> +	if (pdata && pdata->host_ch_num)
> +		dwc_otg_module_params.host_channels = pdata->host_ch_num;
> +#else

then let's say another company licenses this core from Synopsys. Will
you add another pre-processor directive here ?


[1]
http://git.kernel.org/?p=linux/kernel/git/balbi/usb.git;a=tree;f=drivers/usb/dwc3;h=6ace38c51cfab18de3be257f86ae2c9afabf8237;hb=refs/heads/dwc3

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110621/1b834c42/attachment.sig>
