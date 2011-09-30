From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 30 Sep 2011 12:41:44 -0600 (MDT)
Subject: [PATCH v5 3/3] OMAP2+: voltage: add check for missing PMIC info
	in vp init
In-Reply-To: <1317363153-10259-4-git-send-email-abhilash.kv@ti.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-3-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-4-git-send-email-abhilash.kv@ti.com>
Message-ID: <alpine.DEB.2.00.1109301240070.12185@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 30 Sep 2011, Abhilash K V wrote:

> From: Abhilash K V <abhilash.kv@ti.com>
> 
> If PMIC info is not available in omap_vp_init(), abort.
> 
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/vp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..0ed3d13 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -41,6 +41,13 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	u32 val, sys_clk_rate, timeout, waittime;
>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>  
> +	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
> +		pr_err("%s: PMIC info requried to configure VP for "
> +			"vdd_%s not populated.Hence cannot initialize VP\n",
> +			__func__, voltdm->name);
> +		return;
> +	}
> +

Just wondering about the intent of this patch.  Is the goal here to not 
call omap_vp_init() for chips that don't have a VP IP block?  If so, then 
implementing code that does that directly seems like a better approach 
than using the PMIC data?  Because it seems likely that even SoCs without 
VP IP blocks will have PMICs on the board, right?


- Paul
