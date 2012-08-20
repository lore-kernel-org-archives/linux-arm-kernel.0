From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 20:56:28 +0000
Subject: [PATCH 1/3] ARM: PRIMA2: use DT_MACHINE_START and convert to
 generic board
In-Reply-To: <1345450787-17246-2-git-send-email-Barry.Song@csr.com>
References: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
 <1345450787-17246-2-git-send-email-Barry.Song@csr.com>
Message-ID: <201208202056.28361.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> we will have SiRFMarco and SiRFPolo, all of them will be in the
> generic board.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/mach-prima2/Makefile                      |    2 +-
>  arch/arm/mach-prima2/{prima2.c => board-generic.c} |   10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>  rename arch/arm/mach-prima2/{prima2.c => board-generic.c} (81%)

I would prefer not to have a board-* file in there, because it's not
specific to a board. If you want to get rid of the prima2 name in it,
you can call it common.c.

> diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/board-generic.c
> similarity index 81%
> rename from arch/arm/mach-prima2/prima2.c
> rename to arch/arm/mach-prima2/board-generic.c
> index e9a17ae..f06b887 100644
> --- a/arch/arm/mach-prima2/prima2.c
> +++ b/arch/arm/mach-prima2/board-generic.c
> @@ -30,12 +30,13 @@ void __init sirfsoc_init_late(void)
>  	sirfsoc_pm_init();
>  }
>  
> -static const char *prima2cb_dt_match[] __initdata = {
> -       "sirf,prima2-cb",
> +#ifdef CONFIG_ARCH_PRIMA2
> +static const char *prima2_dt_match[] __initdata = {
> +       "sirf,prima2",
>         NULL
>  };
>  
> -MACHINE_START(PRIMA2_EVB, "prima2cb")
> +DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
>  	/* Maintainer: Barry Song <baohua.song@csr.com> */
>  	.atag_offset	= 0x100,
>  	.map_io         = sirfsoc_map_lluart,
> @@ -44,6 +45,7 @@ MACHINE_START(PRIMA2_EVB, "prima2cb")
>  	.dma_zone_size	= SZ_256M,
>  	.init_machine	= sirfsoc_mach_init,
>  	.init_late	= sirfsoc_init_late,
> -	.dt_compat      = prima2cb_dt_match,
> +	.dt_compat      = prima2_dt_match,
>  	.restart	= sirfsoc_restart,
>  MACHINE_END
> +#endif

I suppose this never really worked before then?

	Arnd
