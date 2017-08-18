From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Aug 2017 20:29:47 -0500
Subject: [PATCH 3/3] ARM: OMAP5: Enable CPU off idle states
In-Reply-To: <20170817230122.30655-4-tony@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
 <20170817230122.30655-4-tony@atomide.com>
Message-ID: <c31a90c4-8dbe-926a-831c-5fac92ebae80@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2017 06:01 PM, Tony Lindgren wrote:
> With the idle code in place needed for supporting off mode for cpus,
> let's enable it. This seems to save about 0.2W of power compared to
> CPU retention states based on quick measurement on omap5-uevm.

That makes sense since the Silicon you probably have is pre-production 
silicon.

> 
> Some parts of the code is based on an earlier patch done by Santosh
> Shilimkar <santosh.shilimkar@oracle.com> in TI Linux kernel tree as
> commit 7e3035cf0e9b ("ARM: OMAP4+: CPUidle: Add OMAP5 idle driver
> support")
> 


unfortunately, you have been looking at some preproduction code which 
was being developed prior to the silicon going into production (also 
the reason why I have'nt upstreamed those changes).

> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -225,7 +225,7 @@ int __init omap4_pm_init_early(void)
>   	if (cpu_is_omap446x())
>   		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
>   
> -	if (soc_is_omap54xx() || soc_is_dra7xx())
> +	if (soc_is_dra7xx())
>   		pm44xx_errata |= PM_OMAP4_CPU_OSWR_DISABLE;
>   
>   	return 0;
> diff --git a/arch/arm/mach-omap2/powerdomains54xx_data.c b/arch/arm/mach-omap2/powerdomains54xx_data.c
> --- a/arch/arm/mach-omap2/powerdomains54xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains54xx_data.c
> @@ -107,8 +107,8 @@ static struct powerdomain cpu0_54xx_pwrdm = {
>   	.voltdm		  = { .name = "mpu" },
>   	.prcm_offs	  = OMAP54XX_PRCM_MPU_PRM_C0_INST,
>   	.prcm_partition	  = OMAP54XX_PRCM_MPU_PARTITION,
> -	.pwrsts		  = PWRSTS_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> +	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>   	.banks		  = 1,
>   	.pwrsts_mem_ret	= {
>   		[0] = PWRSTS_OFF_RET,	/* cpu0_l1 */
> @@ -124,8 +124,8 @@ static struct powerdomain cpu1_54xx_pwrdm = {
>   	.voltdm		  = { .name = "mpu" },
>   	.prcm_offs	  = OMAP54XX_PRCM_MPU_PRM_C1_INST,
>   	.prcm_partition	  = OMAP54XX_PRCM_MPU_PARTITION,
> -	.pwrsts		  = PWRSTS_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> +	.pwrsts		  = PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>   	.banks		  = 1,
>   	.pwrsts_mem_ret	= {
>   		[0] = PWRSTS_OFF_RET,	/* cpu1_l1 */
> @@ -158,7 +158,7 @@ static struct powerdomain mpu_54xx_pwrdm = {
>   	.prcm_offs	  = OMAP54XX_PRM_MPU_INST,
>   	.prcm_partition	  = OMAP54XX_PRM_PARTITION,
>   	.pwrsts		  = PWRSTS_RET_ON,
> -	.pwrsts_logic_ret = PWRSTS_RET,
> +	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>   	.banks		  = 2,
>   	.pwrsts_mem_ret	= {
>   		[0] = PWRSTS_OFF_RET,	/* mpu_l2 */
> 

unfortunately, I have to NAK this patch.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f5dc91b691cf296c49aedf0a671fd659a70f737
as per Technical Reference Manual SWPU282AF?May 2012?Revised August 2016,
PM_MPU_PWRSTCTRL can only support: ON INA, RET. (CSWR only).

Same applies to CPUs as well. which was the reason in the first place 
for me to send the patch upstream.

-- 
Regards,
Nishanth Menon
