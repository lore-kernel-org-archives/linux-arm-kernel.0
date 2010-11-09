From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 09 Nov 2010 15:29:06 -0800
Subject: [PATCH v3 10/13] OMAP: DMA: Convert DMA library into DMA platform
	Driver
In-Reply-To: <1288099513-1854-11-git-send-email-manjugk@ti.com> (Manjunath
	Kondaiah G.'s message of "Tue, 26 Oct 2010 18:55:10 +0530")
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-11-git-send-email-manjugk@ti.com>
Message-ID: <871v6uhy9p.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Convert DMA library into DMA platform driver and make use
> of platform data provided by HWMOD data base for OMAP2PLUS onwards.
> For OMAP1 processors, the DMA driver in mach-omap uses resource
> structures for getting platform data.
>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/Makefile           |    2 +-
>  arch/arm/mach-omap1/dma.c              |  180 ++++++++++++++++++-
>  arch/arm/mach-omap2/Makefile           |    2 +-
>  arch/arm/mach-omap2/dma.c              |  209 +++++++++++++++++++++-
>  arch/arm/mach-omap2/include/mach/dma.h |    3 +
>  arch/arm/plat-omap/dma.c               |  321 +++++++++++---------------------
>  arch/arm/plat-omap/include/plat/dma.h  |   50 ++++--
>  7 files changed, 538 insertions(+), 229 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 9a304d8..b7dfc54 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -3,7 +3,7 @@
>  #
>  
>  # Common support
> -obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
> +obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o dma.o
>  obj-y += clock.o clock_data.o opp_data.o
>  
>  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index e756069..38a7294 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -35,6 +35,81 @@
>  #include <plat/tc.h>
>  
>  #define OMAP1_DMA_BASE			(0xfffed800)
> +#define OMAP1_LOGICAL_DMA_CH_COUNT	17
> +
> +static u32 errata;
> +static u32 enable_1510_mode;
> +
> +enum {
> +	GCR1 = 0,	GSCR,		GRST,		HW_ID,
> +	PCH2_ID,	PCH0_ID,	PCH1_ID,	PCHG_ID,
> +	PCHD_ID,	CAPS_0_U,	CAPS_0_L,	CAPS_1_U,
> +	CAPS_1_L,	CAPS_2,		CAPS_3,		CAPS_4,
> +	PCH2_SR,	PCH0_SR,	PCH1_SR,	PCHD_SR,
> +
> +	CH_COMMON_START,
> +
> +	/* Common Registers */
> +	CSDP1,		CCR1,		CICR1,		CSR1,
> +	CEN1,		CFN1,		CSFI1,		CSEI1,
> +	CPC,		CSAC1,		CDAC1,		CDEI1,
> +	CDFI1,		CLNK_CTRL1,
> +
> +	/* Channel specific register offsets */
> +	CSSA_L,		CSSA_U,		CDSA_L,		CDSA_U,
> +	COLOR_L,	COLOR_U,	CCR1_2,		LCH_CTRL,
> +
> +	CH_COMMON_END,
> +};

These reg_map enums are added here, then promptly moved in the following
patch.  Please just put them in the right place earlier in the series.
Also, at this point, similar versions also still exist in
plat-omap/dma.c

This may be a good technique for inflating the number of lines changed
in the git history, but it is not review friendly.

Kevin
