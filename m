From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 30 Aug 2013 10:18:12 +0300
Subject: [PATCH v4 3/5] at91/avr32/atmel_lcdfb: prepare clk before calling
 enable
In-Reply-To: <1374133225-19141-1-git-send-email-b.brezillon@overkiz.com>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133225-19141-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52204734.3010603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/13 10:40, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/atmel_lcdfb.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index ece49d5..bf9c5d0 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -954,14 +954,14 @@ static int __init atmel_lcdfb_init_fbinfo(struct atmel_lcdfb_info *sinfo)
>  
>  static void atmel_lcdfb_start_clock(struct atmel_lcdfb_info *sinfo)
>  {
> -	clk_enable(sinfo->bus_clk);
> -	clk_enable(sinfo->lcdc_clk);
> +	clk_prepare_enable(sinfo->bus_clk);
> +	clk_prepare_enable(sinfo->lcdc_clk);
>  }
>  
>  static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
>  {
> -	clk_disable(sinfo->bus_clk);
> -	clk_disable(sinfo->lcdc_clk);
> +	clk_disable_unprepare(sinfo->bus_clk);
> +	clk_disable_unprepare(sinfo->lcdc_clk);
>  }
>  
>  #ifdef CONFIG_OF

Thanks, queued this for 3.12.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130830/396f8749/attachment-0001.sig>
