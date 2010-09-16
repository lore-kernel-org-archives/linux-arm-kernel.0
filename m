From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Sep 2010 17:21:35 -0700
Subject: [PATCH 3/6] omap4: l2x0: Override the default l2x0_disable
In-Reply-To: <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
	<1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100916002134.GL4174@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100907 00:50]:
> The machine_kexec() calls outer_disable which can crash on OMAP4
> becasue of trustzone restrictions.
> 
> This patch overrides the default l2x0_disable with a OMAP4
> specific implementation taking care of trustzone

<snip>

> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/
> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);

Just to be sure.. No outer_cache functions get set unless
l2x0_init gets called, right? So omap2 and omap3 functions
always stay NULL with omap3_defconfig?

Tony
