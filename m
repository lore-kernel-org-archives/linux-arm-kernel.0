From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Feb 2012 09:21:22 +0100
Subject: [PATCH] ARM: mx3: Setup AIPS registers
In-Reply-To: <1330398901-20211-1-git-send-email-festevam@gmail.com>
References: <1330398901-20211-1-git-send-email-festevam@gmail.com>
Message-ID: <20120228082122.GJ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 12:15:01AM -0300, Fabio Estevam wrote:
> It was observed on a mx31pdk board that audio playback only worked when the bootloader was Redboot, and 
> did not work when U-boot was used. 
> 
> Comparing the sources of these bootloaders showed that the AIPS registers were not setup in U-boot.
> 
> Instead of relying on the bootloader to setup the AIPS registers, do it in the kernel so that audio
> playback can work independantly of the bootloader being used.
> 
> Copied the AIPS settings from Redboot to the kernel.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/cpu-imx31.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
> index 3f2345f..c309d51 100644
> --- a/arch/arm/mach-imx/cpu-imx31.c
> +++ b/arch/arm/mach-imx/cpu-imx31.c
> @@ -60,3 +60,35 @@ int mx31_revision(void)
>  	return mx31_cpu_rev;
>  }
>  EXPORT_SYMBOL(mx31_revision);
> +
> +static void __init imx_set_aips(void __iomem *base)
> +{
> +	unsigned int reg;
> +/*
> + * Set all MPROTx to be non-bufferable, trusted for R/W,
> + * not forced to user-mode.
> + */
> +	__raw_writel(0x77777777, base + 0x0);
> +	__raw_writel(0x77777777, base + 0x4);
> +
> +/*
> + * Clear the on and off peripheral modules Supervisor Protect bit
> + * for SDMA to access them. Did not change the AIPS control registers
> + * (offset 0x20) access type
> + */
> +	__raw_writel(0x0, base + 0x40);
> +	__raw_writel(0x0, base + 0x44);
> +	__raw_writel(0x0, base + 0x48);
> +	__raw_writel(0x0, base + 0x4C);
> +	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
> +	__raw_writel(reg, base + 0x50);
> +}
> +
> +static int __init post_cpu_init(void)
> +{
> +	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
> +	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
> +
> +	return 0;
> +}
> +postcore_initcall(post_cpu_init);

Nah, you don't want this code to run on all SoCs compiled into
the kernel, do you?

BTW the AIPS setup looks useful for other SoCs aswell, maybe
imx_set_aips should go to a more general place?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
