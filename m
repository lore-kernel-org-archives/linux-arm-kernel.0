From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Sep 2012 19:26:56 -0700
Subject: [PATCH 08/10] ARM: msm: Prepare clk_get() users in mach-msm for
 clock-pcom driver
In-Reply-To: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1348194419-11486-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the near future we'll be moving clock-pcom to a platform
driver, in which case these two users of clk_get() in mach-msm
need to be updated. Have board-trout-panel.c make the proc_comm
call directly so that we don't have to port this board specific
code to the driver right now and reorder the initcall order of
dma.c so that it initializes after the clock driver probes but
before any drivers use dma APIs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/Makefile            |  9 ++++++---
 arch/arm/mach-msm/board-trout-panel.c | 19 +++++++------------
 arch/arm/mach-msm/dma.c               |  5 ++---
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 17519fa..3dbae74 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -5,12 +5,15 @@ obj-$(CONFIG_DEBUG_FS) += clock-debug.o
 obj-$(CONFIG_MSM_VIC) += irq-vic.o
 obj-$(CONFIG_MSM_IOMMU) += devices-iommu.o
 
-obj-$(CONFIG_ARCH_MSM7X00A) += dma.o irq.o
-obj-$(CONFIG_ARCH_MSM7X30) += dma.o
-obj-$(CONFIG_ARCH_QSD8X50) += dma.o sirc.o
+obj-$(CONFIG_ARCH_MSM7X00A) += irq.o
+obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
 
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 
+obj-$(CONFIG_ARCH_MSM7X00A) += dma.o
+obj-$(CONFIG_ARCH_MSM7X30) += dma.o
+obj-$(CONFIG_ARCH_QSD8X50) += dma.o
+
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
diff --git a/arch/arm/mach-msm/board-trout-panel.c b/arch/arm/mach-msm/board-trout-panel.c
index 89bf6b4..0be703b 100644
--- a/arch/arm/mach-msm/board-trout-panel.c
+++ b/arch/arm/mach-msm/board-trout-panel.c
@@ -7,7 +7,6 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
-#include <linux/clk.h>
 #include <linux/err.h>
 
 #include <asm/io.h>
@@ -19,6 +18,7 @@
 
 #include "board-trout.h"
 #include "proc_comm.h"
+#include "clock-pcom.h"
 #include "devices.h"
 
 #define TROUT_DEFAULT_BACKLIGHT_BRIGHTNESS 255
@@ -170,7 +170,6 @@ static struct mddi_table mddi_toshiba_init_table[] = {
 #define INTMASK_VWAKEOUT (1U << 0)
 
 
-static struct clk *gp_clk;
 static int trout_new_backlight = 1;
 static struct vreg *vreg_mddi_1v5;
 static struct vreg *vreg_lcm_2v85;
@@ -273,18 +272,14 @@ int __init trout_init_panel(void)
 	} else {
 		uint32_t config = PCOM_GPIO_CFG(27, 1, GPIO_OUTPUT,
 						GPIO_NO_PULL, GPIO_8MA);
+		uint32_t id = P_GP_CLK;
+		uint32_t rate = 19200000;
+
 		msm_proc_comm(PCOM_RPC_GPIO_TLMM_CONFIG_EX, &config, 0);
 
-		gp_clk = clk_get(NULL, "gp_clk");
-		if (IS_ERR(gp_clk)) {
-			printk(KERN_ERR "trout_init_panel: could not get gp"
-			       "clock\n");
-			gp_clk = NULL;
-		}
-		rc = clk_set_rate(gp_clk, 19200000);
-		if (rc)
-			printk(KERN_ERR "trout_init_panel: set clock rate "
-			       "failed\n");
+		msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
+		if (id < 0)
+			pr_err("trout_init_panel: set clock rate failed\n");
 	}
 
 	rc = platform_device_register(&msm_device_mdp);
diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index 354b91d..37a4ddd 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -258,6 +258,7 @@ static int __init msm_init_datamover(void)
 	clk = clk_get(NULL, "adm_clk");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
+	clk_prepare(clk);
 	msm_dmov_clk = clk;
 	ret = request_irq(INT_ADM_AARM, msm_datamover_irq_handler, 0, "msmdatamover", NULL);
 	if (ret)
@@ -265,6 +266,4 @@ static int __init msm_init_datamover(void)
 	disable_irq(INT_ADM_AARM);
 	return 0;
 }
-
-arch_initcall(msm_init_datamover);
-
+module_init(msm_init_datamover);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
