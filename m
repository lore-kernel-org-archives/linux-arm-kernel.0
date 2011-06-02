From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Jun 2011 22:41:16 +0530
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate to
	dm646x_init()
In-Reply-To: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
Message-ID: <1307034677-27236-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>

The DM6467 and DM6467T EVMs use different reference clock
frequencies. This difference is currently supported by having
the SoC code call a public board routine which sets up the reference
clock frequency. This does not scale as more boards are added.

Instead, pass the reference clock frequency as a parameter
to dm646x_init(). Boards which do not need the default reference
clock changed can pass NULL to this function.

Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
I have marked Bob as the author of this patch since it is essentially
his idea. Hope he doesnt mind that :)

 arch/arm/mach-davinci/board-dm646x-evm.c    |   23 +++++++++++------------
 arch/arm/mach-davinci/dm646x.c              |    6 ++++--
 arch/arm/mach-davinci/include/mach/common.h |   10 ++++++++++
 arch/arm/mach-davinci/include/mach/dm646x.h |    4 ++--
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f6ac9ba..37c49a9 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -719,9 +719,19 @@ static void __init cdce_clk_init(void)
 	}
 }
 
+#define DM646X_EVM_REF_FREQ		27000000
+#define DM6467T_EVM_REF_FREQ		33000000
+
+static struct davinci_board_info dm646x_evm;
+
 static void __init davinci_map_io(void)
 {
-	dm646x_init();
+	if (machine_is_davinci_dm6467tevm())
+		dm646x_evm.ref_clk_rate = DM6467T_EVM_REF_FREQ;
+	else
+		dm646x_evm.ref_clk_rate = DM646X_EVM_REF_FREQ;
+
+	dm646x_init(&dm646x_evm);
 	cdce_clk_init();
 }
 
@@ -785,17 +795,6 @@ static __init void evm_init(void)
 	soc_info->emac_pdata->phy_id = DM646X_EVM_PHY_ID;
 }
 
-#define DM646X_EVM_REF_FREQ		27000000
-#define DM6467T_EVM_REF_FREQ		33000000
-
-void __init dm646x_board_setup_refclk(struct clk *clk)
-{
-	if (machine_is_davinci_dm6467tevm())
-		clk->rate = DM6467T_EVM_REF_FREQ;
-	else
-		clk->rate = DM646X_EVM_REF_FREQ;
-}
-
 MACHINE_START(DAVINCI_DM6467_EVM, "DaVinci DM646x EVM")
 	.boot_params  = (0x80000100),
 	.map_io       = davinci_map_io,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 1e0f809..871af17 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -899,9 +899,11 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 	return platform_device_register(&dm646x_edma_device);
 }
 
-void __init dm646x_init(void)
+void __init dm646x_init(struct davinci_board_info *board)
 {
-	dm646x_board_setup_refclk(&ref_clk);
+	if (board && board->ref_clk_rate)
+		ref_clk.rate = board->ref_clk_rate;
+
 	davinci_common_init(&davinci_soc_info_dm646x);
 }
 
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index a57cba2..fbe650b 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -83,6 +83,16 @@ struct davinci_soc_info {
 
 extern struct davinci_soc_info davinci_soc_info;
 
+/*
+ * DaVinci board info.
+ *
+ * This structure is used to pass board information to
+ * early SoC specific initialization code.
+ */
+struct davinci_board_info {
+	unsigned long ref_clk_rate;
+};
+
 extern void davinci_common_init(struct davinci_soc_info *soc_info);
 extern void davinci_init_ide(void);
 
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 5e95b02..b92db82 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/davinci_emac.h>
 
+#include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/asp.h>
 
@@ -29,10 +30,9 @@
 #define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
 #define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
 
-void __init dm646x_init(void);
+void __init dm646x_init(struct davinci_board_info *board);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
-void __init dm646x_board_setup_refclk(struct clk *clk);
 int __init dm646x_init_edma(struct edma_rsv_info *rsv);
 
 void dm646x_video_init(void);
-- 
1.7.3.2
