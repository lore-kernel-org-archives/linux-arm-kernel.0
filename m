From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Jul 2011 08:56:27 +0530
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states as ON
	at init
Message-ID: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Program all powerdomain target state as ON; This is to
prevent domains from hitting low power states (if bootloader
has target states set to something other than ON) and potentially
even losing context while PM is not fully initilized.
The PM late init code can then program the desired target
state for all the power domains.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e0490bc..e61866c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 
 	list_add(&pwrdm->node, &pwrdm_list);
 
+	/*
+	* Program all powerdomain target state as ON; This is to
+	* prevent domains from hitting low power states (if bootloader
+	* has target states set to something other than ON) and potentially
+	* even losing context while PM is not fully initilized.
+	* The PM late init code can then program the desired target
+	* state for all the power domains.
+	*/
+	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);
+
 	/* Initialize the powerdomain's state counter */
 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
@@ -218,7 +228,7 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 /**
  * pwrdm_init - set up the powerdomain layer
  * @pwrdm_list: array of struct powerdomain pointers to register
- * @custom_funcs: func pointers for arch specific implementations
+ * @custom_funcs: func pointers for arch specfic implementations
  *
  * Loop through the array of powerdomains @pwrdm_list, registering all
  * that are available on the current CPU. If pwrdm_list is supplied
-- 
1.7.4.1
