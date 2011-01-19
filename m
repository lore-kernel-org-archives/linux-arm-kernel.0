From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 19 Jan 2011 16:36:46 +0100
Subject: [PATCH] usb: gadget/fsl_mxc_udc: Detect the CPU type in run-time
In-Reply-To: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
References: <1295451164-3363-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4D37050E.6010009@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 19/01/2011 16:32, Fabio Estevam wrote:
> Instead of checking the CPU type in build-time, do it in run-time.
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
> ---
>   drivers/usb/gadget/fsl_mxc_udc.c |   23 ++++++++++++-----------
>   1 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> index 77b1eb5..167abe0 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -88,17 +88,18 @@ eenahb:
>   void fsl_udc_clk_finalize(struct platform_device *pdev)
>   {
>   	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> -#if defined(CONFIG_ARCH_MX35)
> -	unsigned int v;
> -
> -	/* workaround ENGcm09152 for i.MX35 */
> -	if (pdata->workaround&  FLS_USB2_WORKAROUND_ENGCM09152) {
> -		v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -				USBPHYCTRL_OTGBASE_OFFSET));
> -		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> -				USBPHYCTRL_OTGBASE_OFFSET));
> -	}
> -#endif
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
> +	}
>
are you sure this compiles when MX35 is not selected ?

Eric
