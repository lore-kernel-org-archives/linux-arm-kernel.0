From: krohei@gmail.com (Heikki Krogerus)
Date: Fri, 13 Aug 2010 16:27:17 +0300
Subject: [PATCH 3/3] usb/otg/ulpi: extend the generic ulpi driver.
In-Reply-To: <1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
	<1279198816-30367-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <20100813132717.GA6986@as23.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch has already been applied and I have totally missed it,
sorry about that, but I have to ask..

On Thu, Jul 15, 2010 at 04:00:16PM +0300, Igor Grinberg wrote:
> 1) Introduce ulpi specific flags for control of the ulpi phy
> 2) Extend the generic ulpi driver with support for Function and
> Interface control of upli phy
> 3) Update the platforms using the generic ulpi driver with new ulpi
> flags
> 4) Remove the otg control flags not in use
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

<snip>

> diff --git a/include/linux/usb/ulpi.h b/include/linux/usb/ulpi.h
> index 900d97b..82b1507 100644
> --- a/include/linux/usb/ulpi.h
> +++ b/include/linux/usb/ulpi.h
> @@ -15,6 +15,41 @@
>  /*-------------------------------------------------------------------------*/
>  
>  /*
> + * ULPI Flags
> + */
> +#define ULPI_OTG_ID_PULLUP		(1 << 0)
> +#define ULPI_OTG_DP_PULLDOWN_DIS	(1 << 1)
> +#define ULPI_OTG_DM_PULLDOWN_DIS	(1 << 2)
> +#define ULPI_OTG_DISCHRGVBUS		(1 << 3)
> +#define ULPI_OTG_CHRGVBUS		(1 << 4)
> +#define ULPI_OTG_DRVVBUS		(1 << 5)
> +#define ULPI_OTG_DRVVBUS_EXT		(1 << 6)
> +#define ULPI_OTG_EXTVBUSIND		(1 << 7)

Why are you redefining these? If you look through the file you'll find
the same bits are already there for OTG Control?

> +#define ULPI_IC_6PIN_SERIAL		(1 << 8)
> +#define ULPI_IC_3PIN_SERIAL		(1 << 9)
> +#define ULPI_IC_CARKIT			(1 << 10)
> +#define ULPI_IC_CLKSUSPM		(1 << 11)
> +#define ULPI_IC_AUTORESUME		(1 << 12)
> +#define ULPI_IC_EXTVBUS_INDINV		(1 << 13)
> +#define ULPI_IC_IND_PASSTHRU		(1 << 14)
> +#define ULPI_IC_PROTECT_DIS		(1 << 15)

Why bit offsets starting from (1 << 8)? I took a look@ulpi.c and
you are still using ULPI_IFC_CTRL register, so these offsets can't
possibly work. There are also existing definitions for ULPI Interface
Control bits in any case.

> +#define ULPI_FC_HS			(1 << 16)
> +#define ULPI_FC_FS			(1 << 17)
> +#define ULPI_FC_LS			(1 << 18)
> +#define ULPI_FC_FS4LS			(1 << 19)
> +#define ULPI_FC_TERMSEL			(1 << 20)
> +#define ULPI_FC_OP_NORM			(1 << 21)
> +#define ULPI_FC_OP_NODRV		(1 << 22)
> +#define ULPI_FC_OP_DIS_NRZI		(1 << 23)
> +#define ULPI_FC_OP_NSYNC_NEOP		(1 << 24)
> +#define ULPI_FC_RST			(1 << 25)
> +#define ULPI_FC_SUSPM			(1 << 26)

Same here?

I'm asking in case I'm missing something and there is a reason the
above, before sending any patches.

br,

-- 
heikki
