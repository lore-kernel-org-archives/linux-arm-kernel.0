From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 10:32:11 +0530
Subject: [PATCH 16/16] ARM: zx: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1479099731-28108-17-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now as we have of_scu_enable which takes care of mapping
scu base from DT, lets use it.

CC: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-zx/platsmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-zx/platsmp.c b/arch/arm/mach-zx/platsmp.c
index 0297f92..2788c34 100644
--- a/arch/arm/mach-zx/platsmp.c
+++ b/arch/arm/mach-zx/platsmp.c
@@ -44,13 +44,11 @@ static void __iomem *scu_base;
 void __init zx_smp_prepare_cpus(unsigned int max_cpus)
 {
 	struct device_node *np;
-	unsigned long base = 0;
 	void __iomem *aonsysctrl_base;
 	void __iomem *sys_iram;
 
-	base = scu_a9_get_base();
-	scu_base = ioremap(base, SZ_256);
-	if (!scu_base) {
+	scu_base = of_scu_get_base();
+	if (IS_ERR(scu_base)) {
 		pr_err("%s: failed to map scu\n", __func__);
 		return;
 	}
-- 
2.7.4
