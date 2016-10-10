From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Oct 2016 10:17:10 +0100
Subject: [PATCH v3 10/12] scsi/ncr5380: Expedite register polling
In-Reply-To: <2806ba151f6983923fa0aae700245dfeb4cfaf38.1476051962.git.fthain@telegraphics.com.au>
References: <cover.1476051961.git.fthain@telegraphics.com.au>
 <2806ba151f6983923fa0aae700245dfeb4cfaf38.1476051962.git.fthain@telegraphics.com.au>
Message-ID: <20161010091709.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 12:46:53AM -0400, Finn Thain wrote:
> Avoid the call to NCR5380_poll_politely2() when possible. The call is
> easily short-circuited on the PIO fast path, using the inline wrapper.
> This requires that the NCR5380_read macro be made available before
> any #include "NCR5380.h" so a few declarations have to be moved too.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> ---

> diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
> index ae1d4c6..fb7600d 100644
> --- a/drivers/scsi/arm/cumana_1.c
> +++ b/drivers/scsi/arm/cumana_1.c
> @@ -29,6 +29,10 @@
>  #define NCR5380_implementation_fields	\
>  	unsigned ctrl
>  
> +struct NCR5380_hostdata;
> +static u8 cumanascsi_read(struct NCR5380_hostdata *, unsigned int);
> +static void cumanascsi_write(struct NCR5380_hostdata *, unsigned int, u8);
> +
>  #include "../NCR5380.h"
>  
>  #define CTRL	0x16fc

This seems to be non-obviously unrelated to this commit - should it be in
some other commit?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
