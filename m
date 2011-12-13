From: balbi@ti.com (Felipe Balbi)
Date: Tue, 13 Dec 2011 16:18:04 +0200
Subject: [PATCH v2 01/19] mxc_udc: add workaround for ENGcm09152 for i.MX25
In-Reply-To: <1323785377-22463-1-git-send-email-eric@eukrea.com>
References: <20111213101846.GC2619@pengutronix.de>
 <1323785377-22463-1-git-send-email-eric@eukrea.com>
Message-ID: <20111213141803.GO3133@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 13, 2011 at 03:09:37PM +0100, Eric B?nard wrote:
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX25 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 42 of the following Errata,
> titled "USB: UTMI_USBPHY VBUS input impedance implementation error" :
> http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Li Yang <leoli@freescale.com>

Sascha, are you taking this one or should I take it ? One comment below
though.

> ---
>  drivers/usb/gadget/fsl_mxc_udc.c |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
> index dcbc0a2..4aff05d 100644
> --- a/drivers/usb/gadget/fsl_mxc_udc.c
> +++ b/drivers/usb/gadget/fsl_mxc_udc.c
> @@ -23,7 +23,7 @@
>  static struct clk *mxc_ahb_clk;
>  static struct clk *mxc_usb_clk;
>  
> -/* workaround ENGcm09152 for i.MX35 */
> +/* workaround ENGcm09152 for i.MX25/35 */
>  #define USBPHYCTRL_OTGBASE_OFFSET	0x608
>  #define USBPHYCTRL_EVDO			(1 << 23)
>  
> @@ -89,16 +89,20 @@ eenahb:
>  void fsl_udc_clk_finalize(struct platform_device *pdev)
>  {
>  	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
> -	if (cpu_is_mx35()) {
> +	if (cpu_is_mx25() || cpu_is_mx35()) {
>  		unsigned int v;
> -
> -		/* workaround ENGcm09152 for i.MX35 */
> +		void __iomem *otgbase;
> +		if (cpu_is_mx25())
> +			otgbase = MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
> +					USBPHYCTRL_OTGBASE_OFFSET);
> +		else if (cpu_is_mx35())
> +			otgbase = MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
> +					USBPHYCTRL_OTGBASE_OFFSET);

I don't want to see cpu_is_* or machine_is_* or <plat/*> or <mach/*>
anywhere on drivers, please make sure to remove them for 3.4 merge
window the latest. You should also make sure that this driver has no
static globals. IOW, I would like to be able to have multiple instances
of this driver working fine.

Granted, you have no boards with such setup, but we made that mistake on
musb driver and now we have a bunch of other stuff to rework in order to
get our dual-MUSB board to work ;-)

I also see that fsl_udc_core.c is still not using dev_pm_ops, please fix
that too.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111213/4da9192b/attachment.sig>
