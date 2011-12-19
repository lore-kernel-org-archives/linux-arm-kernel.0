From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 11:07:37 -0800
Subject: [PATCH 01/20] ARM: clean up idle handlers
In-Reply-To: <1324288069-21940-2-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-2-git-send-email-nico@fluxnic.net>
Message-ID: <20111219190736.GK6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111219 01:20]:
> Let's factor out the need_resched() check instead of having it duplicated
> in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
> was missing it already).
> 
> The forceful re-enablement of IRQs after pm_idle has returned can go.
> The warning certainly doesn't trigger for existing users.  Similar for
> the redundant local_irq_disable() call in the OMAP implementations.
> 
> To get rid of the pm_idle calling convention oddity, let's introduce
> arm_pm_idle() allowing for the local_irq_enable() to be factored out
> from SOC specific implementations. The default pm_idle function becomes
> a wrapper for arm_pm_idle and it takes care of enabling IRQs closer to
> where they are initially disabled.
> 
> And finally move the comment explaining the reason for that turning off
> of IRQs to a more proper location.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

For omaps:

Tested-by: Tony Lindgren <tony@atomide.com>

For pm44xx.c the following merge will be needed for omap/omap4 branch
in arm-soc tree:

--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@@ -16,10 -17,10 +17,12 @@@
  #include <linux/err.h>
  #include <linux/slab.h>
  
 +#include <asm/system.h>
 +
  #include "common.h"
+ #include "clockdomain.h"
  #include "powerdomain.h"
+ #include "pm.h"
  
  struct power_state {
  	struct powerdomain *pwrdm;
@@@ -85,11 -161,30 +163,24 @@@ static int __init pwrdms_setup(struct p
  	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
  	if (!pwrst)
  		return -ENOMEM;
+ 
  	pwrst->pwrdm = pwrdm;
- 	pwrst->next_state = PWRDM_POWER_ON;
+ 	pwrst->next_state = PWRDM_POWER_RET;
  	list_add(&pwrst->node, &pwrst_list);
  
- 	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
+ 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+ }
+ 
+ /**
+  * omap_default_idle - OMAP4 default ilde routine.'
+  *
+  * Implements OMAP4 memory, IO ordering requirements which can't be addressed
+  * with default arch_idle() hook. Used by all CPUs with !CONFIG_CPUIDLE and
+  * by secondary CPU with CONFIG_CPUIDLE.
+  */
+ static void omap_default_idle(void)
+ {
 -	local_irq_disable();
 -	local_fiq_disable();
 -
+ 	omap_do_wfi();
 -
 -	local_fiq_enable();
 -	local_irq_enable();
  }
  
  /**
@@@ -117,6 -255,11 +251,11 @@@ static int __init omap4_pm_init(void
  	suspend_set_ops(&omap_pm_ops);
  #endif /* CONFIG_SUSPEND */
  
+ 	/* Overwrite the default arch_idle() */
 -	pm_idle = omap_default_idle;
++	arm_pm_idle = omap_default_idle;
+ 
+ 	omap4_idle_init();
+ 
  err2:
  	return ret;
  }

Regards,

Tony
