From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 24 Jun 2010 17:04:48 +0300
Subject: [PATCH v2] otg/ulpi.c : fix register write
In-Reply-To: <1277311435-12027-1-git-send-email-eric@eukrea.com>
References: <1277311435-12027-1-git-send-email-eric@eukrea.com>
Message-ID: <4C236600.2030605@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/23/10 19:43, Eric B?nard wrote:
> ulpi_set_vbus and ulpi_set_flags are using ULPI_SET(register) to write
> to the PHY's registers, which means we can only set bits in the PHY's
> register and not clear them.
> By directly using the address of the register without any offset, we
> now get the expected behaviour for these functions.
>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
> v2 :
> drop reg/val swap which is handled in a better way by Igor's patch here :
> http://comments.gmane.org/gmane.linux.usb.general/32092 
>  
>  drivers/usb/otg/ulpi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
> index b1b3469..086853b 100644
> --- a/drivers/usb/otg/ulpi.c
> +++ b/drivers/usb/otg/ulpi.c
> @@ -54,7 +54,7 @@ static int ulpi_set_flags(struct otg_transceiver *otg)
>  	if (otg->flags & USB_OTG_EXT_VBUS_INDICATOR)
>  		flags |= ULPI_OTG_CTRL_EXTVBUSIND;
>  
> -	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
> +	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>  }
>   

ulpi_set_flags is used to set the OTG flags and not to clear them,
also it is a static function and is not a part of struct otg_transceiver,
so it cannot be called from outside the ulpi.c, thus after the ulpi_create,
it is never called.
I think, currently, this should stay as it is.


>  static int ulpi_init(struct otg_transceiver *otg)
> @@ -90,7 +90,7 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
>  			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
>  	}
>  
> -	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
> +	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>  }
>   

This one seems ok.

>  
>  struct otg_transceiver *
>   

-- 
Regards,
Igor.
