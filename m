From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Jul 2011 16:12:26 +0300
Subject: [PATCH V3 02/19] OMAP3+: voltage: fix build warning
In-Reply-To: <1299338962-5602-3-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-3-git-send-email-nm@ti.com>
Message-ID: <20110726131225.GO32582@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2011 at 08:59:05PM +0530, Nishanth Menon wrote:
> Handle the case for a future SoC where sys_ck_name might be
> uninitialized. Fixes the build warning:
> arch/arm/mach-omap2/voltage.c: In function 'omap_voltage_late_init':
> arch/arm/mach-omap2/voltage.c:86:8: warning: 'sys_ck_name' may be used uninitialized in this function
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index e0cbd93..56961df 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -91,10 +91,14 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
>  	 * XXX Clockfw should handle this, or this should be in a
>  	 * struct record
>  	 */
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>  		sys_ck_name = "sys_ck";
> -	else if (cpu_is_omap44xx())
> +	} else if (cpu_is_omap44xx()) {
>  		sys_ck_name = "sys_clkin_ck";
> +	} else {
> +		pr_err("%s: Unsupported OMAP\n", __func__);
> +		return -EINVAL;
> +	}
>  
>  	/*
>  	 * Sys clk rate is require to calculate vp timeout value and
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110726/7b6b64ce/attachment.sig>
