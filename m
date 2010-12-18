From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 17 Dec 2010 17:14:13 -0800
Subject: [PATCH 1/3] OMAP2+: powerdomain: add API to get context loss count
Message-ID: <1292634855-14728-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new powerdomain API

    u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)

for checking how many times the powerdomain has lost context.  The
loss count is the sum sum of the powerdomain off-mode counter, the
logic off counter and the per-bank memory off counter.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c |   26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    1 +
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 06ef60e..b147a82 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -909,3 +909,29 @@ int pwrdm_post_transition(void)
 	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
+
+/**
+ * pwrdm_get_context_loss_count - get powerdomain's context loss count
+ * @pwrdm: struct powerdomain * to wait for
+ *
+ * Context loss count is a sum of powerdomain off-mode counter,
+ * the logic off counter and the per-bank memory off counter.
+ */
+u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
+{
+	int i, count;
+
+	if (!pwrdm)
+		return -EINVAL;
+
+	count = pwrdm->state_counter[PWRDM_POWER_OFF];
+	count += pwrdm->ret_logic_off_counter;
+
+	for (i = 0; i < pwrdm->banks; i++)
+		count += pwrdm->ret_mem_off_counter[i];
+
+	pr_debug("powerdomain: %s: context loss count = %u\n",
+		 pwrdm->name, count);
+
+	return count;
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 35b5b48..c66431e 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -211,6 +211,7 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
 int pwrdm_pre_transition(void);
 int pwrdm_post_transition(void);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
+u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 
 extern void omap2xxx_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
-- 
1.7.2.1
