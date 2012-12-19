From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 19 Dec 2012 15:09:31 -0600
Subject: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
In-Reply-To: <20121209200327.3196.27686.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan>
Message-ID: <50D22D0B.3050502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 12/09/2012 02:03 PM, Paul Walmsley wrote:
> There's no need to determine the current power state for powerdomains
> that must be on while the kernel is running.  We mark these
> powerdomains with a new flag, PWRDM_ACTIVE_WITH_KERNEL.  Any
> powerdomain marked with that flag is reported as being in the ON power
> state while the kernel is running.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c           |    9 ++++++---
>  arch/arm/mach-omap2/powerdomain.h           |    4 ++++
>  arch/arm/mach-omap2/powerdomains2xxx_data.c |    2 ++
>  arch/arm/mach-omap2/powerdomains33xx_data.c |    3 ++-
>  arch/arm/mach-omap2/powerdomains3xxx_data.c |    9 ++++++---
>  arch/arm/mach-omap2/powerdomains44xx_data.c |    5 ++++-
>  6 files changed, 24 insertions(+), 8 deletions(-)

[snip]

> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
> index 704664c..b64213c 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -53,7 +53,8 @@ static struct powerdomain core_44xx_pwrdm = {
>  		[3] = PWRSTS_ON,	/* ducati_l2ram */
>  		[4] = PWRSTS_ON,	/* ducati_unicache */
>  	},
> -	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
> +	.flags		  = (PWRDM_HAS_LOWPOWERSTATECHANGE |
> +			     PWRDM_ACTIVE_WITH_KERNEL),
>  };

My understanding is that for OMAP4 devices, the core power domain may
not be active the same time as the MPU power domain. The Cortex-A9 has
the ability to access some peripherals (such as timer, McBSP) via a
private bus that does not require the core domain to be active. This is
a difference from OMAP3 devices, where the core would always be on with
the MPU power domain.

Hopefully, Benoit will chime in if I have gotten this wrong ;-)

Cheers
Jon
