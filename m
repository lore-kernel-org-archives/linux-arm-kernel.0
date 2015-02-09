From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 9 Feb 2015 12:14:34 +0100
Subject: [PATCH 1/3] USB: gadget: at91_udc: add at91sam9n12 support
In-Reply-To: <1423472572-19824-2-git-send-email-voice.shen@atmel.com>
References: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
 <1423472572-19824-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20150209111434.GN3715@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bo,

On 09/02/2015 at 17:02:50 +0800, Bo Shen wrote :
> Add at91sam9n12 SoC support.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> 
>  drivers/usb/gadget/udc/at91_udc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> index c862656..f4c785f 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -931,7 +931,8 @@ static void pullup(struct at91_udc *udc, int is_on)
>  		at91_udp_write(udc, AT91_UDP_TXVC, 0);
>  		if (cpu_is_at91rm9200())
>  			gpio_set_value(udc->board.pullup_pin, active);
> -		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() || cpu_is_at91sam9g20()) {
> +		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() ||
> +			 cpu_is_at91sam9g20() || cpu_is_at91sam9n12()) {

cpu_is_at91xx have been removed from the kernel, using the correct
compatible should be enough, see
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/usb/gadget/udc/at91_udc.c?id=f0bceab4e3b528e799aba8fda8d2936fcfd41f1f


>  			u32	txvc = at91_udp_read(udc, AT91_UDP_TXVC);
>  
>  			txvc |= AT91_UDP_TXVC_PUON;
> @@ -949,7 +950,8 @@ static void pullup(struct at91_udc *udc, int is_on)
>  		at91_udp_write(udc, AT91_UDP_TXVC, AT91_UDP_TXVC_TXVDIS);
>  		if (cpu_is_at91rm9200())
>  			gpio_set_value(udc->board.pullup_pin, !active);
> -		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() || cpu_is_at91sam9g20()) {
> +		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() ||
> +			 cpu_is_at91sam9g20() || cpu_is_at91sam9n12()) {
>  			u32	txvc = at91_udp_read(udc, AT91_UDP_TXVC);
>  
>  			txvc &= ~AT91_UDP_TXVC_PUON;
> @@ -1758,7 +1760,8 @@ static int at91udc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* newer chips have more FIFO memory than rm9200 */
> -	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {
> +	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20() ||
> +	    cpu_is_at91sam9n12()) {
>  		udc->ep[0].maxpacket = 64;
>  		udc->ep[3].maxpacket = 64;
>  		udc->ep[4].maxpacket = 512;
> -- 
> 2.3.0.rc0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
