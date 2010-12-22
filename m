From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 22 Dec 2010 15:04:17 -0800
Subject: [PATCH] OMAP2: PM: fix compile error when !CONFIG_SUSPEND
Message-ID: <1293059057-16490-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_SUSPEND is not enabled, none of the system PM methods are
used, so do not compile them in.

Thanks to Charles Manning for reporting the problem and proposing
an initial patch.

Reported-by: Charles Manning <manningc2@actrix.gen.nz>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies on Tony's omap-for-linus branch.

 arch/arm/mach-omap2/pm24xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2844b84..dac2d1d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -299,6 +299,7 @@ out:
 	local_irq_enable();
 }
 
+#ifdef CONFIG_SUSPEND
 static int omap2_pm_begin(suspend_state_t state)
 {
 	disable_hlt();
@@ -355,6 +356,9 @@ static struct platform_suspend_ops omap_pm_ops = {
 	.end		= omap2_pm_end,
 	.valid		= suspend_valid_only_mem,
 };
+#else
+static const struct platform_suspend_ops __initdata omap_pm_ops;
+#endif /* CONFIG_SUSPEND */
 
 /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
 static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
-- 
1.7.3.4
