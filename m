From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 21 Jul 2010 17:46:17 +0300
Subject: [PATCH v2] otg/ulpi.c : fix register write
In-Reply-To: <1279178419-3806-1-git-send-email-eric@eukrea.com>
References: <20100714204740.GA29417@suse.de>
	<1279178419-3806-1-git-send-email-eric@eukrea.com>
Message-ID: <4C470839.2050500@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

This was a resend, you've asked...
Can you please update us on its status?

Thanks

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
>  static int ulpi_init(struct otg_transceiver *otg)
> @@ -90,7 +90,7 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
>  			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
>  	}
>  
> -	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
> +	return otg_io_write(otg, flags, ULPI_OTG_CTRL);
>  }
>  
>  struct otg_transceiver *
>   

-- 
Regards,
Igor.
