From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jun 2011 12:21:27 +0300
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2
	to use REGULATOR_SUPPLY
In-Reply-To: <1307342762-25363-2-git-send-email-green@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
Message-ID: <20110606092126.GG18731@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06, 2011 at 02:46:01AM -0400, green at linuxhacker.ru wrote:
> From: Oleg Drokin <green@linuxhacker.ru>
> 
> CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
> CC: Mike Rapoport <mike@compulab.co.il>
> CC: Nishant Kamat <nskamat@ti.com>
> CC: Steve Sakoman <steve@sakoman.com>
> CC: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c          |   16 +++++-----------
>  arch/arm/mach-omap2/board-cm-t35.c           |   10 ++++------
>  arch/arm/mach-omap2/board-ldp.c              |    5 ++---
>  arch/arm/mach-omap2/board-omap3beagle.c      |   10 ++++------
>  arch/arm/mach-omap2/board-omap3evm.c         |   10 ++++------
>  arch/arm/mach-omap2/board-omap3logic.c       |    5 ++---
>  arch/arm/mach-omap2/board-omap3stalker.c     |   10 ++++------
>  arch/arm/mach-omap2/board-omap3touchbook.c   |   10 ++++------
>  arch/arm/mach-omap2/board-omap4panda.c       |   16 +++++-----------
>  arch/arm/mach-omap2/board-overo.c            |    5 ++---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |   21 ++++++++-------------
>  11 files changed, 44 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 63de2d3..914885a 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -332,17 +332,11 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{}	/* Terminator */
>  };
>  
> -static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
> -	{
> -		.supply = "vmmc",
> -		.dev_name = "omap_hsmmc.1",
> -	},
> -};
> +static struct regulator_consumer_supply sdp4430_vaux_supply =
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");

this should be an array, as it was before.

> +
>  static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> -	{
> -		.supply = "vmmc",
> -		.dev_name = "omap_hsmmc.0",
> -	},
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
>  };
>  
>  static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> @@ -400,7 +394,7 @@ static struct regulator_init_data sdp4430_vaux1 = {
>  					| REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies  = 1,

and this should use ARRAY_SIZE(),

> -	.consumer_supplies      = sdp4430_vaux_supply,
> +	.consumer_supplies      = &sdp4430_vaux_supply,
>  };
>  
>  static struct regulator_init_data sdp4430_vaux2 = {
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 77456de..33855e4 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -337,13 +337,11 @@ static void __init cm_t35_init_display(void)
>  	}
>  }
>  
> -static struct regulator_consumer_supply cm_t35_vmmc1_supply = {
> -	.supply			= "vmmc",
> -};
> +static struct regulator_consumer_supply cm_t35_vmmc1_supply =
> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");

this should also be array. It should read as:

static struct regulator_consumer_supply cm_t35_vmmc1_supply[] =
	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0",
};

ditto to all others.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110606/89b3bba3/attachment.sig>
