From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 14 Feb 2012 21:55:34 +0100
Subject: [PATCH 2/2] ARM: OMAP: am33xx: Hook-up am33xx support to existing
 cm code
In-Reply-To: <1329233348-23356-3-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Tue, 14 Feb 2012 20:59:08 +0530")
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
 <1329233348-23356-3-git-send-email-hvaibhav@ti.com>
Message-ID: <87fweduoc9.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Vaibhav" == Vaibhav Hiremath <hvaibhav@ti.com> writes:

 Vaibhav> Reuse existing omap4 cminst code for am33xx device,
 Vaibhav> add separate cm base table for am33xx device and initialize
 Vaibhav> it during __init for future use.

 Vaibhav> Also, since cpu_is_omap34xx() check is true for am33xx family of
 Vaibhav> devices, we must change the order of cpu_is_xxxx check, so first
 Vaibhav> check for cpu_is_am33xx() to follow right execution path.

 Vaibhav>  	if (cpu_is_omap44xx()) {
 Vaibhav>  		_cm_bases = omap44xx_cm_bases;
 Vaibhav>  		max_cm_partitions = ARRAY_SIZE(omap44xx_cm_bases);
 Vaibhav> +	} else if (cpu_is_am33xx()) {
 Vaibhav> +		_cm_bases =am33xx_cm_bases;

Space after '='.

 Vaibhav> +++ b/arch/arm/mach-omap2/omap_hwmod.c
 Vaibhav> @@ -737,7 +737,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 Vaibhav>  static void _enable_module(struct omap_hwmod *oh)
 Vaibhav>  {
 Vaibhav>  	/* The module mode does not exist prior OMAP4 */
 Vaibhav> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 Vaibhav> +	if (!cpu_is_omap44xx() && !cpu_is_am33xx())

Maybe update the comment as well?
 
 Vaibhav>  	/* The module mode does not exist prior OMAP4 */
 Vaibhav> -	if (!cpu_is_omap44xx())
 Vaibhav> +	if (!cpu_is_omap44xx() && !cpu_is_am33xx())
 Vaibhav>  		return -EINVAL;

Here as well.

Otherwise it looks good.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
