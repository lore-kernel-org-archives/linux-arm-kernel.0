From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Tue, 19 Jul 2011 15:17:24 +0530
Subject: [PATCH 2/3] USB: pxa168: Add onchip USB host controller support
In-Reply-To: <1310971931-4825-3-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1310971931-4825-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<1310971931-4825-3-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <4E2552AC.2090801@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 18 July 2011 12:22 PM, Tanmay Upadhyay wrote:
> - Add EHCI Host controller driver
> - Add wrapper that creates resources for host controller driver
>
> Signed-off-by: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
> ---
>   arch/arm/mach-mmp/include/mach/pxa168.h |    7 +
>   arch/arm/mach-mmp/pxa168.c              |   46 ++++
>   drivers/usb/Kconfig                     |    1 +
>   drivers/usb/host/Kconfig                |    7 +
>   drivers/usb/host/ehci-hcd.c             |    5 +
>   drivers/usb/host/ehci-pxa168.c          |  362 +++++++++++++++++++++++++++++++
>   6 files changed, 428 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/usb/host/ehci-pxa168.c
>
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 7f00584..7fb568d 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -35,6 +35,13 @@ extern struct pxa_device_desc pxa168_device_fb;
>   extern struct pxa_device_desc pxa168_device_keypad;
>   extern struct pxa_device_desc pxa168_device_eth;
>
> +struct pxa168_usb_pdata {
> +	/* If NULL, default phy init routine for PXA168 would be called */
> +	int (*phy_init)(void __iomem *usb_phy_reg_base);
> +};
> +/* pdata can be NULL */
> +int __init pxa168_add_usb_host(struct pxa168_usb_pdata *pdata);
> +
>   static inline int pxa168_add_uart(int id)
>   {
>   	struct pxa_device_desc *d = NULL;
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 2de96e8..80ff4ee 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -25,6 +25,9 @@
>   #include<mach/dma.h>
>   #include<mach/devices.h>
>   #include<mach/mfp.h>
> +#include<linux/platform_device.h>
> +#include<linux/dma-mapping.h>
> +#include<mach/pxa168.h>
>
>   #include "common.h"
>   #include "clock.h"
> @@ -83,6 +86,7 @@ static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
>   static APMU_CLK(nand, NAND, 0x01db, 208000000);
>   static APMU_CLK(lcd, LCD, 0x7f, 312000000);
>   static APMU_CLK(eth, ETH, 0x09, 0);
> +static APMU_CLK(usb, USB, 0x12, 0);
>
>   /* device and clock bindings */
>   static struct clk_lookup pxa168_clkregs[] = {
> @@ -104,6 +108,7 @@ static struct clk_lookup pxa168_clkregs[] = {
>   	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
>   	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
>   	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
> +	INIT_CLKREG(&clk_usb, "pxa168-ehci", "PXA168-USBCLK"),
>   };
>
>   static int __init pxa168_init(void)
> @@ -169,3 +174,44 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
>   PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
>   PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
>   PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
> +
> +struct resource pxa168_usb_host_resources[] = {
> +	/* USB Host conroller register base */
> +	[0] = {
> +		.start	= 0xd4209000,
> +		.end	= 0xd4209000 + 0x200,
> +		.flags	= IORESOURCE_MEM,
> +		.name	= "pxa168-usb-host",
> +	},
> +	/* USB PHY register base */
> +	[1] = {
> +		.start	= 0xd4206000,
> +		.end	= 0xd4206000 + 0xff,
> +		.flags	= IORESOURCE_MEM,
> +		.name	= "pxa168-usb-phy",
> +	},
> +	[2] = {
> +		.start	= IRQ_PXA168_USB2,
> +		.end	= IRQ_PXA168_USB2,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static u64 pxa168_usb_host_dmamask = DMA_BIT_MASK(32);
> +struct platform_device pxa168_device_usb_host = {
> +	.name = "pxa168-ehci",
> +	.id   = -1,
> +	.dev  = {
> +		.dma_mask =&pxa168_usb_host_dmamask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	},
> +
> +	.num_resources = ARRAY_SIZE(pxa168_usb_host_resources),
> +	.resource      = pxa168_usb_host_resources,
> +};
> +
> +int __init pxa168_add_usb_host(struct pxa168_usb_pdata *pdata)
> +{
> +	pxa168_device_usb_host.dev.platform_data = pdata;
> +	return platform_device_register(&pxa168_device_usb_host);
> +}
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 006489d..3121d41 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -67,6 +67,7 @@ config USB_ARCH_HAS_EHCI
>   	default y if PLAT_SPEAR
>   	default y if ARCH_MSM
>   	default y if MICROBLAZE
> +	default y if ARCH_MMP
>   	default PCI
>
>   # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index e0e0787..130738d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -529,3 +529,10 @@ config USB_OCTEON_OHCI
>   config USB_OCTEON2_COMMON
>   	bool
>   	default y if USB_OCTEON_EHCI || USB_OCTEON_OHCI
> +
> +config USB_PXA168_EHCI
> +	bool "Marvell PXA168 on-chip EHCI HCD support"
> +	depends on USB_EHCI_HCD&&  ARCH_MMP
> +	help
> +	  Enable support for Marvell PXA168 SoC's on-chip EHCI
> +	  host controller
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 78561d1..1c49b26 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1265,6 +1265,11 @@ MODULE_LICENSE ("GPL");
>   #define PLATFORM_DRIVER		tegra_ehci_driver
>   #endif
>
> +#ifdef CONFIG_USB_PXA168_EHCI
> +#include "ehci-pxa168.c"
> +#define PLATFORM_DRIVER		ehci_pxa168_driver
> +#endif
> +
>   #if !defined(PCI_DRIVER)&&  !defined(PLATFORM_DRIVER)&&  \
>       !defined(PS3_SYSTEM_BUS_DRIVER)&&  !defined(OF_PLATFORM_DRIVER)&&  \
>       !defined(XILINX_OF_PLATFORM_DRIVER)
> diff --git a/drivers/usb/host/ehci-pxa168.c b/drivers/usb/host/ehci-pxa168.c
> new file mode 100644
> index 0000000..6aeb18a
> --- /dev/null
> +++ b/drivers/usb/host/ehci-pxa168.c
> @@ -0,0 +1,362 @@
> +/*
> + * drivers/usb/host/ehci-pxa168.c
> + *
> + * Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
> + *
> + * Based on drivers/usb/host/ehci-orion.c
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/platform_device.h>
> +#include<linux/clk.h>
> +#include<mach/pxa168.h>
> +
> +#define USB_PHY_CTRL_REG 0x4
> +#define USB_PHY_PLL_REG  0x8
> +#define USB_PHY_TX_REG   0xc
> +
> +#define FBDIV_SHIFT      4
> +
> +#define ICP_SHIFT        12
> +#define ICP_15            2
> +#define ICP_20            3
> +#define ICP_25            4
> +
> +#define KVCO_SHIFT       15
> +
> +#define PLLCALI12_SHIFT  25
> +#define CALI12_VDD        0
> +#define CALI12_09         1
> +#define CALI12_10         2
> +#define CALI12_11         3
> +
> +#define PLLVDD12_SHIFT   27
> +#define VDD12_VDD         0
> +#define VDD12_10          1
> +#define VDD12_11          2
> +#define VDD12_12          3
> +
> +#define PLLVDD18_SHIFT   29
> +#define VDD18_19          0
> +#define VDD18_20          1
> +#define VDD18_21          2
> +#define VDD18_22          3
> +
> +
> +#define PLL_READY        (1<<  23)
> +#define VCOCAL_START     (1<<  21)
> +#define REG_RCAL_START   (1<<  12)
> +
> +struct pxa168_usb_drv_data {
> +	struct ehci_hcd ehci;
> +	struct clk	*pxa168_usb_clk;
> +	struct resource	*usb_phy_res;
> +	void __iomem	*usb_phy_reg_base;
> +};
> +
> +static int ehci_pxa168_setup(struct usb_hcd *hcd)
> +{
> +	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> +	int retval;
> +
> +	ehci_reset(ehci);
> +	retval = ehci_halt(ehci);
> +	if (retval)
> +		return retval;
> +
> +	/*
> +	 * data structure init
> +	 */
> +	retval = ehci_init(hcd);
> +	if (retval)
> +		return retval;
> +
> +	hcd->has_tt = 1;
> +
> +	ehci_port_power(ehci, 0);
> +
> +	return retval;
> +}
> +
> +static const struct hc_driver ehci_pxa168_hc_driver = {
> +	.description = hcd_name,
> +	.product_desc = "Marvell PXA168 EHCI",
> +	.hcd_priv_size = sizeof(struct pxa168_usb_drv_data),
> +
> +	/*
> +	 * generic hardware linkage
> +	 */
> +	.irq = ehci_irq,
> +	.flags = HCD_MEMORY | HCD_USB2,
> +
> +	/*
> +	 * basic lifecycle operations
> +	 */
> +	.reset = ehci_pxa168_setup,
> +	.start = ehci_run,
> +	.stop = ehci_stop,
> +	.shutdown = ehci_shutdown,
> +
> +	/*
> +	 * managing i/o requests and associated device resources
> +	 */
> +	.urb_enqueue = ehci_urb_enqueue,
> +	.urb_dequeue = ehci_urb_dequeue,
> +	.endpoint_disable = ehci_endpoint_disable,
> +	.endpoint_reset = ehci_endpoint_reset,
> +
> +	/*
> +	 * scheduling support
> +	 */
> +	.get_frame_number = ehci_get_frame,
> +
> +	/*
> +	 * root hub support
> +	 */
> +	.hub_status_data = ehci_hub_status_data,
> +	.hub_control = ehci_hub_control,
> +	.bus_suspend = ehci_bus_suspend,
> +	.bus_resume = ehci_bus_resume,
> +	.relinquish_port = ehci_relinquish_port,
> +	.port_handed_over = ehci_port_handed_over,
> +
> +	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
> +};
> +
> +static int pxa168_usb_phy_init(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	void __iomem *usb_phy_reg_base;
> +	struct pxa168_usb_pdata *pdata;
> +	struct pxa168_usb_drv_data *drv_data;
> +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> +	unsigned long reg_val;
> +	int pll_retry_cont = 10000, err = 0;
> +
> +	drv_data = (struct pxa168_usb_drv_data *)hcd->hcd_priv;
> +	pdata = (struct pxa168_usb_pdata *)pdev->dev.platform_data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev,
> +			"Found HC with no PHY register addr. Check %s setup!\n",
> +			dev_name(&pdev->dev));
> +		return -ENODEV;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				ehci_pxa168_hc_driver.description)) {
> +		dev_dbg(&pdev->dev, "controller already in use\n");
> +		return -EBUSY;
> +	}
> +
> +	usb_phy_reg_base = ioremap(res->start, resource_size(res));
> +	if (usb_phy_reg_base == NULL) {
> +		dev_dbg(&pdev->dev, "error mapping memory\n");
> +		err = -EFAULT;
> +		goto err1;
> +	}
> +	drv_data->usb_phy_reg_base = usb_phy_reg_base;
> +	drv_data->usb_phy_res = res;
> +
> +	/* If someone wants to init USB phy in board specific way */
> +	if (pdata&&  pdata->phy_init)
> +		return pdata->phy_init(usb_phy_reg_base);
> +
> +	/* Power up the PHY and PLL */
> +	writel(readl(usb_phy_reg_base + USB_PHY_CTRL_REG) | 0x3,
> +		usb_phy_reg_base + USB_PHY_CTRL_REG);
> +
> +	/* Configure PHY PLL */
> +	reg_val = readl(usb_phy_reg_base + USB_PHY_PLL_REG)&  ~(0x7e03ffff);
> +	reg_val |= (VDD18_22<<  PLLVDD18_SHIFT | VDD12_12<<  PLLVDD12_SHIFT |
> +		CALI12_11<<  PLLCALI12_SHIFT | 3<<  KVCO_SHIFT |
> +		ICP_15<<  ICP_SHIFT | 0xee<<  FBDIV_SHIFT | 0xb);
> +	writel(reg_val, usb_phy_reg_base + USB_PHY_PLL_REG);
> +
> +	/* Make sure PHY PLL is ready */
> +	while (!(readl(usb_phy_reg_base + USB_PHY_PLL_REG)&  PLL_READY)) {
> +		if (!(pll_retry_cont--)) {
> +			dev_dbg(&pdev->dev, "USB PHY PLL not ready\n");
> +			err = -EIO;
> +			goto err2;
> +		}
> +	}
> +
> +	/* Toggle VCOCAL_START bit of U2PLL for PLL calibration */
> +	udelay(200);
> +	writel(readl(usb_phy_reg_base + USB_PHY_PLL_REG) | VCOCAL_START,
> +		usb_phy_reg_base + USB_PHY_PLL_REG);
> +	udelay(40);
> +	writel(readl(usb_phy_reg_base + USB_PHY_PLL_REG)&  ~VCOCAL_START,
> +		usb_phy_reg_base + USB_PHY_PLL_REG);
> +
> +	/* Toggle REG_RCAL_START bit of U2PTX for impedance calibration */
> +	udelay(400);
> +	writel(readl(usb_phy_reg_base + USB_PHY_TX_REG) | REG_RCAL_START,
> +		usb_phy_reg_base + USB_PHY_TX_REG);
> +	udelay(40);
> +	writel(readl(usb_phy_reg_base + USB_PHY_TX_REG)&  ~REG_RCAL_START,
> +		usb_phy_reg_base + USB_PHY_TX_REG);
> +
> +	/* Make sure PHY PLL is ready again */
> +	pll_retry_cont = 0;
> +	while (!(readl(usb_phy_reg_base + USB_PHY_PLL_REG)&  PLL_READY)) {
> +		if (!(pll_retry_cont--)) {
> +			dev_dbg(&pdev->dev, "USB PHY PLL not ready\n");
> +			err = -EIO;
> +			goto err2;
> +		}
> +	}
> +
> +	return 0;
> +err2:
> +	iounmap(usb_phy_reg_base);
> +err1:
> +	release_mem_region(res->start, resource_size(res));
> +	return err;
> +}
> +
> +static int __devinit ehci_pxa168_drv_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct usb_hcd *hcd;
> +	struct ehci_hcd *ehci;
> +	struct pxa168_usb_drv_data *drv_data;
> +	void __iomem *regs;
> +	int irq, err = 0;
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_debug("Initializing pxa168-SoC USB Host Controller\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq<= 0) {
> +		dev_err(&pdev->dev,
> +			"Found HC with no IRQ. Check %s setup!\n",
> +			dev_name(&pdev->dev));
> +		err = -ENODEV;
> +		goto err1;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev,
> +			"Found HC with no register addr. Check %s setup!\n",
> +			dev_name(&pdev->dev));
> +		err = -ENODEV;
> +		goto err1;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				ehci_pxa168_hc_driver.description)) {
> +		dev_dbg(&pdev->dev, "controller already in use\n");
> +		err = -EBUSY;
> +		goto err1;
> +	}
> +
> +	regs = ioremap(res->start, resource_size(res));
> +	if (regs == NULL) {
> +		dev_dbg(&pdev->dev, "error mapping memory\n");
> +		err = -EFAULT;
> +		goto err2;
> +	}
> +
> +	hcd = usb_create_hcd(&ehci_pxa168_hc_driver,
> +			&pdev->dev, dev_name(&pdev->dev));
> +	if (!hcd) {
> +		err = -ENOMEM;
> +		goto err3;
> +	}
> +
> +	drv_data = (struct pxa168_usb_drv_data *)hcd->hcd_priv;
> +
> +	/* Enable USB clock */
> +	drv_data->pxa168_usb_clk = clk_get(&pdev->dev, "PXA168-USBCLK");
> +	if (IS_ERR(drv_data->pxa168_usb_clk)) {
> +		dev_err(&pdev->dev, "Couldn't get USB clock\n");
> +		err = PTR_ERR(drv_data->pxa168_usb_clk);
> +		goto err4;
> +	}
> +	clk_enable(drv_data->pxa168_usb_clk);
> +
> +	err = pxa168_usb_phy_init(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "USB PHY initialization failed\n");
> +		goto err5;
> +	}
> +
> +	hcd->rsrc_start = res->start;
> +	hcd->rsrc_len = resource_size(res);
> +	hcd->regs = regs;
> +
> +	ehci = hcd_to_ehci(hcd);
> +	ehci->caps = hcd->regs + 0x100;
> +	ehci->regs = hcd->regs + 0x100 +
> +		HC_LENGTH(ehci_readl(ehci,&ehci->caps->hc_capbase));
> +	ehci->hcs_params = ehci_readl(ehci,&ehci->caps->hcs_params);
> +	hcd->has_tt = 1;
> +	ehci->sbrn = 0x20;
> +
> +	err = usb_add_hcd(hcd, irq, IRQF_SHARED | IRQF_DISABLED);
> +	if (err)
> +		goto err5;
> +
> +	return 0;
> +
> +err5:
> +	clk_disable(drv_data->pxa168_usb_clk);
> +err4:
> +	usb_put_hcd(hcd);
> +err3:
> +	iounmap(regs);
> +err2:
> +	release_mem_region(res->start, resource_size(res));
> +err1:
> +	dev_err(&pdev->dev, "init %s fail, %d\n",
> +		dev_name(&pdev->dev), err);
> +
> +	return err;
> +}
> +
> +static int __exit ehci_pxa168_drv_remove(struct platform_device *pdev)
> +{
> +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> +	struct pxa168_usb_drv_data *drv_data =
> +		(struct pxa168_usb_drv_data *)hcd->hcd_priv;
> +
> +	usb_remove_hcd(hcd);
> +
> +	/* Power down PHY&  PLL */
> +	writel(readl(drv_data->usb_phy_reg_base + USB_PHY_CTRL_REG)&  (~0x3),
> +		drv_data->usb_phy_reg_base + USB_PHY_CTRL_REG);
> +
> +	clk_disable(drv_data->pxa168_usb_clk);
> +	clk_put(drv_data->pxa168_usb_clk);
> +
> +	iounmap(hcd->regs);
> +	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
> +
> +	iounmap(drv_data->usb_phy_reg_base);
> +	release_mem_region(drv_data->usb_phy_res->start,
> +			resource_size(drv_data->usb_phy_res));
> +
> +	usb_put_hcd(hcd);
> +
> +	return 0;
> +}
> +
> +MODULE_ALIAS("platform:pxa168-ehci");
> +
> +static struct platform_driver ehci_pxa168_driver = {
> +	.probe		= ehci_pxa168_drv_probe,
> +	.remove		= __exit_p(ehci_pxa168_drv_remove),
> +	.shutdown	= usb_hcd_platform_shutdown,
> +	.driver.name	= "pxa168-ehci",
> +};
It was sad to know that David Brownell is no more with us. Added new 
maintainer for EHCI - Alan Stern in loop.
