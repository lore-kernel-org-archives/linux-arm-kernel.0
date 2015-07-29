From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 Jul 2015 10:20:29 -0500
Subject: [PATCH v4 04/46] staging: emxx_udc: add ep capabilities support
In-Reply-To: <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
 <1437988616-6962-5-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150729152029.GB32418@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 11:16:14AM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
> 
> Fixed typo in "epc-nulk" to "epc-bulk".
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index 3b7aa36..0d64bee 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadget_ops = {
>  	.ioctl			= nbu2ss_gad_ioctl,
>  };
>  
> -static const char g_ep0_name[] = "ep0";
> -static const char g_ep1_name[] = "ep1-bulk";
> -static const char g_ep2_name[] = "ep2-bulk";
> -static const char g_ep3_name[] = "ep3in-int";
> -static const char g_ep4_name[] = "ep4-iso";
> -static const char g_ep5_name[] = "ep5-iso";
> -static const char g_ep6_name[] = "ep6-bulk";
> -static const char g_ep7_name[] = "ep7-bulk";
> -static const char g_ep8_name[] = "ep8in-int";
> -static const char g_ep9_name[] = "ep9-iso";
> -static const char g_epa_name[] = "epa-iso";
> -static const char g_epb_name[] = "epb-bulk";
> -static const char g_epc_name[] = "epc-nulk";
> -static const char g_epd_name[] = "epdin-int";
> -
> -static const char *gp_ep_name[NUM_ENDPOINTS] = {
> -	g_ep0_name,
> -	g_ep1_name,
> -	g_ep2_name,
> -	g_ep3_name,
> -	g_ep4_name,
> -	g_ep5_name,
> -	g_ep6_name,
> -	g_ep7_name,
> -	g_ep8_name,
> -	g_ep9_name,
> -	g_epa_name,
> -	g_epb_name,
> -	g_epc_name,
> -	g_epd_name,
> +static const struct {
> +	const char *name;
> +	const struct usb_ep_caps caps;
> +} ep_info[NUM_ENDPOINTS] = {
> +#define EP_INFO(_name, _type, _dir) \
> +	{ \
> +		.name = _name, \
> +		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
> +				USB_EP_CAPS_DIR_ ## _dir), \
> +	}
> +
> +	EP_INFO("ep0",		CONTROL, ALL),
> +	EP_INFO("ep1-bulk",	BULK,	ALL),
> +	EP_INFO("ep2-bulk",	BULK,	ALL),
> +	EP_INFO("ep3in-int",	INT,	IN),
> +	EP_INFO("ep4-iso",	INT,	ALL),
> +	EP_INFO("ep5-iso",	ISO,	ALL),
> +	EP_INFO("ep6-bulk",	ISO,	ALL),
> +	EP_INFO("ep7-bulk",	BULK,	ALL),
> +	EP_INFO("ep8in-int",	INT,	IN),
> +	EP_INFO("ep9-iso",	ISO,	ALL),
> +	EP_INFO("epa-iso",	ISO,	ALL),
> +	EP_INFO("epb-bulk",	BULK,	ALL),
> +	EP_INFO("epc-bulk",	BULK,	ALL),
> +	EP_INFO("epdin-int",	INT,	IN),

IMO, this is pointless obfuscation. It just makes it a pain to grep
source around. Why don't you have UDC drivers initialize the 1-bit flags
directly ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/84443a9b/attachment.sig>
