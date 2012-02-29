From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 29 Feb 2012 10:22:30 -0700 (MST)
Subject: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
In-Reply-To: <1330525621-29836-5-git-send-email-t-kristo@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
 <1330525621-29836-5-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1202291009500.12752@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

a quick comment on this one

On Wed, 29 Feb 2012, Tero Kristo wrote:

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e97ec3f..e6c2d39 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
>  		goto err1;
>  	}
>  
> +	if (omap3_has_io_wakeup())
> +		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> +					   PM_WKEN);
> +

Let's avoid adding any more direct PRM or CM register accesses to code 
outside the PRM & CM files.  Instead let's use higher-level interfaces 
that are independent of the underlying OMAP SoC.  There are two 
motivations.  The first is to make the PM code as OMAP SoC-independent as 
possible, and low-level register manipulations are SoC-dependent.  The 
second motivation is that we eventually want to move the PRM and CM code 
(and ultimately the PM code) out of arch/arm/mach-omap2 into drivers/.

So for this we'd need some code to control the WKEN bits.  Maybe 
omap_prm_{disable,enable}_wakeup_from_module() or 
pwrdm_{enable,disable}_wakeup_from_module() ?


- Paul
