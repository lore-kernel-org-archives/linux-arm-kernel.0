From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 Jan 2013 16:01:24 +0200
Subject: [PATCH 06/12] ARM: OMAP44xx: PM: convert to use the functional
 power states API
In-Reply-To: <20121209175313.6933.36300.stgit@dusk.lan>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175313.6933.36300.stgit@dusk.lan>
Message-ID: <1357308084.2221.101.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sun, 2012-12-09 at 10:53 -0700, Paul Walmsley wrote:

<clip>

> @@ -40,20 +39,19 @@ static LIST_HEAD(pwrst_list);
>  static int omap4_pm_suspend(void)
>  {
>  	struct power_state *pwrst;
> -	int state, ret = 0;
> +	int prev_fpwrst;
> +	int ret = 0;
>  	u32 cpu_id = smp_processor_id();
>  
> +	/* XXX Seems like these two loops could be combined into one loop? */
> +

They can be combined yes.

<clip>

> @@ -113,10 +113,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  		return -ENOMEM;
>  
>  	pwrst->pwrdm = pwrdm;
> -	pwrst->next_state = PWRDM_POWER_RET;
> +	pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
>  	list_add(&pwrst->node, &pwrst_list);
>  
> -	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
> +	return WARN_ON(pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_fpwrst));

This causes a regression on omap4, as several power domains can't idle
after this anymore (they get programmed to ON state due to CSWR not
being supported on them.) Following patch fixes this problem (applies on
top of the whole set):

=============

From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 2 Jan 2013 18:05:42 +0200
Subject: [PATCH] ARM: OMAP4: PM: fix the power state setup

After the functional power state code changes, OMAP4 PM init code
programs
powerdomains now to ON state if the domain does not support CSWR. This
breaks
suspend and should be avoided.

Fixed by adding a loop to the pwrdms_setup code, that for each domain
selects
the next fpwrst based on following order: CSWR, OSWR, OFF, ON. This
allows
all the domains to enter supported low power states, instead of always
selecting ON.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 8775ee5..67f05fe 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -88,6 +88,13 @@ static int omap4_pm_suspend(void)
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
+	const u8 fpwrst_states[] = {
+		PWRDM_FUNC_PWRST_CSWR,
+		PWRDM_FUNC_PWRST_OSWR,
+		PWRDM_FUNC_PWRST_OFF,
+		PWRDM_FUNC_PWRST_ON,
+	};
+	int i;
 
 	if (!pwrdm->pwrsts)
 		return 0;
@@ -106,12 +113,17 @@ static int __init pwrdms_setup(struct powerdomain
*pwrdm, void *unused)
 
 	pwrst->pwrdm = pwrdm;
 	/*
-	 * XXX This should be replaced by explicit lists of
-	 * powerdomains with specific powerstates to set
+	 * We attempt to program the fpwrst of a domain in the following
+	 * order: CSWR, OSWR, OFF, ON. This is needed as some domains
+	 * don't support retention, and instead should go to off in low
+	 * power modes. If everything else fails, the code falls back
+	 * to ON state.
 	 */
-	pwrst->next_fpwrst = PWRDM_FUNC_PWRST_CSWR;
-	if (!pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
-		pwrst->next_fpwrst = PWRDM_FUNC_PWRST_ON;
+	for (i = 0; i < ARRAY_SIZE(fpwrst_states); i++) {
+		pwrst->next_fpwrst = fpwrst_states[i];
+		if (pwrdm_supports_fpwrst(pwrdm, pwrst->next_fpwrst))
+			break;
+	}
 	list_add(&pwrst->node, &pwrst_list);
 
 	return WARN_ON(pwrdm_set_fpwrst(pwrst->pwrdm, pwrst->next_fpwrst));
-- 
1.7.4.1
