From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 29 Feb 2012 18:44:24 -0700 (MST)
Subject: [PATCH-V2 2/2] arm:omap:am33xx: Add power domain data
In-Reply-To: <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
References: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
 <1324803628-16790-3-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1202291839130.12752@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

some other observations:

On Sun, 25 Dec 2011, Vaibhav Hiremath wrote:

> +static struct powerdomain per_33xx_pwrdm = {
> +	.name			= "per_pwrdm",
> +	.voltdm			= { .name = "core" },
> +	.prcm_partition		= AM33XX_PRM_PARTITION,
> +	.prcm_offs		= AM33XX_PRM_PER_MOD,
> +	.pwrsts			= PWRSTS_OFF_RET_ON,
> +	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
> +	.pwrstctrl_offs		= AM33XX_PM_PER_PWRSTCTRL_OFFSET,
> +	.pwrstst_offs		= AM33XX_PM_PER_PWRSTST_OFFSET,
> +	.flags			= PWRDM_HAS_LOWPOWERSTATECHANGE,
> +	.banks			= 3,
> +	.pwrsts_mem_ret		= {
> +		[0]	= PWRSTS_OFF_RET,	/* icss_mem */
> +		[1]	= PWRSTS_OFF_RET,	/* per_mem */
> +		[2]	= PWRSTS_OFF_RET,	/* ram_mem */
> +	},
> +	.pwrsts_mem_on		= {
> +		[0]	= PWRSTS_ON,		/* icss_mem */
> +		[1]	= PWRSTS_ON,		/* per_mem */
> +		[2]	= PWRSTS_ON,		/* ram_mem */
> +	},
> +};

According to SPRUH73C Table 8-184 "PM_PER_PWRSTCTRL Register Field 
Descriptions" the pwrsts_mem_on field for RAM_MEM should be 
PWRSTS_OFF_RET_ON.

> +static struct powerdomain mpu_33xx_pwrdm = {
> +     .name                   = "mpu_pwrdm",
> +     .voltdm                 = { .name = "mpu" },
> +     .prcm_partition         = AM33XX_PRM_PARTITION,
> +     .prcm_offs              = AM33XX_PRM_MPU_MOD,
> +     .pwrsts                 = PWRSTS_OFF_RET_ON,
> +     .pwrsts_logic_ret       = PWRSTS_OFF_RET,
> +     .pwrstctrl_offs         = AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
> +     .pwrstst_offs           = AM33XX_PM_MPU_PWRSTST_OFFSET,
> +     .flags                  = PWRDM_HAS_LOWPOWERSTATECHANGE,
> +     .banks                  = 3,
> +     .pwrsts_mem_ret         = {
> +             [0]     = PWRSTS_OFF_RET,       /* mpu_l1 */
> +             [1]     = PWRSTS_OFF_RET,       /* mpu_l2 */
> +             [2]     = PWRSTS_OFF_RET,       /* mpu_ram */
> +     },

Again SPRUH73C Table 8-191 "PM_MPU_PWRSTCTRL Register Field Descriptions" 
claims these should simply by PWRSTS_RET.

> +     .pwrsts_mem_on          = {
> +             [0]     = PWRSTS_ON,            /* mpu_l1 */
> +             [1]     = PWRSTS_ON,            /* mpu_l2 */
> +             [2]     = PWRSTS_ON,            /* mpu_ram */
> +     },
> +};

And the same table claims the MPU_RAM pwrsts_mem_on field should be 
PWRSTS_OFF_ON.

Can you please reconcile these differences and let us know which values 
should be correct?

thanks


- Paul
