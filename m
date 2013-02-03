From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 3 Feb 2013 16:44:37 +0530
Subject: [PATCH v2 1/6] ARM: davinci: da850: fix clock lookup for mdio
 device
In-Reply-To: <1359380879-26306-2-git-send-email-prabhakar.lad@ti.com>
References: <1359380879-26306-1-git-send-email-prabhakar.lad@ti.com>
 <1359380879-26306-2-git-send-email-prabhakar.lad@ti.com>
Message-ID: <510E469D.9020807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/2013 7:17 PM, Prabhakar Lad wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> This patch removes the clock alias for mdio device and adds a entry
> in clock lookup table, this entry can now be used by both DT and NON
> DT case.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: netdev at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Heiko Schocher <hs@denx.de>
> ---
>  arch/arm/mach-davinci/da850.c         |    1 +
>  arch/arm/mach-davinci/devices-da8xx.c |    8 ++------
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 86056ca..f74bfb6 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -402,6 +402,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK(NULL,		"arm",		&arm_clk),
>  	CLK(NULL,		"rmii",		&rmii_clk),
>  	CLK("davinci_emac.1",	NULL,		&emac_clk),
> +	CLK("davinci_mdio.0",	"fck",		&emac_clk),
>  	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
>  	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
>  	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index 2d5502d..52faa05 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -444,12 +444,8 @@ int __init da8xx_register_emac(void)
>  	ret = platform_device_register(&da8xx_mdio_device);
>  	if (ret < 0)
>  		return ret;
> -	ret = platform_device_register(&da8xx_emac_device);
> -	if (ret < 0)
> -		return ret;
> -	ret = clk_add_alias(NULL, dev_name(&da8xx_mdio_device.dev),
> -			    NULL, &da8xx_emac_device.dev);
> -	return ret;
> +
> +	return platform_device_register(&da8xx_emac_device);

You added the look-up only for DA850 which means after this patch da830
network will be broken. Did you test on DA830?

Thanks,
Sekhar
