From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 12:17:08 +0200
Subject: [PATCH v3 2/3] usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to
 ioremap
In-Reply-To: <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
References: <1358158361-25550-1-git-send-email-peter.chen@freescale.com>
 <1358158361-25550-3-git-send-email-peter.chen@freescale.com>
Message-ID: <20130114101708.GC10874@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 06:12:40PM +0800, Peter Chen wrote:
> As mach/hardware.h is deleted, we can't visit platform code at driver.
> It has no phy driver to combine with this controller, so it has to use
> ioremap to map phy address as a workaround.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/gadget/fsl_mxc_udc.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> index 6df45f7..0e858e6 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -23,7 +23,8 @@ static struct clk *mxc_per_clk;
>  static struct clk *mxc_ipg_clk;
>  
>  /* workaround ENGcm09152 for i.MX35 */
> -#define USBPHYCTRL_OTGBASE_OFFSET	0x608
> +#define MX35_USBPHYCTRL_OFFSET		0x600
> +#define USBPHYCTRL_OTGBASE_OFFSET	0x8
>  #define USBPHYCTRL_EVDO			(1 << 23)
>  
>  int fsl_udc_clk_init(enum fsl_udc_type devtype, struct platform_device *pdev)
> @@ -83,15 +84,16 @@ void fsl_udc_clk_finalize(enum fsl_udc_type devtype,
>  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
>  	if (devtype == IMX35_UDC) {
>  		unsigned int v;
> +		void __iomem *phy_regs = ioremap((unsigned long)pdata->regs +
> +						MX35_USBPHYCTRL_OFFSET, 512);

as I said before, this should be passed via struct resource, not pdata.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/3b90d250/attachment-0001.sig>
