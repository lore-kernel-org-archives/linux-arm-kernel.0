From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 15:51:41 +0100
Subject: [PATCH] [V2] ARM: imx6: fix static declaration in
 include/soc/imx/cpuidle.h
Message-ID: <1466175101-18812-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If both CONFIG_CPU_IDLE or CONFIG_SOC_IMX6Q are not set
then the imx6q_cpuidle_fec_irqs_used() and other functions
should be marked static inline to avoid the following
warnings whilst building drivers/net/ethernet/freescale:

include/soc/imx/cpuidle.h:21:6: warning: symbol 'imx6q_cpuidle_fec_irqs_used' was not declared. Should it be static?
include/soc/imx/cpuidle.h:22:6: warning: symbol 'imx6q_cpuidle_fec_irqs_unused' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
V2..V1: fix missing use of inline part
---
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 include/soc/imx/cpuidle.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/soc/imx/cpuidle.h b/include/soc/imx/cpuidle.h
index 986a482..8e7743d 100644
--- a/include/soc/imx/cpuidle.h
+++ b/include/soc/imx/cpuidle.h
@@ -18,8 +18,8 @@
 void imx6q_cpuidle_fec_irqs_used(void);
 void imx6q_cpuidle_fec_irqs_unused(void);
 #else
-void imx6q_cpuidle_fec_irqs_used(void) { }
-void imx6q_cpuidle_fec_irqs_unused(void) { }
+static inline void imx6q_cpuidle_fec_irqs_used(void) { }
+static inline void imx6q_cpuidle_fec_irqs_unused(void) { }
 #endif
 
 #endif /* __SOC_IMX_CPUIDLE_H__ */
-- 
2.8.1
