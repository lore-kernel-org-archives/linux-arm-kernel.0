From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 17:55:12 +0200
Subject: [PATCH] ARM: bcm2835: remove unused __packet
In-Reply-To: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <3205257.80lYkVfUux@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 7, 2016 6:49:33 PM CEST Ben Dooks wrote:
> The driver defines a variable called __packet but then never
> uses it, and does not export it for others to use either. Fix
> the warning about undeclared variable by removing it.
> 
> drivers/soc/bcm/raspberrypi-power.c:48:3: warning: symbol '__packet' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

The patch looks good, but it's probably worth mentioning here that
this was intended to be the '__packed' attribute instead of a local
variable. The attribute is useless here, as the variables both
still get the default stack alignment, even if rpi_firmware_property
only requires byte-aligned data.

	Arnd

> diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
> index fe96a8b..f7ed118 100644
> --- a/drivers/soc/bcm/raspberrypi-power.c
> +++ b/drivers/soc/bcm/raspberrypi-power.c
> @@ -45,7 +45,7 @@ struct rpi_power_domains {
>  struct rpi_power_domain_packet {
>         u32 domain;
>         u32 on;
> -} __packet;
> +};
> 
