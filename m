From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 10 Jul 2013 10:10:13 -0300
Subject: [PATCH v2 1/2] ARM: imx: system: Do not declare imx_init_l2cache() as
 static
Message-ID: <1373461814-8844-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 879ec1cee (ARM: imx: let L2 initialization be a common function) breaks 
the build when CONFIG_CACHE_L2X0=y:

arch/arm/mach-imx/system.c:101:20: error: static declaration of 'imx_init_l2cache' follows non-static declaration
In file included from arch/arm/mach-imx/system.c:32:0:
arch/arm/mach-imx/common.h:165:13: note: previous declaration of 'imx_init_l2cache' was here
arch/arm/mach-imx/system.c:101:20: warning: 'imx_init_l2cache' defined but not used [-Wunused-function]

imx_init_l2cache() is a common function now, so it cannot be declared as static 
anymore.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Newly introduced in this series

 arch/arm/mach-imx/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index e5592ca..64ff37e 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -98,7 +98,7 @@ void __init mxc_arch_reset_init_dt(void)
 }
 
 #ifdef CONFIG_CACHE_L2X0
-static void __init imx_init_l2cache(void)
+void __init imx_init_l2cache(void)
 {
 	void __iomem *l2x0_base;
 	struct device_node *np;
-- 
1.8.1.2
