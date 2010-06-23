From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 23 Jun 2010 18:16:53 +0300
Subject: [PATCH] otg/ulpi.c : fix register write
In-Reply-To: <1277304632-11314-1-git-send-email-eric@eukrea.com>
References: <1277304632-11314-1-git-send-email-eric@eukrea.com>
Message-ID: <4C222565.5000407@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/23/10 17:50, Eric B?nard wrote:
> * drivers/usb/otg/ulpi.c :
> ulpi_set_vbus and ulpi_set_flags are using ULPI_SET(register) to write
> to the PHY's registers, which means we can only set bits in the PHY's
> register and not clear them.
> By directly using the address of the register without any offset, we
> now get the expected behaviour for these functions.
>
> * this patch also keep usage of otg_io_write & ulpi parameters coherent
> as in include/linux/usb/otg.h we have :
> otg_io_write(struct otg_transceiver *otg, u32 reg, u32 val)
>   

and also:

struct otg_io_access_ops {
         int (*read)(struct otg_transceiver *otg, u32 reg);
<http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/linux/usb/otg.h;h=f8302d036a7674e33109bf8fce16d67325d2d17a;hb=HEAD#l60> 
       int (*write)(struct otg_transceiver *otg, u32 val, u32 reg);
};

and please, look here:
http://comments.gmane.org/gmane.linux.usb.general/32092

> so keep the same parameters order in drivers/usb/otg/ulpi.c and
> arch/arm/plat-mxc/ulpi.c.
>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  arch/arm/plat-mxc/ulpi.c |    2 +-
>  drivers/usb/otg/ulpi.c   |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/ulpi.c b/arch/arm/plat-mxc/ulpi.c
> index 582c6df..84eb5c7 100644
> --- a/arch/arm/plat-mxc/ulpi.c
> +++ b/arch/arm/plat-mxc/ulpi.c
> @@ -83,7 +83,7 @@ static int ulpi_read(struct otg_transceiver *otg, u32 reg)
>  	return (__raw_readl(view) >> ULPIVW_RDATA_SHIFT) & ULPIVW_RDATA_MASK;
>  }
>  
> -static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
> +static int ulpi_write(struct otg_transceiver *otg, u32 reg, u32 val)
>  {
>  	int ret;
>  	void __iomem *view = otg->io_priv;
> diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
> index b1b3469..f6048ca 100644
> --- a/drivers/usb/otg/ulpi.c
> +++ b/drivers/usb/otg/ulpi.c
> @@ -54,7 +54,7 @@ static int ulpi_set_flags(struct otg_transceiver *otg)
>  	if (otg->flags & USB_OTG_EXT_VBUS_INDICATOR)
>  		flags |= ULPI_OTG_CTRL_EXTVBUSIND;
>  
> -	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
> +	return otg_io_write(otg, ULPI_OTG_CTRL, flags);
>  }
>  
>  static int ulpi_init(struct otg_transceiver *otg)
> @@ -90,7 +90,7 @@ static int ulpi_set_vbus(struct otg_transceiver *otg, bool on)
>  			flags |= ULPI_OTG_CTRL_DRVVBUS_EXT;
>  	}
>  
> -	return otg_io_write(otg, flags, ULPI_SET(ULPI_OTG_CTRL));
> +	return otg_io_write(otg, ULPI_OTG_CTRL, flags);
>  }
>  
>  struct otg_transceiver *
>   

-- 
Regards,
Igor.
