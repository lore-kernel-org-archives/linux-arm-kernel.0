From: gmbnomis@gmail.com (Simon Baatz)
Date: Sat, 26 Jan 2013 20:01:04 +0100
Subject: [PATCH] clk: mvebu: Do not gate ge0/1 and runit clocks on Kirkwood
Message-ID: <1359226864-28811-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commits f479db "ARM: Kirkwood: Ensure runit clock always ticks." and
128789 "ARM: Kirkwood: Fix clk problems modular ethernet driver"
ensured that the ge and runit clocks always tick on Kirkwood.  This
prevents the device from locking up and from forgetting the MAC addresses
which are usually set by the boot loader.

When moving the clock gating control to this driver for DT devices, these
changes were disabled.  Ensure that the respective clocks have the
CLK_IGNORE_UNUSED flag set.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---

Hi,

kernel 3.8-rc5 will hang on kirkwood DT if the Ethernet driver is built
as a module or when no driver claiming the runit clock is built in. 
(Usually, at least the serial driver is built in, but it won't request
the clock if "clock-frequency" is given in DT.)

In the past, we fixed this by keeping the clocks ticking (which
probably is not be the nicest solution for the ge clocks).

The patch creates much noise, but is hopefully obvious. I have tested
it on IB-NAS6210 (kirkwood, single Ethernet port).  The other platforms
are only compile tested. I don't know whether something similar is 
required for other platforms as well; I left them untouched.

- Simon

 drivers/clk/mvebu/clk-gating-ctrl.c |  159 +++++++++++++++++------------------
 1 file changed, 79 insertions(+), 80 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index 8fa5408..917049c 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -28,6 +28,7 @@ struct mvebu_soc_descr {
 	const char *name;
 	const char *parent;
 	int bit_idx;
+	unsigned long flags;
 };
 
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
@@ -88,21 +89,12 @@ static void __init mvebu_clk_gating_setup(
 	}
 
 	for (n = 0; n < ctrl->num_gates; n++) {
-		u8 flags = 0;
 		const char *parent =
 			(descr[n].parent) ? descr[n].parent : default_parent;
-
-		/*
-		 * On Armada 370, the DDR clock is a special case: it
-		 * isn't taken by any driver, but should anyway be
-		 * kept enabled, so we mark it as IGNORE_UNUSED for
-		 * now.
-		 */
-		if (!strcmp(descr[n].name, "ddr"))
-			flags |= CLK_IGNORE_UNUSED;
-
 		ctrl->gates[n] = clk_register_gate(NULL, descr[n].name, parent,
-				   flags, base, descr[n].bit_idx, 0, &ctrl->lock);
+						   descr[n].flags, base,
+						   descr[n].bit_idx,
+						   0, &ctrl->lock);
 		WARN_ON(IS_ERR(ctrl->gates[n]));
 	}
 	of_clk_add_provider(np, mvebu_clk_gating_get_src, ctrl);
@@ -114,92 +106,99 @@ static void __init mvebu_clk_gating_setup(
 
 #ifdef CONFIG_MACH_ARMADA_370
 static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
-	{ "audio", NULL, 0 },
-	{ "pex0_en", NULL, 1 },
-	{ "pex1_en", NULL,  2 },
-	{ "ge1", NULL, 3 },
-	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 9 },
-	{ "sata0", NULL, 15 },
-	{ "sdio", NULL, 17 },
-	{ "tdm", NULL, 25 },
-	{ "ddr", NULL, 28 },
-	{ "sata1", NULL, 30 },
+	{ .name = "audio", .bit_idx = 0 },
+	{ .name = "pex0_en", .bit_idx = 1 },
+	{ .name = "pex1_en", .bit_idx =  2 },
+	{ .name = "ge1", .bit_idx = 3 },
+	{ .name = "ge0", .bit_idx = 4 },
+	{ .name = "pex0", .bit_idx = 5 },
+	{ .name = "pex1", .bit_idx = 9 },
+	{ .name = "sata0", .bit_idx = 15 },
+	{ .name = "sdio", .bit_idx = 17 },
+	{ .name = "tdm", .bit_idx = 25 },
+		/* The DDR clock is a special case: it isn't taken by
+		 * any driver, but should anyway be kept enabled.
+		 */
+	{ .name = "ddr", .bit_idx = 28, .flags = CLK_IGNORE_UNUSED },
+	{ .name = "sata1", .bit_idx = 30 },
 	{ }
 };
 #endif
 
 #ifdef CONFIG_MACH_ARMADA_XP
 static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
-	{ "audio", NULL, 0 },
-	{ "ge3", NULL, 1 },
-	{ "ge2", NULL,  2 },
-	{ "ge1", NULL, 3 },
-	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 6 },
-	{ "pex2", NULL, 7 },
-	{ "pex3", NULL, 8 },
-	{ "bp", NULL, 13 },
-	{ "sata0lnk", NULL, 14 },
-	{ "sata0", "sata0lnk", 15 },
-	{ "lcd", NULL, 16 },
-	{ "sdio", NULL, 17 },
-	{ "usb0", NULL, 18 },
-	{ "usb1", NULL, 19 },
-	{ "usb2", NULL, 20 },
-	{ "xor0", NULL, 22 },
-	{ "crypto", NULL, 23 },
-	{ "tdm", NULL, 25 },
-	{ "xor1", NULL, 28 },
-	{ "sata1lnk", NULL, 29 },
-	{ "sata1", "sata1lnk", 30 },
+	{ .name = "audio", .bit_idx = 0 },
+	{ .name = "ge3", .bit_idx = 1 },
+	{ .name = "ge2", .bit_idx =  2 },
+	{ .name = "ge1", .bit_idx = 3 },
+	{ .name = "ge0", .bit_idx = 4 },
+	{ .name = "pex0", .bit_idx = 5 },
+	{ .name = "pex1", .bit_idx = 6 },
+	{ .name = "pex2", .bit_idx = 7 },
+	{ .name = "pex3", .bit_idx = 8 },
+	{ .name = "bp", .bit_idx = 13 },
+	{ .name = "sata0lnk", .bit_idx = 14 },
+	{ .name = "sata0", .bit_idx = 15, .parent = "sata0lnk" },
+	{ .name = "lcd", .bit_idx = 16 },
+	{ .name = "sdio", .bit_idx = 17 },
+	{ .name = "usb0", .bit_idx = 18 },
+	{ .name = "usb1", .bit_idx = 19 },
+	{ .name = "usb2", .bit_idx = 20 },
+	{ .name = "xor0", .bit_idx = 22 },
+	{ .name = "crypto", .bit_idx = 23 },
+	{ .name = "tdm", .bit_idx = 25 },
+	{ .name = "xor1", .bit_idx = 28 },
+	{ .name = "sata1lnk", .bit_idx = 29 },
+	{ .name = "sata1", .bit_idx = 30, .parent = "sata1lnk" },
 	{ }
 };
 #endif
 
 #ifdef CONFIG_ARCH_DOVE
 static const struct mvebu_soc_descr __initconst dove_gating_descr[] = {
-	{ "usb0", NULL, 0 },
-	{ "usb1", NULL, 1 },
-	{ "ge", "gephy", 2 },
-	{ "sata", NULL, 3 },
-	{ "pex0", NULL, 4 },
-	{ "pex1", NULL, 5 },
-	{ "sdio0", NULL, 8 },
-	{ "sdio1", NULL, 9 },
-	{ "nand", NULL, 10 },
-	{ "camera", NULL, 11 },
-	{ "i2s0", NULL, 12 },
-	{ "i2s1", NULL, 13 },
-	{ "crypto", NULL, 15 },
-	{ "ac97", NULL, 21 },
-	{ "pdma", NULL, 22 },
-	{ "xor0", NULL, 23 },
-	{ "xor1", NULL, 24 },
-	{ "gephy", NULL, 30 },
+	{ .name = "usb0", .bit_idx = 0 },
+	{ .name = "usb1", .bit_idx = 1 },
+	{ .name = "ge", .bit_idx = 2, .parent = "gephy" },
+	{ .name = "sata", .bit_idx = 3 },
+	{ .name = "pex0", .bit_idx = 4 },
+	{ .name = "pex1", .bit_idx = 5 },
+	{ .name = "sdio0", .bit_idx = 8 },
+	{ .name = "sdio1", .bit_idx = 9 },
+	{ .name = "nand", .bit_idx = 10 },
+	{ .name = "camera", .bit_idx = 11 },
+	{ .name = "i2s0", .bit_idx = 12 },
+	{ .name = "i2s1", .bit_idx = 13 },
+	{ .name = "crypto", .bit_idx = 15 },
+	{ .name = "ac97", .bit_idx = 21 },
+	{ .name = "pdma", .bit_idx = 22 },
+	{ .name = "xor0", .bit_idx = 23 },
+	{ .name = "xor1", .bit_idx = 24 },
+	{ .name = "gephy", .bit_idx = 30 },
 	{ }
 };
 #endif
 
 #ifdef CONFIG_ARCH_KIRKWOOD
 static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
-	{ "ge0", NULL, 0 },
-	{ "pex0", NULL, 2 },
-	{ "usb0", NULL, 3 },
-	{ "sdio", NULL, 4 },
-	{ "tsu", NULL, 5 },
-	{ "runit", NULL, 7 },
-	{ "xor0", NULL, 8 },
-	{ "audio", NULL, 9 },
-	{ "sata0", NULL, 14 },
-	{ "sata1", NULL, 15 },
-	{ "xor1", NULL, 16 },
-	{ "crypto", NULL, 17 },
-	{ "pex1", NULL, 18 },
-	{ "ge1", NULL, 19 },
-	{ "tdm", NULL, 20 },
+		/* Prevent that the Ethernet interfaces will forget their
+		 * MAC addresses by keeping the "ge0/1" clocks running.
+		 */
+	{ .name = "ge0", .bit_idx = 0, .flags = CLK_IGNORE_UNUSED },
+	{ .name = "pex0", .bit_idx = 2 },
+	{ .name = "usb0", .bit_idx = 3 },
+	{ .name = "sdio", .bit_idx = 4 },
+	{ .name = "tsu", .bit_idx = 5 },
+		/* Devices will lock hard if the "runit" clock is gated. */
+	{ .name = "runit", .bit_idx = 7, .flags = CLK_IGNORE_UNUSED },
+	{ .name = "xor0", .bit_idx = 8 },
+	{ .name = "audio", .bit_idx = 9 },
+	{ .name = "sata0", .bit_idx = 14 },
+	{ .name = "sata1", .bit_idx = 15 },
+	{ .name = "xor1", .bit_idx = 16 },
+	{ .name = "crypto", .bit_idx = 17 },
+	{ .name = "pex1", .bit_idx = 18 },
+	{ .name = "ge1", .bit_idx = 19, .flags = CLK_IGNORE_UNUSED },
+	{ .name = "tdm", .bit_idx = 20 },
 	{ }
 };
 #endif
-- 
1.7.9.5
