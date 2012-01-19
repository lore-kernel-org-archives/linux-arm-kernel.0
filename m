From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jan 2012 14:32:42 +0800
Subject: [PATCH] ARM: mxs: add GPMI-NAND support for imx23/imx28
In-Reply-To: <1326937424-19786-1-git-send-email-b32955@freescale.com>
References: <1326937424-19786-1-git-send-email-b32955@freescale.com>
Message-ID: <20120119063240.GC2247@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 09:43:44AM +0800, Huang Shijie wrote:
> add GPMI-NAND support for imx23 and imx28.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/clock-mx23.c                  |    1 +
>  arch/arm/mach-mxs/clock-mx28.c                  |    1 +
>  arch/arm/mach-mxs/devices-mx23.h                |    4 +
>  arch/arm/mach-mxs/devices-mx28.h                |    4 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-gpmi-nand.c  |  109 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++
>  8 files changed, 133 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nand.c
> 
...
> +#ifdef CONFIG_SOC_IMX23
> +const struct mxs_gpmi_nand_data mx23_gpmi_nand_data __initconst = {
> +	.devid = "imx23-gpmi-nand",
> +	.res = {
> +		{	/* GPMI */
> +			.start = MX23_GPMI_BASE_ADDR,
> +			.end   = MX23_GPMI_BASE_ADDR + SZ_8K - 1,
> +			.name  = GPMI_NAND_GPMI_REGS_ADDR_RES_NAME,
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = MX23_INT_GPMI_ATTENTION,
> +			.end   = MX23_INT_GPMI_ATTENTION,
> +			.name  = GPMI_NAND_GPMI_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		}, {	/* BCH */
> +			.start = MX23_BCH_BASE_ADDR,
> +			.end   = MX23_BCH_BASE_ADDR + SZ_8K - 1,
> +			.name  = GPMI_NAND_BCH_REGS_ADDR_RES_NAME,
> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = MX23_INT_BCH,
> +			.end   = MX23_INT_BCH,
> +			.name  = GPMI_NAND_BCH_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		}, {	/* DMA */
> +			.start	= MX23_DMA_GPMI0,
> +			.end	= MX23_DMA_GPMI3,
> +			.name  = GPMI_NAND_DMA_CHANNELS_RES_NAME,
> +			.flags = IORESOURCE_DMA,
> +		}, {
> +			.start = MX23_INT_GPMI_DMA,
> +			.end   = MX23_INT_GPMI_DMA,
> +			.name  = GPMI_NAND_DMA_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	},
> +};
> +#endif
> +
> +#ifdef CONFIG_SOC_IMX28
> +const struct mxs_gpmi_nand_data mx28_gpmi_nand_data __initconst = {
> +	.devid = "imx28-gpmi-nand",
> +	.res = {
> +		{	/* GPMI */
> +			.start = MX28_GPMI_BASE_ADDR,
> +			.end   = MX28_GPMI_BASE_ADDR + SZ_8K - 1,
> +			.name  = GPMI_NAND_GPMI_REGS_ADDR_RES_NAME,
> +			.flags = IORESOURCE_MEM,
> +		 }, {
> +			.start = MX28_INT_GPMI,
> +			.end   = MX28_INT_GPMI,
> +			.name  = GPMI_NAND_GPMI_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		}, {	/* BCH */
> +			.start = MX28_BCH_BASE_ADDR,
> +			.end   = MX28_BCH_BASE_ADDR + SZ_8K - 1,
> +			.name  = GPMI_NAND_BCH_REGS_ADDR_RES_NAME,
> +			.flags = IORESOURCE_MEM,
> +		 }, {
> +			.start = MX28_INT_BCH,
> +			.end   = MX28_INT_BCH,
> +			.name  = GPMI_NAND_BCH_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		 }, {	/* DMA */
> +			.start	= MX28_DMA_GPMI0,
> +			.end	= MX28_DMA_GPMI7,
> +			.name	= GPMI_NAND_DMA_CHANNELS_RES_NAME,
> +			.flags	= IORESOURCE_DMA,
> +		 }, {
> +			.start = MX28_INT_GPMI_DMA,
> +			.end   = MX28_INT_GPMI_DMA,
> +			.name  = GPMI_NAND_DMA_INTERRUPT_RES_NAME,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	},

You now can use the DEFINE_RES_* helper created by commit a0e44d4 (include/linux/ioport.h:
new helper to define common struct resource constructs) for these
definitions.

Other than that, the patch looks good to me.

> +};
> +#endif

-- 
Regards,
Shawn
