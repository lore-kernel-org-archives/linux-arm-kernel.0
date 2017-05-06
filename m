From: jdelvare@suse.de (Jean Delvare)
Date: Sat, 6 May 2017 10:00:59 +0200
Subject: [PATCH 4/6] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
In-Reply-To: <1493997974-17699-5-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-5-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170506100059.6003d9ef@endymion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Fri, 5 May 2017 23:26:12 +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT2701/MT7623 is an 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> single cluster and this hardware is also compatible with the existing
> driver through enabling CPU frequency feature with operating-points-v2
> bindings.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm      | 4 ++--
>  drivers/cpufreq/mt8173-cpufreq.c | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 74ed7e9..68b387a 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -90,11 +90,11 @@ config ARM_KIRKWOOD_CPUFREQ
>  config ARM_MT8173_CPUFREQ
>  	tristate "Mediatek MT8173 CPUFreq support"
>  	depends on ARCH_MEDIATEK && REGULATOR
> -	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
> +	depends on (ARM || ARM64) || (ARM_CPU_TOPOLOGY && COMPILE_TEST)

Parentheses not needed. I am also curious if ARM_CPU_TOPOLOGY can
actually be set when neither ARM nor ARM64 is. I suspect not, and then
the above can be simplified to just:

	depends on ARM || ARM64

>  	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
> -	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
> +	  This adds the CPUFreq driver support for Mediatek SoCs.

If this driver actually support all Mediatek SoCs, the menu entry
itself should be updated to drop "MT8173".

>  
>  config ARM_OMAP2PLUS_CPUFREQ
>  	bool "TI OMAP2+"
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index fd1886f..481ec77 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -575,6 +575,8 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
>  
>  /* List of machines supported by this driver */
>  static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
> +	{ .compatible = "mediatek,mt2701", },
> +	{ .compatible = "mediatek,mt7623", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },


-- 
Jean Delvare
SUSE L3 Support
