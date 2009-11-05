From: ospite@studenti.unina.it (Antonio Ospite)
Date: Thu, 5 Nov 2009 16:14:32 +0100
Subject: [PATCH] Allow platforms to control which PXA uarts are registered
In-Reply-To: <20091105141337.GB21681@n2100.arm.linux.org.uk>
References: <20091105141337.GB21681@n2100.arm.linux.org.uk>
Message-ID: <20091105161432.cf278409.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2009 14:13:38 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> For some platforms, it is inappropriate to register all PXA UARTs.
> In some cases, the UARTs may not be used, and in others we may want
> to avoid registering the UARTs to allow other drivers (eg, FICP) to
> make use of the UART.
> 
> In addition, a while back there was a request to be able to pass
> platform data to the UART driver.
> 
> This patch enables all of this by providing functions platforms can
> call to register each individual UART.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

in ezx.c you only put the *uart_info() calls in e2_init() (the last one,
I guess it was because of some automation?), but in this file there are
several machines defined.

>  arch/arm/mach-pxa/ezx.c            |    3 +++

> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 588b265..0dca63e 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -971,6 +971,9 @@ static void __init e2_init(void)
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(gen2_pin_config));
>  	pxa2xx_mfp_config(ARRAY_AND_SIZE(e2_pin_config));
>  
> +	pxa_set_ffuart_info(NULL);
> +	pxa_set_btuart_info(NULL);
> +	pxa_set_stuart_info(NULL);
>  	pxa_set_i2c_info(NULL);
>  	i2c_register_board_info(0, ARRAY_AND_SIZE(e2_i2c_board_info));
>  

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091105/f440d4b8/attachment.sig>
