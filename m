From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:48:18 -0800
Subject: [PATCH] clk: ti: omap5+: dpll: implement errata i810
In-Reply-To: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
References: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
Message-ID: <20151203164817.GT23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [151130 06:44]:
> +	/*
> +	 * Errata i810 - DPLL controller can get stuck while transitioning
> +	 * to a power saving state. Software must ensure the DPLL can not
> +	 * transition to a low power state while changing M/N values.
> +	 * Easiest way to accomplish this is to prevent DPLL autoidle
> +	 * before doing the M/N re-program.
> +	 */
> +	errata_i810 = ti_clk_get_features()->flags & TI_CLK_ERRATA_I810;
> +
> +	if (errata_i810) {
> +		ai = omap3_dpll_autoidle_read(clk);
> +		if (ai) {
> +			omap3_dpll_deny_idle(clk);
> +
> +			/* OCP barrier */
> +			omap3_dpll_autoidle_read(clk);
> +		}
> +	}

Should we just do this unconditionally? It seems like disabling the
autoidle always before reprogramming is a good idea.

Regards,

Tony
