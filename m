From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 12:23:10 -0600
Subject: [PATCH V2 2/4] ARM: tegra: Add OF_DEV_AUXDATA for SLINK driver
 in board dt
In-Reply-To: <1351531180-1652-3-git-send-email-ldewangan@nvidia.com>
References: <1351531180-1652-1-git-send-email-ldewangan@nvidia.com>
 <1351531180-1652-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <508EC98E.902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 11:19 AM, Laxman Dewangan wrote:
> Add OF_DEV_AUXDATA for slink driver for Tegra20 and Tegra30
> board dt files.
> Set the parent clock of slink controller to PLLP and configure
> clock to 100MHz.

> diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c

> @@ -90,6 +90,10 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
>  		       &tegra_ehci3_pdata),
>  	OF_DEV_AUXDATA("nvidia,tegra20-apbdma", TEGRA_APB_DMA_BASE, "tegra-apbdma", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK1_BASE, "spi_tegra.0", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK2_BASE, "spi_tegra.1", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK3_BASE, "spi_tegra.2", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK4_BASE, "spi_tegra.3", NULL),

I would rather hard-code the addresses there (e.g. write literally
0x7000d400), and hence not have to edit iomap.h;

> diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h

> -#define TEGRA_SPI1_BASE			0x7000D400
> -#define TEGRA_SPI1_SIZE			SZ_512
> +#define TEGRA_SLINK1_BASE		0x7000D400
> +#define TEGRA_SLINK1_SIZE		SZ_512

As I wrote for V1:

Lets not add [or change] anything to iomap.h; we're trying to remove it.
Instead, just put the raw address in the AUXDATA; I assume that's the
only place these defines end up being used...

Aside from that, this series looks fine.
