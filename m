From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Fri, 22 Sep 2017 14:40:21 +0200
Subject: [PATCH v2 6/9] ehci-atmel: Power down during suspend is normal
In-Reply-To: <20170915140411.31716-7-romain.izard.pro@gmail.com>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-7-romain.izard.pro@gmail.com>
Message-ID: <90b0ce5e-d99e-7bba-0e6e-3d375053487d@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/2017 at 16:04, Romain Izard wrote:
> When an Atmel SoC is suspended with the backup mode, the USB bus will be
> powered down. As this is expected, do not return an error to the driver
> core when ehci_resume detects it.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/usb/host/ehci-atmel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 7440722bfbf0..2a8b9bdc0e57 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -205,7 +205,8 @@ static int __maybe_unused ehci_atmel_drv_resume(struct device *dev)
>  	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
>  
>  	atmel_start_clock(atmel_ehci);
> -	return ehci_resume(hcd, false);
> +	ehci_resume(hcd, false);
> +	return 0;

Ok, I agree with that as the underlying function takes care about the
controller, in any case (even for !B+S-R case). So we don't have any
added value to propagate this information.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

>  }
>  
>  #ifdef CONFIG_OF
> 


-- 
Nicolas Ferre
