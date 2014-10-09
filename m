From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 10 Oct 2014 02:10:03 +0400
Subject: [PATCH V2] ARM: tegra: Re-add removed SoC id macro to
 tegra_resume()
In-Reply-To: <1412796255-10589-1-git-send-email-digetx@gmail.com>
References: <20141008190432.GN22688@saruman>
 <1412796255-10589-1-git-send-email-digetx@gmail.com>
Message-ID: <543707BB.1040603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

08.10.2014 23:24, Dmitry Osipenko ?????:
> Commit d127e9c5c5bc1ee22a7b1fe804397cddd132f756 ("ARM: tegra: make tegra_resume
> can work with current and later chips") removed tegra_get_soc_id macro leaving
> used cpu register unassigned and as result causing execution of unintended code
> on tegra20. Fix it by re-adding macro.
> 
> Fixes: d127e9c (ARM: tegra: make tegra_resume can work with current and later chips)
> Cc: <stable@vger.kernel.org> # v3.13+
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> V2: added Cc's for lakml and stable, added "Reviewed-by:" Felipe Balbi
> 
>  arch/arm/mach-tegra/reset-handler.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> index 7b2baab..71be4af 100644
> --- a/arch/arm/mach-tegra/reset-handler.S
> +++ b/arch/arm/mach-tegra/reset-handler.S
> @@ -51,6 +51,7 @@ ENTRY(tegra_resume)
>   THUMB(	it	ne )
>  	bne	cpu_resume			@ no
>  
> +	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
>  	/* Are we on Tegra20? */
>  	cmp	r6, #TEGRA20
>  	beq	1f				@ Yes
> 
Ugh, I just noticed that r6 is expected to be SoC id func argument. It was bug
in my emulator that blinded me, so please drop that patch.
But, seems tegra20_lp1_reset() doesn't set r6, at least for now I don't see
where. I'll check it on real hw and send patch if needed.

-- 
Dmitry
