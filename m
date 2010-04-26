From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 26 Apr 2010 23:02:02 +0200
Subject: [PATCHv8 2.6.34-rc5 4/5] mxc: Add generic USB HW
	initialization for MX51
In-Reply-To: <1271998277-3949-4-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271998277-3949-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271998277-3949-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1271998277-3949-3-git-send-email-Dinh.Nguyen@freescale.com>
	<1271998277-3949-4-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100426210202.GW30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 11:51:16PM -0500, Dinh.Nguyen at freescale.com wrote:

[...]

> diff --git a/arch/arm/plat-mxc/include/mach/mxc_ehci.h b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> index 4b9b836..7fc5f99 100644
> --- a/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> +++ b/arch/arm/plat-mxc/include/mach/mxc_ehci.h
> @@ -25,6 +25,18 @@
>  #define MXC_EHCI_INTERNAL_PHY		(1 << 7)
>  #define MXC_EHCI_IPPUE_DOWN		(1 << 8)
>  #define MXC_EHCI_IPPUE_UP		(1 << 9)
> +#define MXC_EHCI_WAKEUP_ENABLED	(1 << 10)
> +#define MXC_EHCI_ITC_NO_THRESHOLD	(1 << 11)
> +
> +#define MXC_USBCTRL_OFFSET		0
> +#define MXC_USB_PHY_CTR_FUNC_OFFSET	0x8
> +#define MXC_USB_PHY_CTR_FUNC2_OFFSET	0xc
> +
> +#define MX5_USBOTHER_REGS_OFFSET	0x800
> +
> +/* USB_PHY_CTRL_FUNC2*/
> +#define MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK		0x3
> +#define MX5_USB_UTMI_PHYCTRL1_PLLDIV_SHIFT		0
>  
>  struct mxc_usbh_platform_data {
>  	int (*init)(struct platform_device *pdev);
> @@ -35,7 +47,7 @@ struct mxc_usbh_platform_data {
>  	struct otg_transceiver	*otg;
>  };
>  
> -int mxc_set_usbcontrol(int port, unsigned int flags);
> +int mxc_initialize_usb_hw(int port, unsigned int flags);
>  
>  #endif /* __INCLUDE_ASM_ARCH_MXC_EHCI_H */
>  
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index ead59f4..bb8d092 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -191,6 +191,11 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  		clk_enable(priv->ahbclk);
>  	}
>  
> +	/* setup specific usb hw */
> +	ret = mxc_initialize_usb_hw(pdev->id, pdata->flags);
> +	if (ret < 0)
> +		goto err_init;
> +
>  	/* set USBMODE to host mode */
>  	temp = readl(hcd->regs + USBMODE_OFFSET);
>  	writel(temp | USBMODE_CM_HOST, hcd->regs + USBMODE_OFFSET);
> @@ -199,11 +204,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>  	writel(pdata->portsc, hcd->regs + PORTSC_OFFSET);
>  	mdelay(10);
>  
> -	/* setup USBCONTROL. */
> -	ret = mxc_set_usbcontrol(pdev->id, pdata->flags);
> -	if (ret < 0)
> -		goto err_init;
> -
>  	/* Initialize the transceiver */
>  	if (pdata->otg) {
>  		pdata->otg->io_priv = hcd->regs + ULPI_VIEWPORT_OFFSET;

I think there's still one concern left for the move of this function
block, right? Dinh, is this actually necessary? Could you try calling
mxc_initialize_usb_hw() from the location where mxc_set_usbcontrol() was
used to be called? Or is there anything I overlook?

This might look like nit-picking to you, but as Sascha explained, there
is a certain risk of breaking functionality for existing boards, and if
we can avoid that, we should.

Meanwhile, I prepared a patch to clean up plat-mxc/ehci.c. I'll send it
out once this series is accepted.

Thanks,
Daniel
