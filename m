From: bob.dunlop@xyzzy.org.uk (Bob Dunlop)
Date: Mon, 6 Jun 2011 13:25:52 +0100
Subject: [PATCH 2/3] davinci: dm6467/T EVM: pass reference clock rate
	to dm646x_init()
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D38344A@dbde02.ent.ti.com>
References: <1307034677-27236-1-git-send-email-nsekhar@ti.com>
	<1307034677-27236-2-git-send-email-nsekhar@ti.com>
	<4DEB7DD4.5050706@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D38344A@dbde02.ent.ti.com>
Message-ID: <20110606122552.GA2729@xyzzy.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06 at 05:01, Nori, Sekhar wrote:
> On Sun, Jun 05, 2011 at 18:30:04, Sergei Shtylyov wrote:
> >     I don't think you should ascribe *your* patch to Bob. There's 
> > Suggested-by: line if you want to credit Bob.
> 
> Bob, do you have an opinion on this? If not, I will go with what
> Sergei is suggesting.

I have no problem one way or the other, we all know who we are.

Anyway I'd like to propose a simpler patch that covers both boards in one.
Fewer files touched than the original da850 patch.

Add the ref_clk_rate parameter to the davinci_soc_info structure and
perform the clock adjustment in davinci_common_init().  The code assumes
that if which to tweak the ref_clk it will be the first one listed in
cpu_clocks[] which is the case for all boards sofar.

The only downside is you need to export the davinci_soc_info_dm646x struct
in order to tweak it.

I don't have a dm646x to test this with.
Signed-off-by: Bob Dunlop <bob.dunlop@xyzzy.org.uk>



diff -Naur linux-2.6-arm-orig/arch/arm/mach-davinci//board-dm646x-evm.c linux-2.6-arm/arch/arm/mach-davinci//board-dm646x-evm.c
--- linux-2.6-arm-orig/arch/arm/mach-davinci//board-dm646x-evm.c	2011-02-09 08:37:02.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-davinci//board-dm646x-evm.c	2011-06-06 12:30:12.000000000 +0100
@@ -719,8 +719,16 @@
 	}
 }
 
+#define DM646X_EVM_REF_FREQ            27000000
+#define DM6467T_EVM_REF_FREQ           33000000
+
 static void __init davinci_map_io(void)
 {
+	if (machine_is_davinci_dm6467tevm())
+		davinci_soc_info_dm646x.ref_clk_rate = DM6467T_EVM_REF_FREQ;
+	else
+		davinci_soc_info_dm646x.ref_clk_rate = DM646X_EVM_REF_FREQ;
+
 	dm646x_init();
 	cdce_clk_init();
 }
@@ -785,17 +793,6 @@
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
diff -Naur linux-2.6-arm-orig/arch/arm/mach-davinci//common.c linux-2.6-arm/arch/arm/mach-davinci//common.c
--- linux-2.6-arm-orig/arch/arm/mach-davinci//common.c	2011-02-09 08:37:02.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-davinci//common.c	2011-06-06 12:00:14.000000000 +0100
@@ -106,6 +106,10 @@
 		goto err;
 
 	if (davinci_soc_info.cpu_clks) {
+		if(davinci_soc_info.ref_clk_rate)
+			davinci_soc_info.cpu_clks->clk->rate
+					= davinci_soc_info.ref_clk_rate;
+
 		ret = davinci_clk_init(davinci_soc_info.cpu_clks);
 
 		if (ret != 0)
diff -Naur linux-2.6-arm-orig/arch/arm/mach-davinci//dm646x.c linux-2.6-arm/arch/arm/mach-davinci//dm646x.c
--- linux-2.6-arm-orig/arch/arm/mach-davinci//dm646x.c	2011-02-09 08:37:02.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-davinci//dm646x.c	2011-06-06 12:24:25.000000000 +0100
@@ -825,7 +825,7 @@
 	},
 };
 
-static struct davinci_soc_info davinci_soc_info_dm646x = {
+struct davinci_soc_info davinci_soc_info_dm646x = {
 	.io_desc		= dm646x_io_desc,
 	.io_desc_num		= ARRAY_SIZE(dm646x_io_desc),
 	.jtag_id_reg		= 0x01c40028,
@@ -901,7 +901,6 @@
 
 void __init dm646x_init(void)
 {
-	dm646x_board_setup_refclk(&ref_clk);
 	davinci_common_init(&davinci_soc_info_dm646x);
 }
 
diff -Naur linux-2.6-arm-orig/arch/arm/mach-davinci//include/mach/common.h linux-2.6-arm/arch/arm/mach-davinci//include/mach/common.h
--- linux-2.6-arm-orig/arch/arm/mach-davinci//include/mach/common.h	2011-02-09 08:37:02.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-davinci//include/mach/common.h	2011-06-06 11:52:56.000000000 +0100
@@ -79,6 +79,7 @@
 	unsigned			sram_len;
 	struct platform_device		*reset_device;
 	void				(*reset)(struct platform_device *);
+	unsigned long			ref_clk_rate;
 };
 
 extern struct davinci_soc_info davinci_soc_info;
diff -Naur linux-2.6-arm-orig/arch/arm/mach-davinci//include/mach/dm646x.h linux-2.6-arm/arch/arm/mach-davinci//include/mach/dm646x.h
--- linux-2.6-arm-orig/arch/arm/mach-davinci//include/mach/dm646x.h	2011-02-09 08:37:02.000000000 +0000
+++ linux-2.6-arm/arch/arm/mach-davinci//include/mach/dm646x.h	2011-06-06 12:23:02.000000000 +0100
@@ -31,7 +31,6 @@
 void __init dm646x_init(void);
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
-void __init dm646x_board_setup_refclk(struct clk *clk);
 int __init dm646x_init_edma(struct edma_rsv_info *rsv);
 
 void dm646x_video_init(void);
@@ -92,3 +91,5 @@
 		       struct vpif_capture_config *);
 
+extern struct davinci_soc_info davinci_soc_info_dm646x;
+
 #endif /* __ASM_ARCH_DM646X_H */

-- 
        Bob Dunlop
