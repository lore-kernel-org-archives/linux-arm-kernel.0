From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:45:01 +0100
Subject: [PATCH v2] ARM: mx3: Setup AIPS registers
In-Reply-To: <1330431826-29217-1-git-send-email-fabio.estevam@freescale.com>
References: <1330431826-29217-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120229084501.GW3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 09:23:46AM -0300, Fabio Estevam wrote:
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
> Changes since v1:
> - Make sure post_cpu_init() only runs on mx31
> - Place imx_set_aips() in a common location so that other SoCs can use it.
> - Improve comments about OPACRx
> 
>  arch/arm/mach-imx/cpu-imx31.c           |   11 +++++++++++
>  arch/arm/plat-mxc/cpu.c                 |   24 ++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  3 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
> index 3f2345f..8841039 100644
> --- a/arch/arm/mach-imx/cpu-imx31.c
> +++ b/arch/arm/mach-imx/cpu-imx31.c
> @@ -60,3 +60,14 @@ int mx31_revision(void)
>  	return mx31_cpu_rev;
>  }
>  EXPORT_SYMBOL(mx31_revision);
> +
> +static int __init post_cpu_init(void)
> +{
> +	if (cpu_is_mx31()) {
> +		imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
> +		imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(post_cpu_init);

I think we should add this to imx31_soc_init() instead of adding an
initcall for it in which we have to check for the cpu type. Sorry for
not mentioning it in v1.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
