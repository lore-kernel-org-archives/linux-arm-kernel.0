From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 17 May 2010 02:59:42 +0200
Subject: [PATCH] phy/marvell: Add special settings for D-Link DNS-323
	rev C1
In-Reply-To: <1274056058.21352.697.camel@pasglop>
References: <1274056058.21352.697.camel@pasglop>
Message-ID: <20100517005942.GB27301@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 10:27:38AM +1000, Benjamin Herrenschmidt wrote:
> Without this change, the network LED doesn't work on the device. The
> value itself comes from the vendor kernel.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/net/phy/marvell.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 64c7fbe..22b1efa 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -34,6 +34,10 @@
>  #include <asm/irq.h>
>  #include <asm/uaccess.h>
>  
> +#ifdef CONFIG_ARM
> +#include <asm/mach-types.h>
> +#endif
> +
>  #define MII_M1011_IEVENT		0x13
>  #define MII_M1011_IEVENT_CLEAR		0x0000
>  
> @@ -350,7 +354,14 @@ static int m88e1118_config_init(struct phy_device *phydev)
>  		return err;
>  
>  	/* Adjust LED Control */
> +#ifdef CONFIG_MACH_DNS323
> +	/* The DNS-323 needs a special value in here for the LED to work */
> +	if (machine_is_dns323())
> +		err = phy_write(phydev, 0x10, 0x1100);
> +	else
> +#else
>  	err = phy_write(phydev, 0x10, 0x021e);
> +#endif

There is a fixup()-callback to prevent boardcode in the drivers. See
Documentation/networking/phy.txt, last chapter.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100517/d2b6bf79/attachment.sig>
