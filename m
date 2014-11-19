From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 19 Nov 2014 12:51:10 -0200
Subject: [PATCH] ARM: vfp: Fix build warning when CONFIG_CONFIG_VFPv3=n
Message-ID: <1416408670-25500-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building bcm2835_defconfig, which has CONFIG_CONFIG_VFPv3=n causes the following
build warning:

arch/arm/vfp/vfpmodule.c: In function 'vfp_init':
arch/arm/vfp/vfpmodule.c:725:6: warning: unused variable 'mvfr0' [-Wunused-variable]
  u32 mvfr0;
      ^

As mvfr0 is only used inside a '#ifdef CONFIG_VFPv3' code block, protect its 
definition accordingly to avoid the warning.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/vfp/vfpmodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 5002d00..19a9338 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -722,7 +722,9 @@ static int __init vfp_init(void)
 {
 	unsigned int vfpsid;
 	unsigned int cpu_arch = cpu_architecture();
+#ifdef CONFIG_VFPv3
 	u32 mvfr0;
+#endif
 
 	if (cpu_arch >= CPU_ARCH_ARMv6)
 		on_each_cpu(vfp_enable, NULL, 1);
-- 
1.9.1
