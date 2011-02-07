From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Feb 2011 09:09:45 +0100
Subject: [PATCH 3/5] ARM: mxs: dynamically allocate dma device for mx23/28
In-Reply-To: <1296871696-21008-4-git-send-email-shawn.guo@freescale.com>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110207080945.GH9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 05, 2011 at 10:08:14AM +0800, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c                  |    3 +-
>  arch/arm/mach-mxs/clock-mx28.c                  |    4 +-
>  arch/arm/mach-mxs/devices-mx23.h                |    6 +++
>  arch/arm/mach-mxs/devices-mx28.h                |    6 +++
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-dma.c        |   50 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    7 +++
>  8 files changed, 77 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-dma.c
> 
> diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
> index 1256788..d5595ce 100644
> --- a/arch/arm/mach-mxs/devices-mx23.h
> +++ b/arch/arm/mach-mxs/devices-mx23.h
> @@ -14,3 +14,9 @@
>  extern const struct amba_device mx23_duart_device __initconst;
>  #define mx23_add_duart() \
>  	mxs_add_duart(&mx23_duart_device)
> +
> +extern const struct mxs_dma_data mx23_dma_data[] __initconst;
> +#define mx23_add_apbh_dma() \
> +	mxs_add_dma(&mx23_dma_data[0])
> +#define mx23_add_apbx_dma() \
> +	mxs_add_dma(&mx23_dma_data[1])
> diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
> index 3b18304..e3a3bbc 100644
> --- a/arch/arm/mach-mxs/devices-mx28.h
> +++ b/arch/arm/mach-mxs/devices-mx28.h
> @@ -23,6 +23,12 @@ extern const struct mxs_auart_data mx28_auart_data[] __initconst;
>  #define mx28_add_auart3()		mx28_add_auart(3)
>  #define mx28_add_auart4()		mx28_add_auart(4)
>  
> +extern const struct mxs_dma_data mx28_dma_data[] __initconst;
> +#define mx28_add_apbh_dma() \
> +	mxs_add_dma(&mx28_dma_data[0])
> +#define mx28_add_apbx_dma() \
> +	mxs_add_dma(&mx28_dma_data[1])
> +

Given that the DMA device is fully internal to the SoC and always
present, does it make sense to add it dynamically and to leave
registration to the boards?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
