From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 19 Jan 2011 21:41:57 +0100
Subject: [PATCH v2] usb: gadget/fsl_mxc_udc: Detect the CPU type in
	run-time
In-Reply-To: <1295468223-11371-1-git-send-email-fabio.estevam@freescale.com>
References: <1295468223-11371-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4D374C95.7020204@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/2011 21:17, Fabio Estevam wrote:
> Make sure we are running on a MX35 processor.
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
Acked-by: Eric B?nard <eric@eukrea.com>

> ---
>   drivers/usb/gadget/fsl_mxc_udc.c |   19 +++++++++++--------
>   1 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> index 77b1eb5..c1a65cd 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -89,14 +89,17 @@ void fsl_udc_clk_finalize(struct platform_device *pdev)
>   {
>   	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
>   #if defined(CONFIG_ARCH_MX35)
> -	unsigned int v;
> -
> -	/* workaround ENGcm09152 for i.MX35 */
> -	if (pdata->workaround&  FLS_USB2_WORKAROUND_ENGCM09152) {
> -		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -				USBPHYCTRL_OTGBASE_OFFSET));
> -		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -				USBPHYCTRL_OTGBASE_OFFSET));
> +	if (cpu_is_mx35()) {
> +		unsigned int v;
> +
> +		/* workaround ENGcm09152 for i.MX35 */
> +		if (pdata->workaround&  FLS_USB2_WORKAROUND_ENGCM09152) {
> +			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> +					USBPHYCTRL_OTGBASE_OFFSET));
> +			writel(v | USBPHYCTRL_EVDO,
> +				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> +					USBPHYCTRL_OTGBASE_OFFSET));
> +		}
>   	}
>   #endif
>
