From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 15 Jun 2010 12:39:45 +0200
Subject: [PATCH 1/2] otg/ulpi: bail out on read errors
In-Reply-To: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
References: <1276598063-3956-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100615103945.GD17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 12:34:22PM +0200, Wolfram Sang wrote:
> otg_read may return errnos, so bail out correctly to prevent bogus
> ID-numbers.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Daniel Mack <daniel@caiaq.de>

> Cc: Greg KH <gregkh@suse.de>
> ---
>  drivers/usb/otg/ulpi.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
> index b1b3469..d331b22 100644
> --- a/drivers/usb/otg/ulpi.c
> +++ b/drivers/usb/otg/ulpi.c
> @@ -59,12 +59,17 @@ static int ulpi_set_flags(struct otg_transceiver *otg)
>  
>  static int ulpi_init(struct otg_transceiver *otg)
>  {
> -	int i, vid, pid;
> -
> -	vid = (otg_io_read(otg, ULPI_VENDOR_ID_HIGH) << 8) |
> -	       otg_io_read(otg, ULPI_VENDOR_ID_LOW);
> -	pid = (otg_io_read(otg, ULPI_PRODUCT_ID_HIGH) << 8) |
> -	       otg_io_read(otg, ULPI_PRODUCT_ID_LOW);
> +	int i, vid, pid, ret;
> +	u32 ulpi_id = 0;
> +
> +	for (i = 0; i < 4; i++) {
> +		ret = otg_io_read(otg, ULPI_PRODUCT_ID_HIGH - i);
> +		if (ret < 0)
> +			return ret;
> +		ulpi_id = (ulpi_id << 8) | ret;
> +	}
> +	vid = ulpi_id & 0xffff;
> +	pid = ulpi_id >> 16;
>  
>  	pr_info("ULPI transceiver vendor/product ID 0x%04x/0x%04x\n", vid, pid);
>  
> -- 
> 1.7.1
> 
