From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Aug 2015 11:09:48 -0500
Subject: [PATCH v5 07/46] usb: dwc3: gadget: add ep capabilities support
In-Reply-To: <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-8-git-send-email-r.baldyga@samsung.com>
Message-ID: <20150804160948.GJ23659@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 04:00:19PM +0200, Robert Baldyga wrote:
> Convert endpoint configuration to new capabilities model.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2feed9e..bd4c3db 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1715,6 +1715,19 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
>  				return ret;
>  		}
>  
> +		if (epnum == 0 || epnum == 1) {
> +			dep->endpoint.caps.type_control = true;
> +		} else {
> +			dep->endpoint.caps.type_iso = true;
> +			dep->endpoint.caps.type_bulk = true;
> +			dep->endpoint.caps.type_int = true;
> +		}
> +
> +		if (direction)
> +			dep->endpoint.caps.dir_in = true;
> +		else
> +			dep->endpoint.caps.dir_out = true;

you can avoid the branch for the direction:

		dep->endpoint.caps.dir_in = !!direction;
		dep->endpoint.caps.dir_out = !direction;

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/de171f73/attachment-0001.sig>
