From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 14:39:17 -0700
Subject: [PATCH v4 3/3] OMAP2+: voltage: add check for missing PMIC info
	in vp init
In-Reply-To: <1316697993-696-4-git-send-email-abhilash.kv@ti.com> (Abhilash
	K. V.'s message of "Thu, 22 Sep 2011 18:56:33 +0530")
References: <1316697993-696-1-git-send-email-abhilash.kv@ti.com>
	<1316697993-696-2-git-send-email-abhilash.kv@ti.com>
	<1316697993-696-3-git-send-email-abhilash.kv@ti.com>
	<1316697993-696-4-git-send-email-abhilash.kv@ti.com>
Message-ID: <87mxdws1dm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash K V <abhilash.kv@ti.com> writes:

> If PMIC info is not available in omap_vp_init(), abort.
>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

Looks good, some minor nitpicking below...

> ---
>  arch/arm/mach-omap2/vp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..2c99837 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -41,6 +41,13 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
>  	u32 val, sys_clk_rate, timeout, waittime;
>  	u32 vddmin, vddmax, vstepmin, vstepmax;
>  
> +	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
> +		pr_err("%s: PMIC info requried to configure vp for"

nit 1: s/vp/VP/

nit 2: need a space at the end of this string, otherwise the "vdd_" will
be right after the "for" with no spaces.

> +			"vdd_%s not populated.Hence cannot initialize vp\n",

nit 3: Add space after '.'

Kevin

> +			__func__, voltdm->name);
> +		return;
> +	}
> +
>  	if (!voltdm->read || !voltdm->write) {
>  		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
>  			__func__, voltdm->name);
